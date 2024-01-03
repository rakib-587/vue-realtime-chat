/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./chat.html",
    "./src/chat.ts",
  ],
  theme: {
    extend: {},
  },
  corePlugins: {
    preflight: false,
  },
  plugins: [],
}

