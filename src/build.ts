Bun.build({
  publicPath: "https://farhnkrnapratma.dev/",
  entrypoints: [
    "./src/index.html",
    "./src/pages/blog/index.html",
    "./src/pages/contact/index.html",
    "./src/pages/donate/index.html",
    "./src/pages/feed/index.html",
    "./src/pages/social/index.html",
  ],
  outdir: "./build",
  naming: {
    asset: "[dir]/[name].[ext]",
    entry: "[dir]/[name].[ext]",
    chunk: "[dir]/[name].[ext]",
  },
  sourcemap: "inline",
  minify: true,
});

Bun.write("./build/assets/banner.png", Bun.file("./src/assets/banner.png"));
