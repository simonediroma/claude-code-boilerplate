# Lessons Learned — {{PROJECT_NAME}}

Operative lessons that emerged during development. Consult before implementing anything new.

---

## General (universal)

**Every unit of work is independent**
An error on one element must never block the others. Pattern: `try/except` per element in the main loop, log the error, `continue`.

**Lazy loading for heavy modules**
Modules with expensive imports (ML, cloud SDK, scraping) should be imported only when the feature is actually used, not at the top level. Avoids timeouts and slow startup.

**Batch before parallelizing**
Pre-load all required data in a single batch before parallelizing with threads/async. Each thread doing separate I/O multiplies costs and latency.

**Singleton for expensive clients**
Clients to external APIs (DB, cloud, LLM) should be instantiated once and reused. Use appropriate cache/decorator patterns for the framework in use.

---

## Database

**Avoid N+1 queries**
One query per element in a loop is always a performance bug. Replace with a batch query using `IN (...)` or `UNNEST`.

**Index frequently filtered columns**
Any column used in `WHERE` or `ORDER BY` on large tables must be indexed. Verify with `EXPLAIN` before going to production.

---

## APIs and Integrations

**Exponential backoff on all external calls**
Rate limiting and transient errors are the norm, not the exception. Backoff: 2s → 4s → 8s → 16s, max 4 retries.

**Credentials always from environment variables**
Never hardcode API keys, tokens, or passwords in code or committed files. Use `.env` + `.gitignore` or a secret manager.

**Validate the response before using it**
External APIs change format without notice. Validate the response structure before accessing specific fields.

---

## Project-Specific

> Add lessons that emerge during development of {{PROJECT_NAME}} here.

<!-- Example:
**Lesson title**
Description of the problem encountered and the solution adopted. Include the file/module involved.
-->
