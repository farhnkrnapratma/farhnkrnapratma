set shell := ["fish", "-c"]

server := "./src/server.ts"
builder := "./src/build.ts"
artifacts := "./build"

alias i := install
alias u := update
alias b := build
alias c := clean
alias s := serve
alias l := lint
alias f := format

[doc("Enter dev env")]
@default:
    echo "Entering development environment..."
    @devel

[doc("Install packages")]
@install:
    echo "Installing packages..."
    @bun install

[doc("Update packages")]
@update:
    echo "Updating packages..."
    @bun update

[doc("Build artifacts")]
@build:
    echo "Building artifacts..."
    @bun {{ builder }}

[doc("Clean artifacts")]
@clean:
    echo "Cleaning artifacts..."
    @rm -Recurse -Force {{ artifacts }}

[doc("Start server")]
@serve:
    echo "Starting development server..."
    @bun --hot {{ server }}

[doc("Lint projects")]
@lint:
    echo "Linting projects..."
    @bunx --bun @biomejs/biome lint --write

[doc("Format projects")]
@format:
    echo "Formating projects..."
    @bunx --bun @biomejs/biome format --write
