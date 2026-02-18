Bun.build({
  publicPath: "https://farhnkrnapratma.dev/",
  entrypoints: ["./src/index.html"],
  outdir: "./build",
  naming: {
    asset: "[dir]/[name].[ext]",
    entry: "[name].[ext]",
    chunk: "[name].[ext]"
  },
  sourcemap: "inline",
  minify: true
});

Bun.write("./build/assets/banner.png", Bun.file("./src/assets/banner.png"));
