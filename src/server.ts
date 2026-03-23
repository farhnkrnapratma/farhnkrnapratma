import Icon from "./assets/favicon.ico";
import Banner from "./assets/banner.png";
import Home from "./index.html";

const server = Bun.serve({
  routes: {
    "/": Home,
    "/favicon": () =>
      new Response(Bun.file(Icon), {
        headers: { "Content-Type": "image/x-icon" },
      }),
    "/banner": () =>
      new Response(Bun.file(Banner), {
        headers: { "Content-Type": "image/png" },
      }),
  },
  fetch() {
    return new Response("404 Not Found!", { status: 404 });
  },
});

console.log(`Server running at http://localhost:${server.port}`);
