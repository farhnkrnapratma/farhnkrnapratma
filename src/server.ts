/** @format */

import Home from "./index.html";
import Blog from "./blog/index.html";

const server = Bun.serve({
  routes: {
    "/": Home,
    "/blog": Blog
  },
  fetch() {
    return new Response("404 Not Found!", { status: 404 });
  }
});

console.log(`Server running at http://localhost:${server.port}`);
