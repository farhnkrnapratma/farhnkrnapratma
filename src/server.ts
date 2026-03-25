/** @format */

import Blog from "./blog/index.html";
import Contact from "./contact/index.html";
import Home from "./index.html";
import Support from "./support/index.html";

const server = Bun.serve({
  routes: {
    "/blog": Blog,
    "/contact": Contact,
    "/": Home,
    "/support": Support
  },
  fetch() {
    return new Response("404 Not Found!", { status: 404 });
  }
});

console.log(`Server running at http://localhost:${server.port}`);
