# Folder Structure — Heat Rules Autopilot

```
heat-rules-autopilot/
├── app/
│   ├── layout.jsx                    ✅ scaffolded
│   ├── page.jsx                      ✅ scaffolded (placeholder, wire real component in build step 4)
│   ├── globals.css                   ✅ scaffolded
│   ├── record/[decisionId]/page.jsx  ⬜ build step 6 — Heat Response Record
│   ├── audit/[decisionId]/page.jsx   ⬜ build step 7 — Audit Trail
│   ├── feed/page.jsx                 ⬜ build step 8 — Operations Feed
│   └── api/
│       ├── evaluate/route.js         ⬜ build step 3 — core trigger, POST
│       ├── readings/
│       │   ├── live/route.js         ⬜ build step 5 — FortyGuard proxy, server-side only
│       │   └── replay/route.js       ⬜ build step 3 — returns the fixture
│       ├── decisions/[id]/route.js   ⬜ build step 6
│       └── operations/[id]/route.js  ⬜ build step 6
├── components/                       ⬜ build step 4+ — paste directly from design-system.md
│   ├── ConsolePanel.jsx
│   ├── StatusBadge.jsx
│   ├── DataRow.jsx
│   ├── DecisionTrace.jsx
│   ├── SourceTag.jsx
│   ├── FeedItem.jsx
│   └── PrimaryButton.jsx
├── lib/
│   ├── db.js                         ✅ scaffolded — Neon serverless client
│   ├── adapter.js                    ⬜ build step 3/5 — Heat Data Adapter (live/replay)
│   ├── decisionEngine.js             ⬜ build step 2 — pure function, write + test before any UI
│   └── fixtures/
│       └── fortyguard-sample-response.json  ✅ placeholder, replace with real captured response in build step 5
├── scripts/
│   └── seed.mjs                      ⬜ optional — run schema.sql programmatically instead of via Neon SQL editor
├── schema.sql                        ✅ scaffolded — run once against Neon
├── .env.example                      ✅ scaffolded — copy to .env.local, never commit .env.local
├── package.json                      ✅ scaffolded
├── tailwind.config.js                ✅ scaffolded — tokens from design-system.md
├── postcss.config.js                 ✅ scaffolded
├── next.config.js                    ✅ scaffolded
└── README.md                         ✅ scaffolded
```

✅ = included in this scaffold drop, ready to commit as-is
⬜ = build in the feature loop, following `architecture.md`'s build order exactly, don't build out of sequence

## Setup steps
1. Create the GitHub repo, add these files, commit.
2. **Add `fortyguard` as an actual repo collaborator** (not just make the repo public), this is one of the three required submission artifacts per `hackathon-constraints.md`. Settings → Collaborators → invite.
3. Run `schema.sql` against the Neon project's SQL editor (or wire up `scripts/seed.mjs` if preferred).
4. Copy `.env.example` to `.env.local`, fill in the real `DATABASE_URL` from Neon and `FORTYGUARD_API_KEY` once it arrives by email.
5. `npm install`, then `npm run dev` to confirm the placeholder home page loads.
6. Link the repo to Vercel, add the same two environment variables in Vercel's project settings (never commit them).
7. Follow `architecture.md`'s build order starting at step 1, the schema and seed data here already satisfy that step.
