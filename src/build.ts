await Bun.build({
  entrypoints: ["./src/index.html"],
  outdir: "./build",
  naming: {
    asset: "[name].[ext]",
    entry: "[dir]/[name].[ext]",
    chunk: "[dir]/[name].[ext]",
  },
  sourcemap: "inline" as const,
  minify: true,
});
