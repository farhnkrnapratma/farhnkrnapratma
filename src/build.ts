await Bun.build({
  publicPath: "https://farhnkrnapratma.dev/",
  entrypoints: ["./src/index.html"],
  outdir: "./build",
  naming: {
    asset: "[name].[ext]",
    entry: "[dir]/[name].[ext]",
    chunk: "[dir]/[name].[ext]",
  },
  minify: true,
});

await Bun.write("./build/banner.png", Bun.file("./src/assets/banner.png"));
await Bun.write("./build/android-chrome-192x192.png", Bun.file("./src/assets/android-chrome-192x192.png"));
await Bun.write("./build/android-chrome-512x512.png", Bun.file("./src/assets/android-chrome-512x512.png"));
