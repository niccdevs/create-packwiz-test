#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

if compgen -G "mods/.index/*.pw.toml" > /dev/null; then
  mv mods/.index/*.pw.toml mods/
  echo "moved $(ls mods/.index 2>/dev/null | wc -l || echo 0) leftover files; metafiles now in mods/"
fi
rmdir mods/.index 2>/dev/null || true

packwiz refresh

if [ -z "$(git status --porcelain)" ]; then
  echo "no changes"
  exit 0
fi

git add -A
git status --short
msg="${1:-update pack}"
git commit -m "$msg"
git push
