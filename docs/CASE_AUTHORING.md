# MiguelMiguel — Case Authoring Contract

> **Superseded:** This document describes the earlier multi-case web-game plan. Do not use it as implementation authority for the Godot visual novel. See `NARRATIVE_DESIGN.md` and `SCENE_BEAT_SHEET.md`.

**Status:** Gates 1–3 planning draft
**Audience:** narrative designers, case reviewers, engine engineers, QA
**Publication rule:** no case is published until schema, reachability, solvability, fairness, and hidden-data checks pass

## 1. Authoring promise

MiguelMiguel mysteries are handcrafted, deterministic, and explainable. A player should be able to solve a case using only content they could reasonably obtain in the current run. A case may contain uncertainty, lies, withheld motives, red herrings, and morally difficult conclusions, but it may not depend on a fixed behavioral tell, an untelegraphed author intention, or an inaccessible private fact.

The case author owns the truth model. The engine owns execution, state transitions, idempotency, public projection, and score calculation. The client never receives the private profile or solution graph before accusation.

## 2. Required case package

Each case version ships as a single validated definition plus review artifacts:

```text
case-version/
├─ definition.json              # canonical authored content
├─ case-bible.md                # intent, themes, red herrings, fairness notes
├─ truth-timeline.md            # complete factual chronology
├─ public-timeline.md           # what a player can learn and when
├─ knowledge-map-original.md    # known/certain/inferred/hidden facts
├─ knowledge-map-copy.md        # copied/distorted/absent facts and strategy
├─ question-tree.md             # base questions, follow-ups, prerequisites
├─ evidence-register.md         # source inventory, costs, unlocks
├─ solution-graph.md            # valid links, weakening links, alternatives
├─ scoring-rubric.md             # conclusion and reasoning weights
├─ debrief.md                    # stepwise reveal and false assumptions
└─ solvability-review.md         # independent reviewer proof
```

The implementation may store these as source-controlled markdown plus JSON, but only validated content is imported into the server database. Private materials are never copied into frontend/public assets.

## 3. Non-negotiable authored fields

### 3.1 Case metadata

- Stable case ID, slug, version, title localization key, difficulty.
- Starting IP and per-action costs within documented bounds.
- Public briefing, incident summary, objective, tone note, and allowed conclusions.
- Copy strategy label(s), debrief title, and campaign unlock requirement.
- Minimum evidence set and at least one intended solve path; Case 1 requires two independent paths.

### 3.2 Complete private identity profile

For both the original and the copy/reconstruction, author:

- legal name, age, birthday, hometown, education, occupation;
- favorite/disliked food, color, music, place, routines;
- honesty, patience, empathy, confidence, humor, impulsiveness, shame sensitivity;
- relationships, closeness, conflict, shared memories, and protected facts;
- memories with time, location, participants, sequence, objects, sensory details, emotion, hidden cause, and certainty;
- habitual phrases, nervous gesture, thinking behavior, conversational rhythm, and lying behavior;
- secrets, motive for concealment, triggers, willingness to confess, and supporting evidence;
- knowledge boundaries tagged as original-known, copied, distorted, inferred, or absent;
- deterministic rules for questions, pressure, evidence, trust, stress, and hostility thresholds.

The profile must explain not only what is true, but why each subject would answer as authored at a particular point in the run.

### 3.3 Public content node

Every answer, evidence item, and unlockable content node includes:

- stable ID;
- speaker or target;
- question/evidence ID;
- localization key for public response text;
- optional stage direction key;
- prerequisites;
- IP cost;
- exact state deltas;
- facts asserted and concealed;
- follow-ups and evidence unlocked;
- logical connection IDs in which it may participate;
- public projection variant and debrief reference.

## 4. State and branching rules

The case engine evaluates a small deterministic transition:

```text
next_state = transition(
  case_version,
  public_run_facts,
  private_subject_state,
  action,
  expected_state_version
)
```

The transition may:

- deduct IP;
- append a statement/evidence result;
- change exact trust/stress/hostility;
- unlock follow-ups or evidence;
- reveal a fact into the public run projection;
- set a case-authored flag;
- append a safe action record.

The transition may not:

- use wall-clock time, client randomness, response latency, viewport, color, or user identity as substantive logic;
- return the hidden role or solution graph before accusation;
- increase IP except through a documented authored rule (the default case rules have no IP refunds);
- mutate a completed run;
- make a source score-bearing before the player can reasonably encounter it.

Cosmetic wording variants are allowed only when a server-provided deterministic run seed selects among variants with identical logical content and deltas.

## 5. Question-tree authoring

Question trees should mix:

- public-record confirmation;
- timeline reconstruction;
- relationship and motive questions;
- memory details;
- knowledge-boundary tests;
- emotional/causal understanding;
- pressure/challenge moments;
- fair follow-ups that respond to something the subject or evidence has already surfaced.

Each question must state its target mode (`both`, `subject_a`, `subject_b`, or `investigator_record`), cost, prerequisites, expected learning purpose, and what it does *not* prove. Individual questions are permitted when the asymmetry is narratively justified; they must not make the targeted subject's side easier to identify merely because it is individual.

### Question review checklist

- Can a first-time player tell what will be asked and what it costs?
- Is the answer different in a logical way, not just a mood or wording change?
- Does the question test a fact, sequence, knowledge boundary, motive, or emotion that matters later?
- If the answer is misleading, is the player given a route to challenge or corroborate it?
- Is the follow-up unlocked by a visible fact or state change?
- Is the question needed for the intended solve path, optional enrichment, or red herring?

## 6. Evidence and connection authoring

Evidence types are records, objects, recordings, witness statements, and documents. Each evidence item defines:

- source ID and type;
- public title and availability condition;
- examination cost;
- content and visible metadata;
- facts asserted, omitted, or ambiguously framed;
- possible connections and their types;
- whether it is part of a minimum solve path, a red herring, or a debrief-only reference.

Connection types:

- Contradiction
- Corroboration
- Motive
- Knowledge leak
- Emotional mismatch

The player may propose any validly shaped connection between encountered sources. The server evaluates it against authored rules. An invalid connection stays a private rejected hypothesis and must not reveal “the correct pair” or the existence of another hidden source.

## 7. Solvability contract

Before publication, an independent reviewer must solve the case from a clean run using the public projection and record:

1. The conclusion selected.
2. Two or three cited sources.
3. The copy strategy.
4. Confidence choice and why it is calibrated.
5. At least one valid connection path.
6. Which evidence is necessary versus optional.
7. Which red herrings were plausible but defeatable.

The author must also document:

- minimum solve path(s);
- where the game teaches each required interaction;
- the earliest point at which the player can reasonably accuse;
- the latest point at which each crucial clue can be obtained;
- why neither subject's emotion, confidence, or one isolated mistake proves the answer;
- what the debrief says when the player reaches the correct conclusion for the wrong reason;
- what score a thoughtful but wrong theory can receive.

### Automated validations

- Stable IDs are unique within the case version.
- Every referenced question, answer, evidence, fact, localization key, and connection exists.
- No prerequisite cycle can deadlock a required path.
- Every required question/evidence node is reachable from the briefing.
- Every allowed conclusion has at least one authored support path or is explicitly the permitted unresolved/moral outcome.
- Every paid action has a bounded nonnegative cost and cannot spend more than the run's reachable IP unless early accusation is available.
- No answer references hidden solution fields in public projection.
- Every localization key is present.
- No published case version is mutated in place.
- The case engine's IP, version, completion, and public-projection invariants hold under replay/property tests.

## 8. Five-case narrative plan

These are planning seeds, not completed case bibles. They define what the authored content must prove at the next gate.

### Case 1 — The Familiar Error

- **Copy type:** incomplete copy.
- **Teaches:** question selection, pinning, simple follow-ups, evidence examination, and accusation.
- **Mystery:** the copy knows official records and major preferences but combines two childhood events incorrectly.
- **Design:** 10–12 base questions, 4–6 follow-ups, 3 evidence items, accessible pacing, at least two independent solution paths.
- **Fairness spine:** one path uses a timeline/document connection; another uses a childhood object plus a corroborating statement. Neither path relies on nervousness or a single contradiction.
- **Debrief lesson:** knowing the public record and preference facts is different from holding the original's connected memory.

### Case 2 — The Unwritten Afternoon

- **Copy type:** pattern mimic.
- **Teaches:** reconstructing a timeline and linking contradictions.
- **Mystery:** both subjects describe an afternoon accurately, but the copy learned the sequence from messages and misplaces an event that was never written down.
- **Design:** 14–18 base questions, 6–8 follow-ups, 5 evidence items, one unreliable witness, one plausible red herring.
- **Fairness spine:** the misplaced event becomes provable only by combining an unwritten physical sequence with two sources; the witness is corroborative/uncertain, not an oracle.
- **Debrief lesson:** factual accuracy at individual moments does not guarantee lived sequence.

### Case 3 — The Weight of Water

- **Copy type:** memory thief.
- **Teaches:** factual recall versus emotional and causal understanding.
- **Mystery:** a lake accident involving Miguel's friend Daniel. The copy knows visible events but not why Miguel feels responsible.
- **Design:** include a document, an object, and a witness statement; sensory details support the chain but never magically prove identity.
- **Fairness spine:** visible events are shared; causal/emotional meaning is supported by a protected fact, an object, and a witness whose wording has limits. Stress can surface either a genuine memory or a defensive refusal.
- **Debrief lesson:** emotional mismatch is evidence only when tied to a known relationship and cause.

### Case 4 — The Clean Lie

- **Copy type:** manipulator.
- **Teaches:** a liar is not necessarily the copy.
- **Mystery:** the original conceals a theft and appears less consistent; the copy weaponizes accurate stolen memories to frame him.
- **Design:** hard but fair; identity evidence and guilt evidence must be separable in the evidence graph and debrief.
- **Fairness spine:** guilt-related inconsistency explains motive but does not explain the copy's knowledge boundary. The copy's framing strategy is exposed by a source that connects accurate memory to impossible access.
- **Debrief lesson:** “who lied” and “who is the reconstruction” are distinct questions.

### Case 5 — The Continuity Problem

- **Copy type:** corrupted reconstruction.
- **Teaches:** factual deduction may not settle moral identity.
- **Mystery:** records suggest neither present Miguel has an uncontested claim to being the uninterrupted original.
- **Design:** conceptual finale; objective discoveries remain fixed while more than one philosophically defensible ending is supported.
- **Fairness spine:** the player solves what happened to the records and reconstruction process, then selects an epilogue stance. The API scores factual evidence separately from moral choice and does not retroactively alter facts.
- **Debrief lesson:** an evidence-backed answer may still leave a human judgment that the game should not pretend to mechanize.

## 9. Tone and sensitivity rules

- Restrained institutional horror; no gore, jump scares, or graphic violence.
- Trauma is written with care and is never used as a universal lie/fake cue.
- The game may be unsettling through implication, surveillance, records, and uncertainty.
- Do not reward cruelty or humiliation as the only effective interrogation style.
- Pressure actions should have authored tradeoffs and can produce genuine, misleading, or refused speech depending on the subject's profile.
- All case content receives a sensitivity pass before publication.

## 10. Localization and content tooling

- Every public string has a stable localization key.
- Case-definition validation fails on missing keys, duplicate keys, unbounded text, or concatenated narrative fragments that lack translation context.
- Authoring dashboard is deferred beyond the MVP; source-controlled JSON + reviewer markdown is the release workflow.
- A future authoring dashboard may preview public projections and validate question reachability, but must never expose the private solution to non-author roles.

## 11. Review template

Every case review records:

```text
Case/version:
Reviewer:
Clean-run seed:
Allowed conclusion:
Copy strategy:
Sources cited:
Validated connections:
Minimum solve path:
Optional clues:
Red herring and defeat route:
Why behavior alone cannot solve it:
Wrong-but-reasoned score expectation:
Missing localization keys:
Schema/reachability/hidden-data checks:
Decision: approve / revise / reject
```

## 12. Publication gate

The case is ready for implementation only when the author, an independent reviewer, engine tests, and security projection tests agree that:

- the intended conclusion is supportable through available evidence;
- at least one plausible wrong theory is treated fairly;
- public data cannot expose the private solution early;
- IP, unlocks, state deltas, and score are deterministic;
- the debrief can explain both a correct theory and an incorrect-but-reasoned theory;
- the case version can be seeded, retired, and kept immutable for active runs.
