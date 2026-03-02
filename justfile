set shell := [ "fish", "-i", "-c" ]

server := "./src/server.ts"
builder := "./src/build.ts"
artifacts := "./build"

alias b := build
alias c := clean
alias s := serve
alias l := lint
alias f := format
alias lf := lint-fix
alias fc := format-check

[doc("Enter dev env")]
@default:
  echo Entering development environment...
  @devel # equivalent to "nix develop" command

[doc("Build artifacts")]
@build:
  echo "Building artifacts..."
  @bun {{builder}}

[doc("Clean artifacts")]
@clean:
  echo "Cleaning artifacts..."
  @rm -rf {{artifacts}}

[doc("Start server")]
@serve: build
  echo "Starting development server..."
  @bun --hot {{server}}

[doc("Lint projects")]
@lint:
  echo "Linting projects..."
  @bunx oxlint

[doc("Lint then fix")]
@lint-fix:
  echo "Linting and fixing projects..."
  @bunx oxlint --fix

[doc("Format projects")]
@format:
  echo "Formating projects..."
  @bunx oxfmt

[doc("Just check don not format")]
@format-check:
  echo "Checking projects..."
  @bunx oxfmt --check
