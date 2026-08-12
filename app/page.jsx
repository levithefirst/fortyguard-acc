// Operations Console — primary/hero screen (see design-system.md, Screen 1).
// This is a placeholder wired against seed data. Replace with the real
// OperationsConsole component from design-system.md once /api/evaluate exists.

export default function HomePage() {
  return (
    <main className="min-h-screen p-6">
      <div className="mx-auto max-w-2xl">
        <h1 className="text-2xl font-semibold">Heat Rules Autopilot</h1>
        <p className="mt-2 text-sm text-concrete-400">
          Scaffold placeholder. Wire in the OperationsConsole component from
          design-system.md once the decision engine and /api/evaluate route
          are working (architecture.md build order, steps 1–4).
        </p>
      </div>
    </main>
  );
}
