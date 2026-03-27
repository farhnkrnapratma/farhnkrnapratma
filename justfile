set shell := ["fish", "--private", "--interactive", "--command"]

alias a := audit
alias b := build
alias c := clean
alias d := check
alias f := format
alias g := generate
alias i := install
alias l := lint
alias s := serve
alias u := update

[doc("Audit all packages")]
@audit:
  @bun audit

[doc("Build this project")]
@build: generate format lint check
  @bun run ./build.ts

[doc("Remove build directory")]
@clean:
  @rm -rf ./build

@check:
  @bunx --bun @biomejs/biome check --write --verbose

[doc("Format this project")]
@format:
  @bunx --bun @biomejs/biome format --write --verbose
  @xq -i src/rss.xml

[doc("Generate blog and RSS")]
@generate:
  @./generate.sh

[doc("Install all packages")]
@install:
  @bun install

[doc("Lint this project")]
@lint:
  @bunx --bun @biomejs/biome lint --write --verbose

[doc("Start development server")]
@serve:
  @bun run ./serve.ts --hot

[doc("Update all packages")]
@update:
  @bun update
