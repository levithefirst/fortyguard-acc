/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,jsx}",
    "./components/**/*.{js,jsx}",
  ],
  theme: {
    extend: {
      colors: {
        basalt: { 950: "#17140F", 900: "#221D16", 800: "#322A1F" },
        concrete: { 100: "#EDEAE2", 400: "#A8A196" },
        signal: { amber: "#FF8A1E", teal: "#2DD4BF", red: "#E5484D" },
      },
      fontFamily: {
        sans: ["Inter", "ui-sans-serif", "system-ui", "sans-serif"],
        mono: ["JetBrains Mono", "ui-monospace", "monospace"],
      },
    },
  },
  plugins: [],
};
