import NotFound from "./src/404.html"
import Blog from "./src/blog/index.html"
import Home from "./src/index.html"

const server = Bun.serve({
  routes: {
    "/": Home,
    "/blog": Blog,
    "/404": NotFound
  },
  fetch() {
    return Response.redirect("/404")
  }
})

console.log(`Server running at http://localhost:${server.port}`)
