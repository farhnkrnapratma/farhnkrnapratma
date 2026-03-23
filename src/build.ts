await Bun.build({
  publicPath: "https://farhnkrnapratma.dev/",
  entrypoints: ["./src/index.html"],
  outdir: "./build",
  naming: {
    asset: "[dir]/[name].[ext]",
    entry: "[dir]/[name].[ext]",
    chunk: "[dir]/[name].[ext]",
  },
  sourcemap: "inline" as const,
  minify: true,
});

await Bun.write("./build/favicon", Bun.file("./src/assets/favicon.ico"));
await Bun.write("./build/banner", Bun.file("./src/assets/banner.png"));
