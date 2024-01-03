import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from 'tailwindcss';

export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  build: {
    rollupOptions: {
      input: fileURLToPath(new URL('./chat.html', import.meta.url)),
    },
    minify: false,
  },
  css: {
    postcss: {
      plugins: [
        tailwindcss({
          config: "./tailwind-chat.config.js",
        }),
      ],
    },
  },
});
