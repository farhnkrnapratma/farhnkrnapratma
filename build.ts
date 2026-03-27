/** @format */

import tailwind from "bun-plugin-tailwind"

await Bun.build({
  publicPath: "https://fkp.my.id/",
  entrypoints: ["./src/index.html", "./src/blog/index.html"],
  outdir: "./build",
  naming: {
    asset: "[name].[ext]",
    entry: "[dir]/[name].[ext]",
    chunk: "[dir]/[name].[ext]"
  },
  minify: true,
  plugins: [tailwind]
})

await Bun.write(
  "./build/banner-home.png",
  Bun.file("./src/assets/banner-home.png")
)
await Bun.write(
  "./build/banner-blog.png",
  Bun.file("./src/assets/banner-blog.png")
)
await Bun.write(
  "./build/android-chrome-192x192.png",
  Bun.file("./src/assets/android-chrome-192x192.png")
)
await Bun.write(
  "./build/android-chrome-512x512.png",
  Bun.file("./src/assets/android-chrome-512x512.png")
)
