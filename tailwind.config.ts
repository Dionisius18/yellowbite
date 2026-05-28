import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      colors: {
        // Palet PRD YellowBite
        primary: { DEFAULT: "#FFC107", dark: "#E0A800" },
        accent: { DEFAULT: "#E65100", dark: "#B83C00" },
        cream: "#FFFDF2",
        ink: { DEFAULT: "#1A1207", muted: "#6B5B3E", soft: "#9B8B6E" },
      },
      fontFamily: {
        display: ['"Fraunces"', "Georgia", "serif"],
        sans: ['"Plus Jakarta Sans"', "system-ui", "sans-serif"],
      },
    },
  },
  plugins: [],
};

export default config;
