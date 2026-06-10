#!/bin/bash
# setup.sh — Initialize a new Claude Code project from the boilerplate
# Usage: ./setup.sh

set -e

echo "=== Claude Code Boilerplate Setup ==="
echo ""

# Input
read -p "Project name (e.g. MyApp): " PROJECT_NAME
read -p "Invariant files to never touch (e.g. legacy.py, data/): " INVARIANT_FILES

echo ""
echo "Configuration:"
echo "  Project:         $PROJECT_NAME"
echo "  Invariant files: $INVARIANT_FILES"
echo ""
read -p "Confirm? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
  echo "Cancelled."
  exit 0
fi

# Replace placeholders in CLAUDE.md
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" CLAUDE.md
sed -i "s/{{INVARIANT_FILES}}/$INVARIANT_FILES/g" CLAUDE.md

# Replace placeholders in docs/architecture.md
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" docs/architecture.md
sed -i "s/{{PROJECT_DIR}}/$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')/g" docs/architecture.md

# Replace placeholders in docs/lessons.md
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" docs/lessons.md

# Create CLAUDE_MEMORY.md from template
TODAY=$(date +%Y-%m-%d)
sed "s/{{DATA}}/$TODAY/g" CLAUDE_MEMORY.md.template \
  | sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
  > CLAUDE_MEMORY.md

echo ""
echo "✓ CLAUDE.md configured"
echo "✓ docs/architecture.md configured"
echo "✓ docs/lessons.md configured"
echo "✓ CLAUDE_MEMORY.md created (gitignored)"
echo ""
echo "Next steps:"
echo "  1. Fill in docs/architecture.md with your project architecture"
echo "  2. Start Claude Code: claude"
echo "  3. Approve the @docs/architecture.md and @docs/lessons.md imports when prompted"
echo ""
echo "Optional:"
echo "  - Install Graphify: pip install graphifyy && graphify install"
echo "  - Then inside Claude Code: /graphify . --mode deep"
