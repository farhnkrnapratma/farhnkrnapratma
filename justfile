set shell := ["/usr/bin/env", "bash", "-euo", "pipefail", "-c"]

generate_script := "./generate.sh"
build_script    := "./build.ts"
serve_script    := "./serve.ts"
rss_file        := "./src/rss.xml"

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

[doc("Run standard maintenance workflow: clean, audit, update, and generate")]
@default:
  echo "[just] Starting standard project maintenance..."
  @just clean
  @just audit
  @just update
  @just generate
  echo "[just] Maintenance workflow completed successfully."

[doc("Audit all packages for vulnerabilities")]
@audit:
  echo "[just] Auditing packages with Bun..."
  @bun audit
  echo "[just] Audit finished."

[doc("Build the project after generating and validating")]
@build:
  echo "[just] Starting full build process..."
  @just generate
  @just format
  @just lint
  @just check
  @bun run {{build_script}}
  echo "[just] Build completed successfully."

[doc("Remove build directory and generated files")]
@clean:
  echo "[just] Cleaning up build artifacts and generated blog files..."
  @rm -rf ./build
  @rm -rf {{rss_file}}
  @rm -rf ./src/blog/{2026,index.html}
  echo "[just] Cleanup finished."

[doc("Run Biome check to fix formatting and linting issues")]
@check:
  echo "[just] Running Biome check and auto-fix..."
  @bunx --bun @biomejs/biome check --write --verbose
  echo "[just] Check finished."

[doc("Format the project files (Biome, shfmt, xq)")]
@format:
  echo "[just] Formatting project files..."
  @bunx --bun @biomejs/biome format --write --verbose
  @shfmt --write {{generate_script}}
  @if [ -f {{rss_file}} ]; then xq -i {{rss_file}}; fi
  echo "[just] Formatting completed."

[doc("Generate blog content and RSS feed")]
@generate:
  echo "[just] Generating blog and RSS content..."
  @{{generate_script}}
  @just format
  @just lint
  @just check
  echo "[just] Generation and validation finished."

[doc("Install all project dependencies")]
@install:
  echo "[just] Installing dependencies with Bun..."
  @bun install
  echo "[just] Installation finished."

[doc("Lint the project (Biome and Shellcheck)")]
@lint:
  echo "[just] Linting project files..."
  @bunx --bun @biomejs/biome lint --write --verbose
  @shellcheck {{generate_script}}
  echo "[just] Linting finished."

[doc("Start the development server with hot reload")]
@serve:
  echo "[just] Starting development server on {{serve_script}}..."
  @bun run {{serve_script}} --hot

[doc("Update all project packages")]
@update:
  echo "[just] Updating Bun packages..."
  @bun update
  echo "[just] Update finished."
