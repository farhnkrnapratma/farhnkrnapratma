import { routes } from "./routes";

Bun.build({
  publicPath: "https://farhnkrnapratma.dev/",
  entrypoints: Object.values(routes).map((f) => `./src/${f}`),
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
