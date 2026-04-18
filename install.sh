#!/usr/bin/env bash
# nodream installer - cross-agent skill/rule drop
# usage: ./install.sh <claude|codex|cursor|gemini>
# or:    curl -fsSL .../install.sh | bash -s -- <agent>

set -euo pipefail

AGENT="${1:-}"

if [ -z "$AGENT" ]; then
  cat <<EOF
nodream installer

usage: $0 <agent>

  claude   install skills to ~/.claude/skills/nodream/
  codex    append ruleset to ~/.codex/AGENTS.md
  cursor   drop rules to ./.cursor/rules/nodream.mdc (cwd)
  gemini   append ruleset to ~/.gemini/GEMINI.md

for Claude Code, the preferred install is via marketplace:
  /plugin marketplace add meherpanguluri/nodream
  /plugin install nodream@nodream
EOF
  exit 1
fi

# find the source dir. when run from clone, it's $PWD. when curl-piped, clone to temp.
if [ -f "./skills/nodream/SKILL.md" ]; then
  SRC="$PWD"
else
  TMP="$(mktemp -d)"
  echo "cloning nodream to $TMP..."
  git clone --depth=1 https://github.com/meherpanguluri/nodream.git "$TMP" >/dev/null 2>&1
  SRC="$TMP"
fi

RULESET() {
  cat "$SRC/skills/nodream/SKILL.md" "$SRC/skills/pics/SKILL.md"
}

case "$AGENT" in
  claude)
    DEST="$HOME/.claude/skills"
    mkdir -p "$DEST"
    cp -r "$SRC/skills/nodream" "$DEST/"
    cp -r "$SRC/skills/pics" "$DEST/"
    echo "installed: $DEST/nodream/ + $DEST/pics/"
    echo "tip: marketplace install is recommended instead — see README."
    ;;
  codex)
    DEST="$HOME/.codex/AGENTS.md"
    mkdir -p "$(dirname "$DEST")"
    {
      echo ""
      echo "<!-- nodream:start -->"
      RULESET
      echo "<!-- nodream:end -->"
    } >> "$DEST"
    echo "appended nodream ruleset to $DEST"
    ;;
  cursor)
    DEST="./.cursor/rules/nodream.mdc"
    mkdir -p "$(dirname "$DEST")"
    RULESET > "$DEST"
    echo "wrote rules to $DEST"
    ;;
  gemini)
    DEST="$HOME/.gemini/GEMINI.md"
    mkdir -p "$(dirname "$DEST")"
    {
      echo ""
      echo "<!-- nodream:start -->"
      RULESET
      echo "<!-- nodream:end -->"
    } >> "$DEST"
    echo "appended nodream ruleset to $DEST"
    ;;
  *)
    echo "unknown agent: $AGENT"
    echo "supported: claude, codex, cursor, gemini"
    exit 1
    ;;
esac

echo "done."
