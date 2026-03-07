import Home from "./index.html";
import Blog from "./pages/blog/index.html";
import Contact from "./pages/contact/index.html";
import Donate from "./pages/donate/index.html";
import Feed from "./pages/feed/index.html";
import Social from "./pages/social/index.html";

const server = Bun.serve({
  routes: {
    "/": Home,
    "/blog": Blog,
    "/contact": Contact,
    "/donate": Donate,
    "/feed": Feed,
    "/social": Social,
  },
  fetch() {
    return new Response("404 Not Found!");
  },
});

console.log(`Server running at http://localhost:${server.port}`);
