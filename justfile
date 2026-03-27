set shell := ["fish", "--private", "--interactive", "--command"]

alias a := audit
alias b := build
alias c := clean
alias f := format
alias i := install
alias l := lint
alias s := serve
alias u := update

[doc("Brute force mode")]
@default:
  @just clean
  @just update
  @just install
  @just build
  @just format
  @just lint
  @just serve

[doc("Audit all packages")]
@audit:
  @bun audit

[doc("Build this project")]
@build:
  @bun run ./build.ts

[doc("Remove build directory")]
@clean:
  @rm -rf ./build

[doc("Format this project")]
@format:
  @bunx prettier --write .
  @bunx prettier --write bun.lock --parser json

[doc("Install all packages")]
@install:
  @bun install

[doc("Lint this project")]
@lint:
  @bunx eslint

[doc("Start development server")]
@serve:
  @bun run ./serve.ts --hot

[doc("Update all packages")]
@update:
  @bun update
