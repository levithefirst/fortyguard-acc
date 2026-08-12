# Heat Rules Autopilot

An agent that monitors FortyGuard's hyperlocal temperature forecast for a Phoenix, AZ job site. When conditions breach a pre-authorized safety threshold, it automatically executes a pre-approved schedule adjustment, documents the decision, and updates the operations feed, no approval click for the action itself, because the boundaries were already approved in advance.

Built for FortyGuard Hackathon'26, Track 6 (Agentic AI).

## Stack
Next.js (App Router) + Neon (serverless Postgres) + Vercel, $0 budget, browser-only build.

## Docs
- `architecture.md` — system design, data model, API surface, build order
- `mvp-prd-v2.md` — locked scope, kill list, judge-visible success metrics
- `design-system.md` — tokens, components, screen code
- `FOLDER_STRUCTURE.md` — what's scaffolded vs. what's built in the feature loop

## Local development
```
npm install
cp .env.example .env.local   # fill in real values
npm run dev
```

## Data reliability
Every reading is tagged `live` or `replay` in the UI, never presented as live when it isn't. Replay mode uses a real, previously-captured FortyGuard response (`lib/fixtures/fortyguard-sample-response.json`) so the demo stays honest and functional even if live API access is unavailable during judging or afterward.
