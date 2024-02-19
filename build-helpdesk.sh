#!/bin/bash

# Create main.ts file for Vue app
cat >./helpdesk/main.ts <<EOL
import './assets/main.css'
import { createApp } from 'vue'
import App from './App.vue'

// Dynamically create link element for CSS
const link = document.createElement('link');
link.rel = 'stylesheet';
link.href = import.meta.env.VITE_BASE_URL + '/helpdesk.css';
document.head.appendChild(link);

// Create a div element for mounting Vue app
const root = document.createElement('div');
root.id = 'helpdesk';
document.body.appendChild(root);

// Mount Vue app to the created div element
createApp(App).mount('#helpdesk')
EOL

# Create helpdesk.html file as entry point
cat >./helpdesk.html <<EOL
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <link rel="icon" href="/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vite App</title>
  </head>
  <body>
    <script type="module" src="/helpdesk/main.ts"></script>
  </body>
</html>
EOL

# Create tailwind.config.helpdesk.js file for Tailwind CSS configuration
cat >./tailwind.config.helpdesk.js <<EOL
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./helpdesk.html",
    "./helpdesk/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  corePlugins: {
    preflight: false,
  },
  plugins: [],
}
EOL

# Create vite.config.helpdesk.ts file for Vite configuration
cat >./vite.config.helpdesk.ts <<EOL
import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from 'tailwindcss';

// Define Vite configuration
export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./helpdesk', import.meta.url))
    }
  },
  build: {
    rollupOptions: {
      input: fileURLToPath(new URL('./helpdesk.html', import.meta.url)),
      output: {
          entryFileNames: \`[name]-entrance.js\`,
          chunkFileNames: \`[name].js\`,
          assetFileNames: \`[name].[ext]\`
      },
    },
    copyPublicDir: false,
  },
  css: {
    postcss: {
      plugins: [
        tailwindcss({
          config: "./tailwind.config.helpdesk.js",
        }),
      ],
    },
  },
});
EOL

# Run type-checking (Assuming it's defined in package.json)
npm run type-check

# Run Vite build for helpdesk app
npx vite build --config=vite.config.helpdesk.ts

# Remove temporary files
rm ./helpdesk/main.ts
rm ./helpdesk.html
rm ./tailwind.config.helpdesk.js
rm ./vite.config.helpdesk.ts

# Copy generated CSS and JavaScript files to the public directory
cp ./dist/helpdesk.css ./public
cp ./dist/helpdesk-entrance.js ./public

# Remove the dist directory
rm -r ./dist
