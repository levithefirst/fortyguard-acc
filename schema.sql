-- Heat Rules Autopilot — Neon schema starter
-- Run this once against the Neon project's SQL editor or via `npm run db:seed`.

create extension if not exists pgcrypto;

create table operations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  site_lat double precision not null,
  site_lng double precision not null,
  scheduled_start timestamptz not null,
  scheduled_end timestamptz not null,
  status text not null default 'scheduled', -- scheduled | rescheduled | escalated
  created_at timestamptz not null default now()
);

create table thresholds (
  id uuid primary key default gen_random_uuid(),
  operation_id uuid not null references operations(id) on delete cascade,
  metric text not null default 'temperature_f', -- temperature_f | heat_index_f
  value numeric not null,
  source_note text not null default 'Arizona 2026 workplace heat guidance',
  created_at timestamptz not null default now()
);

create table alternatives (
  id uuid primary key default gen_random_uuid(),
  operation_id uuid not null references operations(id) on delete cascade,
  label text not null, -- e.g. 'Earlier start'
  new_start timestamptz not null,
  new_end timestamptz not null,
  priority_order int not null,
  created_at timestamptz not null default now()
);

create table readings (
  id uuid primary key default gen_random_uuid(),
  operation_id uuid not null references operations(id) on delete cascade,
  source text not null check (source in ('live','replay')),
  raw_value numeric not null,
  raw_payload jsonb not null,
  captured_at timestamptz not null,
  fetched_at timestamptz not null default now()
);

create table decisions (
  id uuid primary key default gen_random_uuid(),
  operation_id uuid not null references operations(id) on delete cascade,
  reading_id uuid not null references readings(id),
  threshold_id uuid not null references thresholds(id),
  outcome text not null check (outcome in ('executed','escalated','no_breach')),
  selected_alternative_id uuid references alternatives(id),
  reasoning_trace jsonb not null, -- array of { alternative_id, label, passed, reason }
  created_at timestamptz not null default now()
);

create table audit_events (
  id uuid primary key default gen_random_uuid(),
  decision_id uuid not null references decisions(id) on delete cascade,
  event_type text not null check (
    event_type in ('trigger','evaluation','decision','action','escalation','record_created','feed_updated')
  ),
  payload jsonb not null default '{}',
  occurred_at timestamptz not null default now()
);

create index idx_readings_operation on readings(operation_id);
create index idx_decisions_operation on decisions(operation_id);
create index idx_audit_events_decision on audit_events(decision_id);

-- Seed: one operation, one threshold, two alternatives.
-- Matches the MVP's single-operation scope exactly, do not add more without
-- updating mvp-prd-v2.md's kill list first.
insert into operations (id, name, site_lat, site_lng, scheduled_start, scheduled_end, status)
values (
  '00000000-0000-0000-0000-000000000001',
  'Concrete pour — Site 14',
  33.4484, -112.0740, -- Phoenix, AZ
  '2026-08-18 07:00:00-07',
  '2026-08-18 11:00:00-07',
  'scheduled'
);

insert into thresholds (operation_id, metric, value, source_note)
values (
  '00000000-0000-0000-0000-000000000001',
  'temperature_f', 105, 'Arizona 2026 workplace heat guidance'
);

insert into alternatives (operation_id, label, new_start, new_end, priority_order)
values
  ('00000000-0000-0000-0000-000000000001', 'Earlier start', '2026-08-18 05:30:00-07', '2026-08-18 09:30:00-07', 1),
  ('00000000-0000-0000-0000-000000000001', 'Split shift',   '2026-08-18 05:30:00-07', '2026-08-18 07:00:00-07', 2);
