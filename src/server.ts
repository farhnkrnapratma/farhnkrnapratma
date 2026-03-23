import Icon from "./assets/favicon.ico";
import Banner from "./assets/banner.png";
import Home from "./index.html";

const server = Bun.serve({
  routes: {
    "/": Home,
    "/favicon": new Response(Bun.file(Icon)),
    "/banner": new Response(Bun.file(Banner)),
  },
  fetch() {
    return new Response("404 Not Found!");
  },
});

console.log(`Server running at http://localhost:${server.port}`);
