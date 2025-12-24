#!/bin/bash
# Sync conductor-skill with upstream conductor repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPSTREAM_DIR="$SCRIPT_DIR/upstream"

echo "=== Conductor Skill Sync Script ==="
echo

# Step 1: Clone or update upstream conductor
if [ -d "$UPSTREAM_DIR/.git" ]; then
    echo "→ Pulling latest from upstream conductor..."
    cd "$UPSTREAM_DIR"
    git pull origin main
else
    echo "→ Cloning upstream conductor..."
    rm -rf "$UPSTREAM_DIR"
    git clone https://github.com/gemini-cli-extensions/conductor.git "$UPSTREAM_DIR"
fi

UPSTREAM_COMMIT=$(cd "$UPSTREAM_DIR" && git rev-parse --short HEAD)
UPSTREAM_DATE=$(cd "$UPSTREAM_DIR" && git log -1 --format=%ci HEAD)

echo
echo "✓ Upstream updated to commit: $UPSTREAM_COMMIT ($UPSTREAM_DATE)"
echo

# Step 2: Copy templates
echo "→ Copying templates from upstream..."
cp "$UPSTREAM_DIR/templates/workflow.md" "$SCRIPT_DIR/templates/"
mkdir -p "$SCRIPT_DIR/templates/code_styleguides"
cp -r "$UPSTREAM_DIR/templates/code_styleguides/"* "$SCRIPT_DIR/templates/code_styleguides/"
echo "✓ Templates updated"
echo

# Step 3: Extract prompts from TOML files
echo "→ Extracting prompts from TOML files..."
mkdir -p "$SCRIPT_DIR/commands"

for cmd in setup newTrack implement status revert; do
    # Convert command name to file naming convention
    case $cmd in
        newTrack) outfile="new-track.md" ;;
        *) outfile="${cmd}.md" ;;
    esac

    echo "  - Extracting $cmd → commands/$outfile"
    cat "$UPSTREAM_DIR/commands/conductor/${cmd}.toml" | \
        sed -n '/^prompt = """/,/^"""/p' | \
        sed '1d;$d' > "$SCRIPT_DIR/commands/$outfile"
done

echo "✓ Prompts extracted"
echo

# Step 4: Update version info
cat > "$SCRIPT_DIR/VERSION.md" << EOF
# Conductor Skill Version Info

**Last Synced:** $(date +%Y-%m-%d)

**Upstream Commit:** $UPSTREAM_COMMIT

**Upstream Date:** $UPSTREAM_DATE

**Upstream Repository:** https://github.com/gemini-cli-extensions/conductor

## What Changed

Run \`git log ${UPSTREAM_COMMIT}..HEAD\` in upstream/ to see changes since last sync.
EOF

echo "=== Sync Complete ==="
echo
echo "Files updated:"
echo "  - templates/workflow.md"
echo "  - templates/code_styleguides/*"
echo "  - commands/*.md"
echo "  - VERSION.md"
echo
echo "Review the changes and test the skill before committing."
