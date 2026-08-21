# MiguelMiguel — Test Strategy

> **Superseded:** This document describes the earlier web-game test plan. Do not use it as implementation authority for the Godot visual novel. See `TECHNICAL_DESIGN.md` and `PRODUCTION_MILESTONES.md`.

**Status:** Gates 1–3 planning draft
**Quality target:** deterministic, accessible, concurrency-safe, and explainable portfolio MVP

## 1. Quality risks

The highest-risk failures are not cosmetic. They are:

- a player can no longer solve a case from the public evidence available;
- the client sees hidden identity or solution data early;
- a paid action duplicates, disappears, or spends from stale state;
- a player reads the wrong subject as “real” because of an accidental visual cue;
- progress or guest ownership crosses users;
- mobile/keyboard/screen-reader players cannot complete the critical journey;
- a content change invalidates a previously published case version.

Testing prioritizes these risks before broad UI snapshot coverage.

## 2. Test layers

### 2.1 Static and schema checks

- Python formatting/linting/type checking.
- TypeScript type checking and frontend lint.
- JSON/Pydantic validation for every case definition.
- Localization-key completeness and duplicate stable-ID checks.
- Dependency audit, lockfile consistency, and container scan where available.
- Production artifact scan for private case strings, role fields, and solution-graph keys.

### 2.2 Pure case-engine unit tests

The case engine is a pure, table-driven module with no HTTP, database, clock, or random dependency. Test:

- prerequisites and question/evidence reachability;
- target modes and action costs;
- exact trust/stress/hostility transitions;
- qualitative state thresholds;
- follow-up/evidence unlocks;
- refusal, recollection, challenged, and redacted response variants;
- valid and invalid typed connections;
- hint penalties;
- score category boundaries and grade cutoffs;
- allowed conclusions per case;
- Case 5 factual score versus moral epilogue;
- early accusation and completed-run immutability.

Property invariants:

- IP never increases unexpectedly.
- State versions are monotonic.
- Every transition is deterministic for the same seed, state, and action.
- Hidden fields never enter public projections.
- Required nodes remain reachable.
- A completed run cannot mutate.
- Validated links are a subset of submitted links and authored links.

### 2.3 API and database integration tests

Use a deterministic PostgreSQL test database with migrations and case seeds. Use Redis test fixtures for rate limiting and short-lived coordination.

Cover:

- health liveness/readiness;
- registration, login, logout, session expiry, password reset;
- guest creation, expiry, claim, and already-owned account behavior;
- campaign case ordering and progress;
- run creation, server-side A/B assignment, begin, resume;
- all paid actions with insufficient IP, stale version, duplicate idempotency, and altered-payload replay;
- two concurrent actions on one run;
- accusation exactly once and debrief gating;
- notebook/note bounds and ownership;
- user A cannot read or mutate user B's runs, notes, connections, progress, accusations, debriefs, or settings;
- one guest cannot claim/access another guest's run;
- published-version retirement with active run continuation;
- unavailable PostgreSQL/Redis safe failure behavior;
- generic password reset responses and single-use tokens.

Avoid asserting private solution fields in pre-accusation responses except through explicit negative assertions that the fields are absent.

### 2.4 Frontend component and interaction tests

Use React Testing Library or equivalent semantic interaction tests. Assert:

- target/cost preview before a paid action;
- both subject answers are labeled and comparable;
- state indicators include text/icon, not color-only meaning;
- focus moves to a new response/unlock and does not jump unexpectedly;
- loading, error, retry, autosave, offline, and session-expired states;
- keyboard navigation and modal focus behavior;
- ARIA announcements for actions/unlocks/errors/restored state;
- reduced-motion and high-contrast presentation states;
- note draft recovery when autosave fails;
- mobile compare-responses view and no horizontal primary scrolling;
- accusation validation and irreversible confirmation;
- debrief step navigation and factual/moral separation for Case 5.

Do not use snapshots as the primary assertion strategy. Use role/name/state/visible-content assertions and focused visual regression only where layout relationships are critical.

### 2.5 End-to-end journeys

Playwright is the required browser baseline. Chromium is required; Firefox/WebKit are added when stable within CI budget. CI uses retries only, trace on first retry, screenshots on failure, and video on failure if storage permits. Authentication storage fixtures avoid repeating UI login in every test.

Proposed journeys requiring product approval before implementation:

1. Guest starts Case 1, spends IP, refreshes, accuses, and reaches debrief.
2. User registers, completes a case, logs out/in, and sees synchronized progress.
3. Guest progress is claimed by a new account.
4. Player creates and validates an evidence connection.
5. Wrong or incomplete accusation receives the appropriate debrief.
6. Expired session during a run recovers without losing committed progress.
7. Network failure after an action does not double-spend IP on retry.
8. User A cannot access User B's run.

Each approved journey covers the happy path plus relevant failures: invalid input, expired session, network failure, empty data, stale state, and forbidden access.

## 3. Case-definition validation matrix

| Check | Failure example | Gate |
| --- | --- | --- |
| Schema | Missing stable ID, unsupported enum, unbounded text | import/CI |
| References | Question points to missing fact/localization/evidence | import/CI |
| Reachability | Required node cannot unlock from briefing | CI |
| No cycles | Follow-up prerequisites deadlock | CI |
| Solvability | No allowed conclusion has a public evidence path | reviewer + CI |
| Fairness | One UI cue or single emotion predicts role | narrative review |
| Projection | Private role/profile/solution field appears early | API contract |
| Scoring | Wrong rationale receives unjustified pass | engine + reviewer |
| Versioning | Active run would observe changed definition | migration/integration |

## 4. Responsive and accessibility verification

Manual smoke matrix:

| Mode | Viewports/devices | Checks |
| --- | --- | --- |
| Desktop | 1280×800, 1440×900 | three-region layout, persistent dock, long dialogue |
| Tablet | 768×1024, 1024×768 | subject pair above console, evidence drawer |
| Mobile | 320×844, 390×844 | tabs, sticky IP/action bar, compare responses, no horizontal scroll |
| Zoom | 200% | content order and no clipped controls |
| Keyboard | desktop | full critical journey with visible focus |
| Screen reader | NVDA/VoiceOver smoke path | labels, announcements, subject distinction |
| Motion | reduced-motion preference | no essential information hidden in animation |
| Contrast | high-contrast setting | borders, disabled/selected/focus states |

Automated axe checks supplement, but do not replace, manual accessibility review.

## 5. Failure-injection matrix

| Scenario | Expected behavior |
| --- | --- |
| Refresh during answer transition | Reload authoritative state; no duplicate action |
| Back/forward during run | Preserve route safety; reconcile state or return to current run |
| Two tabs, same state version | One commits; other receives 409 and safe refresh path |
| Timeout after server commit | Retry same idempotency key returns original result |
| Reused key, different payload | 409 idempotency conflict; no state mutation |
| Insufficient IP from stale client | 409/422 safe error; no negative IP |
| Accusation twice | First result immutable; second returns existing completion safely |
| Debrief before accusation | 409/403/404 safe gate; no private data |
| Locked question/evidence direct request | Not found/locked response without hidden text |
| Session expires mid-case | Recovery prompt and authoritative reload |
| Guest expires before claim | Clear recovery/expiry path; no cross-owner fallback |
| DB unavailable | 503 safe error; client keeps unsent draft only |
| Redis unavailable | Fail closed for protected operations or use documented degraded policy |

## 6. CI foundation

Pull request workflow should run:

1. dependency install from lockfiles;
2. formatting/lint/type checks;
3. case schema and solvability validation;
4. migration up/down smoke and deterministic seed;
5. unit tests;
6. API integration tests with PostgreSQL/Redis services;
7. frontend component tests;
8. production build;
9. approved E2E journeys;
10. artifact/security scans.

Required scripts:

```text
test:e2e
test:e2e:ui
test:e2e:ci
```

`docs/TESTING.md` will document local and CI execution when the implementation scaffolding exists.

## 7. Test data and isolation

- Seed all five cases from committed validated definitions.
- Use test-only users, guests, and deterministic credentials.
- Clean database state between integration suites or use transaction-isolated fixtures.
- Never commit real account data, production reset tokens, or player notes.
- Keep one fixture for each case's minimum solve path, a plausible wrong theory, an invalid connection, a locked-node request, and a completed run.

## 8. Exit criteria

The MVP test gate is met when:

- all five case definitions pass schema/reachability/solvability/hidden-data validation;
- unit/integration/component coverage protects critical domain and failure paths;
- approved E2E journeys pass locally and in CI;
- the core journey passes keyboard and automated accessibility checks with manual review documented;
- production build, migration/seed, health, security, and artifact scans pass;
- no Critical or High security finding remains unresolved after the approved remediation cycle.
