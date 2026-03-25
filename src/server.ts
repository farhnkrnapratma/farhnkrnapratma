/** @format */

import Home from './index.html'

const server = Bun.serve({
  routes: {
    '/': Home
  },
  fetch() {
    return new Response('404 Not Found!', { status: 404 })
  }
})

console.log(`Server running at http://localhost:${server.port}`)
