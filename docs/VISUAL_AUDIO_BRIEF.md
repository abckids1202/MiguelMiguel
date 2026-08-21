# MiguelMiguel — Visual and Audio Brief

**Status:** Gate 1 planning authority
**Reference frame:** 1920×1080, 16:9
**Primary style:** painterly, muted, institutional visual novel

## 1. Visual direction

Use illustrated realism with serious static composition and controlled atmosphere. Meridian should look inhabited and technologically sophisticated, not like a neon cyberpunk ruin. The horror is administrative: a clean form, a waiting queue, a locked door, a procedural phrase, and a signature can carry more weight than spectacle.

Do not imitate copyrighted artwork or recreate assets from *The House in Fata Morgana*. Take only broad inspiration from the seriousness of static composition and psychological pacing.

## 2. Palette

| Token | Hex | Use |
| --- | --- | --- |
| Charcoal | `#111416` | outer frame, deep text panels |
| Deep blue-gray | `#1B2429` | rooms, interrogation surfaces, shadows |
| Concrete | `#6E7472` | dividers, inactive structural surfaces |
| Paper | `#DDD6C7` | reports, dossiers, profile records |
| Pale text | `#ECE8DF` | primary dark-theme text |
| Institutional amber | `#C69A54` | one subject position/accent, not authenticity |
| Muted cyan | `#5D9FA3` | other subject position/accent, not authenticity |
| Dried red | `#8E4547` | danger, rejected action, or institutional harm; never “fake” |

Amber and cyan must not consistently map to original or artificial. A/B placement and accent assignment are presentation choices, not identity clues. Text, icons, and labels always carry the meaning.

## 3. Composition rules

- Full-screen background artwork with portraits layered above it.
- Readable bottom dialogue panel with speaker name, narration distinction, text, and advance indicator.
- Minimal top controls appear on hover/focus: history, profile, dossier, save, settings.
- During split interrogation, portraits are symmetrical; emphasis uses brightness/opacity changes, not dramatic movement.
- Profile choices appear in an official record overlay with complete neutral sentences.
- Profile viewer remains available during story scenes unless an intentional evidence reveal requires focus.
- Dossier/evidence viewer reads like a record surface, not a collectible menu.
- Focus remains visible for keyboard users.
- No timed choices.

## 4. Required screens

1. Title screen: New Game, Continue, Save/Load, Settings, Credits, Quit.
2. Main story screen: background, portrait layer, dialogue panel, top controls.
3. Choice overlay: official interpretation record.
4. Profile overlay: current subject observations and later examiner observations.
5. Dossier/evidence viewer.
6. Dialogue history.
7. Save/load slots.
8. Settings.
9. Ending profile and report outcome.
10. Credits and license acknowledgement.

## 5. Background manifest

The table is the planning manifest. No assets are created during Gate 1. Any placeholder used later must be clearly labeled and replaced before content lock.

| Filename | Dimensions | Purpose | State | License/source | Replacement |
| --- | ---: | --- | --- | --- | --- |
| `bg_civic_office_placeholder.png` | 1920×1080 | Scene 1 office | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `bg_train_interior_placeholder.png` | 1920×1080 | Scene 2 train | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `bg_meridian_exterior_placeholder.png` | 1920×1080 | Scene 2 city/exterior | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `bg_detention_corridor_placeholder.png` | 1920×1080 | Scene 2 arrival/transition | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `bg_interrogation_neutral_placeholder.png` | 1920×1080 | Scenes 4–5 neutral room | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `bg_interrogation_split_placeholder.png` | 1920×1080 | Scenes 3, 6, 8 | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `bg_records_profile_placeholder.png` | 1920×1080 | Scenes 7 and 9 report surface | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |
| `cg_shared_childhood_placeholder.png` | 1920×1080 | Repaired bird/radio memory | Planned placeholder | Original temporary block-in | Replace with commissioned/original art |

## 6. Character manifest

| Asset family | Planned states | Purpose | State | License/source |
| --- | --- | --- | --- | --- |
| Elias partial portrait/reflection | 3–4 | Close-third-person anchor; optional reflection/partial face | Planned | Original/commissioned, not started |
| Lena portrait | 3 | Plain, guarded, protective responsibility without melodrama | Planned | Original/commissioned, not started |
| Hale portrait | 3 | Calm procedural variations; no theatrical villain pose | Planned | Original/commissioned, not started |
| Miguel shared base | 5–6 | Shared face and core portrait language | Planned | Original/commissioned, not started |
| Miguel A variants | Controlled wardrobe/lighting/context | Different present state without authenticity coding | Planned | Original/commissioned, not started |
| Miguel B variants | Controlled wardrobe/lighting/context | Different present state without authenticity coding | Planned | Original/commissioned, not started |

Do not give either Miguel a permanent “real” portrait treatment. Any clothing or light distinction must be explainable by detention context and scene state.

## 7. Motion and transition rules

Allowed:

- crossfades;
- very slow background drift or restrained parallax;
- portrait fade/slide by a few pixels;
- subtle text emphasis;
- rare display flicker tied to institutional screens.

Avoid:

- lip-sync;
- skeletal animation;
- particle spectacle;
- camera-shake abuse;
- idle animation loops that imply identity;
- constant glitching;
- transitions that conceal a choice or response.

Reduced motion should remove drift, slide, flicker, and staged reveals while preserving content order and focus.

## 8. Audio direction

Create separate music, ambience, and effects buses so players can adjust them independently. Audio must support silence as a deliberate narrative tool.

### Music motifs

| Cue | Motif | Use |
| --- | --- | --- |
| `music_office_routine` | sparse piano + room tone | Scene 1 and procedural transitions |
| `music_meridian_transit` | low mechanical pulse | Scene 2 train/city |
| `music_detention_drone` | sustained restrained drone | arrival and interrogation pressure |
| `music_shared_memory` | warmer incomplete motif | Scene 4 father/object memory |
| `music_divergence` | same motif with incompatible harmonies | Scenes 5–6 |
| `music_proof_report` | near-silence with low tonal pressure | Scenes 7–9 |
| `music_credits_unresolved` | unresolved variation of Miguel motif | credits |

Plan for 5–7 restrained tracks or motifs, not a large soundtrack. Music should not identify A or B.

### Ambient and effects manifest

| Filename | Bus | Purpose | State | License/source |
| --- | --- | --- | --- | --- |
| `amb_train_movement.ogg` | Ambience | rails, carriage motion | Planned | Original/cleared recording |
| `amb_city_announcements.ogg` | Ambience | distant Meridian public system | Planned | Original/cleared recording |
| `amb_fluorescent_hum.ogg` | Ambience | office/interrogation room | Planned | Original/cleared recording |
| `sfx_page_interface.ogg` | Effects | dossier/page transitions | Planned | Original/cleared recording |
| `sfx_pen_signature.ogg` | Effects | Lena’s report and final report | Planned | Original/cleared recording |
| `sfx_door_lock.ogg` | Effects | detention movement | Planned | Original/cleared recording |
| `sfx_system_confirm.ogg` | Effects | restrained procedural confirmation | Planned | Original/cleared recording |

The pen/signature sound must recur from Scene 1 in the final report. No Signature intentionally omits or interrupts that sound.

## 9. Accessibility requirements

- Minimum 18px-equivalent body text at 1080p, with a scalable text option.
- High-contrast dialogue box and visible focus.
- Full keyboard navigation for title, story, choice, profile, dossier, save/load, settings, and endings.
- Controller focus navigation where practical.
- Adjustable text speed and auto-advance delay.
- Skip read text by default; skipping unread text requires an explicit setting.
- Dialogue history includes speaker and narration labels.
- All clue-bearing gestures are described in text.
- Separate master/music/ambience/effects volume controls.
- Reduced-motion option.
- No time-limited decisions.
- Dyslexia-friendly font option is desirable if it can be licensed and tested without changing default readability.

## 10. Visual QA questions

Before art lock, verify:

1. Can a first-time player tell who is speaking without relying on color?
2. Can a player read long dialogue at 100% and scaled text without clipping?
3. Do A and B receive the same range of portrait states?
4. Does any background composition place a “truth” halo, brighter edge, or camera emphasis around one subject?
5. Are placeholder files and final files unambiguously separated?
6. Do reduced-motion and high-contrast modes preserve the same information?
