/** @format */

import Home from "./src/index.html"
import Blog from "./src/blog/index.html"

const server = Bun.serve({
  routes: {
    "/": Home,
    "/blog": Blog
  },
  fetch() {
    return new Response("404 Not Found", { status: 404 })
  }
})

console.log(`Server running at http://localhost:${server.port}`)
