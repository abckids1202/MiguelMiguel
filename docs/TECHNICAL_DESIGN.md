# MiguelMiguel — Technical Design

**Status:** Gate 1 planning authority
**Implementation status:** first visual vertical slice implemented; full production not started
**Engine target:** Godot 4.7.1 stable or latest compatible 4.7 patch
**Language:** typed GDScript where practical

## 1. Beginner-friendly technical summary

### First visual implementation

The current Godot slice keeps the story runner in `scripts/main.gd` but adds a reusable layered visual foundation: a catalog-driven location background layer, tint layer, portrait/UI layers, explicit `background_id` story metadata, fallback loading, Elias de-registration treatment, and restrained motion hooks. The active test backgrounds are `bg_civic_office_v2.png`, `bg_meridian_revolt_street.png`, and `bg_interrogation_split_v2.png`. Future backgrounds and transparent portraits can be added without changing story node IDs.

Godot is the game engine that will display the story, accept input, play audio, and save progress. A Godot **project** is normally identified by a `project.godot` file, but this task intentionally stops before creating that file. We are first keeping the game in a normal folder so the story/design decisions can be reviewed without mixing them with engine files.

When implementation begins:

- A **scene** will be a reusable screen or layout, such as the title or story screen.
- A **node** will be one object in a scene, such as a text label, image, panel, or button.
- An **autoload** will be a shared service that stays available while the game runs, such as saving or settings.
- A **story graph** will be the connected set of dialogue, choice, and ending nodes.
- A **validator** will be a development tool that checks the story graph before the player sees it.

The game does not need a backend. Local files under Godot’s `user://` location will hold saves and settings.

## 2. Future project boundary

When approved, the future project may use this shape:

```text
res://
├── project.godot
├── README.md
├── LICENSE
├── docs/
├── assets/
│   ├── backgrounds/
│   ├── characters/
│   ├── cg/
│   ├── audio/music/
│   ├── audio/sfx/
│   ├── fonts/
│   └── ui/
├── data/
│   ├── story/
│   ├── profiles/
│   └── localization/
├── scenes/
│   ├── main/
│   ├── title/
│   ├── story/
│   ├── profile/
│   ├── dossier/
│   ├── save_load/
│   └── settings/
├── scripts/
│   ├── autoload/
│   ├── dialogue/
│   ├── profile/
│   ├── save/
│   ├── audio/
│   └── ui/
├── tests/
└── export_presets.cfg
```

The project should remain content-driven: story content lives outside scene files, and presentation code should not contain the full script.

## 3. Planned responsibilities

### GameState autoload

Holds current story node, flags, choice history, profile axes, visible profile entries, read-node history, current ending, and safe restoration state. It exposes signals to the UI rather than making UI scenes reach into every field directly.

### SaveManager autoload

Owns manual slots, autosave, schema versioning, validation, temporary-write/replace behavior where practical, and safe error handling for corrupt or incompatible saves.

### AudioManager autoload

Owns music, ambience, and effects buses, volume settings, crossfades, loop state, and restoration of the current cue. It must not decide story logic.

### SettingsManager autoload

Owns text speed, auto delay, skip-read setting, font/text scale, reduced motion, display mode, resolution where supported, and master/music/ambience/effects volume. Settings save separately from story progress.

### DialogueRunner

Deterministically reads the current validated node, checks conditions, applies effects through GameState, shows text/portraits/audio commands, and moves to `next` or a selected branch. It is a small story runner, not a general scripting language.

### ProfileAssembler

Maps hidden profile axes and recorded choice IDs to authored visible subject observations and 4–6 examiner observations. It must never generate freeform prose or expose numeric axes.

### StoryDataValidator

Runs in development/CI/headless mode. It catches duplicate IDs, missing references, unreachable nodes, missing assets, invalid effects, broken endings, and missing localization keys before export.

## 4. Story data contract

Story data should be stored in validated JSON or Godot Resources. JSON is the recommended starting format because writers can review it without opening a scene. The exact runtime schema can be refined after Gate 2, but each node must support:

```json
{
  "id": "s01_lena_choice",
  "type": "profile_choice",
  "speaker": "Elias",
  "text": "RECORD INTERPRETATION\\nHow should this observation be classified?",
  "localization_key": "s01.choice.lena.prompt",
  "visual_commands": ["show_profile_overlay"],
  "audio_commands": ["play:sfx_page_interface"],
  "conditions": [],
  "effects": {
    "profile_axes": {"empathy_context": 1},
    "profile_entry": "obs_subject_01",
    "choice_tag": "epistemic_restraint"
  },
  "next": "s01_lena_continue",
  "branches": [
    {"id": "fraud", "text_key": "s01.choice.fraud", "next": "s01_choice_fraud"}
  ]
}
```

Required fields:

- `id`
- `type`
- `speaker` when a speaker exists
- `text` or `localization_key`
- `visual_commands`
- `audio_commands`
- `conditions`
- `effects`
- `next` or `branches`

Supported node types:

```text
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

## 5. Story runner behavior

1. Load a validated story graph and initial node.
2. Display background, portrait, speaker, and text through the Story scene.
3. Wait for the player to advance or select a choice; never use timed decisions.
4. Check conditions against GameState.
5. Apply authored effects once.
6. Record the node ID in read history.
7. Emit UI/domain signals such as `dialogue_started`, `choice_opened`, `profile_entry_added`, or `story_advanced`.
8. Move to the next node or ending.
9. Trigger autosave at scene boundaries and after profile choices.

Save/load must preserve the current node so a player can restore the same narrative moment without replaying or losing a choice.

## 6. Conditions and effects

Conditions may read only approved state such as:

- a choice ID was selected;
- a profile axis is within an authored range;
- a flag is set;
- a node has been read;
- a dossier item is visible;
- a final report has been selected.

Effects may:

- set or clear a story flag;
- add a visible profile entry;
- change an internal axis within the configured range;
- select a later authored text variant;
- change a background/portrait/audio cue;
- mark a dossier item visible or read.
- record a private, non-scored deduction such as the pre-proof biological assessment;
- add an authored choice/action tag such as `epistemic_restraint`, `report_accepts_marker`, or `report_withholds_authorship`.

Effects may not:

- change the canonical biological truth;
- use random values, system time, viewport, response speed, or player device as narrative logic;
- write outside the save boundary;
- create a new unvalidated story node;
- expose hidden axis values to the UI.

The six `profile_choice` nodes are the only interpretation choices. The Scene 6 pre-proof biological assessment is a separate private deduction node: it records `subject_a`, `subject_b`, or `insufficient`, changes no axis, does not change ending access, and is used only for a post-marker reflection.

## 7. Legal-action state

The future story state must distinguish scientific evidence from legal action:

- `marker_result`: fixed internal fact that B is the reconstruction;
- `designation`: `subject_a`, `subject_b`, `both_noncompliant`, or `refused`;
- `designation_status`: `pending`, `presumptive`, `conflict_review`, `panel_override`, or `finalized`;
- `transfer_authorization`: whether the signed designation or panel has authorized the connected transfer;
- `review_reason`: authored safe label for contradiction or refusal.

A signed designation matching the marker becomes presumptive and can finalize through the ordinary route. A signed designation for B becomes presumptive for the immediate proceeding but must enter delayed `conflict_review`; it cannot silently rewrite the marker. A refusal enters documented `panel_override`; the panel may apply the marker result, but the saved state retains that Elias withheld clean human authorization.

## 8. Save design

Use versioned local files through Godot’s supported `user://` APIs. Save data should include:

- schema version;
- current story node;
- flags;
- choice history;
- profile axes;
- visible profile entries;
- read-node history;
- current background, portrait, music, and ambience restoration state;
- ending/report state when complete.

Settings save separately and include text speed, auto delay, skip-read preference, volume, display, text scale, and reduced motion.

### Save safety rules

- Validate types, required keys, and schema version on load.
- Write to a temporary file and replace the destination where practical.
- Keep autosave separate from manual slots.
- On corrupt/incompatible data, show a safe recovery message and offer a new game; never crash or silently overwrite every slot.
- Do not store absolute paths, secrets, telemetry, or online credentials.
- Add migrations only when a future schema actually changes; document each migration.

## 9. UI and input architecture

Use scalable `Control` nodes anchored to a 1920×1080 reference layout. In plain terms, `Control` nodes are Godot UI elements that can resize with the window.

Main story layout:

```text
StoryRoot
├── BackgroundLayer
├── PortraitLayer
├── TopControlBar
├── DialoguePanel
│   ├── SpeakerLabel
│   ├── NarrationOrDialogueText
│   └── AdvanceIndicator
├── ChoiceOverlay
├── ProfileOverlay
├── DossierOverlay
└── FocusAnnouncer
```

Input requirements:

- keyboard-first navigation with visible focus;
- mouse activation for every button;
- controller focus navigation where practical;
- no timed choices;
- logical focus order for story, choice, profile, dossier, save/load, and settings;
- text speed and skip behavior that still allow screen-reader and reduced-motion use.

Do not rely on color alone for subject, choice state, selected state, or validation state.

## 10. Audio architecture

Create buses named `Music`, `Ambience`, and `Effects`, plus a master bus. AudioManager controls their volumes and crossfades. It should restore the active track after load without replaying a signature sound incorrectly.

The pen/signature sound is a reusable effects cue: it plays in Scene 1 and the signed final reports; No Signature deliberately omits it.

## 11. Validator and tests

### Headless validator

The validator must report:

- duplicate node IDs;
- missing `next`, branch, asset, or localization references;
- unreachable nodes;
- endings without termination;
- invalid node types;
- invalid profile-axis names or out-of-range effects;
- missing required scene boundaries;
- report routes that are not reachable;
- missing visible profile entries;
- missing final profile question.
- more or fewer than six `profile_choice` nodes;
- missing the single private pre-proof biological assessment;
- a contradictory designation that skips `conflict_review`;
- a refusal route that skips `panel_override`;
- ending text that omits the legal consequence of the selected report.

### Automated tests

- Story graph traversal proves all four endings are reachable.
- Every non-ending node has a valid continuation.
- Save/load round trips preserve story node, flags, choice history, axes, entries, and restoration state at each scene boundary.
- Profile choices produce expected authored entries and axis changes.
- Conditional dialogue selects the expected variant.
- No profile choice changes historical truth.
- Corrupt/incompatible saves produce a safe recovery state.
- UI smoke tests cover title, story, profile, dossier, settings, save/load, and ending profile.

### Manual QA

Test 16:9 desktop resolutions, keyboard navigation, controller where supported, text scale, reduced motion, audio buses, history, auto, skip, save interruption/corruption, placeholder replacement, and a clean-machine Windows export.

## 12. Technical constraints

- No third-party plugin in the initial vertical slice unless its value clearly outweighs maintenance risk.
- Keep scripts focused by responsibility.
- Avoid one enormous story controller.
- Use signals for UI/domain boundaries.
- Avoid global state outside intentional autoloads.
- Keep content, presentation, state, saves, and tests separated.
- No hardcoded absolute paths.
- No network dependency, secrets, or telemetry.
- Do not create `project.godot`, `res://`, scenes, scripts, assets, or export presets until Gate 1 and script approval are complete.
