#!/bin/bash
# setup.sh — Inizializza un nuovo progetto Claude Code dal boilerplate
# Uso: ./setup.sh

set -e

echo "=== Claude Code Boilerplate Setup ==="
echo ""

# Input
read -p "Nome progetto (es. MyApp): " PROJECT_NAME
read -p "File invariati da non toccare mai (es. legacy.py, data/): " INVARIANT_FILES

echo ""
echo "Configurazione:"
echo "  Progetto:       $PROJECT_NAME"
echo "  File invariati: $INVARIANT_FILES"
echo ""
read -p "Confermi? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
  echo "Annullato."
  exit 0
fi

# Sostituisci placeholder in CLAUDE.md
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" CLAUDE.md
sed -i "s/{{INVARIANT_FILES}}/$INVARIANT_FILES/g" CLAUDE.md

# Sostituisci placeholder in docs/architecture.md
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" docs/architecture.md
sed -i "s/{{PROJECT_DIR}}/$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')/g" docs/architecture.md

# Sostituisci placeholder in docs/lessons.md
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" docs/lessons.md

# Crea CLAUDE_MEMORY.md da template
TODAY=$(date +%Y-%m-%d)
sed "s/{{DATA}}/$TODAY/g" CLAUDE_MEMORY.md.template \
  | sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
  > CLAUDE_MEMORY.md

echo ""
echo "✓ CLAUDE.md configurato"
echo "✓ docs/architecture.md configurato"
echo "✓ docs/lessons.md configurato"
echo "✓ CLAUDE_MEMORY.md creato (gitignored)"
echo ""
echo "Prossimi passi:"
echo "  1. Compila docs/architecture.md con l'architettura del progetto"
echo "  2. Avvia Claude Code: claude"
echo "  3. Approva gli import @docs/architecture.md e @docs/lessons.md quando richiesto"
echo ""
echo "Opzionale:"
echo "  - Installa Graphify: pip install graphifyy && graphify install"
echo "  - Poi dentro Claude Code: /graphify . --mode deep"
