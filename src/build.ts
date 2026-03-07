import { routes } from "./routes";

const buildConfig = {
  publicPath: "https://farhnkrnapratma.dev/",
  outdir: "./build",
  naming: {
    asset: "[name].[ext]",
    entry: "[dir]/[name].[ext]",
    chunk: "[dir]/[name].[ext]",
  },
  sourcemap: "inline" as const,
  minify: true,
};

const rootEntries = Object.entries(routes)
  .filter(([url]) => url === "/")
  .map(([, file]) => `./src/${file}`);

const pageEntries = Object.entries(routes)
  .filter(([url]) => url !== "/")
  .map(([, file]) => `./src/${file}`);

await Promise.all([
  Bun.build({ ...buildConfig, root: "./src", entrypoints: rootEntries }),
  Bun.build({ ...buildConfig, root: "./src/pages", entrypoints: pageEntries }),
]);

Bun.write("./build/banner.png", Bun.file("./src/assets/banner.png"));
