# Lezioni Imparate — {{PROJECT_NAME}}

Lezioni operative emerse durante lo sviluppo. Da consultare prima di implementare qualcosa di nuovo.

---

## Generali (universali)

**CLAUDE_MEMORY.md: gitignore dipende dall'ambiente**
In uso locale (CLI/IDE), aggiungere `CLAUDE_MEMORY.md` al `.gitignore` per non committarlo.
In uso web (claude.ai/code / remote environment), il file va committato e pushato ad ogni fine sessione,
altrimenti Claude non lo trova all'avvio della sessione successiva (l'ambiente è efimero e non persiste).

**Ogni unità di lavoro è indipendente**
Un errore su un elemento non deve mai bloccare gli altri. Pattern: `try/except` per elemento nel loop principale, log dell'errore, `continue`.

**Lazy loading per moduli pesanti**
Moduli con import costosi (ML, cloud SDK, scraping) vanno importati solo quando la funzionalità viene effettivamente usata, non al top-level. Evita timeout e startup lenti.

**Batch prima di parallelizzare**
Pre-carica tutti i dati necessari in un unico batch prima di parallelizzare con thread/async. Ogni thread che fa I/O separato moltiplica i costi e i tempi.

**Singleton per client costosi**
Client verso API esterne (DB, cloud, LLM) vanno istanziati una volta sola e riusati. Usa cache/decorator appropriati per il framework in uso.

---

## Database

**Evita query N+1**
Una query per elemento in un loop è sempre un bug di performance. Sostituire con una query batch con `IN (...)` o `UNNEST`.

**Indici su colonne filtrate frequentemente**
Qualsiasi colonna usata in `WHERE` o `ORDER BY` su tabelle grandi va indicizzata. Verificare con `EXPLAIN` prima di andare in produzione.

---

## API e Integrazioni

**Exponential backoff su tutte le chiamate esterne**
Rate limiting e errori temporanei sono la norma, non l'eccezione. Backoff: 2s → 4s → 8s → 16s, max 4 retry.

**Credenziali sempre da variabili d'ambiente**
Mai hardcodare API key, token, password nel codice o nei file committati. Usare `.env` + `.gitignore` o secret manager.

**Validare la risposta prima di usarla**
Le API esterne cambiano formato senza preavviso. Validare la struttura della risposta prima di accedere a campi specifici.

---

## Specifiche del Progetto

> Aggiungere qui le lezioni emerse durante lo sviluppo di {{PROJECT_NAME}}.

<!-- Esempio:
**Titolo lezione**
Descrizione del problema incontrato e della soluzione adottata. Includere il file/modulo coinvolto.
-->
