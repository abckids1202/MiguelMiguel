# MiguelMiguel — Product Requirements Document

**Status:** Gates 1–3 planning draft
**Audience:** product, narrative, design, engineering, QA, security, and case authors
**Release target:** polished portfolio MVP, five handcrafted cases
**Primary platform:** desktop-first responsive web application

## 1. Product summary

MiguelMiguel is a deterministic psychological deduction game set inside the Palinode Institute, a private facility that validates identities after a memory-reconstruction experiment produces two physically identical people. Both subjects have Miguel's face, voice, habits, and memories. Both claim to be the original. The player is a junior identity examiner who must build a defensible theory from interviews, records, objects, witness statements, and contradictions.

The central question is not simply “which one is fake?” The game progressively separates factual recall, emotional meaning, motive, guilt, and personhood. The player should leave each case able to explain the conclusion through a traceable combination of evidence and logical links, while accepting that the final case may support more than one morally defensible interpretation.

The MVP is single-player, English-first, guest-friendly, and free of monetization. Narrative content is authored and versioned. No runtime LLM, procedural mystery generation, multiplayer, voice recognition, or public user-generated content is part of this release.

## 2. Problem statement

Players who enjoy deduction games and psychological mystery want clues that reward attention rather than author-guessing. Many mystery interfaces either hide the reasoning model behind arbitrary branching or overcomplicate the interaction with detective busywork. MiguelMiguel addresses this by making every meaningful deduction explainable: paid actions are limited, responses are deterministic, evidence can be pinned and connected, and the debrief shows how the authored solution graph supports or weakens the player's theory.

The product must serve two needs at once:

1. A mystery player needs fair, discussable logic and meaningful uncertainty.
2. A curiosity-driven casual player needs a readable tutorial, strong recaps, clear action costs, and optional hints that keep progress moving.

## 3. Target users and personas

### Persona A — Theory builder

- **Age:** 16–28
- **Enjoys:** deduction games, psychological fiction, unreliable narrators, and theory discussion.
- **Wants:** fair clues, meaningful twists, and the ability to explain why an answer is correct.
- **Frustrated by:** solutions that depend on guessing the author's intention, personality stereotypes, or one arbitrary trivia detail.
- **Design implication:** every score-bearing conclusion needs a visible evidence trail; behavior is contextual evidence, never a proof shortcut.

### Persona B — Curious newcomer

- **Age:** 14–30
- **Attracted by:** the two-identical-people premise and strong visual presentation.
- **Does not want:** memorizing dozens of facts or learning a complicated detective interface.
- **Needs:** a good tutorial, readable recaps, clear available actions, and optional hints that reduce score rather than blocking progress.
- **Design implication:** Case 1 teaches the loop, the notebook summarizes rather than duplicates the entire transcript, and mobile includes a compare-responses view.

## 4. Product principles

1. **Uncertainty is a feature.** Subject position, color, portrait treatment, confidence, stress, and response speed never encode the official identity. A/B roles are assigned server-side per run.
2. **Every clue earns its meaning.** A fact becomes useful through context, a boundary, a contradiction, a corroboration, or a motive. No single nervous gesture proves a copy.
3. **Reasoning is visible and authored.** The player may form private hypotheses, but only validated case-definition links affect reasoning score. The debrief explains the logic rather than revealing a magic answer.

## 5. Goals and non-goals

### MVP goals

- Deliver five complete, handcrafted cases from briefing through debrief.
- Make Case 1 an integrated tutorial for questioning, pinning, follow-ups, evidence, and accusation.
- Preserve guest play while supporting secure account-backed progress and cross-device continuation.
- Make Inquiry Points, state changes, unlocks, and scoring server-authoritative and concurrency-safe.
- Provide a restrained archival laboratory visual identity with responsive desktop, tablet, and mobile layouts.
- Make the public browser projection incapable of exposing hidden solutions before a finalized accusation.
- Ship automated coverage for the pure case engine, critical API paths, accessible UI states, and approved Playwright journeys.

### Non-goals for the MVP

- Additional case packs or daily seeded challenges.
- Procedural cases, runtime LLM/generative AI, or community-authored cases.
- Voice acting, voice recognition, cooperative or multiplayer investigation.
- Native desktop/mobile packaging.
- Payments, advertisements, loot boxes, or other monetization.
- Public chat, social feeds, or a large administrative CMS.
- Real biometric identity detection or photorealistic deepfake technology.

## 6. User stories

### Discovery and access

- As a curious player, I want to play as a guest so that I can reach Case 1 without an account.
- As a returning player, I want to resume my active run after refresh so that a connection interruption does not erase committed progress.
- As a guest who enjoyed the game, I want to convert to an account without losing my run so that I can continue on another device.
- As an account holder, I want to see unlocked cases, best scores, grades, and achievements so that my campaign progress has a clear home.

### Investigation

- As an examiner, I want to preview a question's target and IP cost so that I can spend limited actions deliberately.
- As an examiner, I want both subjects' answers presented in a comparable layout so that I can reason from differences without relying on memory.
- As an examiner, I want to pin statements and evidence, add notes, and connect items as contradiction, corroboration, motive, knowledge leak, or emotional mismatch so that I can maintain a theory.
- As an examiner, I want qualitative trust, stress, and hostility states so that I can read the room without being given a fake-detection meter.
- As an examiner, I want optional hints to reduce score rather than stop progress so that I can recover from uncertainty.

### Decision and learning

- As an examiner, I want to accuse early if I am confident so that judgment is part of the game rather than a forced checklist.
- As an examiner, I want to cite two or three sources, select a copy strategy, and set confidence so that my reasoning is explicit.
- As a player, I want a step-by-step debrief that separates conclusion accuracy from reasoning quality so that I can learn from a wrong or incomplete theory.
- As a player, I want Case 5's factual discoveries separated from its moral epilogue choice so that philosophical disagreement does not rewrite objective evidence.

## 7. MVP feature requirements and acceptance criteria

### 7.1 Landing, tone notice, and guest entry

**Requirement:** Present the premise, tone, and a clear “Play as Guest” action without exposing case solutions.

**Acceptance criteria:**

- The landing page identifies the Palinode Institute setting and the two-Miguels premise.
- A content/tone notice appears before Case 1 begins.
- Guest creation returns an opaque guest credential managed by the server; no secret is stored in localStorage.
- A guest can reach Case 1 briefing in one coherent path.
- If guest creation fails, the player sees a safe retryable error and no partial run is created.

### 7.2 Authentication and guest conversion

**Requirement:** Support registration, login, logout, password reset, session expiry, and transactional guest-to-account conversion.

**Acceptance criteria:**

- Authentication uses opaque server-side sessions in secure HttpOnly cookies.
- Passwords are hashed with Argon2id; reset tokens and session identifiers are hashed at rest.
- Password-reset responses do not reveal whether an email exists.
- Login and ownership transitions rotate the session identifier.
- Claiming a guest transfers eligible progress exactly once, then invalidates the guest credential.
- Cross-user and cross-guest access tests fail closed.

### 7.3 Campaign archive and progress

**Requirement:** Show five case entries with locked/unlocked/completed states, scores, best grade, and resume/start actions.

**Acceptance criteria:**

- Case order and unlock rules are server-derived.
- A guest can progress in the current run; an account can retrieve progress on a new session/device.
- A completed case cannot be mutated by replaying an old action.
- Case version used by an active run remains immutable even if a published version is retired.

### 7.4 Briefing and run creation

**Requirement:** A briefing explains the verified public record, incident summary, objective, starting IP, and available outcome types.

**Acceptance criteria:**

- Run creation assigns A/B subject positions server-side using secure randomness or a securely stored run seed.
- Briefing contains only public case content.
- Starting IP and permitted conclusions come from the server case definition.
- The player can leave and resume without creating duplicate active runs unless replay is explicitly supported.

### 7.5 Interrogation and action economy

**Requirement:** Players choose topics/questions, preview cost and target, receive authored answers, and spend IP only once per committed paid action.

**Acceptance criteria:**

- Standard and follow-up questions cost 1 IP; evidence/witness/record requests cost 2 IP; direct challenges cost 1 IP; hints cost 1 IP unless the case definition overrides within the documented bounds.
- Mutating actions require `Idempotency-Key` and expected `state_version`.
- A repeated key with the same payload returns the original result without a second spend.
- A repeated key with a different payload is rejected.
- Stale state returns 409 with safe current-state metadata.
- Concurrent tabs cannot duplicate an IP spend.
- Question text and evidence metadata remain locked until prerequisites are met.

### 7.6 Subject state and response projection

**Requirement:** Track exact backend integers for trust, stress, and hostility while displaying qualitative states.

**Acceptance criteria:**

- The UI displays states such as Calm, Guarded, Strained, or Volatile and does not expose exact numeric values.
- Both subject booths support the same visual capability set and semantic labels.
- State transitions are deterministic and case-authored.
- Stress can unlock a genuine memory, error, refusal, or misleading speech according to authored rules; no global fake heuristic exists.
- A response includes facts asserted/concealed and unlocks only through the public projection needed to continue play.

### 7.7 Evidence, notebook, and connections

**Requirement:** Players examine evidence, pin sources, write bounded notes, update private suspicion estimates, and create typed connections.

**Acceptance criteria:**

- Pinning, notes, review, and suspicion changes are free actions.
- Evidence examination and witness/record requests consume IP atomically.
- Connections remain hypotheses until validated by the server against the case solution graph.
- Invalid connections do not reveal the correct answer.
- Only validated links contribute to reasoning score.
- Notes are plain text, bounded, recoverable locally if autosave fails, and never sent as analytics.

### 7.8 Accusation and scoring

**Requirement:** Require an explicit irreversible accusation with conclusion, sources, copy strategy, and confidence.

**Acceptance criteria:**

- The player selects Miguel A, Miguel B, both are copies, or identity cannot be resolved only when the case permits it.
- Exactly two or three source IDs are required and validated against the current run.
- The server derives correctness, reasoning, efficiency, strategy, calibration, and grade.
- Accusation is immutable and idempotent.
- A wrong conclusion can earn limited reasoning credit but cannot pass unless the case explicitly supports an unresolved philosophical choice.
- The player must confirm a consequence summary before submission.

### 7.9 Debrief and progression

**Requirement:** Reveal the solution step by step after accusation, grade the player's reasoning, show missed clues and false assumptions, and update campaign progression.

**Acceptance criteria:**

- Debrief cannot be fetched before a finalized accusation.
- Hidden identity/profile fields are revealed only in the debrief projection allowed by the completed run.
- The debrief separates factual conclusion, evidence quality, validated links, efficiency, copy-strategy identification, and confidence calibration.
- Case 4 explicitly distinguishes identity evidence from guilt evidence.
- Case 5 separates objective discoveries from the moral epilogue branch.

### 7.10 Settings, accessibility, and resilience

**Requirement:** Provide reduced motion, high-contrast support, readable typography, keyboard navigation, loading/error/offline states, and session recovery.

**Acceptance criteria:**

- Core journey is keyboard-completable with visible focus.
- ARIA live announcements describe new answers, unlocks, errors, and restored progress without duplicating entire transcripts.
- `prefers-reduced-motion` removes nonessential transitions and narrative reveals.
- Refresh during an answer transition reconciles to authoritative state without double-spending.
- Network timeout after server commit offers safe retry and state reload.
- Mobile remains usable without horizontal scrolling and includes compare-responses mode.

## 8. Case catalogue

These are the MVP's authored case spines. Full bibles, timelines, question trees, evidence objects, solution graphs, scoring rubrics, and debrief copy are governed by [`CASE_AUTHORING.md`](CASE_AUTHORING.md) and must pass its validation gates before publication.

| Case | Working title | Copy strategy | Core lesson | Difficulty | Allowed conclusions |
| --- | --- | --- | --- | --- | --- |
| 1 | The Familiar Error | Incomplete copy | Official facts and preferences are not enough; childhood sequence exposes a boundary | Accessible tutorial | A, B |
| 2 | The Unwritten Afternoon | Pattern mimic | Accurate events can still be placed in an impossible sequence; an unreliable witness is not a shortcut | Moderate | A, B |
| 3 | The Weight of Water | Memory thief | Factual recall differs from emotional and causal understanding; sensory detail supports but does not prove | Moderate | A, B |
| 4 | The Clean Lie | Manipulator | Guilt and identity evidence must be separated; the liar may be the original | Hard but fair | A, B |
| 5 | The Continuity Problem | Corrupted reconstruction | Biological or chronological priority may not settle moral identity | Conceptual finale | A, B, unresolved identity, or both copies as authored by the case |

Each case targets roughly 15–25 minutes after Case 1. Case 1 contains 10–12 base questions, 4–6 follow-ups, 3 evidence items, and at least two independent solution paths. Case 2 contains 14–18 base questions, 6–8 follow-ups, 5 evidence items, one unreliable witness, and one plausible red herring. Case 3 includes a document, object, and witness statement. Cases 4 and 5 must prove the premise's ethical complexity without relying on fear, gore, or a fixed behavioral tell.

## 9. Core gameplay loop

1. **Briefing:** read the verified public record, incident summary, objective, and action budget.
2. **Initial statements:** hear Miguel A and Miguel B separately explain why they believe they are real.
3. **Interrogate:** select a topic/question; both answer unless explicitly individual.
4. **Observe:** read wording, confidence, emotion, gestures, and follow-up unlocks as fallible evidence.
5. **Investigate:** spend IP on documents, objects, recordings, witnesses, or records.
6. **Record:** pin statements/evidence, annotate, adjust private suspicion, and connect sources.
7. **Pressure:** challenge statements, present evidence, or ask high-pressure follow-ups.
8. **Accuse:** select outcome, cite sources, choose strategy, and declare confidence.
9. **Debrief:** reveal the authored solution, score the theory, show missed evidence, and advance progression.

## 10. Inquiry Points and state rules

| Action | Default cost | Notes |
| --- | ---: | --- |
| Standard question | 1 IP | Target and cost previewed before confirmation |
| Follow-up question | 1 IP | Requires authored prerequisites |
| Examine evidence | 2 IP | Paid only once per evidence item unless definition says replay is free |
| Call witness/request record | 2 IP | Authored unlock and rate limits apply |
| Direct challenge/present evidence | 1 IP | Requires a statement/evidence target |
| Optional hint | 1 IP | Reduces maximum grade |

Starting IP is case-defined, normally 10–14. Exact trust, stress, and hostility values live server-side. The UI maps ranges to authored qualitative labels. State deltas are applied in a transaction with action deduplication and optimistic concurrency.

## 11. Scoring model

The server scores each completed run on a transparent 100-point scale:

- Conclusion accuracy: 0–40
- Evidence quality: 0–25
- Valid logical connections: 0–15
- Efficiency/IP remaining: 0–10
- Copy-strategy identification: 0–5
- Confidence calibration: 0–5

Hints subtract from the maximum achievable score. Suggested grades are S (90–100), A (80–89), B (70–79), C (55–69), and D (below 55). Case 5 records factual discovery score separately from the moral epilogue choice.

## 12. Data model sketch

The authoritative relational model is specified in [`ARCHITECTURE.md`](ARCHITECTURE.md). Core entities are:

- `users`, `sessions`, `password_reset_tokens`, `guest_credentials`
- `cases`, immutable `case_versions`, validated case-definition payloads
- `runs`, `run_actions`, `run_unlocks`, `run_subject_states`
- `statements`, `evidence_items`, `notebook_items`, `connections`, `accusations`, `accusation_sources`
- `user_case_progress`, `achievements`, `user_achievements`, `audit_events`

Private case definitions and solutions are server-side only. The frontend receives public projections scoped to the current run and phase.

## 13. Edge cases and failure states

- Refresh or back/forward navigation during answer transition.
- Two tabs submit different questions from the same `state_version`.
- Request timeout after server commit; retry must not duplicate IP.
- Stale client believes IP remains; server rejects with current safe state.
- Reused idempotency key with altered payload.
- Accusation submitted twice or attempted after completion.
- Locked question/evidence requested directly.
- Guest or account ownership mismatch.
- Session expires mid-case.
- Guest token expires before claim; claim target already has an account.
- Published case version retires while an active run continues.
- Invalid/cyclic case definition or missing localization key.
- Empty notebook/evidence board.
- Note exceeds limit or autosave fails.
- PostgreSQL or Redis unavailable.
- Password reset token expires, is reused, or is tampered with.
- Reduced motion, high contrast, long dialogue, long evidence names, narrow mobile viewport.

For every failure, preserve authoritative progress, return a stable machine-readable error code, avoid hidden-solution leakage, and make the next safe action obvious.

## 14. Success metrics and guardrails

### Product metrics

- At least 80% of players who begin Case 1 complete the tutorial.
- At least 65% of tutorial completers start Case 2.
- Median first-attempt duration for Cases 2–4 is 15–25 minutes.
- At least 70% of Case 2 completers create one valid evidence connection without a hint.
- At least 80% of usability testers can explain one valid reason for their accusation.

### Quality and fairness guardrails

- Wrong answers distribute across plausible hypotheses; a misleading UI cue must never predict identity.
- Zero solution fields are exposed before accusation in automated contract tests.
- Zero cross-user object access in authorization tests.
- WCAG 2.2 AA automated checks plus manual keyboard and screen-reader review of the core journey.
- CI passes lint, types, migrations, unit, integration, build, and approved E2E journeys.
- LCP target under 2.5s and INP target under 200ms on a reasonable mid-range laptop after production optimization.

## 15. Open questions and recommended defaults

These are the only remaining decisions that can materially affect implementation. They are intentionally recorded rather than silently invented.

| Question | Recommended default | Consequence if accepted | Blocking? |
| --- | --- | --- | --- |
| Which email delivery provider should send password reset mail? | Use a local development console adapter and a production SMTP/API adapter behind one interface | Reset-flow integration remains testable without committing to a vendor | No for Gate 1–3; yes before production auth |
| Are account passwords/email required for the portfolio demo, or should auth be feature-flagged? | Implement real auth in MVP; keep guest play first-class | More work, but preserves the explicit cross-device requirement | No |
| Should an active run resume automatically or ask the player? | Ask with “Resume” and “Restart case” only when replay is supported | Prevents accidental overwrite and makes intent clear | No |
| What is the production deployment target? | Containerized API + managed PostgreSQL/Redis + static frontend host | Keeps local/CI/prod topology aligned | No for planning; yes before deployment |
| How much of Case 5's unresolved ending should affect campaign unlock? | Unlock next content on completion; grade factual reasoning separately from epilogue preference | Avoids treating a philosophical choice as a binary identity test | No |

No application code should be written until this planning gate is approved. The next approval gate should confirm the wireframes, API projection boundary, case-definition schema, and the five case spines.
