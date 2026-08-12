import "./globals.css";

export const metadata = {
  title: "Heat Rules Autopilot",
  description: "Autonomous heat-response scheduling for outdoor operations.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="bg-basalt-950 font-sans text-concrete-100">{children}</body>
    </html>
  );
}
