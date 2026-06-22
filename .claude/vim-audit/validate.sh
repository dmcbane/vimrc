#!/usr/bin/env bash
#
# validate.sh — the auditor's safety gate.
#
# Boots this Vim/Neovim config headlessly in an isolated environment and fails if
# the config does not load cleanly. The auditor MUST run this and see exit 0
# before merging any auto-applied low-risk change to main. Non-zero => downgrade
# the change to a review PR.
#
# Why the XDG dance: vimrc resolves its own paths via stdpath('config')
# (= $XDG_CONFIG_HOME/nvim) to find autoload/plug.vim and settings/. A plain
# `nvim -u <repo>/vimrc` would NOT make those resolve to the clone. So we point a
# throwaway $XDG_CONFIG_HOME/nvim at the repo and let Neovim discover init.vim
# normally — exactly how the real install works through the ~/.config/nvim symlink.
#
# Usage:   bash .claude/vim-audit/validate.sh [repo_root]
# Exit:    0 = clean boot (gate PASS)
#          1 = config errors on boot (gate FAIL)
#          2 = inconclusive (nvim missing / setup failure) — treat as FAIL for auto-merge

set -u

# --- locate repo root (dir containing vimrc + init.vim) -----------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${1:-$(cd "$SCRIPT_DIR/../.." && pwd)}"

if [[ ! -f "$REPO_ROOT/vimrc" || ! -f "$REPO_ROOT/init.vim" ]]; then
  echo "GATE INCONCLUSIVE: $REPO_ROOT does not look like the vimrc repo (no vimrc/init.vim)." >&2
  exit 2
fi

if ! command -v nvim >/dev/null 2>&1; then
  echo "GATE INCONCLUSIVE: 'nvim' not found on PATH. Install Neovim in the sandbox first," >&2
  echo "then re-run. (Optional language tools improve coverage: node for coc, gopls, mix.)" >&2
  exit 2
fi

echo "== validate.sh =="
echo "repo:  $REPO_ROOT"
echo "nvim:  $(nvim --version | head -1)"

# --- isolated, throwaway config/data/state homes ------------------------------
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
export XDG_CONFIG_HOME="$TMP/config"
export XDG_DATA_HOME="$TMP/data"
export XDG_STATE_HOME="$TMP/state"
export XDG_CACHE_HOME="$TMP/cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"
ln -s "$REPO_ROOT" "$XDG_CONFIG_HOME/nvim"

# --- pass 1: install plugins (network noise here is NOT a gate signal) ---------
echo "-- installing plugins (vim-plug) --"
nvim --headless +'silent! PlugInstall --sync' +qa >/dev/null 2>"$TMP/install.log" || true
if grep -qiE 'error|fail' "$TMP/install.log"; then
  echo "   (plugin install reported issues — see below; not fatal unless boot fails)"
  sed 's/^/   /' "$TMP/install.log"
fi

# --- pass 2: clean boot is the GATE ------------------------------------------
# In headless mode Neovim writes config errors (E### etc.) to stderr.
echo "-- boot check --"
BOOT_ERR="$TMP/boot.err"
nvim --headless +'qall!' 2>"$BOOT_ERR"

# Filter for genuine Vim error signatures; ignore empty/benign lines.
if grep -qE '^E[0-9]+:|Error detected|^line [0-9]+:' "$BOOT_ERR"; then
  echo "GATE FAIL: config produced errors on boot:" >&2
  sed 's/^/  /' "$BOOT_ERR" >&2
  exit 1
fi

if [[ -s "$BOOT_ERR" ]]; then
  echo "   (non-empty stderr, but no recognized error signature — review:)"
  sed 's/^/   /' "$BOOT_ERR"
fi

echo "GATE PASS: config boots cleanly."
exit 0
