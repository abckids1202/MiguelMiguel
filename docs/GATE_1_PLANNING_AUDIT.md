# MiguelMiguel — Gate 1 Planning Audit

**Status:** Gate 1.1 approved; Gate 2 end-to-end script draft in progress
**Current format:** normal folder containing planning documents only
**Godot project created:** no
**Application code written:** no
**Revision status:** Gate 1.1 and the current script draft are committed and pushed; editorial review remains open

## 1. What this gate does

Gate 1 turns the definitive direction into a usable production contract. It answers:

- What game are we making?
- What is factually true in the story?
- What does the player learn, scene by scene?
- What do the six interpretation choices mean and how do they shape Elias’s profile?
- What visual/audio work is needed?
- What technical shape should the future Godot project have?
- What risks must be resolved before script and code work?

The Gate 1 package did **not** create `project.godot`, `res://`, assets, or application code. Gate 2 now adds the narrative draft in `docs/SCRIPT.md`; implementation remains deferred.

## 2. Source hierarchy

The two supplied attachments were read in full. The project did not initially contain the named `MiguelMiguel_Full_Game_Plan_and_Build_Prompt.md`; the supplied master-prompt attachment is now preserved as that root-level file so future reviews have a stable canonical reference. The source hierarchy is:

1. **Definitive planning direction attachment:** source of truth for the short psychological visual novel, canon, scope, tone, scenes, word budgets, profile axes, endings, visual/audio direction, and technical baseline.
2. **Supplied master prompt attachment:** source of truth for the Gate 1 workflow, Godot architecture expectations, validator requirements, save requirements, testing expectations, and approval stops.
3. **Existing repository docs:** historical web-game planning only. They are moved under `docs/archive/web-plan/` and must not guide Godot implementation.

If a later canonical file is supplied, it should be compared against the root copy before any script or implementation work begins. Any difference that changes canon or scope requires approval.

## 3. Definitive production contract

| Area | Decision |
| --- | --- |
| Format | 45–60 minute psychological/philosophical visual novel with light profiling |
| Presentation | Static illustrated backgrounds, portraits, dialogue, narration, monologue, music, ambience, restrained fades |
| Engine | Godot 4.7.1 stable, or latest compatible 4.7 patch |
| Language | Typed GDScript where practical |
| Primary platform | Windows desktop |
| Secondary platform | Web only after desktop quality is proven and no accessibility/narrative regression appears |
| Runtime | Offline single-player; no backend, accounts, cloud saves, analytics, or telemetry |
| Story structure | Nine major scenes, branch-and-bottleneck flow, six interpretation choices, one final report, four endings |
| Factual canon | Miguel A is biologically/chronologically original; Miguel B is the biological reconstruction |
| Moral canon | No ending is labeled ethically correct; the game does not score which consciousness deserves the name |
| Player role | Elias Venn, a Human Review Detective whose signature creates a presumptive legal identity and authorizes transfer around a consequence the Measure already computed |
| Visual identity | Muted painterly institutional realism; no neon cyberpunk, gore, constant glitch, or identity-coded color |
| First implementation slice | Title, story UI, deterministic dialogue runner, Scene 1 through its profile choice, profile overlay, placeholder art, basic settings, autosave/manual save |

## 4. Strong recommendations

### Recommendation A — Keep the factual answer fixed and visible only through evidence

Do not randomize which subject is original. The story is about the gap between discovering a fact and deciding what the fact should authorize. The laboratory marker gives the player a factual anchor late in the story; earlier scenes establish why that anchor is not the whole moral problem.

### Recommendation B — Make the profile system a record, not a morality meter

The hidden axes are useful authoring tools, not player-facing alignment. Each choice should immediately produce one authored observation in a dossier overlay. At the ending, those observations are reframed around Elias. This makes the system legible without turning the story into a quiz.

### Recommendation C — Treat the final report as an institutional action

The four conclusions should be presented as reports with consequences, not as “good,” “bad,” or “secret” endings. The Continuation must temporarily change treatment through presumptive designation before delayed conflict review. The No Signature outcome must show that refusal removes clean human authorization but does not stop the documented emergency panel route.

### Recommendation F — Keep uncertainty distinct from avoidance

Ordinary “insufficient information,” “mixed motive,” and “no single criterion” choices receive an authored `epistemic_restraint` tag, not `avoidance`. Avoidance is inferred primarily from how Elias acts at the final report and how his final monologue frames that action.

### Recommendation G — Make both Miguels pay a real moral cost

A chooses possible systemic change over immediate worker lives. B uses an institution-controlled emergency channel to save the workers, knowing it may expose the Uncounted’s access route; authorities capture rebels and destroy most of the leak. Neither choice is presented as the clean answer.

### Recommendation D — Build a small content-driven runner

In Godot, a **scene** is a screen or room definition, a **node** is one object in that scene, and an **autoload** is a shared service that stays available while the game runs. Use a small typed story runner that reads validated story data. Do not build a general-purpose scripting language or a single giant controller.

### Recommendation E — Keep placeholder art explicitly temporary

The vertical slice should use labels such as `PLACEHOLDER — REPLACE BEFORE CONTENT LOCK` on art and audio assets. This avoids accidentally treating grey boxes or temporary portraits as the final visual identity.

## 5. True ambiguities and recommended defaults

| Decision | Recommended default | Why it is safe | Approval point |
| --- | --- | --- | --- |
| Canonical full-plan file | Preserve the supplied master prompt at the repository root; compare any later replacement before script work | Gives future reviewers one stable reference | Before Gate 2/script |
| Viewpoint | Close third person through Elias | Preserves intimacy while allowing distance from his thoughts | Gate 2 |
| Subject labels | Use Miguel A and Miguel B as institutional labels; never imply A/B moral status | The labels are already canon and help the UI stay neutral | Gate 2 |
| Miguel portrait differentiation | Same base portrait with controlled wardrobe/lighting/context differences only | Avoids visual meta-clues about origin | Asset review |
| Final report UI | Four plain report cards with full consequence text and no hierarchy beyond reading order | Prevents “secret ending” behavior | Gate 2 |
| Profile axis ranges | Small bounded integers, initially `-3..3`, clamped after every choice; use `epistemic_restraint` tags for caution | Separates careful reasoning from avoidance | Technical review |
| Profile entries | One visible entry after each interpretation choice; 4–6 final observations assembled from authored combinations | Meets the brief without exposing hidden variables | Script approval |
| Save slots | Three manual slots plus one autosave | Simple for a new player and enough for branch comparison | Technical review |
| Controller | Support standard focus/navigation where Godot provides it; do not block Windows release on advanced remapping | Keeps the first slice small | Vertical-slice review |
| Web export | Defer until Windows build, text scaling, saves, audio, and keyboard navigation pass | Web export can expose platform-specific regressions | Release gate |
| Font | Use a readable bundled sans-serif placeholder first; choose final licensed font before art lock | Avoids blocking the first slice on font licensing | Visual lock |

## 6. Gate 1 acceptance checklist

- [x] Premise, factual canon, moral scope, and non-goals documented.
- [x] Nine-scene structure and word/time envelopes documented.
- [x] Canonical truth timeline documented separately from player-facing discovery order.
- [x] Knowledge boundaries for A, B, Hale, Elias, and Lena documented.
- [x] Six choice options are defensible and mapped to hidden axes and visible entries.
- [x] Four report outcomes and consequences documented without a correct-ending label.
- [x] Visual palette, screen layout, background/portrait needs, audio buses, and asset manifest contract documented.
- [x] Future Godot architecture, data schema, saves, validators, and tests documented in beginner-friendly language.
- [x] Production milestones and risks documented.
- [x] No Godot project or application code created.
- [x] Legal presumption, delayed conflict review, and emergency panel override are explicit.
- [x] A/B moral costs and pre-decision knowledge are explicit.
- [x] One private, non-scored pre-proof biological deduction is explicit.
- [x] Typography baseline is 26–30px dialogue, 20–24px speaker labels, 18px secondary UI minimum.
- [x] Superseded web documents are separated under `docs/archive/web-plan/`.

## 7. Approval needed

Before moving to Gate 2/script drafting, approve or revise:

1. The close-third-person viewpoint through Elias.
2. The fixed A-original/B-reconstruction canon and late proof reveal.
3. The legal mechanics: presumptive designation, delayed conflict review, and emergency panel override.
4. The six-choice profile matrix, `epistemic_restraint` tags, and final-report avoidance inference.
5. The four final reports and their stated consequences.
6. The branch-and-bottleneck structure and word-budget tension described in `SCENE_BEAT_SHEET.md`.
7. The normal-folder-first workflow and the recommendation to defer `project.godot` until the script/design gate is approved.

The next step after approval is `docs/SCRIPT.md` in scene order. No implementation should begin before that script is separately reviewed and approved.
