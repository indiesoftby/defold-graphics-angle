#!/usr/bin/env bash
set -euo pipefail

# Export staged Defold changes. Usage: ./update-patch.sh [defold-repository]
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
defold_repo=${1:-/home/linux/defold-angle}
patch_tmp=$(mktemp "$script_dir/.angle.patch.XXXXXX")
trap 'rm -f -- "$patch_tmp"' EXIT

git -C "$defold_repo" diff --cached --binary > "$patch_tmp"
mv -- "$patch_tmp" "$script_dir/angle.patch"
echo "Updated $script_dir/angle.patch"
