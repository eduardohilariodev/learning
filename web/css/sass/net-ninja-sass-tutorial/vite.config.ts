import { defineConfig } from "vite";
// https://vitejs.dev/config/
export default defineConfig({
  build: {
    cssMinify: false,
    emptyOutDir: false,
    outDir: "dist",
    rollupOptions: { output: { assetFileNames: "[name].[ext]" } },
  },
  css: { preprocessorOptions: { scss: { api: "modern-compiler" } } },
});
