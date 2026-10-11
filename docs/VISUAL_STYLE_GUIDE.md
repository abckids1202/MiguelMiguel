# MiguelMiguel Visual Style Guide

**Status:** Active implementation guide for the dark 2D remake  
**Reference:** 1920×1080, 16:9  
**Title:** MiguelMiguel

## Direction

MiguelMiguel uses graphic painted 2D: clear architectural blocks, simplified silhouettes, ink-like edges, controlled dry-brush texture, and selective realistic lighting without photorealistic surfaces. The world should feel inhabited but barely functional. The horror comes from procedure, records, waiting rooms, public unrest, and the calmness of official language.

The presentation is serious and quiet even when the city is in revolt. It does not use neon cyberpunk colors, cartoon brightness, spectacle, gore, or visual noise. It takes broad inspiration from psychologically serious visual novels without copying any named game or artist.

## Palette

| Token | Hex | Use |
| --- | --- | --- |
| Charcoal | `#111416` | Outer frame and deep panels |
| Deep blue-gray | `#1B2429` | Rooms, shadows, interrogation surfaces |
| Concrete | `#6E7472` | Dividers and architecture |
| Paper | `#DDD6C7` | Reports and evidence surfaces |
| Pale text | `#ECE8DF` | Main dialogue text |
| Institutional amber | `#C69A54` | Focus, warmth, procedural emphasis |
| Muted cyan | `#5D9FA3` | Secondary structural accent |
| Dried red | `#8E4547` | Danger or institutional harm |

Amber and cyan are never permanent identity clues. They can move between subjects or contexts. Labels, text, and story evidence—not color—carry meaning.

## Composition

- Use wide 16:9 backgrounds with strong horizontal and vertical architectural lines.
- Keep the lower third calm enough for the dialogue panel.
- Place important environmental evidence near the upper and middle thirds.
- Use portraits as separate transparent layers so expressions can change without replacing the location.
- Keep interrogation portraits symmetrical and emphasize attention through opacity or brightness rather than dramatic movement.
- Keep title and menu surfaces dark, paper-like, and sparse.
- Let public unrest remain distant and environmental: barricades, damaged screens, low-detail crowds, hand-made signs, smoke, and aftermath.

## Typography

- Dialogue: approximately 26–30px at 1080p.
- Speaker labels: approximately 20–24px.
- Secondary UI: 18px minimum.
- Use a readable serif voice for dialogue and a restrained sans-serif voice for system labels.
- Keep line spacing generous and never place text over high-detail areas without a dark backing panel.

## Character consistency

Elias, Lena, Hale, Miguel A, and Miguel B use locked portrait reference sheets before a full batch is generated. Expression variants change posture, gaze, and tension—not facial identity.

Miguel A and Miguel B must share the same base likeness and wardrobe logic. No artificial-looking glow, cyan skin, mechanical detail, perfect symmetry, or other visual shorthand may reveal the biological answer.

## Elias de-registration arc

Elias begins with the clearest and warmest record treatment. Across the chapters his portrait loses a small amount of contrast and warmth; later screens may mark his record as partial or misaligned. This is an administrative and psychological visual effect, not supernatural body horror. The treatment must never identify Miguel A or Miguel B.

## Motion rules

The first animation pass uses only crossfades, very slow background drift, a few-pixel portrait fade or slide, subtle text emphasis, and rare short flicker. Every animated state has a static fallback. Reduced motion disables drift, slides, flicker, and unnecessary transitions.

## AI generation policy

All generated assets are original project assets. Prompts and approval notes are kept in `docs/ASSET_CATALOG.md`. Do not request direct imitation of a named artist or recreate copyrighted game artwork. Reject text, logos, watermarks, accidental faces, excessive bloom, and visual identity cues that conflict with the narrative.

