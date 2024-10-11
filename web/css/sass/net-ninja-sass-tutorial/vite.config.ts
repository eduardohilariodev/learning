import { defineConfig } from "vite";
// https://vitejs.dev/config/
export default defineConfig({
  build: {
    emptyOutDir: true,
    outDir: "dist",
    cssMinify: false,
    rollupOptions: {
      output: { assetFileNames: "[name].[ext]" },
    },
  },
  css: { preprocessorOptions: { scss: { api: "modern-compiler" } } },
});
