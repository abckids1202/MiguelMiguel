# MiguelMiguel — Narrative Design

**Status:** Gate 1 planning authority; approved Gate 2 script handoff
**Viewpoint default:** close third person through Elias Venn
**Script status:** end-to-end draft exists in `docs/SCRIPT.md`; editorial and implementation review remain open

## 1. Narrative shape

MiguelMiguel starts as a tired procedural. Elias reviews a minor allowance case, rides a train, reads a dossier, and enters another room. The philosophical pressure grows because routine language fails in the presence of two people with one history.

The story uses a **branch-and-bottleneck** structure:

- A branch is a short authored variation caused by a player interpretation.
- A bottleneck is a shared scene the story returns to so pacing and production scope stay controlled.
- Branches change Elias’s dossier entries, selected later lines, internal monologue, or an ending reflection.
- Branches never change the canonical timeline, biological result, or which four reports exist.

The player is not solving a branching puzzle tree. The player is building a record of what Elias treats as evidence when certainty becomes costly.

## 2. Viewpoint and prose

Use close third person consistently. Stay near Elias’s attention without turning every observation into a confession.

### Before abstraction

Describe the untouched coffee, the delayed message, the train handrail, the light under the office door, the click of a pen. Only later let those objects carry a larger implication.

### Dialogue rules

- Dialogue carries subtext and contradiction.
- Characters do not cite philosophers or explain the entire theme.
- A character may misunderstand their own motive.
- Leave silence after strong lines.
- Keep most lines plain and short; reserve lyrical sentences for earned moments.
- Do not make every line quotable.
- A political or philosophical claim must arise from an immediate consequence, object, memory, or decision.

### Voice guide

| Character | Rhythm | What they avoid | What makes them distinct |
| --- | --- | --- | --- |
| Elias | economical, dry, observant | personal answers, emotional naming | notices procedure and small physical neglect |
| Miguel A | compressed, interrupting, concrete | pity, institutional euphemism | uses actual harm as evidence and accepts harsh tradeoffs |
| Miguel B | qualified, careful, precise | claiming certainty about his own agency | turns definitions back toward the speaker |
| Hale | calm, procedural, complete sentences | moral vocabulary when legal vocabulary will do | makes responsibility sound like a workflow |
| Lena | plain, direct, unsentimental | performing helplessness | separates what she did from what the system made necessary |

## 3. Information design

The player should learn in this order:

1. Meridian is ordinary and administratively unequal.
2. Elias signs decisions generated elsewhere.
3. Lena’s factual violation is not the whole moral story.
4. Two Miguels share a memory record but differ in present interpretation and action.
5. B has a first memory that A cannot share.
6. The attack creates a concrete moral divergence: A chooses possible systemic change over immediate workers; B saves the workers through a traceable institution-controlled channel, allowing authorities to capture rebels and destroy most of the leak.
7. The Measure already knows the biological answer.
8. The marker is scientifically conclusive but not legally self-executing; Elias’s signature creates a presumptive legal identity and authorizes transfer.
9. A contradictory designation triggers delayed conflict review; refusal triggers a documented emergency panel override. Elias’s signature is valuable as legal and moral cover, not because the institution has no fallback.
10. The player chooses what report to sign, refuse, falsify, or expand.

The game should never make the player memorize dozens of facts. The profile overlay and dossier viewer preserve key observations without announcing which are “correct.”

## 4. Profile system as narrative feedback

The profile system is not a quiz and does not calculate a good-person result. Each interpretation choice records a sentence about an observation. The sentence is framed as a limited evidentiary note, for example:

```text
SUBJECT OBSERVATION 03

Controlled affect cannot independently establish artificial origin.
Current evidentiary value: limited.
Recorded by: Detective Elias Venn
```

At the ending, the same idea is reframed around Elias:

```text
EXAMINER OBSERVATION 03

Venn resisted treating emotional conformity as proof of authenticity.
He preferred unresolved evidence to convenient certainty.
```

The game never shows the hidden axes, percentages, alignment names, or a “correct” selection. The visible profile is authored content selected from combinations of choices. Epistemic restraint is not avoidance: a player can admit that evidence is insufficient and still accept responsibility later.

## 5. Dialogue and choice rules

Every profile choice must:

- present only defensible interpretations;
- avoid saintly versus cruel wording;
- be answerable from the current scene, even if the player cannot know the full canon yet;
- add a visible observation immediately;
- alter one or more hidden axes;
- optionally influence later wording or internal monologue;
- never invent a historical fact;
- never make calmness or anger function as identity proof.

The choice overlay is styled as an official record:

```text
RECORD INTERPRETATION
How should this observation be classified?
```

After selection, the entry appears and the scene continues. There is no green/red feedback and no timer.

## 6. Elias’s concrete dependency

Elias’s employed civic status protects his housing and treatment priority. He fears entering the low-utility category assigned to the people whose reports he signs. This should appear as a practical detail—a renewal notice, a treatment queue, a benefits line—not as a large tragic backstory or an excuse that absolves him. He stays partly because remaining inside once felt like a way to soften decisions, then gradually turns that reason into a justification for silence.

## 7. Legal consequence as narrative pressure

The marker is the scientific answer, not the legal action. The institution wants Elias because a signed designation creates a presumptive identity for the immediate proceeding and authorizes transfer. It can function without him, but only through a documented emergency review or panel override that records the missing human authorization.

- **The Original:** the signed report agrees with the marker; A is prosecuted and B moves toward reclamation without conflict review.
- **The Continuation:** the signed report contradicts the marker; B temporarily receives human-prosecution protections and A’s transfer is held while a delayed conflict review investigates the mismatch. Hale investigates Elias because the report conflicts with conclusive evidence and may be deliberate falsification.
- **Two Names:** the noncompliant report is rejected; it creates no automatic third category, but the institution must continue review without a clean designation.
- **No Signature:** the refusal is recorded and an emergency panel applies the known result. Elias loses clean authorship, not all institutional consequence.

This keeps the institution’s need meaningful without making Elias technically indispensable.

## 8. Emotional progression

| Movement | Concrete experience | Emerging question |
| --- | --- | --- |
| Routine | forms, coffee, a solved allowance case | What does a human signature add? |
| Contact | two similar faces, different pressure responses | Is behavior evidence or stereotype? |
| Memory | shared childhood object and changed meaning | Is memory content enough? |
| Divergence | B’s awakening, A’s accepted casualties, and B’s costly warning | What makes a choice one’s own? |
| Proof | synthesis marker, legal presumption, and Hale’s prior knowledge | Who is asking for the decision? |
| Responsibility | four reports and their consequences | Can refusal stay innocent? |

## 9. Provisional deduction

After Scene 6 and before the laboratory report, add one private, non-scored deduction:

> Before reviewing the laboratory result, which subject do you currently believe is biologically original?

Options are Miguel A, Miguel B, and Available evidence is insufficient. The answer is recorded privately and used for a short reflection after the marker reveal. It does not change profile axes, ending access, or final score. A correct guess is not praised; an incorrect guess is not shamed.

## 10. Editing pass before script lock

The current `SCRIPT.md` is a complete flow draft, not a locked final script. Review every scene aloud and mark:

- redundant philosophical claims;
- worldbuilding characters already know;
- lines that explain a visual twice;
- repeated metaphors;
- choices with an obviously virtuous answer;
- moments where calmness or anger becomes identity proof;
- speeches longer than the emotional situation can carry;
- exposition that should be replaced by a form, screen, queue, or object.

Cut or rewrite marked lines before script lock. The final script should feel more concrete after editing, not less intelligent.

## 11. Dossier and profile language

Use terms that preserve uncertainty:

- “supports” rather than “proves,” unless the laboratory marker is being discussed;
- “current evidentiary value: limited/meaningful/contested” rather than a score;
- “classification” for an institutional decision, not for a person’s soul;
- “reconstruction” rather than “fake” in neutral narration;
- “biological continuity” for the factual answer;
- “present agency,” “memory continuity,” and “recognition” for philosophical criteria.

Avoid terms like *good ending*, *bad ending*, *true Miguel*, *fake Miguel*, *morality*, *alignment*, and *correct profile* in player-facing UI.

## 12. Script handoff contract

The current and final `SCRIPT.md` must contain, in scene order:

- stable node IDs;
- speaker and prose;
- choices and option text;
- visible profile entries;
- hidden axis effects;
- conditional variants;
- background, portrait, music, ambience, and sound cues;
- dossier/evidence references;
- save boundaries;
- ending variants;
- localization keys or a keying plan.

The current draft satisfies the handoff contract at the planning level. It still needs aloud review, line polish, and later implementation validation before content lock.
