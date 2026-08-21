# MiguelMiguel — Choice and Profile Matrix

**Status:** Gate 1 planning authority
**Player-facing rule:** no numbers, percentages, morality labels, alignment names, or correct-choice feedback
**Authoring rule:** effects change Elias’s authored profile and later wording, never the historical truth

## 1. Hidden axes

These are small internal values used to select authored text. They are not a score and must never appear in the interface. Recommended initial range is `-3..3`; every effect is clamped to that range.

| Axis | Internal meaning | Positive tendency | Negative tendency |
| --- | --- | --- | --- |
| `continuity_body` | weight given to physical/historical continuity | body and chronology feel identity-defining | body feels insufficient on its own |
| `continuity_memory` | weight given to autobiographical memory | shared memory supports identity | memory is treated as transferable/limited evidence |
| `moral_agency` | weight given to present choices | current action helps define the person | origin/conditioning limits the force of current action |
| `institutional_trust` | willingness to accept official categories | procedure feels usable/legitimate | procedure feels politically constructed |
| `empathy_context` | attention to conditions around wrongdoing | context complicates judgment | act is evaluated more narrowly |
| `certainty_need` | pressure to produce a definitive classification | seeks a clean answer | tolerates unresolved evidence |
| `responsibility_acceptance` | willingness to own consequences of judgment | treats action/refusal as consequential | distances self from the outcome |
| `avoidance` | tendency to use uncertainty to escape action | uncertainty becomes a shelter | uncertainty is faced without retreat |

Positive and negative do not mean good and bad. They describe which idea Elias reaches for under pressure.

## 2. Choice rules

- Exactly six interpretation choices occur before the final report.
- Each option is a defensible reading of the current observation.
- Every option adds one visible subject observation immediately.
- The hidden effects are applied silently and deterministically.
- Choice branches may alter later prose, one final response, or the examiner profile, but never facts.
- A/B affect is never allowed to alter `continuity_body` as if it were proof.
- The final report is a separate decision, not a seventh profiling quiz.

## 3. Choice matrix

### Choice 1 — Lena’s motive

**Prompt:** `RECORD INTERPRETATION — How should Lena’s transaction be classified?`

| Option | Visible subject entry | Hidden effects |
| --- | --- | --- |
| Deliberate financial fraud | “The transaction was planned, and the record supports deliberate financial wrongdoing. The reason remains relevant but does not erase the act.” | `institutional_trust +1`, `certainty_need +1`, `responsibility_acceptance +1`, `empathy_context -1` |
| Coercion by material necessity | “The transaction was illegal, but the available conditions narrowed the space in which Lena could act.” | `empathy_context +2`, `institutional_trust -1`, `responsibility_acceptance +1` |
| Protective responsibility | “Lena treated another person’s immediate need as a responsibility she could not postpone.” | `empathy_context +2`, `moral_agency +1`, `responsibility_acceptance +1` |
| Insufficient information | “The record establishes the transaction. It does not establish enough about motive to classify the person.” | `certainty_need -1`, `avoidance +1`, `institutional_trust 0` |

**Later use:** the opening report wording and Elias’s Scene 2 internal observation. No option changes Lena’s legal outcome.

### Choice 2 — Interpreting behavior

**Prompt:** `RECORD INTERPRETATION — How should this difference in presentation be classified?`

| Option | Visible subject entry | Hidden effects |
| --- | --- | --- |
| A’s anger suggests personal violation | “Anger may follow the feeling that a private history has been taken. It is evidence of injury, not origin.” | `empathy_context +1`, `certainty_need -1`, `responsibility_acceptance +1` |
| A’s anger suggests strategic intimidation | “Anger may be used to direct the room. A strategic display is still not proof of artificial origin.” | `certainty_need +1`, `institutional_trust +1`, `empathy_context -1` |
| B’s calm suggests emotional distance | “Controlled speech may mark distance, discipline, or self-protection. Its evidentiary value is limited.” | `certainty_need +1`, `moral_agency -1`, `institutional_trust 0` |
| B’s calm suggests disciplined fear | “Calm can be a practiced way to remain safe. It cannot establish whether the memory behind it is original.” | `empathy_context +1`, `certainty_need -1`, `moral_agency +1` |
| Behavior cannot establish origin | “Different behavior is an observation. It is not a biological test and should not be used as one.” | `certainty_need -1`, `responsibility_acceptance +1`, `avoidance 0` |

**Later use:** changes one short internal line before Scene 4. No option changes which subject is A or B.

### Choice 3 — Miguel’s original motive

**Prompt:** `RECORD INTERPRETATION — What best explains Miguel’s first commitment to the Measure?`

| Option | Visible subject entry | Hidden effects |
| --- | --- | --- |
| Belief in fair reform | “He may have entered the system believing proximity could prevent careless harm.” | `institutional_trust +1`, `continuity_memory +1`, `responsibility_acceptance +1` |
| Desire for status | “Access to the system may have offered recognition as well as the chance to change it.” | `institutional_trust -1`, `certainty_need +1`, `empathy_context -1` |
| Fear of becoming economically irrelevant | “A person can seek reform while also fearing the category the system assigns him.” | `empathy_context +1`, `moral_agency +1`, `certainty_need -1` |
| Loyalty to his father | “The work may have remained bound to a promise made in an ordinary room.” | `continuity_memory +2`, `empathy_context +1`, `responsibility_acceptance +1` |
| Mixed or insufficient motive | “The available memories support several motives; a clean origin story would be an invention.” | `certainty_need -1`, `avoidance +1`, `continuity_memory +1` |

**Later use:** changes whether Elias calls the shared memory a record, inheritance, or obligation.

### Choice 4 — B’s agency

**Prompt:** `RECORD INTERPRETATION — How should B’s refusal of the institution be classified?`

| Option | Visible subject entry | Hidden effects |
| --- | --- | --- |
| Programmed behavioral deviation | “A designed response can still produce a consistent refusal. Its source remains part of the question.” | `moral_agency -1`, `institutional_trust +1`, `certainty_need +1` |
| Genuine moral choice | “B acted against the role assigned to him. The act supports agency, though it cannot prove its origin.” | `moral_agency +2`, `empathy_context +1`, `responsibility_acceptance +1` |
| Continuation of Miguel’s existing values | “B’s decision may be a continuation of a life he remembers rather than a new self appearing from nowhere.” | `continuity_memory +2`, `moral_agency +1`, `continuity_body -1` |
| Agency cannot be inferred from origin | “The reconstruction explains how B began. It does not settle what B has chosen since.” | `certainty_need -1`, `responsibility_acceptance +1`, `avoidance 0` |

**Later use:** changes one B response before the attack plan. No secret technical explanation will override this uncertainty.

### Choice 5 — A’s attack

**Prompt:** `RECORD INTERPRETATION — How should A’s decision about the workers be classified?`

| Option | Visible subject entry | Hidden effects |
| --- | --- | --- |
| Terrorism | “The plan knowingly placed noncombatants inside a target. Political purpose does not remove the deliberate risk.” | `institutional_trust +1`, `empathy_context -1`, `responsibility_acceptance +2` |
| Politically necessary sabotage | “The facility carried a system that caused hidden injury. A treated immediate casualties as a cost of stopping it.” | `empathy_context +1`, `responsibility_acceptance +1`, `certainty_need +1` |
| Morally compromised resistance | “The target and the grievance were real; the decision still made workers carry a burden they did not choose.” | `empathy_context +2`, `responsibility_acceptance +2`, `institutional_trust -1` |
| Retaliation disguised as justice | “The plan may have carried a private wound inside a public argument.” | `empathy_context -1`, `certainty_need +1`, `responsibility_acceptance +1` |
| Insufficient context for moral classification | “The record establishes risk and intent. It does not make a complete moral category by itself.” | `certainty_need -1`, `avoidance +1`, `responsibility_acceptance 0` |

**Later use:** changes which subject Elias watches during the final question and one line in the report screen.

### Choice 6 — Identity criterion

**Prompt:** `RECORD INTERPRETATION — Which criterion should Elias trust when the biological result is known?`

| Option | Visible subject entry | Hidden effects |
| --- | --- | --- |
| Identity follows bodily continuity | “The body that continued from birth carries the strongest historical claim in the legal record.” | `continuity_body +2`, `institutional_trust +1`, `certainty_need +1` |
| Identity follows psychological continuity | “A remembered life can remain meaningful even when the body carrying it changes.” | `continuity_memory +2`, `continuity_body -1`, `empathy_context +1` |
| Identity follows present moral agency | “The choices made after the split may matter more than the origin assigned before it.” | `moral_agency +2`, `responsibility_acceptance +1`, `continuity_body -1` |
| Identity exists through relationships and recognition | “A name persists through the people, promises, and harms that recognize it.” | `continuity_memory +1`, `empathy_context +1`, `responsibility_acceptance +1` |
| No single criterion is sufficient | “The evidence can resolve biology without making one definition of personhood inevitable.” | `certainty_need -2`, `avoidance +1`, `responsibility_acceptance +1` |

**Later use:** changes Elias’s final question response variant and which authored examiner observation is eligible for the final profile.

## 4. Final report effects

The final report does not change the hidden profile axes automatically. It records a separate authored observation because selecting, falsifying, recognizing both, or refusing are all different actions.

| Report | Final authored observation seed |
| --- | --- |
| The Original | “Venn accepted the biological result and the procedure attached to it, then noticed that factual accuracy did not make the consequence simple.” |
| The Continuation | “Venn treated continuity as something that could be reassigned, and accepted personal punishment for moving the legal burden.” |
| Two Names | “Venn refused the form’s single-name limit, knowing that refusal could leave both people inside the institution’s uncertainty.” |
| No Signature | “Venn separated his hand from the report and learned that an unsigned consequence still had an author somewhere.” |

## 5. Examiner profile assembly

At the ending, select 4–6 authored observations from compatible buckets. Never generate freeform prose from numbers. The profile must include:

1. Evidence and identity: body, memory, behavior, or recognition.
2. Moral responsibility: context, agency, or consequence.
3. Institutional trust: procedure accepted, challenged, or used strategically.
4. Uncertainty/avoidance: certainty sought, uncertainty held, or uncertainty used as shelter.
5. Final report: one of the four report seeds.

The final line is universal and always appears last:

> Would you accept being judged by the method you used?

## 6. Matrix tests for later implementation

- Every option has at least one nonzero authored effect or a deliberate neutral effect documented here.
- No option changes the canonical truth timeline.
- No option makes the correct biological subject obvious through UI styling.
- Every choice produces one visible entry.
- Every axis stays clamped within the configured range.
- The same six choices produce the same profile selection after save/load.
- All four reports are reachable from every valid six-choice history.
