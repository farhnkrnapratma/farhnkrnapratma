import HomePage from "./index.html";

const server = Bun.serve({
  routes: {
    "/": HomePage
  },
  fetch() {
    return new Response("404 Not Found!");
  }
});

console.log(`Server running at http://localhost:${server.port}`);
