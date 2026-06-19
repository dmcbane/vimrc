#!/usr/bin/env bash
#
# protect-preserved.sh — OPTIONAL defense-in-depth PreToolUse hook.
#
# Blocks Edit/Write to files that contain hand-written code the owner wants kept.
# This is belt-and-suspenders: the vim-config-auditor already treats these as
# read-only, and cloud runs land on branches/PRs you review. Enable this ONLY if
# you want a hard stop — note it will also block YOUR OWN Claude-driven edits to
# these files until you disable it.
#
# Enable by adding to .claude/settings.json (confirm hook schema for your Claude
# Code version with `claude --help` / docs first):
#
#   {
#     "hooks": {
#       "PreToolUse": [
#         { "matcher": "Edit|Write",
#           "hooks": [ { "type": "command",
#                        "command": "bash .claude/vim-audit/protect-preserved.sh" } ] }
#       ]
#     }
#   }
#
# Protocol: reads the tool-call JSON on stdin; exit 0 = allow, exit 2 = block.

set -u
INPUT="$(cat)"

# Extract the target path (prefer jq; fall back to grep).
if command -v jq >/dev/null 2>&1; then
  FP="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty')"
else
  FP="$(printf '%s' "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*:[[:space:]]*"//;s/"$//')"
fi

[ -z "$FP" ] && exit 0

# Files holding preserved hand-written code (see vim-config-auditor "NEVER TOUCH").
case "$FP" in
  */vimrc|*/settings/initfiles.vim|*/settings/elixir.vim|*/settings/tabs.vim|*/settings/nerdtree.vim)
    echo "BLOCKED: $FP holds preserved hand-written config (TwiddleCase, SourceDirectory," >&2
    echo "ReloadVimrc, EditInitFiles, mix-format, per-filetype indents, NERDTree autocmds)." >&2
    echo "Propose changes via a review PR instead, or disable this hook to edit it yourself." >&2
    exit 2
    ;;
esac
exit 0
