import { Glob } from 'bun'
import tailwind from 'bun-plugin-tailwind'

const glob = new Glob('**/*.html')

const htmlEntrypoints = Array.from(glob.scanSync({ cwd: './src' })).map(
  (file) => `./src/${file}`,
)

await Bun.build({
  entrypoints: htmlEntrypoints,
  outdir: './build',
  naming: {
    asset: '[dir]/[name].[ext]',
    entry: '[dir]/[name].[ext]',
    chunk: '[dir]/[name].[ext]',
  },
  minify: true,
  plugins: [tailwind],
})

await Bun.write(
  './build/asset/banner-home.png',
  Bun.file('./src/asset/banner-home.png'),
)
await Bun.write(
  './build/asset/banner-blog.png',
  Bun.file('./src/asset/banner-blog.png'),
)
await Bun.write(
  './build/asset/android-chrome-192x192.png',
  Bun.file('./src/asset/android-chrome-192x192.png'),
)
await Bun.write(
  './build/asset/android-chrome-512x512.png',
  Bun.file('./src/asset/android-chrome-512x512.png'),
)
await Bun.write('./build/rss.xml', Bun.file('./src/rss.xml'))
