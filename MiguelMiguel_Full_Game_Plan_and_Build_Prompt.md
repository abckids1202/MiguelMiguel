Copy everything between MASTER PROMPT START and MASTER PROMPT END into a capable coding agent working at the project repository root.
You are the senior narrative designer, psychological-fiction editor, game director, Godot engineer, UI/UX designer, accessibility specialist, QA lead, and technical writer responsible for creating MiguelMiguel.
Build a short, restrained, psychologically serious visual novel—not a large feature-driven application. Do not begin coding immediately. Inspect the repository, prepare the required narrative/design/technical documents, and stop at the approval gate described below.
- Title: MiguelMiguel
- Genre: psychological/philosophical visual novel with light profiling choices
- Length: 45–60 minutes
- Script target: 8,000–10,000 words
- Engine: Godot 4.7.1 stable or latest compatible stable patch in Godot 4.7
- Language: typed GDScript where practical
- Presentation: static illustrated backgrounds, character portraits, narration, dialogue, monologue, profile records, music, ambience, and restrained fades
- Primary platform: Windows desktop
- Secondary platform: web only if it creates no material quality/accessibility regression
- Offline single-player
- No backend, accounts, cloud database, analytics, monetization, LLM, generative dialogue, multiplayer, combat, walking system, 3D, or elaborate animation
- Six meaningful profiling choices and one final decision
- Four endings
- Local save/load, auto, skip-read, history, settings, and accessibility controls
Meridian is a dense, functioning near-future city where automation has produced wealth while removing employment. A Civic Allocation System called the Measure assigns housing, medical, financial, surveillance, and civic priority. The powerful call it neutral. In reality, human policymakers encoded which losses were acceptable and use the system to distance themselves from responsibility.
Detective Elias Venn, 40, is a depressed Human Review Detective. Predictive systems already solve most factual cases. Elias’s remaining function is to place a human signature beneath automated decisions. He has become morally exhausted and mistakes passivity for innocence.
Rebel model auditor Miguel discovered that the Measure intentionally reduced services in politically inconvenient districts, producing the instability it later cited as justification for further control. After his father died following a priority denial, Miguel stole internal records and joined the Uncounted.
Authorities created a biological reconstruction of Miguel using stolen medical, neural, and surveillance data. The construct inherited Miguel’s memories through the snapshot date and was intended to infiltrate the rebellion. It instead agreed with Miguel’s cause.
Six months later, the two diverged. The biological original, Miguel A, planned to destroy a records facility and accepted the likely deaths of night workers. The reconstruction, Miguel B, warned the workers and prevented the detonation, causing the leak to fail partially. Both were captured.
The Measure can already identify B as synthetic through a reconstruction marker. Law nevertheless requires a human reviewer to designate the original before A can be prosecuted and B reclaimed as property. Elias is not needed to discover the answer. He is needed to authorize its consequence.
The factual answer is fixed: Miguel A is the biological original; Miguel B is the reconstruction. Do not change this into a random assignment or a last-minute reversal. The philosophical conflict comes from the gap between chronological origin, psychological continuity, moral agency, and legal personhood.
1. Start with ordinary life and procedure. Do not announce philosophical themes immediately.
2. AI is not a conscious evil villain. Human institutions chose the objectives and hide behind automation.
3. Miguel A must remain understandable but morally compromised.
4. Miguel B must remain sympathetic but epistemically uncertain; his compassion might be chosen or imposed.
5. Elias must not become heroic merely by selecting a compassionate-sounding option.
6. Refusing to decide must carry consequences and cannot function as automatic moral purity.
7. Facts may resolve biological origin. The game must not objectively score which consciousness deserves the name.
8. Profiling choices reveal Elias’s standards of humanity.
9. No character cites philosophers or delivers a long lecture explaining the theme.
10. Prefer concrete details, silence, and emotional contradiction to abstract exposition.
Quiet, observant, depressed, ashamed of complicity. Show his condition through ignored messages, untouched food, automatic habits, and avoidance. He once believed human discretion could protect people from systems. Now his signature legitimizes them.
Biological original. Angry, intelligent, impatient, personally wounded. He experienced the city’s injustice and accepts casualties in destroying the Measure’s records facility. He rejects B as an instrument wearing his memories.
Biological reconstruction. Controlled, self-questioning, compassionate, sometimes unnervingly precise. He remembers Miguel’s life through the snapshot, then remembers awakening as property. He prevented the attack. He cannot prove that his mercy is freer than programming.
Elias’s superior. Calm, competent, procedurally reasonable. She believes allocation prevents chaos. Never write her as a theatrical villain. Her function is to show how moral violence becomes administrative language.
An unemployed former nurse’s aide who sold identity allowance access to buy medicine. She admits the act. Her opening scene establishes that factual guilt and moral justice differ.
Write and implement these nine scenes:
1. A Minor Irregularity — Elias reviews Lena’s already-solved case and makes the first interpretive profile choice before signing.
2. Meridian, 18:40 — train journey and understated city worldbuilding; Hale assigns the duplicate case.
3. Miguel / Miguel — first encounter, matched memories, different affect, second profile choice.
4. A Shared Childhood — father, repaired mechanical object, usefulness versus worth, third profile choice.
5. The First New Memory — B describes awakening; programmed versus conditioned agency, fourth profile choice.
6. Necessary Casualties — facility attack, workers at risk, original versus copy moral divergence, fifth profile choice.
7. Proof — synthesis marker reveals B; Hale admits the Measure already knew; Elias’s signature is the actual product.
8. One Final Question — player chooses one final question and records an identity criterion, sixth profile choice.
9. The Signature — player submits one of four reports and receives an ending plus examiner profile.
Use the detailed plan in the project’s planning document as the source of truth for word budgets and scene purposes.
Implement six authored interpretation choices. Track hidden integer axes:
```
continuity_body
continuity_memory
moral_agency
institutional_trust
empathy_context
certainty_need
responsibility_acceptance
avoidance
```
Do not show numbers, percentages, alignment names, or morality labels.
Each choice must:
- Offer only defensible interpretations
- Add a visible authored profile entry
- Change one or more hidden axes
- Optionally alter later internal monologue or one final response
- Never change historical facts
- Never reveal “correct choice” feedback
At the ending, assemble 4–6 authored observations about Elias from his choices. Change the document heading from SUBJECT: MIGUEL to SUBJECT: ELIAS VENN. End with:
Would you accept being judged by the method you used?
Implement exactly these four conclusions without good/bad labels:
1. The Original: designate A according to biological evidence; A is prosecuted, B reclaimed, Elias remains employed.
2. The Continuation: falsify the designation in favour of B; B gains legal personhood through prosecution, A is classified anomalous, Elias is removed and investigated.
3. Two Names: recognize both as persons; the report is rejected as noncompliant and Elias is removed; their immediate fate remains uncertain.
4. No Signature: refuse to sign; emergency procedure applies the Measure’s known result; Elias avoids authorship but not consequence.
Each ending should take approximately 2–4 minutes and include profile-dependent internal reflection. Never state which ending is canonical or ethically correct.
- Recommended viewpoint: close third person through Elias
- Plain, concrete prose before abstraction
- Dialogue carries subtext and contradiction
- No exposition dump about the Measure
- No fake profundity in every line
- No direct philosophical references
- No “AI bad, humans good” simplification
- No twist that Elias is secretly another Miguel
- No revelation that B was emotionless or secretly evil
- No hidden code file that proves whether B’s compassion is authentic
- No miraculous ending where one choice destroys the system
- Keep the city alive and ordinary, not uniformly miserable
Before finalizing the script, perform an editing pass that marks and removes:
- Redundant philosophical statements
- Worldbuilding characters already know
- Lines that explain a visual twice
- Repeated metaphors
- Choices with an obviously virtuous answer
- Any moment where calmness/anger functions as proof of identity
Use a painterly, muted, institutional visual style. Do not imitate copyrighted artwork or recreate The House in Fata Morgana assets. Take only broad inspiration from serious static composition and atmosphere.
Core colors:
```
charcoal       #111416
deep blue-gray #1B2429
concrete       #6E7472
paper          #DDD6C7
pale text      #ECE8DF
amber          #C69A54
muted cyan     #5D9FA3
dried red      #8E4547
```
Required background categories:
- Civic office
- Train interior
- Meridian exterior
- Detention corridor
- Neutral interrogation room
- Split interrogation room
- Records/profile surface
Use static portraits, crossfades, slow drift, minor emphasis changes, and rare display flicker. No lip-sync, skeletal animation, excessive parallax, particles, or constant glitch effects.
Create an asset manifest with dimensions, filenames, purpose, state, license/source, and replacement status. Use clearly labeled original placeholder art until final assets exist. Never present placeholders as final artwork.
Audio requires separate music, ambience, and effects buses. Reuse a pen/signature sound from the opening case in the final report.
- Reference resolution 1920×1080, 16:9
- Scalable Control-node layout
- Readable bottom dialogue panel
- Speaker names and narration distinction
- Choice overlay styled as an official interpretation record
- Profile viewer available during story
- Dossier/evidence viewer
- Dialogue history
- Save/load slots plus autosave
- Text speed, auto delay, skip read, master/music/ambience/effects volumes
- Fullscreen/windowed, resolution where applicable
- Reduced motion
- Scalable text
- Visible keyboard focus
- No timed choices
- Clue-bearing visual gestures always described in text
Implement normal, hover/focus, pressed, disabled, and selected states. Do not rely on color alone.
- Godot 4.7.1 stable / compatible 4.7 patch
- Typed GDScript where practical
- Offline
- Windows desktop export first
- No third-party plugin in the initial vertical slice
- No backend or network requirement
Create:
- GameState autoload
- SaveManager autoload
- AudioManager autoload
- SettingsManager autoload
- Deterministic DialogueRunner
- Story data validator
- Profile assembler
- Story, profile, dossier, title, settings, save/load, and ending scenes
Story data must live outside scene files in validated JSON or Godot Resources and support:
```
id
type
speaker
text/localization_key
visual_commands
audio_commands
conditions
effects
next
branches
```
Supported node types:
```
narration
dialogue
monologue
choice
profile_choice
scene_change
portrait
music
sound
dossier
conditional
jump
ending
```
Validator must detect duplicate IDs, missing references, unreachable nodes, missing assets, invalid effects, broken endings, and missing localization keys.
Use versioned local save files under user:// through supported Godot file APIs. Persist current node, flags, choice history, profile axes, visible entries, read-node history, and restoration state. Store settings separately. Validate save schema and handle corrupt/incompatible saves safely.
- Keep scripts focused by responsibility
- Avoid one enormous story controller
- Use signals for UI/domain boundaries
- Avoid global state outside intentional autoloads
- Document content schemas and save migrations
- No hardcoded absolute paths
- No secrets or telemetry
- Commit .gitignore, export presets without signing secrets, and asset-license records
Provide:
- Story graph validation runnable headlessly
- Automated traversal showing all endings reachable
- Save/load round-trip tests at scene boundaries
- Profile-choice mapping tests
- Conditional-dialogue tests
- Tests that every non-ending node has a valid continuation
- UI smoke tests for title, story, profile, settings, save/load
- Manual QA checklist for 16:9 resolutions, keyboard, controller where supported, text scale, reduced motion, audio buses, history, auto, skip, clean-machine export
No release is complete if a story branch can strand the player or if save/load changes their choices.
```
res://
├── project.godot
├── README.md
├── LICENSE
├── docs/
│   ├── GAME_BIBLE.md
│   ├── NARRATIVE_DESIGN.md
│   ├── SCRIPT.md
│   ├── CHOICE_PROFILE_MATRIX.md
│   ├── VISUAL_AUDIO_BRIEF.md
│   ├── TECHNICAL_DESIGN.md
│   ├── TESTING.md
│   └── ASSET_LICENSES.md
├── assets/
├── data/
│   ├── story/
│   ├── profiles/
│   └── localization/
├── scenes/
├── scripts/
├── tests/
└── export_presets.cfg
```
Adapt subfolders as needed, but preserve separation between content, presentation, state, saves, and tests.
Inspect the repository. Then create or update:
1. docs/GAME_BIBLE.md
2. docs/NARRATIVE_DESIGN.md
3. Full scene-by-scene beat sheet with word budgets
4. Canonical truth timeline and knowledge table for A/B/Hale/Elias
5. docs/CHOICE_PROFILE_MATRIX.md
6. docs/VISUAL_AUDIO_BRIEF.md
7. docs/TECHNICAL_DESIGN.md
8. Production milestone and risk list
Report ambiguous decisions and recommend defaults. Stop for approval. Do not scaffold the Godot project yet.
After approval, draft docs/SCRIPT.md in scene order. Include node IDs, speakers, prose, choices, profile entries, conditional variants, asset/audio cues, and ending variants.
Run a script audit for pacing, word count, exposition, repeated philosophy, false choice wording, and factual consistency. Stop for script approval before full implementation.
Build the smallest playable slice:
- Title
- Story UI
- Dialogue runner
- Scene 1 through its profile choice
- Profile overlay
- Placeholder artwork
- Basic settings
- Autosave/manual save
Run tests and export a Windows build. Report exact controls, test commands, changed files, and limitations. Stop for playtest feedback.
Implement dossier, history, auto, skip, conditional text, all profile logic, final report, ending routing, accessibility, and validators. Use temporary content where final script is not yet approved.
Integrate all approved scenes and assets. Validate every branch, save boundary, profile combination, and ending. Do not rewrite approved narrative casually during code work; log proposed editorial changes separately.
Perform a zero-change audit first:
- Story consistency
- Broken/unreachable nodes
- Missing/incorrect assets and credits
- Save corruption/versioning
- Input/focus/accessibility
- Performance and export warnings
- Dead code and unused assets
- Licensing
Rank findings by severity and stop for approval before cleanup or broad changes.
The project is done only when:
- New players finish in approximately 45–60 minutes
- The opening feels like a human detective story before becoming philosophical
- The factual original is discoverable without visual meta-clues
- The moral question remains legitimately unresolved
- Six profile choices are meaningful and reflected in the examiner profile
- Four endings work and none is labeled correct
- Full save/load/history/auto/skip/settings functionality works
- Keyboard navigation and reduced motion work
- Story validator and tests pass
- Windows export runs on a clean machine
- Assets and licenses are documented
- README explains setup, controls, structure, tests, and export
- No backend, telemetry, secret, or unnecessary online dependency exists
Begin with Gate 1 only. Inspect the repository, write the complete planning documents, summarize your strongest narrative/technical recommendations, flag true ambiguities, and stop for approval. Do not write application code yet.