#!/usr/bin/env bash

set -euo pipefail

metadata_path="metadata.json"
release_workflow=".github/workflows/release.yml"
version="$(jq -er '.version | strings | select(length > 0)' "$metadata_path")"
release_action='uses: 3esmit/logos-modules-release-action/.github/workflows/release.yml@81f506530c56e8757e6d99ee7f9d4c092e74411c'

test "$(jq -r '.name' "$metadata_path")" = "accounts_module"
test "$(jq -r '.type' "$metadata_path")" = "core"
test "$(jq -r '.interface' "$metadata_path")" = "universal"
test "$version" = "1.0.1"
grep -Fq "## [${version}]" CHANGELOG.md
grep -Fq 'test "$GITHUB_REF" = "refs/heads/master"' "$release_workflow"
test "$(grep -Fo "$release_action" "$release_workflow" | wc -l)" -eq 1
grep -Fq 'build_attr: lgx-portable' "$release_workflow"
grep -Fq 'variants: linux-amd64,darwin-arm64' "$release_workflow"
grep -Fq 'require_all_variants: true' "$release_workflow"
grep -Fq 'dispatch_rebuild_index: false' "$release_workflow"
grep -Fq 'prerelease: true' "$release_workflow"
grep -Fq 'signing_mode: none' "$release_workflow"
