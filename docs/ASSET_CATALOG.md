# MiguelMiguel Asset Catalog

This catalog records the visual implementation and keeps generated artwork consistent across the project.

## Approved assets

| File | Dimensions | Purpose | Source | Status |
| --- | ---: | --- | --- | --- |
| `assets/backgrounds/bg_civic_office.png` | 1792×1024 | Previous realistic office prototype | Original built-in image generation | Retained in Git history; superseded |
| `assets/backgrounds/bg_civic_office_v2.png` | 1792×1024 | Scene 1 civic office after hours | Original built-in image generation | Active 2D test asset |
| `assets/backgrounds/bg_meridian_revolt_street.png` | 1792×1024 | Scene 2 city unrest and AI revolt | Original built-in image generation | Active 2D test asset |
| `assets/backgrounds/bg_interrogation_split_v2.png` | 1792×1024 | Scenes 3 and 8 split interrogation | Original built-in image generation | Active 2D test asset |
| `assets/backgrounds/bg_meridian_train.png` | 1792×1024 | Scene 2 elevated train | Original built-in image generation | Active 2D asset |
| `assets/backgrounds/bg_aranda_apartment_memory.png` | 1792×1024 | Scene 4 shared childhood memory | Original built-in image generation | Active 2D asset |
| `assets/backgrounds/bg_memory_lab.png` | 1792×1024 | Scene 5 controlled memory laboratory | Original built-in image generation | Active 2D asset |
| `assets/backgrounds/bg_measure_archive.png` | 1792×1024 | Scene 6 archive and emergency channel | Original built-in image generation | Active 2D asset |
| `assets/backgrounds/bg_evidence_lab.png` | 1792×1024 | Scene 7 laboratory/legal review | Original built-in image generation | Active 2D asset |
| `assets/backgrounds/bg_final_report.png` | 1792×1024 | Scene 9 signature and ending report | Original built-in image generation | Active 2D asset |
| `assets/ui/visual_style_reference_sheet.png` | 1536×1024 | Style lock reference sheet | Original built-in image generation | Active internal reference |

## Scene background catalog

| Background ID | Scene use | Current asset | Future dedicated asset |
| --- | --- | --- | --- |
| `civic_office_after_hours` | Scene 1 | `bg_civic_office_v2.png` | Records desk and rain-window depth layers |
| `meridian_revolt_street` | Scene 2 | `bg_meridian_revolt_street.png` | Skyline, queue, detention entrance |
| `meridian_train` | Scene 2 | `bg_meridian_train.png` | Elevated train interior |
| `interrogation_split` | Scenes 3 and 8 | `bg_interrogation_split_v2.png` | Neutral room, legal chamber, observation layer |
| `aranda_apartment_memory` | Scene 4 | `bg_aranda_apartment_memory.png` | Reconstructed apartment and memory insert |
| `memory_lab` | Scene 5 | `bg_memory_lab.png` | Controlled laboratory and recovery room |
| `measure_archive` | Scene 6 | `bg_measure_archive.png` | Archive, emergency terminal, worker room |
| `evidence_lab` | Scene 7 | `bg_evidence_lab.png` | Laboratory, legal office, detention corridor |
| `final_report` | Scene 9 and endings | `bg_final_report.png` | Report desk, override room, de-registered workplace |

The catalog is complete for the current background pass. If a later asset is removed or renamed, the Godot loader emits a warning and falls back to the civic office rather than breaking the story.

## Generation record: opening civic office

**Use case:** illustration-story  
**Style:** graphic illustrated realism with subtle paper grain and controlled painterly edges  
**Composition:** wide municipal records office, orderly counters, queue displays, security glass, rain-muted windows, empty desk and pen, usable lower foreground for dialogue UI  
**Lighting:** cool overcast blue-gray with one restrained amber desk lamp  
**Avoided:** people, readable text, logos, watermarks, neon, cyberpunk styling, gore, glitch spectacle, direct imitation of existing artwork  

The source image is intentionally retained in the local generated-image history. The project copy is the approved working asset. It may be replaced by a later art pass without changing the story code.

## Generation record: 2D remake test set

The remake set uses the same original graphic-painted prompt language: simplified block shapes, dry-brush edges, dark blue-gray shadows, paper warmth, restrained dried-red accents, and UI-safe lower composition. The reference sheet and eight core location plates are stored in `assets/`.

## Planned folders

- `assets/backgrounds/` — location plates and depth layers.
- `assets/backgrounds_layers/` — optional foreground, midground, and atmospheric layers.
- `assets/characters/` — transparent portraits and expression variants.
- `assets/cg/` — memories and major illustrated moments.
- `assets/ui/` — record panels, evidence overlays, and icons.
- `assets/fonts/` — licensed project fonts when added.
- `assets/audio/` — music, ambience, and effects.
- `assets/atmosphere/` — later rain, smoke, paper, and screen effects.

## Approval checklist

- No accidental readable text or watermark.
- Palette fits the visual style guide.
- Lower dialogue area remains readable.
- No visual clue identifies Miguel A or Miguel B as original/artificial.
- Filename and dimensions are recorded before import.
- Static fallback exists for every later animated treatment.

