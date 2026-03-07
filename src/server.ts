import { routes } from "./routes";

const resolvedRoutes = Object.fromEntries(
  await Promise.all(
    Object.entries(routes).map(async ([url, file]) => {
      const mod = await import(`./${file}`);
      return [url, mod.default];
    })
  )
);

const server = Bun.serve({
  routes: resolvedRoutes,
  fetch() {
    return new Response("404 Not Found!");
  },
});

console.log(`Server running at http://localhost:${server.port}`);
