extends Control
## Original, hand-drawn vector avatar used instead of generated image portraits.
## The shapes are intentionally graphic and subdued so they remain readable at
## small size without implying that either Miguel is biologically "real".

var portrait_code := "E"
var degraded := 0.0

func set_portrait(code: String, fade_amount: float = 0.0) -> void:
    portrait_code = code.left(1).to_upper()
    degraded = fade_amount
    queue_redraw()

func _ready() -> void:
    mouse_filter = Control.MOUSE_FILTER_IGNORE

func _draw() -> void:
    var w := size.x
    var h := size.y
    var ink := Color(0.78, 0.76, 0.72, 1.0 - degraded * 0.25)
    var shadow := Color(0.08, 0.075, 0.08, 0.96)
    var coat := Color(0.20, 0.24, 0.25, 0.98)
    var skin := Color(0.53, 0.43, 0.37, 0.98)
    var skin_light := Color(0.68, 0.55, 0.45, 0.98)
    var accent := Color(0.55, 0.42, 0.31, 0.9)

    # A quiet paper-card ground gives the portrait a drawn-record quality.
    draw_rect(Rect2(18, 12, w - 36, h - 18), Color(0.075, 0.067, 0.068, 0.92), true)
    draw_line(Vector2(24, h - 18), Vector2(w - 24, h - 18), Color(0.33, 0.25, 0.23, 0.75), 1.0)

    var cx := w * 0.5
    var head_y := h * 0.38
    var head_scale := 1.0
    if portrait_code == "H":
        coat = Color(0.25, 0.22, 0.22, 0.98)
        accent = Color(0.60, 0.43, 0.31, 0.95)
    elif portrait_code == "L":
        coat = Color(0.18, 0.26, 0.27, 0.98)
        accent = Color(0.36, 0.55, 0.55, 0.9)
    elif portrait_code == "R":
        coat = Color(0.26, 0.22, 0.19, 0.98)
        accent = Color(0.55, 0.32, 0.28, 0.9)
        head_scale = 1.08
    elif portrait_code == "A" or portrait_code == "B":
        # The two subjects share the same base geometry and palette.
        coat = Color(0.19, 0.23, 0.24, 0.98)
        accent = Color(0.48, 0.40, 0.31, 0.9)

    # Shoulders and collar.
    draw_colored_polygon(PackedVector2Array([
        Vector2(cx - 88, h - 18), Vector2(cx - 70, h - 88),
        Vector2(cx - 34, h - 112), Vector2(cx + 34, h - 112),
        Vector2(cx + 70, h - 88), Vector2(cx + 88, h - 18)
    ]), coat)
    draw_colored_polygon(PackedVector2Array([
        Vector2(cx - 27, h - 108), Vector2(cx, h - 76), Vector2(cx + 27, h - 108),
        Vector2(cx + 17, h - 120), Vector2(cx - 17, h - 120)
    ]), skin)
    draw_line(Vector2(cx - 56, h - 52), Vector2(cx + 56, h - 52), Color(0.08, 0.09, 0.10, 0.7), 2.0)

    # Neck and head.
    draw_rect(Rect2(cx - 22, head_y + 48, 44, 44), skin, true)
    draw_circle(Vector2(cx, head_y), 60.0 * head_scale, skin)
    draw_circle(Vector2(cx, head_y - 8), 61.0 * head_scale, Color(0.10, 0.105, 0.11, 0.98))
    draw_arc(Vector2(cx, head_y), 60.0 * head_scale, 0.0, PI, 24, skin_light, 2.0)
    draw_colored_polygon(PackedVector2Array([
        Vector2(cx - 58, head_y - 9), Vector2(cx - 42, head_y - 52),
        Vector2(cx + 36, head_y - 59), Vector2(cx + 57, head_y - 15),
        Vector2(cx + 30, head_y - 31), Vector2(cx - 24, head_y - 24)
    ]), Color(0.12, 0.12, 0.13, 0.98))

    # Expression and facial structure are simple ink marks, not photorealism.
    var brow_y := head_y - 8
    var eye_shift := 0.0
    if portrait_code == "B":
        eye_shift = 1.5
    elif portrait_code == "A":
        eye_shift = -1.5
    draw_line(Vector2(cx - 31, brow_y - 4 + eye_shift), Vector2(cx - 8, brow_y - 7), ink, 2.0)
    draw_line(Vector2(cx + 8, brow_y - 7), Vector2(cx + 31, brow_y - 4 + eye_shift), ink, 2.0)
    draw_circle(Vector2(cx - 19, brow_y + 5), 2.2, shadow)
    draw_circle(Vector2(cx + 19, brow_y + 5), 2.2, shadow)
    draw_line(Vector2(cx, brow_y + 9), Vector2(cx - 4, brow_y + 27), Color(0.30, 0.23, 0.21, 0.8), 1.5)
    draw_line(Vector2(cx - 13, brow_y + 39), Vector2(cx + 13, brow_y + 39), accent, 2.0)

    if portrait_code == "E":
        draw_line(Vector2(cx - 44, head_y + 4), Vector2(cx - 30, head_y + 19), accent, 2.0)
        draw_line(Vector2(cx + 30, head_y + 19), Vector2(cx + 44, head_y + 4), accent, 2.0)
    elif portrait_code == "L":
        draw_line(Vector2(cx - 55, head_y - 22), Vector2(cx - 48, head_y + 43), Color(0.08, 0.08, 0.09, 0.95), 5.0)
        draw_line(Vector2(cx + 48, head_y - 22), Vector2(cx + 55, head_y + 43), Color(0.08, 0.08, 0.09, 0.95), 5.0)
    elif portrait_code == "H":
        draw_line(Vector2(cx - 59, head_y - 5), Vector2(cx + 59, head_y - 5), accent, 2.0)
        draw_line(Vector2(cx, head_y - 64), Vector2(cx, head_y - 49), accent, 2.0)
    elif portrait_code == "R":
        draw_arc(Vector2(cx, head_y + 23), 24, 0.0, PI, 16, Color(0.18, 0.13, 0.12, 0.95), 5.0)

