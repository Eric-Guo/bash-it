# Repository Guidelines

## Project Structure & Module Organization
Bash-it lives here as a Bash framework. Core loader: `bash_it.sh`. Modules sit under `aliases/available`, `completion/available`, `plugins/available`, and `themes/`; enable them by adding link-styled entries in `enabled/` (e.g., `350---foo.completion.bash`). Shared helpers live in `lib/`, while user-specific overrides belong in `custom/` to avoid conflicts. Scripts and tooling live in `scripts/`, docs in `docs/` (Sphinx), and third-party code in `vendor/`. Tests are under `test/` with supporting Bats tooling in `test_lib/`.

## Build, Test, and Development Commands
Install or refresh your config with `./install.sh` (override target via `BASH_IT_CONFIG_FILE=~/mybashrc ./install.sh`). Diagnose setups or bug reports using `bash-it doctor`. Run the full suite with `test/run`; target a subset with `test/run test/plugins` or parallelize via `TEST_JOBS=4 test/run`. Lint files tracked in `clean_files.txt` using `./lint_clean_files.sh` (requires `pre-commit`/ShellCheck). For new themes, add docs assets under `docs/` and avoid bundling screenshots in the main branch.

## Coding Style & Naming Conventions
Aim for Bash 3.2+ compatibility; avoid associative arrays and rely on `command foo` to bypass aliases. Indent with tabs (EditorConfig enforces a 2-space tab size). Quote `${BASH_IT}` paths. Default to dashed function names (e.g., `my-new-function`) with internal helpers prefixed `_`. Use meta helpers (`about`, `group`, `param`, `example`) to document user-facing functions. File suffixes matter: `.plugin.bash`, `.completion.bash`, `.aliases.bash`, theme files in `themes/`, and new linted files should be listed in `clean_files.txt`.

## Testing Guidelines
Tests are Bats specs under `test/<area>/*.bats`, using `bats-assert`, `bats-support`, and `bats-file`. Add fixtures in `test/fixtures` where possible and keep test names descriptive of behavior. Extend coverage alongside each bug fix or feature, and prefer deterministic tests over ones that depend on external tools being installed.

## Commit & Pull Request Guidelines
Branch from `master` and keep each PR scoped to a single feature/fix. Favor concise, imperative commits with context and optional issue tags (e.g., `Add base plugin doc (#123)`). Squash before opening the PR; avoid force-pushes afterward. PRs should summarize changes, list tests run (`test/run …`), and link issues. Include `bash-it doctor` output when fixing environment-specific bugs. For themes, link a screenshot via the docs site rather than committing images to the main branch.

## Security & Configuration Tips
Do not commit personal shell history, secrets, or machine-specific paths. Keep interactive prompts opt-in and provide safe defaults. Wrap any file access in quoted `${BASH_IT}` paths to support custom install locations.
