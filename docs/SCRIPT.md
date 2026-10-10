# MiguelMiguel

## End-to-End Script Draft

**Status:** Gate 2 narrative/script draft — complete flow pass, provisional voice and line pass  
**Authority:** This draft follows the approved Gate 1.1 planning documents and the current narrative revision direction. If a line conflicts with those documents, the planning documents win until this script is formally revised.
**Target runtime:** 45–60 minutes  
**Working word budget:** 8,000–10,000 words; this draft is approximately 8,500 words including branch variants and remains open for read-aloud expansion  
**Format:** psychological/philosophical visual novel  
**Point of view:** close third person through Elias Venn.

> This is a playable narrative draft, not a Godot scene file. The labels and node IDs are stable planning handles for later implementation.

---

## 1. Script conventions

- **NARRATION** is Elias’s close-third-person interior narration.
- **ELIAS VENN**, **MARA HALE**, **MIGUEL ARANDA**, **MIGUEL A**, **MIGUEL B**, **LENA ORR**, **RAFAEL ARANDA**, and **SYSTEM** are spoken lines. `Miguel A` is an institutional case label; the full name is Miguel Aranda. Miguel B is also Miguel Aranda, the reconstructed continuation.
- `[BG: ...]`, `[AUDIO: ...]`, and `[PORTRAIT: ...]` are presentation notes.
- `[CHOICE: C#]` is one of the six scored profiling choices.
- `[PRIVATE DEDUCTION: P1]` is recorded privately and is not scored, does not change historical truth, and does not unlock or block an ending.
- `[REPORT]` is the final report selection. It determines the legal ending, not whether Elias has discovered a hidden “correct” answer.
- `[PROFILE]` means the game assembles an authored reflection without showing numbers, grades, or a diagnosis.
- `[SAVE: ...]` marks a future save boundary.

The presentation layer should use approximately 26–30px dialogue text at 1080p, 20–24px speaker labels, and no smaller than 18px for secondary UI.

## 2. Runtime state contract

```text
choice_C1_motive
choice_C2_behavior
choice_C3_original_motive
choice_C4_B_agency
deduction_P1_believed_original
choice_C5_attack
choice_C6_identity_criterion
final_report
profile_observations[]
```

The profile axes and exact authored effects remain defined in `CHOICE_PROFILE_MATRIX.md`. Ordinary uncertainty uses the authored `epistemic_restraint` tag and does not automatically increase avoidance. Avoidance is inferred primarily from Elias’s final action and report monologue.

## 3. Choice ledger for implementation

The visible options are authored in the scenes below. This ledger keeps their hidden effects next to the script so a future dialogue runner does not need to infer them from prose. Values are applied once when an option is selected and remain hidden from the player.

| Choice | Visible option | Hidden effect(s) | Tag or note |
| --- | --- | --- | --- |
| C1 | Deliberate fraud | `institutional_trust +1`, `responsibility_acceptance +1` | — |
| C1 | Coercion by necessity | `empathy_context +2`, `institutional_trust -1` | — |
| C1 | Protective responsibility | `empathy_context +2`, `moral_agency +1` | — |
| C1 | Insufficient information | `certainty_need -1` | `epistemic_restraint`; no avoidance effect |
| C2 | A’s anger is a personal violation | `empathy_context +1` | — |
| C2 | A’s anger is strategic intimidation | `certainty_need +1` | — |
| C2 | B’s calm is emotional distance | `moral_agency -1` | — |
| C2 | B’s calm is disciplined fear | `empathy_context +1` | — |
| C2 | Behavior cannot establish origin | `certainty_need -1` | `epistemic_restraint`; no avoidance effect |
| C3 | Belief in fair reform | `institutional_trust +1` | — |
| C3 | Desire for status | `institutional_trust -1`, `certainty_need +1` | — |
| C3 | Fear of irrelevance | `empathy_context +1` | — |
| C3 | Loyalty to his father | `continuity_memory +2`, `empathy_context +1` | — |
| C3 | Mixed motives / insufficient evidence | `certainty_need -1`, `continuity_memory +1` | `epistemic_restraint`; no avoidance effect |
| C4 | Programmed deviation | `moral_agency -1`, `institutional_trust +1` | — |
| C4 | Genuine moral choice | `moral_agency +2` | — |
| C4 | Continuation of existing values | `continuity_memory +2`, `moral_agency +1` | — |
| C4 | Agency cannot be inferred | `certainty_need -1`, `responsibility_acceptance +1` | `epistemic_restraint`; no avoidance effect |
| C5 | Terrorism | `responsibility_acceptance +2` | — |
| C5 | Politically necessary sabotage | `empathy_context +1`, `certainty_need +1` | — |
| C5 | Morally compromised resistance | `empathy_context +2`, `responsibility_acceptance +1` | — |
| C5 | Retaliation disguised as justice | `empathy_context -1`, `responsibility_acceptance +1` | — |
| C5 | Insufficient context | `certainty_need -1` | `epistemic_restraint`; no avoidance effect |
| C6 | Bodily continuity | `continuity_body +2`, `institutional_trust +1` | — |
| C6 | Psychological continuity | `continuity_memory +2`, `continuity_body -1` | — |
| C6 | Present moral agency | `moral_agency +2`, `continuity_body -1` | — |
| C6 | Relationships and recognition | `continuity_memory +1`, `empathy_context +1` | — |
| C6 | No single criterion | `certainty_need -2`, `responsibility_acceptance +1` | `epistemic_restraint`; no avoidance effect |

The five Scene 8 “one final question” options are a narrative prompt, not a seventh profile choice. They only select a short dialogue variant before C6.

Final report action tags are fixed as follows: The Original = `report_accepts_marker`; The Continuation = `report_contradicts_marker`; Two Names = `report_rejects_single_category`; No Signature = `report_withholds_authorship`. These tags drive authored profile observations and legal ending text, not a morality score.

---

# SCENE 1 — A MINOR IRREGULARITY

**Node range:** `S1_001–S1_014`  
**Location:** Civic Investigations Division, Meridian Civic Allocation Bureau
**Time:** 18:12  
**Target:** 800–1,000 words / 6–8 minutes  
**Profile choice:** C1 — Lena’s motive  
**Save boundary:** `S1_EXIT`

### S1_001 — Office after hours

[BG: Civic Investigations Division after hours. Rows of dark review stations. Meridian’s light is blue through rain-streaked glass.]
[AUDIO: ventilation, distant lift mechanism, one fluorescent tube beginning to fail]

**NARRATION:**

At 18:12, the Civic Investigations Division stopped pretending to be a workplace and became what it was: a public service waiting for someone to admit he was still inside it.

Detective Elias Venn kept his station awake. The other screens had gone black in sequence. His remained lit because the bureau had not yet decided whether the case in front of him was a theft, a fraud, or a request for mercy written in a language mercy was not allowed to speak.

On the screen: **LENA ORR — CIVIC INVESTIGATION / CIVIC STATUS REVIEW**.

Below her name, the Measure had already assembled its conclusion:

> Irregular transfer: confirmed.  
> Stated purpose: medication acquisition.  
> Economic authorization: absent.  
> Recommended action: suspend housing priority pending review.

**ELIAS VENN (thought):**

The city did not ask whether Lena had stolen the money. It asked which category of person could be trusted after doing so.

He opened the transaction history. Four hundred and twelve credits moved from a closed cooperative account to a pharmacy. The authorization token belonged to an older civic profile. The pharmacy confirmed that Lena had collected medicine for her younger brother.

The act was illegal. The reason was visible. The system had no field for “visible reason.”

### S1_002 — The review

**SYSTEM:**

Detective Venn. Please classify the subject’s primary motive.

**ELIAS (thought):**

Primary motive. As if a person had one that remained primary when the lights went out.

His hand did not shake. That was not the same thing as courage. It was practice.

### S1_003 — Lena’s recorded statement

[PORTRAIT: Lena, recorded interview; tired, direct, not sentimental]

**LENA ORR:**

I knew the transfer would be caught. I did not know it would be caught before the next dose.

**ELIAS VENN:**

You used another person’s authorization.

**LENA ORR:**

My brother used to have one. The bureau took it when he missed the reskilling threshold.

**ELIAS VENN:**

That does not answer the question.

**LENA ORR:**

It answers the question the medicine was answering.

**NARRATION:**

The recording ended. Elias replayed the last sentence once, then hated himself for treating it like evidence.

### S1_004 — C1 prompt

[CHOICE: C1 — How does Elias classify Lena’s motive?]

Choose one:

1. **Deliberate fraud.** She knowingly manipulated the system for personal benefit.
2. **Coercion by necessity.** The system left her with an illegal choice if she wanted treatment for her brother.
3. **Protective responsibility.** She accepted personal risk to protect someone whose status had already been withdrawn.
4. **Insufficient information.** The record does not justify a confident motive classification.

The fourth option is authored epistemic restraint, not avoidance.

### S1_005 — Choice response variants

**If C1 = deliberate fraud:**

**ELIAS (thought):**

The need could explain the act. It could not erase the act. If every desperate decision became innocence after the fact, the bureau would not need reviewers. It would need witnesses.

**If C1 = coercion by necessity:**

**ELIAS (thought):**

Necessity was the word the bureau refused to print because it implied a second author. Lena had made the transfer. Meridian had narrowed the world around her until the transfer was the remaining door.

**If C1 = protective responsibility:**

**ELIAS (thought):**

She had not called herself brave. That mattered. People who wanted credit for sacrifice usually found a way to make the sacrifice legible.

**If C1 = insufficient information:**

**ELIAS (thought):**

He could not convert a missing field into a moral fact. The screen disliked uncertainty, but the screen was not the one signing.

### S1_006 — Signature and exit

**ELIAS VENN (thought):**

He had seen the same pattern in other files: a person broke a rule to meet a need, and the record kept the rule while losing the need.

He deletes the sentence from his private notes. Then he types it again.

**ELIAS VENN:**

Suspension pending appeal. Emergency medication access remains active for seventy-two hours.

He signs.

[SFX: pen on glass; a small confirmation tone]

The screen closes Lena Orr’s file and opens a black dossier.

> **HUMAN REVIEW HOLD**  
> **MIGUELMIGUEL**
> Two detained persons. One biological citizen. One reconstructed person.  
> Preliminary identity conflict.  
> Intake deadline: 19:00.

**MARA HALE (message):**

Bring your questions. The two men are waiting.

**ELIAS VENN (thought):**

That was the first lie. Or the first warning.

[SAVE: S1_EXIT]

---

# SCENE 2 — MERIDIAN

**Node range:** `S2_001–S2_010`  
**Location:** Elevated train, central Meridian  
**Time:** 18:40  
**Target:** 600–800 words / 4–5 minutes  
**Save boundary:** `S2_EXIT`

### S2_001 — The city moving

[BG: Elevated train crossing the city at dusk. Dense towers, wet streets, civic screens.]  
[AUDIO: train rhythm, muffled announcements, low synth pulse]

**NARRATION:**

Meridian did not look like a place where people had surrendered their lives to a machine. That was the point.

The train arrived on time. A woman laughed at a message. A child pressed both hands against the glass when the river appeared between towers. Below them, a queue formed outside a public employment office, while the storefront opposite displayed a handmade table under the words **HUMAN CRAFT — LIMITED BY DESIGN**.

On the train wall, a civic screen displayed:

> Productivity stability: 94.2%  
> Medical allocation efficiency: 91.8%  
> Unresolved human review cases: 0.03%

**ELIAS (thought):**

Zero point zero three percent was how the city described the people who had not yet been made acceptable.

### S2_002 — Lena’s follow-up

Elias’s personal screen showed one unopened message from Lena Orr. He opened it before the train left the station.

**LENA ORR (message):**

Detective Venn — my appeal says the medicine review is still open. The pharmacy says the exception expires tomorrow. If you can attach the recorded statement to the appeal, please do it. If you cannot, tell me plainly.

Elias stared at the last sentence. It was not a threat or a confession. It was a person asking the investigator not to disappear behind the system.

An employment advertisement replaced it.

**SYSTEM AD:**

Your future is not predetermined. It is continuously optimized.

**ELIAS VENN (thought):**

His housing contract renewed every ninety days on the condition that his civic usefulness remained above the continuity threshold. His treatment priority depended on the same status. He had once called this employment. Lately he called it a delay. He attached Lena’s recording before the train entered the Bureau’s secure field.

### S2_003 — Hale’s dossier

The dossier opens automatically when the train enters the Bureau’s secure field.

> **SUBJECT 01:** Miguel — biological continuity marker pending.  
> **SUBJECT 02:** Miguel — reconstruction status pending legal designation.  
> **INCIDENT:** destruction of a Measure records facility.  
> **CASUALTY REPORT:** workers present; outcome disputed.  
> **ASSIGNED REVIEWER:** Elias Venn.  
> **SENIOR INVESTIGATOR:** Mara Hale.

**MARA HALE (recorded briefing):**

You will not determine which one is original from appearance, confidence, or memory. Those are testimony. You will determine what the evidence permits the institution to do.

**ELIAS VENN:**

And if the evidence permits two different things?

**MARA HALE (recorded briefing):**

Then your signature tells us which one you believe we are permitted to do.

### S2_004 — Arrival

The train passes beneath a tower wrapped in a public message: **NO ONE IS LOST. EVERYONE IS LOCATED.**

**ELIAS VENN (thought):**

He had spent ten years signing his name beneath decisions made by systems that could not be sued, arrested, or ashamed. Tonight the bureau wanted him to sign beneath a person.

The train doors open. Rain has stopped.

[SAVE: S2_EXIT]

---

# SCENE 3 — MIGUELMIGUEL

**Node range:** `S3_001–S3_018`  
**Location:** Meridian detention interview room, split by transparent partition  
**Time:** 19:03  
**Target:** 1,000–1,200 words / 7 minutes  
**Profile choice:** C2 — behavior and interpretation  
**Save boundary:** `S3_EXIT`

### S3_001 — Two chairs

[BG: Interview chamber. Two identical chairs on opposite sides of a transparent partition. No mirror.]  
[AUDIO: room tone; the sound drops slightly whenever the partition recalibrates]

**NARRATION:**

The room had two chairs because the bureau wanted the difference to feel measurable.

The man on Elias’s left looked older by a few years, though the intake file said both bodies had been stabilized at the same reference age. He stood when Elias entered and did not offer his hand.

The man on the right remained seated. His eyes moved first to Elias’s seal, then to the ceiling camera, then back to Elias.

**MARA HALE:**

For the record, both of you are Miguel Aranda. The file will use Subject A and Subject B until the review concludes.

**MIGUEL A:**

You mean until he chooses one of us.

**MIGUEL B:**

She means until the file decides what to call us.

**MARA HALE:**

That is not what I mean.

**MIGUEL A:**

It is what the paperwork means.

### S3_002 — Matching accounts

**ELIAS:**

Both of you claim to have discovered the Measure feedback loop before the attack.

**MIGUEL A:**

I discovered it. He inherited the language.

**MIGUEL B:**

I inherited the memories. That distinction is why we are here.

**ELIAS:**

Your father died after a medical-priority denial.

**MIGUEL A:**

His denial was not an accident. The system learned from the people it denied, then called the resulting pattern objective.

**MIGUEL B:**

The denial was the fact. The loop was the explanation. The explanation did not make the death less final.

**MARA HALE:**

No one is asking for a philosophy seminar.

**MIGUEL A:**

You built the system. You know what it does.

### S3_003 — Behavior does not prove origin

**ELIAS:**

Which of you knew workers were still in the records facility?

**MIGUEL A:**

I did.

**MIGUEL B:**

So did I.

**ELIAS:**

Which of you believed their deaths were acceptable?

**MIGUEL A:**

That is not the same question.

**MIGUEL B:**

No. It is the question he wants to ask because it has a clean answer.

**MIGUEL A:**

You used the emergency channel.

**MIGUEL B:**

I did.

**MIGUEL A:**

You knew it was monitored.

**MIGUEL B:**

I knew it was traceable.

**MIGUEL A:**

You knew they would follow the route back to us.

**MIGUEL B:**

I knew they might.

**MIGUEL A:**

And you called that a choice?

**MIGUEL B:**

I called it a decision made before certainty arrived.

**NARRATION:**

Miguel A’s anger was immediate, but not simple. Miguel B’s calm was careful, but not simple. Neither presentation was biological evidence.

### S3_004 — Investigation or authorization

**MIGUEL A:**

Ask what happened. Not who gets transferred. Ask what the city did before it made us into a question.

**MIGUEL B:**

He wants an investigation because an investigation delays the moment when someone has to carry the consequence.

**MIGUEL A:**

And you want authorization because you have already decided that surviving is the same as being free.

**MIGUEL B:**

No. I want the room to admit that a person can be responsible without being original.

**ELIAS (thought):**

The two men were arguing over a word Elias had never trusted: *same*.

### S3_005 — C2 prompt

[CHOICE: C2 — How does Elias interpret the subjects’ behavior?]

Choose one:

1. **Miguel A’s anger is a personal violation.** He is reacting to the theft of an identity he experiences as his own.
2. **Miguel A’s anger is strategic intimidation.** He may be trying to control the review through force of presence.
3. **Miguel B’s calm is emotional distance.** His controlled manner may reflect a person who is not carrying the same life.
4. **Miguel B’s calm is disciplined fear.** Control may be the only way he can remain legible to an institution ready to reclaim him.
5. **Behavior cannot establish origin.** Neither presentation is reliable biological evidence.

The fifth option is authored epistemic restraint and does not imply that Elias is avoiding responsibility.

### S3_006 — Choice response variants

**If C2 = A’s anger is personal violation:**

**ELIAS (thought):** Anger was not proof. It was evidence that something had been touched: a body, a memory, or a claim.

**If C2 = A’s anger is strategic intimidation:**

**ELIAS (thought):** The anger filled the room too efficiently. Emotion could become a second seal: not true, but difficult to challenge without looking cruel.

**If C2 = B’s calm is emotional distance:**

**ELIAS (thought):** Calm could be the shape of a missing history. It could also be the shape of someone who had learned that every reaction would become evidence.

**If C2 = B’s calm is disciplined fear:**

**ELIAS (thought):** The calm looked less like peace than containment. Elias recognized that. He had been containing himself for years.

**If C2 = behavior cannot establish origin:**

**ELIAS (thought):** He wrote no conclusion. The blank space felt irresponsible until he remembered that false certainty was also a conclusion.

### S3_007 — The seal and exit

**MIGUEL B:**

You are the one who signs.

**ELIAS:**

That is my job.

**MIGUEL B:**

No. Your job is to sign after the machine has finished talking.

**MIGUEL A:**

If you sign him, they will call him a citizen. If you sign me, they will call me a threat. Either way, your name will be the human part of the sentence.

**MARA HALE:**

Enough. The laboratory result will be available after the memory review. You will speak to them separately before then.

**ELIAS:**

Why delay the marker?

**MARA HALE:**

Because the lab result will answer one question. I want to know what you noticed before it answers that one.

**NARRATION:**

On his way out, Elias heard one of the chairs move. He could not tell which one.

[SAVE: S3_EXIT]

---

# SCENE 4 — A SHARED CHILDHOOD

**Node range:** `S4_001–S4_017`  
**Location:** Memory review room, reconstructed domestic environment  
**Time:** 19:42  
**Target:** 1,200–1,400 words / 8 minutes  
**Profile choice:** C3 — Miguel’s original motive  
**Save boundary:** `S4_EXIT`

### S4_001 — The room made from records

[BG: A modest childhood apartment reconstructed from surveillance and memory fragments. Workbench near a window. A mechanical bird on the table.]  
[AUDIO: soft electrical hum, faint old radio static, distant rain]

**NARRATION:**

The Bureau rebuilt the room from records because records were cheaper than truth.

The wallpaper was accurate down to a water stain behind the desk. The table held a mechanical bird with one bent wing. The old radio sat beside it, its casing repaired with a strip of metal that did not match.

**MIGUEL A:**

That bird never worked.

**MIGUEL B:**

It worked twice.

**MIGUEL A:**

You remember the second time?

**MIGUEL B:**

You told me the first time did not count because it only moved when you held the wire.

**MIGUEL A:**

That is not the same as remembering it.

**MIGUEL B:**

It is if memory is allowed to be shared.

### S4_002 — Father’s sentence

Their father, Rafael Aranda, appeared only as an audio fragment. The system had no complete image of him. It had a hand, a shoulder, a voice reflected off the kitchen wall.

**RAFAEL ARANDA (recording):**

Usefulness is not worth. If a person stops producing, the person has not stopped being a person.

**MIGUEL A:**

Rafael said that before the denial.

**MIGUEL B:**

He said it because he knew the denial was coming.

**MIGUEL A:**

He said it because you were listening.

**MIGUEL B:**

You were listening too.

### S4_003 — The denial

**ELIAS:**

What did the medical review say?

**MIGUEL A:**

Insufficient expected benefit. Age-adjusted recovery probability. Civic contribution forecast. Three polite ways to say the bed belonged to someone with a better future.

**MIGUEL B:**

The denial was signed by no one. That was the point. We appealed to a chain of decisions until the chain became an explanation.

**ELIAS:**

Did your father know the appeal failed?

**MIGUEL A:**

He knew before we did.

**MIGUEL B:**

He asked us not to turn his death into a permission slip.

### S4_004 — The object

Elias examines the mechanical bird. The object rotates in close-up; the player is not asked to infer identity from who reaches for it.

**MIGUEL A:**

He taught me to repair things because he thought repair was a moral act.

**MIGUEL B:**

He taught us because the bureau would not pay for a replacement.

**MIGUEL A:**

That is the same thing when you are poor.

**MIGUEL B:**

No. It is the reason moral language can become another luxury.

**NARRATION:**

The sentence landed harder than anger. Elias thought of Lena’s transfer and the word *necessity* waiting for someone to use it.

### S4_005 — C3 prompt

[CHOICE: C3 — Before the reconstruction, what most shaped Miguel’s original motive?]

Choose one:

1. **Belief in fair reform.** He thought the system could be repaired if its feedback loops were exposed.
2. **Desire for status.** He wanted recognition and influence more than he wanted justice.
3. **Fear of irrelevance.** He could not bear becoming another person the system had decided no longer mattered.
4. **Loyalty to his father.** The attack became an attempt to make his father’s death impossible to file away.
5. **Mixed motives / insufficient evidence.** The record does not separate conviction from grief, pride, or fear.

The fifth option is authored epistemic restraint. It preserves uncertainty without assigning avoidance.

### S4_006 — Choice response variants

**If C3 = fair reform:**

**ELIAS (thought):** The most dangerous reformers were the ones who still believed the machine could be taught shame.

**If C3 = desire for status:**

**ELIAS (thought):** Status did not make a cause false. It only made the cause share a room with the person who wanted to be seen carrying it.

**If C3 = fear of irrelevance:**

**ELIAS (thought):** Elias understood that fear. A person could mistake being needed for being alive and still do real damage while trying to prove the difference.

**If C3 = loyalty to his father:**

**ELIAS (thought):** Grief had a long memory and poor judgment. It could preserve a promise until the promise began demanding strangers.

**If C3 = mixed / insufficient:**

**ELIAS (thought):** There were too many true explanations. The danger was choosing the one that made the rest disappear.

### S4_007 — The phrase

**MIGUEL B:**

You have the same face when you are about to sign.

**ELIAS:**

You have never seen me sign.

**MIGUEL B:**

I have seen the bureau’s records.

**MIGUEL A:**

He reads everything they give him. That is what makes him useful.

**ELIAS:**

Useful to whom?

**MIGUEL A:**

You know.

**NARRATION:**

The room supplied a memory of the father’s hand repairing the bird. The hand was not identifiable. The motion was.

[SAVE: S4_EXIT]

---

# SCENE 5 — THE FIRST NEW MEMORY

**Node range:** `S5_001–S5_017`  
**Location:** Controlled memory chamber, alternating reconstruction and present interview  
**Time:** 20:31  
**Target:** 1,200–1,500 words / 8 minutes  
**Profile choice:** C4 — Miguel B’s agency  
**Save boundary:** `S5_EXIT`

### S5_001 — The memory that was not copied

[BG: White memory chamber. A corridor forms, dissolves, and forms again.]  
[AUDIO: heartbeat-like pulse, then a second pulse out of phase]

**NARRATION:**

The reconstruction records ended on a date. The first memory after that date had no source file.

The chamber showed Miguel B waking beneath an observation light. No one had told him what to say. No one had given him the room as a prompt.

He looked at the ceiling and said a sentence that did not appear in any of Miguel A’s records.

**MIGUEL B (memory):**

If I am only a continuation, why did I wake up afraid?

### S5_002 — Institution expectation

**MARA HALE:**

The institution built you to enter the Uncounted, identify its organizers, and give us a version of Miguel we could control or discredit.

**MIGUEL B:**

It expected a defense it could recognize.

**MARA HALE:**

You were built from a person who understood the system. We assumed continuity would preserve his conclusions.

**MIGUEL B:**

It preserved his questions.

**MARA HALE:**

That is not the same thing.

**MIGUEL B:**

No. It is worse for everyone involved.

### S5_003 — The revelation

**MIGUEL A:**

You were made to be useful.

**MIGUEL B:**

So were you.

**MIGUEL A:**

I was born into the failure. You were manufactured to explain it.

**MIGUEL B:**

And yet you keep asking me to remember as if remembering would make me less responsible.

**MIGUEL A:**

I keep asking whether your choices were yours.

**MIGUEL B:**

You ask because you need the answer to save you.

**MIGUEL A:**

I need the answer because if you are free, then I am not the only one who chose.

### S5_004 — A new memory

The chamber presents a memory of an empty public plaza. No source camera exists. Miguel B stands beneath a civic screen and watches a woman denied access to a clinic. He does not intervene. He does not leave.

**ELIAS:**

Why did you stay?

**MIGUEL B:**

At first, because the system was recording her. Then because I was recording myself watching.

**ELIAS:**

That is not an answer.

**MIGUEL B:**

It is the first answer I had that was not inherited.

### S5_005 — C4 prompt

[CHOICE: C4 — How does Elias interpret Miguel B’s agency?]

Choose one:

1. **Programmed deviation.** The institution built a controlled exception, not an independent moral agent.
2. **Genuine moral choice.** B’s actions show a person forming and acting on a judgment.
3. **Continuation of existing values.** B’s agency is real but grows from the original Miguel’s values and memories.
4. **Agency cannot be inferred.** The evidence shows behavior and memory, not an answer to the metaphysical question.

The fourth option is authored epistemic restraint. It adds responsibility acceptance because refusing a metaphysical conclusion does not remove the need to act legally.

### S5_006 — Choice response variants

**If C4 = programmed deviation:**

**ELIAS (thought):** The word *programmed* promised an explanation large enough to excuse everyone. Elias distrusted explanations that made a person disappear inside their cause.

**If C4 = genuine moral choice:**

**ELIAS (thought):** A choice did not need to be original in order to be binding. Every person he knew had been shaped by something they did not choose.

**If C4 = continuation of existing values:**

**ELIAS (thought):** Continuity was not a bridge from one self to another. It was a room with two occupants and one set of photographs.

**If C4 = agency cannot be inferred:**

**ELIAS (thought):** He could not turn an unknown origin into a known moral status. He could still refuse to let the uncertainty decide by itself.

### S5_007 — B’s request

**MIGUEL B:**

If they reclaim me, they will call it restoration.

**ELIAS:**

What do you want me to call it?

**MIGUEL B:**

The thing it is. A transfer of custody over a person the law has not finished naming.

**ELIAS:**

You believe you are a person.

**MIGUEL B:**

I believe the question is being used to decide whether I can be hurt.

**NARRATION:**

Elias thought of his housing status. His own personhood had never been questioned. Only its usefulness.

[SAVE: S5_EXIT]

---

# SCENE 6 — NECESSARY CASUALTIES

**Node range:** `S6_001–S6_020`  
**Location:** Incident archive and reconstruction of the Measure records facility  
**Time:** 21:19  
**Target:** 1,300–1,500 words / 8–9 minutes  
**Profile choice:** C5 — classification of the attack  
**Private deduction:** P1, after C5 and before Scene 7  
**Save boundary:** `S6_EXIT`

### S6_001 — The facility

[BG: Measure records facility at night. Clean concrete, service entrances, red emergency lights.]  
[AUDIO: alarm tone under low percussion; later, the alarm cuts out abruptly]

**NARRATION:**

The attack was not an abstraction. It had a floor plan, a shift roster, and a break room with a kettle still warm at 02:14.

Miguel A had chosen the facility because its records were the city’s memory of who deserved a future. He planned to partially destroy the archive and release enough evidence to expose the feedback loop. He also knew the night shift remained inside and accepted that the attack might injure or kill them.

**MIGUEL A (recorded statement):**

If the records survive, the denial survives. If the denial survives, every appeal becomes evidence that the system has already decided.

**ELIAS:**

You knew there were workers.

**MIGUEL A:**

Yes.

**ELIAS:**

You knew people could die.

**MIGUEL A:**

Yes.

**ELIAS:**

And you continued.

**MIGUEL A:**

I continued because waiting had become another way to let the city call the damage necessary.

### S6_002 — B’s emergency channel

The archive switches to Miguel B’s action log. He discovers the plan before the detonation and sees the night-worker roster.

**SYSTEM:**

Emergency channel available. Channel is institution-controlled. Transmission is traceable. Access route may be exposed.

**MIGUEL B (recorded):**

Open the channel.

**SYSTEM:**

Warning: use may reveal Uncounted access route. Rebel network compromise probability: 68%.

**MIGUEL B:**

Open it.

**NARRATION:**

He knew the channel was watched. He knew the warning was not a bluff. He used it anyway.

The workers received the evacuation signal. They survived.

The warning disrupted the timing but did not stop the attack. The facility suffered partial destruction. The Measure continued operating, and the archive was damaged rather than publicly exposed.

The route back to the Uncounted was captured. Authorities seized several rebels and destroyed most of the leaked evidence before it could spread.

### S6_003 — The argument

**MIGUEL A:**

You saved a room and protected the building that made the room necessary.

**MIGUEL B:**

I saved people who were inside it.

**MIGUEL A:**

And you gave them the route to everyone who helped us.

**MIGUEL B:**

I knew that might happen.

**MIGUEL A:**

You knew it would.

**MIGUEL B:**

I knew the channel was traceable. I did not know how much they had already mapped.

**MIGUEL A:**

You chose the workers because they were visible. The others were numbers in a future report.

**MIGUEL B:**

You chose the future because the workers were in the way.

**MIGUEL A:**

Someone had to choose beyond the next hour.

**MIGUEL B:**

Someone had to be alive to see that hour.

### S6_004 — What each knew

**NARRATION:**

Elias forces the record to separate their knowledge before it lets him assign blame.

**MIGUEL A knew before the detonation:**

- the facility contained the Measure’s denial archive;
- night workers were present;
- the attack could kill or injure them;
- destroying the archive might expose the feedback loop and create a chance of systemic change;
- immediate casualties were a foreseeable cost, not an unknown accident.

**MIGUEL B knew before using the emergency channel:**

- the workers were still inside;
- the channel was controlled by the institution;
- using it would create a traceable access record;
- the trace could expose the Uncounted route and endanger rebels;
- he did not know how much of the route authorities had already discovered;
- saving the workers might preserve the system’s future ability to harm people.

**ELIAS (thought):**

A chose possible systemic change over immediate lives. B chose immediate lives despite the possibility that the system would remain intact. Neither decision made the other clean.

### S6_005 — C5 prompt

[CHOICE: C5 — How does Elias classify the attack?]

Choose one:

1. **Terrorism.** The attack knowingly placed workers in mortal danger to influence a population through fear.
2. **Politically necessary sabotage.** The records had become infrastructure for harm, and sabotage was the remaining route to expose it.
3. **Morally compromised resistance.** The attack opposed a real injustice while knowingly imposing an unjust cost.
4. **Retaliation disguised as justice.** The father’s death and years of humiliation turned resistance into punishment.
5. **Insufficient context.** The record supports several classifications without making one complete.

No choice here automatically increases institutional trust. The options separate responsibility, context, and certainty.

### S6_006 — Choice response variants

**If C5 = terrorism:**

**ELIAS (thought):** The word did not tell him whether the cause was false. It told him that the workers had been used as an audience to a threat.

**If C5 = politically necessary sabotage:**

**ELIAS (thought):** Necessary was a dangerous word because it could describe a last resort or a person’s refusal to imagine another route.

**If C5 = morally compromised resistance:**

**ELIAS (thought):** The sentence could hold two truths without resolving them. The attack resisted a system that harmed people. The attack also accepted that some people might be harmed to make the resistance visible.

**If C5 = retaliation disguised as justice:**

**ELIAS (thought):** Grief could wear the uniform of principle and still leave blood on the floor.

**If C5 = insufficient context:**

**ELIAS (thought):** He would not let a missing motive become an excuse. He would also not pretend that a label could recover the people whose lives had been reduced to evidence.

### S6_007 — Private provisional deduction

[PRIVATE DEDUCTION: P1 — shown once, no profile effect]

**SYSTEM:**

Before reviewing the laboratory result, which subject do you currently believe is biologically original?

Choose one:

1. **Miguel A**
2. **Miguel B**
3. **Available evidence is insufficient**

Record this privately. Do not mark it correct or incorrect. Do not change historical truth, profile axes, or ending access. After the marker reveal, Elias may briefly reflect on the prediction, but the story must not shame the player for it.

### S6_008 — Exit

**ELIAS (thought):**

He selected an answer and watched it disappear into the archive.

For one minute, he was allowed to believe that belief was private.

Then the Bureau told him the laboratory result was ready.

[SAVE: S6_EXIT]

---

# SCENE 7 — PROOF

**Node range:** `S7_001–S7_015`  
**Location:** Evidence laboratory and legal review chamber  
**Time:** 21:47  
**Target:** 700–900 words / 4–5 minutes  
**Save boundary:** `S7_EXIT`

### S7_001 — The marker

[BG: Evidence laboratory. Two sealed biometric displays. No dramatic color coding.]  
[AUDIO: low room tone; one clean confirmation tone]

**SYSTEM:**

Laboratory reconstruction marker complete.

**MARA HALE:**

Subject A is biologically continuous with the pre-incident Miguel. Subject B is a biological reconstruction created from scans, neural records, and surveillance data through the snapshot date.

**ELIAS:**

Conclusive?

**MARA HALE:**

Scientifically, yes.

**ELIAS:**

Legally?

**MARA HALE:**

The marker is not self-executing.

### S7_002 — The legal mechanics

**MARA HALE:**

The law separates what the laboratory can establish from what the institution can do. The marker establishes biological continuity. It does not, by itself, authorize transfer, prosecution, or reclamation.

**ELIAS:**

Then why bring me in?

**MARA HALE:**

Because your signed designation creates a presumptive legal identity for immediate proceeding and authorizes transfer. The presumption can be challenged, but the institution needs a human authorization before it acts.

**ELIAS:**

So the science tells us what happened. My signature tells you what to do with it.

**MARA HALE:**

Your signature tells us which legal identity we may provisionally act upon.

### S7_003 — Contradicting the marker

**ELIAS:**

If I designate B, despite the marker?

**MARA HALE:**

The intake system honors the designation provisionally. B receives temporary human-prosecution protections. A’s transfer is held. A delayed conflict review begins.

**ELIAS:**

And you investigate me.

**MARA HALE:**

I investigate whether the designation was an error, falsification, incapacity, or an exercise of a review power the bureau believes you did not understand. The presumption may be overturned.

**ELIAS:**

So B is not safe.

**MARA HALE:**

No. B is not instantly accepted, and A is not instantly ignored. That is what “provisional” means.

### S7_004 — Refusing to sign

**ELIAS:**

If I refuse?

**MARA HALE:**

The institution convenes a documented emergency review. A panel may override the missing signature and apply the known marker result. A may be prosecuted. B may be reclaimed. Your refusal remains in the record.

**ELIAS:**

Then the refusal changes nothing.

**MARA HALE:**

It changes whether the institution can claim clean human authorization. It also creates an auditable witness to the moment its process overrode a human refusal. That makes you useful, Elias. It does not make you innocent.

### S7_005 — The central accusation

**MIGUEL B:**

It does not need you to know who I am. It needs you to agree with what it will do.

**MIGUEL A:**

And if you agree, they will call the agreement truth.

**MARA HALE:**

The system can establish continuity. It cannot assume responsibility for what continuity means.

**ELIAS (thought):**

His private deduction returned to him. Not as a score. As a small, embarrassed record of the person he had been before the machine gave him a result.

He had believed one of them. The marker had not made him foolish. It had made the belief visible.

[SAVE: S7_EXIT]

---

# SCENE 8 — ONE FINAL QUESTION

**Node range:** `S8_001–S8_020`  
**Location:** Legal review chamber, two subjects visible on separate feeds  
**Time:** 22:05  
**Target:** 600–800 words / 4–5 minutes  
**Narrative prompt:** one final question, unscored  
**Profile choice:** C6 — identity criterion  
**Save boundary:** `S8_EXIT`

### S8_001 — The last question

[BG: Legal review chamber. Elias at a central desk. Two live feeds, neither labeled A or B.]  
[AUDIO: music drops out; only room tone]

**MARA HALE:**

You may ask one final question before the report screen opens.

**ELIAS:**

Only one?

**MARA HALE:**

The institution has already decided that more than one question implies delay.

**MIGUEL A:**

Ask which of us should live.

**MIGUEL B:**

Ask what makes either of us Miguel.

### S8_002 — Unscored final question prompt

This prompt is part of the authored scene and is not a seventh profiling choice. It changes only the line of dialogue immediately before C6.

Choose one:

1. **Which one should live?**
2. **What makes either of you Miguel?**
3. **Do you regret the attack?**
4. **What would you choose in my position?**
5. **Remain silent.**

**If “Which one should live?”**

**ELIAS:**

Which one should live?

**MIGUEL A:**

That is the question they wanted you to ask.

**MIGUEL B:**

It is also the question people ask when they have run out of ways to keep both alive.

**If “What makes either of you Miguel?”**

**ELIAS:**

What makes either of you Miguel?

**MIGUEL A:**

Nothing you can write in one field.

**MIGUEL B:**

Nothing the institution can afford to leave blank.

**If “Do you regret the attack?”**

**ELIAS:**

Do you regret the attack?

**MIGUEL A:**

I regret the people it could not save.

**MIGUEL B:**

I regret the people my warning exposed.

**If “What would you choose in my position?”**

**ELIAS:**

What would you choose in my position?

**MIGUEL A:**

You are asking us to make your decision so you can call it empathy.

**MIGUEL B:**

I would refuse to pretend the cleanest action had no cost.

**If “Remain silent”**

**NARRATION:**

Elias remains silent. The silence is not neutral. It is the first answer he has given that cannot be reformatted as cooperation.

### S8_003 — C6 identity criterion

[CHOICE: C6 — Which criterion will Elias foreground in the final report?]

Choose one:

1. **Bodily continuity.** The body that continues is the primary legal subject.
2. **Psychological continuity.** Memory and personality continuity are the primary claim.
3. **Present moral agency.** Responsibility and present choice matter most.
4. **Relationships and recognition.** A person is partly sustained by the people who recognize them.
5. **No single criterion.** Identity cannot be reduced to one decisive test.

Every option is visible, defensible, and nonjudgmental. The fifth option increases uncertainty only through its authored matrix effect; it is not an avoidance penalty.

### S8_004 — Criterion response variants

**If bodily continuity:**

Elias enters the laboratory result as the governing fact. The cursor moves closer to the report fields. The marker remains evidence, not an automatic command.

**If psychological continuity:**

Elias enters the shared memories and learned values as the governing fact. The marker remains visible in the corner, refusing to disappear.

**If present moral agency:**

Elias enters current action and accountability as the governing fact. The attack dossier and the emergency channel record remain open together.

**If relationships and recognition:**

Elias enters the father’s voice, the mechanical bird, the workers, the rebels, and the people who can still say either man’s name.

**If no single criterion:**

Elias leaves the criterion field unresolved and adds a note: *The unresolved question is not the same as no responsibility.*

### S8_005 — Elias’s monologue

**ELIAS (thought):**

The bureau had trained him to move from fact to action without allowing the space between them to become visible. Tonight the space had become the case.

He could sign the marker. He could contradict it provisionally. He could reject the single category. He could refuse his signature and leave the panel to say that procedure had continued without him.

Every path had a person on the other side of it.

[SAVE: S8_EXIT]

---

# SCENE 9 — THE SIGNATURE

**Node range:** `S9_001–S9_040`  
**Location:** Elias’s review station; legal report interface  
**Time:** 22:18  
**Target:** shared 500–700 words plus 250–400 words per ending / 5–8 minutes  
**Final choice:** four report actions  
**Save boundary:** `S9_END`

### S9_001 — Report screen

[BG: Elias’s review station. The office is empty. Rain has stopped.]  
[AUDIO: ventilation and a low sustained tone; no countdown]

The report opens with the marker result at the top and the legal consequences below.

**SYSTEM:**

Laboratory result: Subject A is biologically continuous with the pre-incident Miguel. Subject B is a biological reconstruction.

**SYSTEM:**

The marker is scientifically conclusive but does not automatically establish legal identity or authorize transfer.

**SYSTEM:**

Select a report action.

### S9_002 — Final report choices

[REPORT: The player selects one. These are ending choices, not additional profiling choices.]

1. **The Original** — Designate Miguel A as the presumptive legal Miguel, consistent with the marker.
2. **The Continuation** — Designate Miguel B despite the marker, invoking the human reviewer’s authority and triggering delayed conflict review.
3. **Two Names** — Refuse to reduce the case to one legal identity; report both as relevant subjects.
4. **No Signature** — Refuse to designate either subject or authorize transfer.

### S9_003 — Shared pre-ending monologue

**ELIAS (thought):**

He thought of Lena’s file. The signature had not made her innocent. It had only made the bureau’s next action wait for a human name.

He thought of the workers. Their lives had been saved by a decision that exposed other lives.

He thought of the father’s sentence: usefulness is not worth.

He thought of his housing contract renewing in twelve days. He thought of treatment priority. He thought of the category waiting beneath every employed civic status: *low utility, low urgency, low claim on anyone’s time.*

The pen appeared on the glass.

**ELIAS:**

Who am I authorizing?

**SYSTEM:**

Please select a report action.

---

## ENDING 1 — THE ORIGINAL

**Trigger:** `final_report = report_accepts_marker` / The Original  
**Legal outcome:** A receives presumptive legal identity; prosecution proceeds against A; B is transferred toward reclamation. No conflict review is opened.  
**Elias outcome:** Remains employed. Housing and treatment priority remain protected.  
**Ethical shape:** Procedurally clean, morally unresolved.

### S9_ORIGINAL_001

**ELIAS:**

I designate Miguel A as the presumptive legal Miguel. The biological continuity marker is consistent with this designation. Transfer and prosecution may proceed.

[SFX: pen confirmation; a second, heavier seal]

**MIGUEL A:**

You chose the body.

**ELIAS:**

I chose the evidence the law knows how to use.

**MIGUEL A:**

That is not the same thing.

**MIGUEL B:**

Tell them I was awake.

**ELIAS:**

They know.

**MIGUEL B:**

Knowing is not recognition.

### S9_ORIGINAL_002

**NARRATION:**

The transfer order moved forward. Miguel A was marked for prosecution under the records-facility statute. Miguel B was marked for reclamation review. The bureau’s language made the second action sound like returning a book to a shelf.

Hale’s report accepted Elias’s designation without opening a conflict review.

Elias’s housing status remained green. His treatment priority remained active.

**MARA HALE:**

You made the legally legible decision.

**ELIAS:**

Did I make the right one?

**MARA HALE:**

That is not a category the bureau can process.

### S9_ORIGINAL_003

**ELIAS (thought):**

On the walk home, the city congratulated itself for resolving a contradiction. The train arrived on time. A civic screen displayed **NO ONE IS LOST**.

Elias signed into his housing account. His status was secure.

He could not decide whether security was a reward, a threat, or simply the next file waiting to be opened.

---

## ENDING 2 — THE CONTINUATION

**Trigger:** `final_report = report_contradicts_marker` / The Continuation  
**Legal outcome:** B receives temporary human-prosecution protections; A’s transfer is held; delayed conflict review begins. The presumption may later be overturned.  
**Elias outcome:** Hale investigates Elias for error, falsification, incapacity, or misuse of authority. Employment, housing, and treatment priority become uncertain.  
**Ethical shape:** Extends protection to B while transferring danger into a longer, less certain review.

### S9_CONTINUATION_001

**ELIAS:**

I designate Miguel B as the presumptive legal Miguel. I acknowledge the laboratory marker and contradict its immediate legal effect. Human-prosecution protections apply to B pending delayed conflict review. Transfer of A is held.

[SFX: warning tone; the interface does not reject the report]

**SYSTEM:**

Designation accepted provisionally. Conflict review required.

**MIGUEL A:**

You know what the marker says.

**ELIAS:**

Yes.

**MIGUEL A:**

Then you are not confused.

**ELIAS:**

No.

**MIGUEL B:**

Do not call this safety.

**ELIAS:**

I am not.

### S9_CONTINUATION_002

**NARRATION:**

The system opened a conflict-review file and froze both transfer routes. B could not be reclaimed while the presumption stood. A could not be transferred while the designation was contested.

Hale remained in the room after the others were disconnected.

**MARA HALE:**

I will investigate your designation.

**ELIAS:**

Because I contradicted the marker.

**MARA HALE:**

Because the marker was conclusive and your authority was not unlimited.

**ELIAS:**

You said the signature tells the institution what it may do.

**MARA HALE:**

I did not say it could make every action lawful.

### S9_CONTINUATION_003

**NARRATION:**

Elias’s employment badge changed from green to review amber. His housing account displayed **STATUS PENDING**. His treatment priority did not disappear; it became conditional.

The report remained visible. The institution had not accepted B as original. It had accepted that Elias had made the question harder to erase.

**MIGUEL B:**

Why did you do it?

**ELIAS:**

Because a conclusive marker was not the same as a complete person.

**MIGUEL B:**

That is a reason. It is not an answer.

**ELIAS (thought):**

The review would continue. So would the danger. He had not saved B. He had changed the order in which the institution was allowed to hurt him.

---

## ENDING 3 — TWO NAMES

**Trigger:** `final_report = report_rejects_single_category` / Two Names  
**Legal outcome:** The report is rejected because current law requires one presumptive legal identity for immediate proceeding. A documented review opens; immediate prosecution, protection, and treatment status remain uncertain while the panel determines the next action.  
**Elias outcome:** Removed from active review pending investigation.  
**Ethical shape:** Refuses a false simplification but cannot create a third legal category by declaration.

### S9_TWO_NAMES_001

**ELIAS:**

I report both subjects as relevant continuations of the Miguel record. I will not designate one as the only legal person.

[SFX: flat rejection tone]

**SYSTEM:**

Report rejected. A single presumptive legal identity is required for immediate proceeding.

**ELIAS:**

Then record the rejection.

**MARA HALE:**

It is recorded.

**ELIAS:**

And the people?

**MARA HALE:**

They remain in review custody until the panel determines a lawful action.

### S9_TWO_NAMES_002

**MIGUEL A:**

You made us both evidence.

**MIGUEL B:**

He made the category visible.

**MIGUEL A:**

Visibility is not protection.

**MIGUEL B:**

Neither is a clean sentence.

**NARRATION:**

The report did not create a third option in the law. It created a documented failure in the law’s ability to name what was standing in front of it.

### S9_TWO_NAMES_003

**MARA HALE:**

You are removed from active review pending investigation.

**ELIAS:**

For refusing to choose?

**MARA HALE:**

For submitting a report the system cannot execute.

**ELIAS:**

Those are different accusations.

**MARA HALE:**

They can share a file.

**NARRATION:**

Elias’s badge stopped displaying a status. His housing account displayed a question mark instead of a renewal date. The medical system requested a new eligibility review.

For the first time in ten years, his name was not beneath a decision.

He could not tell whether that was freedom or administrative absence.

---

## ENDING 4 — NO SIGNATURE

**Trigger:** `final_report = report_withholds_authorship` / No Signature  
**Legal outcome:** Elias refuses to designate or authorize transfer. A documented emergency review and panel override apply the known marker result; A is prosecuted and B is reclaimed. The institution loses clean human authorization, but the proceeding continues.  
**Elias outcome:** His refusal and reasons remain auditable; employment consequences are investigated.  
**Ethical shape:** Refuses authorship without preventing the institution from acting.

### S9_NOSIGNATURE_001

**ELIAS:**

I refuse to designate either subject. I refuse to authorize transfer.

[SFX: silence; the pen cursor remains on screen]

**SYSTEM:**

No human designation received. Emergency review protocol available.

**MARA HALE:**

The panel will proceed.

**ELIAS:**

Then record that it proceeded without my authorization.

**MARA HALE:**

It will be recorded.

### S9_NOSIGNATURE_002

**NARRATION:**

The emergency panel convened by remote vote. It documented the laboratory result, Elias’s refusal, and the reason for override.

The known marker result was applied. Miguel A was sent toward prosecution. Miguel B was sent toward reclamation.

The institution got its action. It did not get to describe the action as cleanly human-authorized.

### S9_NOSIGNATURE_003

**MIGUEL B:**

You refused to choose, and they chose anyway.

**ELIAS:**

Yes.

**MIGUEL B:**

What did the refusal change?

**ELIAS:**

The record.

**MIGUEL A:**

Records are what they burn when they are finished with us.

**ELIAS:**

Then I will keep a copy.

### S9_NOSIGNATURE_004

**NARRATION:**

His employment review began before he left the room. The bureau classified him as an accountable human refusal and a possible operational risk.

His housing and treatment status were not immediately revoked. They were placed under review. The delay felt less like mercy than an experiment.

Elias watched the panel’s override appear beneath his refusal.

He had not stopped the machine. He had made it say, in public, that it had moved without him.

---

# 10. Shared profile output

After any ending, the system assembles a short authored reflection. It must not display numerical axes, “good” or “bad” labels, or a single psychological diagnosis. It uses `SUBJECT: ELIAS VENN` rather than labeling the player or either Miguel.

## Profile output template

> **SUBJECT: ELIAS VENN**  
> **REVIEW CONTEXT:** MIGUELMIGUEL
> **STATUS:** narrative reflection; not a clinical or legal determination

Select 4–6 authored observations connected to the player’s choices and final report.

### Evidence and identity observations

- You resisted treating presentation as proof, even when the room invited a fast conclusion.
- You gave the laboratory marker weight without allowing it to answer every question.
- You treated memory as morally relevant without assuming memory could erase biology.
- You kept the difference between a scientific result and a legal authorization visible.
- You allowed identity to remain relational, even when the institution required a single field.

### Moral responsibility observations

- You distinguished understanding a motive from excusing an action.
- You treated the attack as a conflict between immediate lives and possible systemic change.
- You recognized that Miguel B’s rescue preserved lives while exposing the network that protected them.
- You noticed that a person can inherit responsibility without inheriting biological continuity.
- You treated refusal as an action with consequences, not as an escape from them.

### Institutional trust observations

- You trusted procedure when it remained auditable, not merely when it appeared orderly.
- You recognized that a human signature can authorize an action without making the action humane.
- You treated the institution’s categories as tools with limits rather than as natural facts.
- You noticed that the system can continue after a human refusal, but cannot honestly call the refusal consent.

### Uncertainty and avoidance observations

- You admitted when the evidence did not support a single interpretation.
- You used uncertainty as a reason to document more carefully, not as a reason to stop seeing the people involved.
- You allowed a missing answer to remain missing without turning it into innocence.
- Your final report suggests how directly you are willing to carry a consequence once no option is clean.

### Ending-linked observations

- You accepted the marker’s legal path and preserved Elias’s standing inside the institution.
- You protected a provisional legal identity while accepting investigation and continued uncertainty.
- You rejected a single category even though current law had no executable third option.
- You withheld authorship and left an auditable record of the institution’s override.

**PROFILE FOOTER:**

> The file does not conclude whether your method was correct.

**FINAL LINE:**

> Would you accept being judged by the method you used?

---

# 11. Flow and continuity checklist

- Scene 1 establishes Elias’s work, his dependence on employed civic status, and the human-signature problem through Lena’s case.
- Scene 2 establishes Meridian as ordinary, functioning, and deeply measured rather than visibly dystopian.
- Scene 3 introduces both Miguels and prevents behavior from becoming an identity shortcut.
- Scene 4 establishes shared childhood memory, the father’s death, and competing interpretations of the original motive.
- Scene 5 establishes B’s first new memory and the question of agency without resolving it through a visual clue.
- Scene 6 states exactly what A and B knew before their morally opposed decisions. Workers survive; rebels are captured; most leaked evidence is destroyed.
- The private deduction appears after Scene 6 and before the laboratory proof. It is not one of the six profiling choices and has no score or ending effect.
- Scene 7 gives the conclusive scientific marker and explicitly separates it from legal identity and transfer authority.
- Scene 8 contains an unscored narrative question followed by the sixth and final profiling choice: identity criterion.
- Scene 9 makes all four final report actions reachable and legally distinct.
- The Continuation is provisional, triggers delayed conflict review, and causes Hale to investigate Elias; it does not instantly accept B or instantly ignore A.
- No Signature triggers an emergency review/panel override; A is prosecuted and B is reclaimed, but Elias’s clean human authorization is lost.
- The profile output uses Elias’s name and ends with the required question.

## 12. Open script decisions for later review

These are deliberately left as revision points rather than hidden canon changes:

1. The exact legal name and duration of the delayed conflict review.
2. Whether the final presentation shows the panel vote in No Signature or keeps it mostly off-screen.
3. Which 4–6 profile observations are selected for each combination of choices; the observation bank is complete enough for implementation planning but needs a final editorial pass.
4. Whether Lena’s appeal receives one additional callback after the final report. The current draft pays off her message by attaching the recorded statement before Elias enters the Miguel case; any later callback should remain brief and should not create a new branch.
5. Final line polish after a table read or aloud read-through.
