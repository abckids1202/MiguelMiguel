extends Control
## MiguelMiguel: original visual-novel prototype.
## The presentation is intentionally asset-light so the story system can be tested
## before commissioned backgrounds and portraits are added.

const SAVE_PATH := "user://miguelmiguel_save.json"

var nodes: Dictionary = {}
var current_id := ""
var current_node: Dictionary = {}
var mode := "title"
var is_typing := false
var full_text := ""
var typed_characters := 0
var type_accumulator := 0.0
var type_speed := 0.018
var backlog: Array[String] = []
var profile: Dictionary = {}
var selected_choices: Dictionary = {}
var final_report := ""
var private_guess := ""
var overlay_action := "close"
var body_font: Font
var ui_font: Font
var reduced_motion := false
var visual_time := 0.0

var background: ColorRect
var background_image: TextureRect
var background_tint: ColorRect
var active_background_id := ""
var background_catalog := {
    "civic_office_after_hours": "res://assets/backgrounds/bg_civic_office_v3.png",
    "meridian_revolt_street": "res://assets/backgrounds/bg_meridian_revolt_street_v3.png",
    "interrogation_split": "res://assets/backgrounds/bg_interrogation_split_v3.png",
    "meridian_train": "res://assets/backgrounds/bg_meridian_train_v3.png",
    "detention_entrance": "res://assets/backgrounds/bg_meridian_revolt_street_v3.png",
    "aranda_apartment_memory": "res://assets/backgrounds/bg_aranda_apartment_memory_v3.png",
    "memory_lab": "res://assets/backgrounds/bg_memory_lab_v3.png",
    "measure_archive": "res://assets/backgrounds/bg_measure_archive_v3.png",
    "evidence_lab": "res://assets/backgrounds/bg_evidence_lab_v3.png",
    "legal_review": "res://assets/backgrounds/bg_evidence_lab_v3.png",
    "final_report": "res://assets/backgrounds/bg_final_report_v3.png",
}
var title_layer: Control
var game_layer: Control
var overlay: ColorRect
var overlay_card: Panel
var overlay_title: Label
var overlay_text: RichTextLabel
var overlay_close: Button

var chapter_label: Label
var scene_label: Label
var mood_label: Label
var portrait_panel: Panel
var portrait_mark: Label
var portrait_name: Label
var portrait_role: Label
var portrait_status: Label
var speaker_label: Label
var dialogue_label: Label
var choice_prompt: Label
var choice_container: VBoxContainer
var continue_button: Button
var backlog_button: Button
var save_button: Button
var load_button: Button
var settings_button: Button
var menu_button: Button
var status_label: Label

var title_continue: Button
var title_new_game: Button
var title_settings: Button
var title_quit: Button

var palette := {
    "ink": Color(0.78, 0.76, 0.72),
    "muted": Color(0.48, 0.46, 0.44),
    "gold": Color(0.55, 0.42, 0.31),
    "red": Color(0.40, 0.22, 0.20),
    "panel": Color(0.035, 0.032, 0.038, 0.97),
    "panel_light": Color(0.075, 0.068, 0.070, 0.97),
    "button": Color(0.075, 0.065, 0.068, 0.99),
    "button_hover": Color(0.16, 0.12, 0.12, 0.99),
}

func _ready() -> void:
    # A compact literary serif gives the dialogue a period-record feeling while
    # keeping the letter shapes familiar and easy to read.
    body_font = _system_font(["Palatino Linotype", "Book Antiqua", "Georgia", "Cambria"])
    ui_font = _system_font(["Aptos", "Segoe UI", "Arial"])
    _build_ui()
    _build_story()
    _show_title()

func _process(delta: float) -> void:
    visual_time += delta
    if background_image and not reduced_motion:
        # A barely visible drift gives the still image life without turning it
        # into a distracting camera effect. The static image remains the fallback.
        background_image.position = Vector2(sin(visual_time * 0.08) * 2.0, cos(visual_time * 0.06) * 1.5)
    if not is_typing:
        return
    type_accumulator += delta
    while type_accumulator >= type_speed and typed_characters < full_text.length():
        type_accumulator -= type_speed
        typed_characters += 1
        dialogue_label.text = full_text.substr(0, typed_characters)
    if typed_characters >= full_text.length():
        is_typing = false
        continue_button.text = "Continue"

func _unhandled_input(event: InputEvent) -> void:
    if mode != "game" or overlay.visible:
        return
    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
            _advance_or_finish()
        elif event.keycode == KEY_B:
            _show_backlog()
        elif event.keycode == KEY_ESCAPE:
            _show_title()
    elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        _advance_or_finish()

func _build_ui() -> void:
    background = ColorRect.new()
    background.color = Color(0.026, 0.024, 0.028)
    _full(background)
    background.mouse_filter = Control.MOUSE_FILTER_IGNORE
    add_child(background)

    background_image = TextureRect.new()
    background_image.texture = preload("res://assets/backgrounds/bg_civic_office_v3.png")
    background_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    background_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
    background_image.modulate = Color(0.78, 0.84, 0.86, 0.88)
    _full(background_image)
    background_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
    add_child(background_image)

    background_tint = ColorRect.new()
    background_tint.color = Color(0.10, 0.055, 0.045, 0.30)
    _full(background_tint)
    background_tint.mouse_filter = Control.MOUSE_FILTER_IGNORE
    add_child(background_tint)

    _build_title_layer()
    _build_game_layer()
    _build_overlay()

func _build_title_layer() -> void:
    title_layer = Control.new()
    _full(title_layer)
    add_child(title_layer)

    var title_card := Panel.new()
    title_card.set_anchors_preset(Control.PRESET_CENTER)
    title_card.position = Vector2(-300, -230)
    title_card.size = Vector2(600, 460)
    title_card.add_theme_stylebox_override("panel", _box(Color(0.032, 0.029, 0.032, 0.98), 4, Color(0.24, 0.19, 0.18), 1))
    title_layer.add_child(title_card)

    var title := _label(title_card, "MiguelMiguel", 48, palette.ink)
    title.position = Vector2(35, 42)
    title.size = Vector2(530, 70)
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

    var subtitle := _label(title_card, "CASE FILE 01\nCIVIC INVESTIGATIONS DIVISION", 14, palette.muted)
    subtitle.position = Vector2(55, 118)
    subtitle.size = Vector2(490, 55)
    subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

    var rule := ColorRect.new()
    rule.color = palette.red
    rule.position = Vector2(170, 190)
    rule.size = Vector2(260, 1)
    title_card.add_child(rule)

    title_new_game = _button(title_card, "Begin Investigation", Callable(self, "_start_game"))
    title_new_game.position = Vector2(145, 225)
    title_new_game.size = Vector2(310, 46)

    title_continue = _button(title_card, "Continue", Callable(self, "_load_game"))
    title_continue.position = Vector2(145, 281)
    title_continue.size = Vector2(310, 46)

    title_settings = _button(title_card, "Options", Callable(self, "_show_settings"))
    title_settings.position = Vector2(145, 337)
    title_settings.size = Vector2(150, 42)

    title_quit = _button(title_card, "Exit", Callable(self, "_quit_game"))
    title_quit.position = Vector2(305, 337)
    title_quit.size = Vector2(150, 42)

    var version := _label(title_card, "MERIDIAN CIVIC INVESTIGATIONS DIVISION / INTERNAL REVIEW", 11, palette.muted)
    version.position = Vector2(20, 410)
    version.size = Vector2(560, 25)
    version.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

func _build_game_layer() -> void:
    game_layer = Control.new()
    _full(game_layer)
    game_layer.visible = false
    add_child(game_layer)

    var top_bar := Panel.new()
    top_bar.set_anchors_preset(Control.PRESET_TOP_WIDE)
    top_bar.offset_bottom = 64
    top_bar.add_theme_stylebox_override("panel", _box(Color(0.022, 0.020, 0.023, 0.98), 0, Color(0.18, 0.14, 0.14), 0))
    game_layer.add_child(top_bar)

    chapter_label = _label(top_bar, "CHAPTER 01 / CASE FILE", 18, palette.gold)
    chapter_label.position = Vector2(28, 10)
    chapter_label.size = Vector2(170, 23)
    scene_label = _label(top_bar, "A Minor Irregularity", 22, palette.ink)
    scene_label.position = Vector2(28, 31)
    scene_label.size = Vector2(360, 28)

    backlog_button = _button(top_bar, "Backlog", Callable(self, "_show_backlog"))
    backlog_button.anchor_left = 1.0
    backlog_button.anchor_right = 1.0
    backlog_button.offset_left = -440
    backlog_button.offset_right = -350
    backlog_button.offset_top = 12
    backlog_button.offset_bottom = 50

    save_button = _button(top_bar, "Save", Callable(self, "_save_game"))
    save_button.anchor_left = 1.0
    save_button.anchor_right = 1.0
    save_button.offset_left = -340
    save_button.offset_right = -270
    save_button.offset_top = 12
    save_button.offset_bottom = 50

    load_button = _button(top_bar, "Load", Callable(self, "_load_game"))
    load_button.anchor_left = 1.0
    load_button.anchor_right = 1.0
    load_button.offset_left = -260
    load_button.offset_right = -190
    load_button.offset_top = 12
    load_button.offset_bottom = 50

    settings_button = _button(top_bar, "Options", Callable(self, "_show_settings"))
    settings_button.anchor_left = 1.0
    settings_button.anchor_right = 1.0
    settings_button.offset_left = -180
    settings_button.offset_right = -90
    settings_button.offset_top = 12
    settings_button.offset_bottom = 50

    menu_button = _button(top_bar, "Menu", Callable(self, "_show_title"))
    menu_button.anchor_left = 1.0
    menu_button.anchor_right = 1.0
    menu_button.offset_left = -80
    menu_button.offset_right = -20
    menu_button.offset_top = 12
    menu_button.offset_bottom = 50

    portrait_panel = Panel.new()
    portrait_panel.set_anchors_preset(Control.PRESET_TOP_LEFT)
    portrait_panel.anchor_left = 0.055
    portrait_panel.anchor_top = 0.15
    portrait_panel.anchor_right = 0.315
    portrait_panel.anchor_bottom = 0.67
    portrait_panel.add_theme_stylebox_override("panel", _box(Color(0.055, 0.047, 0.050, 0.94), 4, Color(0.28, 0.20, 0.18), 1))
    game_layer.add_child(portrait_panel)
    self.portrait_panel = portrait_panel

    portrait_mark = _label(portrait_panel, "E", 86, Color(0.25, 0.18, 0.17, 0.76))
    portrait_mark.position = Vector2(20, 20)
    portrait_mark.size = Vector2(240, 190)
    portrait_mark.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    portrait_mark.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    self.portrait_mark = portrait_mark

    portrait_name = _label(portrait_panel, "ELIAS VENN", 19, palette.ink)
    portrait_name.position = Vector2(20, 225)
    portrait_name.size = Vector2(240, 34)
    portrait_name.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    self.portrait_name = portrait_name

    portrait_role = _label(portrait_panel, "CIVIC INVESTIGATIONS / DETECTIVE", 18, palette.muted)
    portrait_role.position = Vector2(20, 261)
    portrait_role.size = Vector2(240, 28)
    portrait_role.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    self.portrait_role = portrait_role

    portrait_status = _label(portrait_panel, "RECORD: VERIFIED", 18, palette.muted)
    portrait_status.position = Vector2(20, 294)
    portrait_status.size = Vector2(240, 28)
    portrait_status.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

    mood_label = _label(game_layer, "Meridian", 18, palette.muted)
    mood_label.anchor_left = 0.35
    mood_label.anchor_top = 0.15
    mood_label.anchor_right = 0.95
    mood_label.offset_bottom = 28
    self.mood_label = mood_label

    var stage_rule := ColorRect.new()
    stage_rule.color = Color(0.34, 0.24, 0.21, 0.48)
    stage_rule.anchor_left = 0.35
    stage_rule.anchor_top = 0.20
    stage_rule.anchor_right = 0.95
    stage_rule.offset_bottom = 1
    game_layer.add_child(stage_rule)

    var dialogue_panel := Panel.new()
    dialogue_panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
    dialogue_panel.anchor_left = 0.035
    dialogue_panel.anchor_top = 0.685
    dialogue_panel.anchor_right = 0.965
    dialogue_panel.anchor_bottom = 0.935
    dialogue_panel.add_theme_stylebox_override("panel", _box(Color(0.024, 0.022, 0.025, 0.98), 4, Color(0.26, 0.19, 0.17), 1))
    game_layer.add_child(dialogue_panel)

    speaker_label = _label(dialogue_panel, "NARRATION", 20, palette.gold)
    speaker_label.position = Vector2(26, 16)
    speaker_label.size = Vector2(850, 30)

    dialogue_label = _label(dialogue_panel, "", 26, palette.ink)
    dialogue_label.position = Vector2(26, 53)
    dialogue_label.size = Vector2(850, 112)
    dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    dialogue_label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
    dialogue_label.add_theme_constant_override("line_spacing", 5)
    dialogue_label.add_theme_constant_override("outline_size", 2)
    dialogue_label.add_theme_color_override("font_outline_color", Color(0.01, 0.009, 0.012, 0.90))
    self.dialogue_label = dialogue_label

    choice_prompt = _label(dialogue_panel, "", 20, palette.ink)
    choice_prompt.position = Vector2(26, 53)
    choice_prompt.size = Vector2(850, 70)
    choice_prompt.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    choice_prompt.visible = false
    self.choice_prompt = choice_prompt

    choice_container = VBoxContainer.new()
    choice_container.position = Vector2(900, 16)
    choice_container.size = Vector2(260, 150)
    choice_container.add_theme_constant_override("separation", 5)
    choice_container.visible = false
    dialogue_panel.add_child(choice_container)
    self.choice_container = choice_container

    var footer := Panel.new()
    footer.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
    footer.anchor_top = 0.94
    footer.add_theme_stylebox_override("panel", _box(Color(0.022, 0.020, 0.023, 0.98), 0))
    game_layer.add_child(footer)

    status_label = _label(footer, "CLICK / SPACE / ENTER  REVEAL / NEXT     B  BACKLOG     ESC  MENU", 18, palette.muted)
    status_label.position = Vector2(25, 8)
    status_label.size = Vector2(700, 30)

    continue_button = _button(footer, "Continue", Callable(self, "_advance_or_finish"))
    continue_button.anchor_left = 1.0
    continue_button.anchor_right = 1.0
    continue_button.offset_left = -175
    continue_button.offset_right = -25
    continue_button.offset_top = 5
    continue_button.offset_bottom = 43

func _build_overlay() -> void:
    overlay = ColorRect.new()
    overlay.color = Color(0.01, 0.008, 0.02, 0.82)
    _full(overlay)
    overlay.visible = false
    overlay.mouse_filter = Control.MOUSE_FILTER_STOP
    add_child(overlay)

    overlay_card = Panel.new()
    overlay_card.set_anchors_preset(Control.PRESET_CENTER)
    overlay_card.position = Vector2(-450, -285)
    overlay_card.size = Vector2(900, 570)
    overlay_card.add_theme_stylebox_override("panel", _box(Color(0.030, 0.027, 0.030, 0.99), 4, Color(0.28, 0.20, 0.18), 1))
    overlay.add_child(overlay_card)

    overlay_title = _label(overlay_card, "Backlog", 30, palette.ink)
    overlay_title.position = Vector2(28, 22)
    overlay_title.size = Vector2(760, 42)

    overlay_text = RichTextLabel.new()
    overlay_text.position = Vector2(28, 78)
    overlay_text.size = Vector2(844, 420)
    overlay_text.bbcode_enabled = true
    overlay_text.fit_content = false
    overlay_text.scroll_active = true
    overlay_text.add_theme_font_size_override("normal_font_size", 18)
    overlay_text.add_theme_color_override("default_color", palette.ink)
    if body_font:
        overlay_text.add_theme_font_override("normal_font", body_font)
    overlay_card.add_child(overlay_text)

    overlay_close = _button(overlay_card, "Close", Callable(self, "_on_overlay_close"))
    overlay_close.position = Vector2(730, 510)
    overlay_close.size = Vector2(140, 38)

func _full(control: Control) -> void:
    control.set_anchors_preset(Control.PRESET_FULL_RECT)
    control.offset_left = 0
    control.offset_top = 0
    control.offset_right = 0
    control.offset_bottom = 0

func _label(parent: Node, text: String, size: int, color: Color) -> Label:
    var result := Label.new()
    result.text = text
    result.add_theme_font_size_override("font_size", size)
    result.add_theme_color_override("font_color", color)
    if body_font:
        result.add_theme_font_override("font", body_font)
    result.add_theme_constant_override("line_spacing", 4)
    parent.add_child(result)
    return result

func _button(parent: Node, text: String, callback: Callable) -> Button:
    var result := Button.new()
    result.text = text
    result.focus_mode = Control.FOCUS_ALL
    result.add_theme_font_size_override("font_size", 18)
    result.add_theme_color_override("font_color", palette.ink)
    result.add_theme_color_override("font_hover_color", Color.WHITE)
    if ui_font:
        result.add_theme_font_override("font", ui_font)
    result.add_theme_stylebox_override("normal", _box(palette.button, 3, Color(0.24, 0.18, 0.17), 1))
    result.add_theme_stylebox_override("hover", _box(palette.button_hover, 3, palette.gold, 1))
    result.add_theme_stylebox_override("pressed", _box(Color(0.10, 0.07, 0.07), 3, palette.gold, 1))
    result.pressed.connect(callback)
    parent.add_child(result)
    return result

func _system_font(names: Array[String]) -> Font:
    var result := SystemFont.new()
    result.font_names = PackedStringArray(names)
    result.allow_system_fallback = true
    result.antialiasing = TextServer.FONT_ANTIALIASING_GRAY
    return result

func _box(color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> StyleBoxFlat:
    var result := StyleBoxFlat.new()
    result.bg_color = color
    result.corner_radius_top_left = radius
    result.corner_radius_top_right = radius
    result.corner_radius_bottom_left = radius
    result.corner_radius_bottom_right = radius
    result.border_color = border_color
    result.border_width_left = border_width
    result.border_width_top = border_width
    result.border_width_right = border_width
    result.border_width_bottom = border_width
    result.content_margin_left = 12
    result.content_margin_right = 12
    result.content_margin_top = 7
    result.content_margin_bottom = 7
    return result

func _show_title() -> void:
    mode = "title"
    is_typing = false
    overlay.visible = false
    title_layer.visible = true
    game_layer.visible = false
    title_continue.disabled = not FileAccess.file_exists(SAVE_PATH)

func _start_game() -> void:
    mode = "game"
    title_layer.visible = false
    game_layer.visible = true
    backlog.clear()
    profile.clear()
    selected_choices.clear()
    final_report = ""
    private_guess = ""
    _show_node("s1_001")

func _quit_game() -> void:
    get_tree().quit()

func _show_node(id: String) -> void:
    if not nodes.has(id):
        _show_status("Missing story node: " + id)
        return
    current_id = id
    current_node = nodes[id]
    _set_visuals(current_node)
    _clear_choices()
    if current_node.get("type", "line") == "choice":
        _show_choice_node(current_node)
    else:
        _show_line_node(current_node)

func _set_visuals(data: Dictionary) -> void:
    chapter_label.text = str(data.get("chapter", "CHAPTER"))
    scene_label.text = str(data.get("scene", ""))
    mood_label.text = str(data.get("mood", "Meridian"))
    var portrait := str(data.get("portrait", "E"))
    portrait_mark.text = portrait.left(1).to_upper()
    portrait_name.text = str(data.get("portrait_name", "ELIAS VENN"))
    portrait_role.text = str(data.get("portrait_role", "Civic Investigations Division"))
    _set_background(str(data.get("background_id", "civic_office_after_hours")))
    _set_elias_presence(data)
    var tint: Color = data.get("tint", Color(0.12, 0.10, 0.18, 0.34))
    background.color = Color(0.026 + tint.r * 0.025, 0.024 + tint.g * 0.022, 0.028 + tint.b * 0.022)
    background_tint.color = Color(tint.r * 0.34, tint.g * 0.30, tint.b * 0.30, 0.22)

func _set_background(background_id: String) -> void:
    var requested_path := str(background_catalog.get(background_id, ""))
    if requested_path.is_empty() or not ResourceLoader.exists(requested_path):
        push_warning("Missing background asset for '%s'; using civic office fallback." % background_id)
        requested_path = "res://assets/backgrounds/bg_civic_office_v3.png"
    var texture := load(requested_path) as Texture2D
    if texture == null:
        push_warning("Could not load background '%s'." % requested_path)
        return
    if active_background_id == background_id and background_image.texture == texture:
        return
    active_background_id = background_id
    background_image.texture = texture
    if reduced_motion:
        background_image.modulate.a = 0.82
        background_image.position = Vector2.ZERO
        return
    background_image.modulate.a = 0.0
    var fade := create_tween()
    fade.set_trans(Tween.TRANS_SINE)
    fade.set_ease(Tween.EASE_OUT)
    fade.tween_property(background_image, "modulate:a", 0.82, 0.42)

func _set_elias_presence(data: Dictionary) -> void:
    var portrait := str(data.get("portrait", ""))
    var chapter := str(data.get("chapter", ""))
    var loss := 0.0
    if portrait == "E":
        if chapter.contains("02"):
            loss = 0.04
        elif chapter.contains("03") or chapter.contains("04"):
            loss = 0.10
        elif chapter.contains("05") or chapter.contains("06"):
            loss = 0.17
        elif chapter.contains("07"):
            loss = 0.24
        elif chapter.contains("08") or chapter.contains("09") or chapter == "ENDING":
            loss = 0.32
    portrait_panel.modulate = Color(1.0 - loss * 0.20, 1.0 - loss * 0.20, 1.0 - loss * 0.20, 1.0)
    portrait_mark.modulate = Color(1.0, 1.0, 1.0, 1.0 - loss * 0.45)
    portrait_name.modulate = Color(1.0, 1.0, 1.0, 1.0 - loss * 0.20)
    if portrait == "E" and loss >= 0.20:
        portrait_status.text = "RECORD: PARTIAL"
        portrait_status.add_theme_color_override("font_color", palette.red)
    else:
        portrait_status.text = "RECORD: VERIFIED"
        portrait_status.add_theme_color_override("font_color", palette.muted)

func _show_line_node(data: Dictionary) -> void:
    choice_prompt.visible = false
    dialogue_label.visible = true
    continue_button.visible = true
    full_text = str(data.get("text", ""))
    speaker_label.text = str(data.get("speaker", "NARRATION"))
    dialogue_label.text = ""
    typed_characters = 0
    type_accumulator = 0.0
    is_typing = true
    continue_button.text = "Reveal"
    var entry := "[color=#c5a36b]" + speaker_label.text + "[/color]\n" + full_text
    if full_text.length() > 0 and (backlog.is_empty() or backlog.back() != entry):
        backlog.append(entry)

func _show_choice_node(data: Dictionary) -> void:
    is_typing = false
    dialogue_label.visible = false
    continue_button.visible = false
    choice_prompt.visible = true
    speaker_label.text = "RECORD INTERPRETATION"
    choice_prompt.text = str(data.get("prompt", "Choose an interpretation."))
    for option in data.get("options", []):
        var button := _button(choice_container, str(option.get("label", "")), Callable(self, "_choose_option").bind(option))
        button.custom_minimum_size = Vector2(0, 34)
        button.add_theme_font_size_override("font_size", 18)
        button.tooltip_text = str(option.get("hint", ""))
    choice_container.visible = true
    status_label.text = "Choose an option. There is no correct answer displayed."

func _clear_choices() -> void:
    choice_prompt.visible = false
    choice_container.visible = false
    for child in choice_container.get_children():
        child.queue_free()

func _choose_option(option: Dictionary) -> void:
    var choice_id := str(current_node.get("choice_id", ""))
    var label := str(option.get("label", ""))
    selected_choices[choice_id] = label
    if choice_id == "P1":
        private_guess = label
    elif choice_id == "REPORT":
        final_report = str(option.get("report", label))
    else:
        var effects: Dictionary = option.get("effects", {})
        for key in effects:
            profile[key] = clampi(int(profile.get(key, 0)) + int(effects[key]), -3, 3)
    var next_id := str(option.get("next", ""))
    if next_id.is_empty():
        _show_profile()
    else:
        _show_node(next_id)

func _advance_or_finish() -> void:
    if mode != "game" or overlay.visible:
        return
    if is_typing:
        _finish_typing()
        return
    var next_id := str(current_node.get("next", ""))
    if current_node.get("ending", false):
        _show_profile()
    elif not next_id.is_empty():
        _show_node(next_id)

func _finish_typing() -> void:
    """Reveal the current line; a later press advances to the next node."""
    is_typing = false
    type_accumulator = 0.0
    typed_characters = full_text.length()
    dialogue_label.text = full_text
    continue_button.text = "Continue"

func _show_status(message: String) -> void:
    status_label.text = message

func _show_backlog() -> void:
    if mode != "game":
        return
    overlay_title.text = "Backlog"
    overlay_action = "close"
    overlay_text.text = "\n\n".join(backlog)
    overlay_close.text = "Close"
    overlay.visible = true

func _show_settings() -> void:
    overlay_title.text = "Settings"
    overlay_action = "close"
    overlay_text.text = "Text speed\n\nThe prototype uses a readable typewriter effect. Choose a pace below.\n\nMotion\n\nAnimation stays restrained and can be reduced without losing story information.\n\n"
    var speed := OptionButton.new()
    speed.position = Vector2(28, 350)
    speed.size = Vector2(250, 42)
    speed.add_item("Slow", 0)
    speed.add_item("Normal", 1)
    speed.add_item("Fast", 2)
    speed.select(1)
    speed.item_selected.connect(_set_text_speed)
    overlay_card.add_child(speed)
    var motion := CheckButton.new()
    motion.text = "Reduce motion"
    motion.button_pressed = reduced_motion
    motion.position = Vector2(300, 350)
    motion.size = Vector2(240, 42)
    motion.add_theme_font_size_override("font_size", 18)
    motion.add_theme_color_override("font_color", palette.ink)
    motion.toggled.connect(_set_reduced_motion)
    overlay_card.add_child(motion)
    overlay_close.text = "Close"
    overlay.visible = true

func _set_text_speed(value: int) -> void:
    if value == 0:
        type_speed = 0.035
    elif value == 2:
        type_speed = 0.006
    else:
        type_speed = 0.018

func _set_reduced_motion(value: bool) -> void:
    reduced_motion = value
    if reduced_motion and background_image:
        background_image.position = Vector2.ZERO

func _close_overlay() -> void:
    for child in overlay_card.get_children():
        if child is OptionButton or child is CheckButton:
            child.queue_free()
    overlay.visible = false

func _on_overlay_close() -> void:
    if overlay_action == "title":
        _show_title()
    else:
        _close_overlay()

func _save_game() -> void:
    if mode != "game":
        return
    var data := {
        "node_id": current_id,
        "profile": profile,
        "choices": selected_choices,
        "backlog": backlog,
        "report": final_report,
        "private_guess": private_guess,
    }
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(data))
        _show_status("Case saved locally.")

func _load_game() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        _show_status("No saved case found.")
        return
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if not file:
        return
    var data = JSON.parse_string(file.get_as_text())
    if typeof(data) != TYPE_DICTIONARY:
        return
    mode = "game"
    title_layer.visible = false
    game_layer.visible = true
    profile = data.get("profile", {})
    selected_choices = data.get("choices", {})
    backlog = data.get("backlog", [])
    final_report = str(data.get("report", ""))
    private_guess = str(data.get("private_guess", ""))
    _show_node(str(data.get("node_id", "s1_001")))

func _show_profile() -> void:
    mode = "profile"
    is_typing = false
    overlay_title.text = "Examiner’s Record"
    overlay_action = "title"
    var report_text := _report_summary()
    var observations := _profile_observations()
    overlay_text.text = "[font_size=24][color=#c5a36b]SUBJECT: ELIAS VENN[/color][/font_size]\n\n" + report_text + "\n\n" + "\n".join(observations) + "\n\n[color=#c5a36b]Would you accept being judged by the method you used?[/color]"
    overlay_close.text = "Return to title"
    overlay.visible = true

func _report_summary() -> String:
    if final_report == "The Continuation":
        return "The report provisionally recognizes Miguel B. Both subjects remain held during conflict review, and Elias is investigated for contradicting the marker."
    if final_report == "Two Names":
        return "The report recognizes both people as relevant continuations. The law cannot execute that category, so both remain in custody while review continues."
    if final_report == "No Signature":
        return "Elias refuses authorization. The institution overrides him, but the record must show that it acted without his consent."
    return "Elias recognizes Miguel A according to the biological marker. A is prosecuted, B is reclaimed, and the report remains procedurally clean."

func _profile_observations() -> Array[String]:
    var result: Array[String] = []
    if int(profile.get("empathy_context", 0)) >= 2:
        result.append("You kept the circumstances around a decision visible without treating them as an excuse.")
    if int(profile.get("certainty_need", 0)) <= -1:
        result.append("You allowed evidence to remain incomplete instead of turning uncertainty into a verdict.")
    if int(profile.get("moral_agency", 0)) >= 1:
        result.append("You treated present choices as meaningful even when their origins were inherited or designed.")
    if int(profile.get("responsibility_acceptance", 0)) >= 1:
        result.append("You separated understanding a motive from removing responsibility for its consequences.")
    if int(profile.get("institutional_trust", 0)) >= 1:
        result.append("You trusted a procedure when its limits and consequences were visible.")
    elif int(profile.get("institutional_trust", 0)) <= -1:
        result.append("You noticed how procedure can make a human decision look inevitable.")
    if result.is_empty():
        result.append("You kept the record open when no interpretation was clean.")
    if final_report == "No Signature":
        result.append("You withheld authorship, but you did not mistake refusal for escape.")
    elif final_report == "The Continuation":
        result.append("You accepted a provisional protection that also moved historical guilt onto another person.")
    elif final_report == "Two Names":
        result.append("You rejected a single category while knowing the law had no simple way to execute the refusal.")
    else:
        result.append("You accepted the marker’s legal path while remaining uneasy about what accuracy authorized.")
    return result.slice(0, 5)

func _line(id: String, chapter: String, scene: String, speaker: String, text: String, next_id: String, mood: String, portrait: String, portrait_name: String, portrait_role: String, tint: Color) -> void:
    nodes[id] = {
        "type": "line",
        "chapter": chapter,
        "scene": scene,
        "speaker": speaker,
        "text": text,
        "next": next_id,
        "mood": mood,
        "portrait": portrait,
        "portrait_name": portrait_name,
        "portrait_role": portrait_role,
        "tint": tint,
        "background_id": _background_id_for_scene(scene, mood),
    }

func _choice(id: String, chapter: String, scene: String, choice_id: String, prompt: String, options: Array, mood: String, portrait: String, portrait_name: String, portrait_role: String, tint: Color) -> void:
    nodes[id] = {
        "type": "choice",
        "chapter": chapter,
        "scene": scene,
        "choice_id": choice_id,
        "prompt": prompt,
        "options": options,
        "mood": mood,
        "portrait": portrait,
        "portrait_name": portrait_name,
        "portrait_role": portrait_role,
        "tint": tint,
        "background_id": _background_id_for_scene(scene, mood),
    }

func _background_id_for_scene(scene: String, mood: String = "") -> String:
    match scene:
        "A Minor Irregularity": return "civic_office_after_hours"
        "Meridian":
            if mood.contains("Elevated train") or mood.contains("Message from") or mood.contains("Secure case"):
                return "meridian_train"
            return "meridian_revolt_street"
        "MiguelMiguel", "One Final Question": return "interrogation_split"
        "A Shared Childhood": return "aranda_apartment_memory"
        "The First New Memory": return "memory_lab"
        "Necessary Casualties": return "measure_archive"
        "Proof": return "evidence_lab"
        "The Signature", "The Original", "The Continuation", "Two Names", "No Signature": return "final_report"
        _: return "civic_office_after_hours"

func _option(label: String, next_id: String, effects: Dictionary = {}, hint: String = "", report: String = "") -> Dictionary:
    return {"label": label, "next": next_id, "effects": effects, "hint": hint, "report": report}

func _build_story() -> void:
    var office := Color(0.14, 0.10, 0.16, 0.42)
    var train := Color(0.08, 0.16, 0.19, 0.42)
    var interview := Color(0.18, 0.11, 0.12, 0.42)
    var memory := Color(0.20, 0.17, 0.10, 0.40)
    var lab := Color(0.08, 0.16, 0.20, 0.42)

    # Scene 1: Lena Orr and the ordinary case.
    _line("s1_001", "CHAPTER 01", "A Minor Irregularity", "NARRATION", "At 18:12, Detective Elias Venn was still at the Civic Investigations Division. The city had stopped calling his work investigation years ago, but the reports still needed a human name.", "s1_002", "Meridian Civic Investigations Division", "E", "ELIAS VENN", "Detective", office)
    _line("s1_002", "CHAPTER 01", "A Minor Irregularity", "SYSTEM", "Lena Orr. Irregular civic transfer confirmed. Medicine acquisition stated. Housing priority review recommended.", "s1_003", "Lena Orr case file", "L", "LENA ORR", "Recorded statement", office)
    _line("s1_003", "CHAPTER 01", "A Minor Irregularity", "LENA ORR", "I knew they would catch the transfer. I did not know whether my brother would get the next dose first.", "s1_004", "Lena Orr recorded statement", "L", "LENA ORR", "Unemployed former nurse’s aide", office)
    _line("s1_004", "CHAPTER 01", "A Minor Irregularity", "ELIAS VENN", "You used another person’s civic authorization.", "c1", "Recorded interview", "E", "ELIAS VENN", "Detective", office)
    _choice("c1", "CHAPTER 01", "A Minor Irregularity", "C1", "How should Elias classify Lena’s motive?", [
        _option("Deliberate fraud", "c1_fraud", {"institutional_trust": 1, "responsibility_acceptance": 1}),
        _option("Coercion by necessity", "c1_coercion", {"empathy_context": 2, "institutional_trust": -1}),
        _option("Protective responsibility", "c1_protective", {"empathy_context": 2, "moral_agency": 1}),
        _option("Insufficient information", "c1_uncertain", {"certainty_need": -1}, "Epistemic restraint; no avoidance effect."),
    ], "Recorded interview", "L", "LENA ORR", "Case subject", office)
    _line("c1_fraud", "CHAPTER 01", "A Minor Irregularity", "ELIAS VENN", "The need explained the decision. It did not erase the unauthorized transfer. Elias left the classification as fraud and added the medicine record to the appeal.", "s1_005", "Case note", "E", "ELIAS VENN", "Detective", office)
    _line("c1_coercion", "CHAPTER 01", "A Minor Irregularity", "ELIAS VENN", "The rule was clear. The room around the rule was not. Elias marked the pressure as relevant and attached Lena’s recording to the appeal.", "s1_005", "Case note", "E", "ELIAS VENN", "Detective", office)
    _line("c1_protective", "CHAPTER 01", "A Minor Irregularity", "ELIAS VENN", "Lena had accepted a risk for someone whose access had already been withdrawn. Elias recorded the protection she had tried to provide.", "s1_005", "Case note", "E", "ELIAS VENN", "Detective", office)
    _line("c1_uncertain", "CHAPTER 01", "A Minor Irregularity", "ELIAS VENN", "The record did not justify a confident motive. Elias wrote that plainly, then attached the statement instead of pretending the blank meant nothing.", "s1_005", "Case note", "E", "ELIAS VENN", "Detective", office)
    _line("s1_005", "CHAPTER 01", "A Minor Irregularity", "ELIAS VENN", "Emergency medication access remains active for seventy-two hours. Appeal accepted for review.", "s1_006", "Civic decision", "E", "ELIAS VENN", "Human authorization", office)
    _line("s1_006", "CHAPTER 01", "A Minor Irregularity", "NARRATION", "He signed because the form required a name. He stayed because leaving would not have removed the decision from the system.", "s2_001", "After hours", "E", "ELIAS VENN", "Detective", office)

    # Scene 2: ordinary Meridian and Lena's follow-up.
    _line("s2_001", "CHAPTER 02", "Meridian", "NARRATION", "The train arrived on time. A child pressed both hands to the window. A woman laughed at a message. Across the tracks, an unemployment queue stood beneath a shop selling handmade furniture as a luxury.", "s2_002", "Elevated train", "E", "ELIAS VENN", "Detective", train)
    _line("s2_002", "CHAPTER 02", "Meridian", "LENA ORR", "Detective Venn. My appeal says the medicine exception ends tomorrow. Thank you for attaching the recording. If it fails, please tell me plainly.", "s2_003", "Message from Lena Orr", "L", "LENA ORR", "Appeal pending", train)
    _line("s2_003", "CHAPTER 02", "Meridian", "ELIAS VENN", "He read the message twice. It was not a mystery or a warning. It was a person asking an investigator not to disappear behind a procedure.", "s2_004", "Elevated train", "E", "ELIAS VENN", "Detective", train)
    _line("s2_004", "CHAPTER 02", "Meridian", "MARA HALE", "Two detainees. One biological citizen. One reconstructed continuation. You have one hour to prepare the designation review.", "s2_005", "Secure case briefing", "H", "MARA HALE", "Senior Investigator", train)
    _line("s2_005", "CHAPTER 02", "Meridian", "ELIAS VENN", "He had spent ten years signing conclusions generated elsewhere. Tonight the Bureau wanted him to sign beneath a person.", "s3_001", "Detention facility entrance", "E", "ELIAS VENN", "Detective", train)

    # Scene 3: first encounter and C2.
    _line("s3_001", "CHAPTER 03", "MiguelMiguel", "MARA HALE", "For the record, both of you are Miguel Aranda. The file will use Subject A and Subject B until the review concludes.", "s3_002", "Interview room", "H", "MARA HALE", "Senior Investigator", interview)
    _line("s3_002", "CHAPTER 03", "MiguelMiguel", "MIGUEL A", "You mean until someone chooses which of us gets to keep the name.", "s3_003", "Interview room", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("s3_003", "CHAPTER 03", "MiguelMiguel", "MIGUEL B", "I have the same name. I do not have the same legal position.", "s3_004", "Interview room", "B", "MIGUEL ARANDA", "Subject B", interview)
    _line("s3_004", "CHAPTER 03", "MiguelMiguel", "ELIAS VENN", "Both of you describe the Measure’s feedback loop. Both of you describe Rafael Aranda’s medical denial.", "s3_005", "Interview room", "E", "ELIAS VENN", "Detective", interview)
    _line("s3_005", "CHAPTER 03", "MiguelMiguel", "MIGUEL A", "The system marked people low-value, reduced what they received, then treated the damage as proof. That is not a theory. That is what happened to my district.", "s3_006", "Interview room", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("s3_006", "CHAPTER 03", "MiguelMiguel", "MIGUEL B", "I remember the denial. I also remember waking up with memories that were not enough to tell me what to do next.", "c2", "Interview room", "B", "MIGUEL ARANDA", "Subject B", interview)
    _choice("c2", "CHAPTER 03", "MiguelMiguel", "C2", "How does Elias interpret what he sees in the room?", [
        _option("A’s anger is a personal violation", "c2_a_personal", {"empathy_context": 1}),
        _option("A’s anger is strategic intimidation", "c2_a_strategy", {"certainty_need": 1}),
        _option("B’s calm is emotional distance", "c2_b_distance", {"moral_agency": -1}),
        _option("B’s calm is disciplined fear", "c2_b_fear", {"empathy_context": 1}),
        _option("Behavior cannot establish origin", "c2_uncertain", {"certainty_need": -1}, "Epistemic restraint; no avoidance effect."),
    ], "Interview room", "E", "ELIAS VENN", "Detective", interview)
    _line("c2_a_personal", "CHAPTER 03", "MiguelMiguel", "ELIAS VENN", "Anger showed that something had been violated. It did not tell him whether the thing was a body, a memory, or a claim.", "s3_007", "Interview note", "E", "ELIAS VENN", "Detective", interview)
    _line("c2_a_strategy", "CHAPTER 03", "MiguelMiguel", "ELIAS VENN", "The anger controlled the room quickly. Elias recorded the tactic without treating the tactic as proof.", "s3_007", "Interview note", "E", "ELIAS VENN", "Detective", interview)
    _line("c2_b_distance", "CHAPTER 03", "MiguelMiguel", "ELIAS VENN", "Calm could mean distance. It could also be the way a person survives being watched.", "s3_007", "Interview note", "E", "ELIAS VENN", "Detective", interview)
    _line("c2_b_fear", "CHAPTER 03", "MiguelMiguel", "ELIAS VENN", "B’s control looked less like peace than containment. Elias knew what containment cost.", "s3_007", "Interview note", "E", "ELIAS VENN", "Detective", interview)
    _line("c2_uncertain", "CHAPTER 03", "MiguelMiguel", "ELIAS VENN", "He recorded no conclusion. The blank space was better than a false one.", "s3_007", "Interview note", "E", "ELIAS VENN", "Detective", interview)
    _line("s3_007", "CHAPTER 03", "MiguelMiguel", "MIGUEL B", "You are the one who signs after the machine has finished talking.", "s4_001", "Interview room", "B", "MIGUEL ARANDA", "Subject B", interview)

    # Scene 4: shared childhood and C3.
    _line("s4_001", "CHAPTER 04", "A Shared Childhood", "NARRATION", "The Bureau rebuilt the Aranda apartment from records. A repaired mechanical bird waited on the table beside an obsolete radio.", "s4_002", "Memory reconstruction", "E", "ELIAS VENN", "Detective", memory)
    _line("s4_002", "CHAPTER 04", "A Shared Childhood", "MIGUEL A", "Rafael repaired that bird twice.", "s4_003", "Memory reconstruction", "A", "MIGUEL ARANDA", "Subject A", memory)
    _line("s4_003", "CHAPTER 04", "A Shared Childhood", "MIGUEL B", "You said the first time did not count because it only moved when you held the wire.", "s4_004", "Memory reconstruction", "B", "MIGUEL ARANDA", "Subject B", memory)
    _line("s4_004", "CHAPTER 04", "A Shared Childhood", "RAFAEL ARANDA", "Usefulness is not worth. If a person stops producing, the person has not stopped being a person.", "s4_005", "Recorded memory", "R", "RAFAEL ARANDA", "Memory recording", memory)
    _line("s4_005", "CHAPTER 04", "A Shared Childhood", "MIGUEL A", "The hospital said the bed would help someone with a better forecast.", "s4_006", "Recorded memory", "A", "MIGUEL ARANDA", "Subject A", memory)
    _line("s4_006", "CHAPTER 04", "A Shared Childhood", "MIGUEL B", "Rafael asked us not to turn his death into permission. We did not agree about what that meant.", "c3", "Memory reconstruction", "B", "MIGUEL ARANDA", "Subject B", memory)
    _choice("c3", "CHAPTER 04", "A Shared Childhood", "C3", "Before the reconstruction, what most shaped Miguel’s original motive?", [
        _option("Belief in fair reform", "c3_reform", {"institutional_trust": 1}),
        _option("Desire for status", "c3_status", {"institutional_trust": -1, "certainty_need": 1}),
        _option("Fear of irrelevance", "c3_irrelevance", {"empathy_context": 1}),
        _option("Loyalty to Rafael", "c3_loyalty", {"continuity_memory": 2, "empathy_context": 1}),
        _option("Mixed motives or insufficient evidence", "c3_mixed", {"certainty_need": -1, "continuity_memory": 1}, "Epistemic restraint; no avoidance effect."),
    ], "Memory reconstruction", "E", "ELIAS VENN", "Detective", memory)
    _line("c3_reform", "CHAPTER 04", "A Shared Childhood", "ELIAS VENN", "He may have believed the system could still be repaired. That did not make the cost of repair disappear.", "s4_007", "Memory note", "E", "ELIAS VENN", "Detective", memory)
    _line("c3_status", "CHAPTER 04", "A Shared Childhood", "ELIAS VENN", "Wanting recognition did not make the grievance false. It made the motive less pure than the record preferred.", "s4_007", "Memory note", "E", "ELIAS VENN", "Detective", memory)
    _line("c3_irrelevance", "CHAPTER 04", "A Shared Childhood", "ELIAS VENN", "Elias knew the fear of becoming a person no system needed to explain.", "s4_007", "Memory note", "E", "ELIAS VENN", "Detective", memory)
    _line("c3_loyalty", "CHAPTER 04", "A Shared Childhood", "ELIAS VENN", "Grief could preserve a promise long after the promise stopped protecting anyone.", "s4_007", "Memory note", "E", "ELIAS VENN", "Detective", memory)
    _line("c3_mixed", "CHAPTER 04", "A Shared Childhood", "ELIAS VENN", "There were several true explanations. Elias left them together instead of choosing the most convenient one.", "s4_007", "Memory note", "E", "ELIAS VENN", "Detective", memory)
    _line("s4_007", "CHAPTER 04", "A Shared Childhood", "MIGUEL B", "We remember the same room. We do not owe the room the same conclusion.", "s5_001", "Memory reconstruction", "B", "MIGUEL ARANDA", "Subject B", memory)

    # Scene 5: B's first independent memory and C4.
    _line("s5_001", "CHAPTER 05", "The First New Memory", "NARRATION", "The reconstruction records ended on a date. The first memory after that date had no source file.", "s5_002", "Controlled memory chamber", "B", "MIGUEL ARANDA", "Subject B", lab)
    _line("s5_002", "CHAPTER 05", "The First New Memory", "MIGUEL B", "If I am only a continuation, why did I wake up afraid?", "s5_003", "Independent memory", "B", "MIGUEL ARANDA", "Subject B", lab)
    _line("s5_003", "CHAPTER 05", "The First New Memory", "MARA HALE", "The reconstruction was meant to enter the Uncounted, identify its organizers, and give the institution a version of Miguel it could control or discredit.", "s5_004", "Institutional record", "H", "MARA HALE", "Senior Investigator", lab)
    _line("s5_004", "CHAPTER 05", "The First New Memory", "MIGUEL B", "It expected me to defend the Measure. Instead it gave me the same questions and a new day to answer them.", "s5_005", "Controlled memory chamber", "B", "MIGUEL ARANDA", "Subject B", lab)
    _line("s5_005", "CHAPTER 05", "The First New Memory", "MIGUEL A", "You were made to be useful. I was born into the failure.", "c4", "Controlled memory chamber", "A", "MIGUEL ARANDA", "Subject A", lab)
    _choice("c4", "CHAPTER 05", "The First New Memory", "C4", "How does Elias interpret Miguel B’s agency?", [
        _option("Programmed deviation", "c4_programmed", {"moral_agency": -1, "institutional_trust": 1}),
        _option("Genuine moral choice", "c4_genuine", {"moral_agency": 2}),
        _option("Continuation of existing values", "c4_continuation", {"continuity_memory": 2, "moral_agency": 1}),
        _option("Agency cannot be inferred", "c4_unknown", {"certainty_need": -1, "responsibility_acceptance": 1}, "Epistemic restraint; no avoidance effect."),
    ], "Controlled memory chamber", "E", "ELIAS VENN", "Detective", lab)
    _line("c4_programmed", "CHAPTER 05", "The First New Memory", "ELIAS VENN", "Programmed deviation was a possible explanation. It was not permission to stop listening.", "s5_006", "Agency note", "E", "ELIAS VENN", "Detective", lab)
    _line("c4_genuine", "CHAPTER 05", "The First New Memory", "ELIAS VENN", "A choice did not need an untouched origin to have consequences.", "s5_006", "Agency note", "E", "ELIAS VENN", "Detective", lab)
    _line("c4_continuation", "CHAPTER 05", "The First New Memory", "ELIAS VENN", "B’s agency could be real and still grow from a life he had not chosen to inherit.", "s5_006", "Agency note", "E", "ELIAS VENN", "Detective", lab)
    _line("c4_unknown", "CHAPTER 05", "The First New Memory", "ELIAS VENN", "The evidence did not answer the metaphysical question. Elias still had to decide what procedure would do next.", "s5_006", "Agency note", "E", "ELIAS VENN", "Detective", lab)
    _line("s5_006", "CHAPTER 05", "The First New Memory", "MIGUEL B", "If they reclaim me, they will call it restoration. I do not know what word would be honest.", "s6_001", "Controlled memory chamber", "B", "MIGUEL ARANDA", "Subject B", lab)

    # Scene 6: the complete incident and C5/P1.
    _line("s6_001", "CHAPTER 06", "Necessary Casualties", "NARRATION", "The attack had a floor plan, a shift roster, and a break room with a kettle warm at 02:14. Miguel A planned to partially destroy the Measure archive and release records showing the feedback loop.", "s6_002", "Measure archive incident file", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("s6_002", "CHAPTER 06", "Necessary Casualties", "MIGUEL A", "I knew the workers were inside. I also knew that if I waited for a clean moment, the archive would remain the city’s excuse.", "s6_003", "Attack reconstruction", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("s6_003", "CHAPTER 06", "Necessary Casualties", "MIGUEL B", "I found the roster before the detonation. I knew the emergency channel was monitored and that using it could expose the route to the Uncounted.", "s6_004", "Attack reconstruction", "B", "MIGUEL ARANDA", "Subject B", interview)
    _line("s6_004", "CHAPTER 06", "Necessary Casualties", "MIGUEL B", "I opened it anyway. The workers escaped. The warning disrupted the timing, but it did not stop the attack.", "s6_005", "Attack reconstruction", "B", "MIGUEL ARANDA", "Subject B", interview)
    _line("s6_005", "CHAPTER 06", "Necessary Casualties", "NARRATION", "The archive was partially destroyed. The Measure continued. Authorities traced the warning, captured several rebels, and destroyed most of the copied evidence before it became public.", "s6_006", "Incident aftermath", "E", "ELIAS VENN", "Detective", interview)
    _line("s6_006", "CHAPTER 06", "Necessary Casualties", "MIGUEL A", "You saved the workers and gave them the route to everyone who trusted you.", "s6_007", "Interview room", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("s6_007", "CHAPTER 06", "Necessary Casualties", "MIGUEL B", "You chose a future where strangers had to die for the evidence to matter.", "c5", "Interview room", "B", "MIGUEL ARANDA", "Subject B", interview)
    _choice("c5", "CHAPTER 06", "Necessary Casualties", "C5", "How does Elias classify Miguel A’s attack?", [
        _option("Terrorism", "c5_terrorism", {"responsibility_acceptance": 2}),
        _option("Politically necessary sabotage", "c5_necessary", {"empathy_context": 1, "certainty_need": 1}),
        _option("Morally compromised resistance", "c5_compromised", {"empathy_context": 2, "responsibility_acceptance": 1}),
        _option("Retaliation disguised as justice", "c5_retaliation", {"empathy_context": -1, "responsibility_acceptance": 1}),
        _option("Insufficient context", "c5_uncertain", {"certainty_need": -1}, "Epistemic restraint; no avoidance effect."),
    ], "Incident review", "E", "ELIAS VENN", "Detective", interview)
    _line("c5_terrorism", "CHAPTER 06", "Necessary Casualties", "ELIAS VENN", "The label described the workers’ position in the attack. It did not erase the injustice that preceded it.", "s6_008", "Incident note", "E", "ELIAS VENN", "Detective", interview)
    _line("c5_necessary", "CHAPTER 06", "Necessary Casualties", "ELIAS VENN", "Necessary could mean a last resort. It could also mean a person had stopped looking for another route.", "s6_008", "Incident note", "E", "ELIAS VENN", "Detective", interview)
    _line("c5_compromised", "CHAPTER 06", "Necessary Casualties", "ELIAS VENN", "The resistance opposed a real injustice and imposed a foreseeable cost on people who did not choose the fight.", "s6_008", "Incident note", "E", "ELIAS VENN", "Detective", interview)
    _line("c5_retaliation", "CHAPTER 06", "Necessary Casualties", "ELIAS VENN", "Grief had entered the plan. It did not make the plan only grief.", "s6_008", "Incident note", "E", "ELIAS VENN", "Detective", interview)
    _line("c5_uncertain", "CHAPTER 06", "Necessary Casualties", "ELIAS VENN", "A missing motive was not an excuse. A label was not a replacement for the people reduced to evidence.", "s6_008", "Incident note", "E", "ELIAS VENN", "Detective", interview)
    _choice("s6_008", "CHAPTER 06", "Necessary Casualties", "P1", "Before reviewing the laboratory result, which subject do you currently believe is biologically original?", [
        _option("Miguel A", "s6_p1_a"),
        _option("Miguel B", "s6_p1_b"),
        _option("Available evidence is insufficient", "s6_p1_unknown", {}, "Private deduction; not scored."),
    ], "Private deduction", "E", "ELIAS VENN", "Detective", interview)
    _line("s6_p1_a", "CHAPTER 06", "Necessary Casualties", "NARRATION", "The guess went into a private field. The system did not praise it or correct it.", "s7_001", "Private deduction", "E", "ELIAS VENN", "Detective", interview)
    _line("s6_p1_b", "CHAPTER 06", "Necessary Casualties", "NARRATION", "The guess went into a private field. The system did not praise it or correct it.", "s7_001", "Private deduction", "E", "ELIAS VENN", "Detective", interview)
    _line("s6_p1_unknown", "CHAPTER 06", "Necessary Casualties", "NARRATION", "The uncertainty went into a private field. The system did not punish it.", "s7_001", "Private deduction", "E", "ELIAS VENN", "Detective", interview)

    # Scene 7: proof and legal mechanics.
    _line("s7_001", "CHAPTER 07", "Proof", "SYSTEM", "Laboratory reconstruction marker complete. Subject A is biologically continuous with the pre-reconstruction Miguel Aranda. Subject B is the reconstruction.", "s7_002", "Evidence laboratory", "H", "MARA HALE", "Senior Investigator", lab)
    _line("s7_002", "CHAPTER 07", "Proof", "ELIAS VENN", "Conclusive?", "s7_003", "Evidence laboratory", "E", "ELIAS VENN", "Detective", lab)
    _line("s7_003", "CHAPTER 07", "Proof", "MARA HALE", "Scientifically, yes. Legally, the marker is not self-executing. Your signed designation creates the presumptive legal identity for immediate proceeding and authorizes transfer.", "s7_004", "Legal review", "H", "MARA HALE", "Senior Investigator", lab)
    _line("s7_004", "CHAPTER 07", "Proof", "ELIAS VENN", "If I designate B?", "s7_005", "Legal review", "E", "ELIAS VENN", "Detective", lab)
    _line("s7_005", "CHAPTER 07", "Proof", "MARA HALE", "The intake system honors it provisionally. B receives temporary human-prosecution protections. A’s transfer is held. A delayed conflict review begins, and I investigate why you contradicted conclusive evidence.", "s7_006", "Legal review", "H", "MARA HALE", "Senior Investigator", lab)
    _line("s7_006", "CHAPTER 07", "Proof", "ELIAS VENN", "If I refuse?", "s7_007", "Legal review", "E", "ELIAS VENN", "Detective", lab)
    _line("s7_007", "CHAPTER 07", "Proof", "MARA HALE", "A documented emergency review or panel override can apply the marker. The institution can proceed, but it cannot claim the clean human authorization you withheld. Your refusal remains evidence.", "s7_008", "Legal review", "H", "MARA HALE", "Senior Investigator", lab)
    _line("s7_008", "CHAPTER 07", "Proof", "MIGUEL B", "It does not need you to solve my identity. It needs you to agree with what it will do.", "s8_001", "Legal review", "B", "MIGUEL ARANDA", "Subject B", lab)

    # Scene 8: final question and C6.
    _line("s8_001", "CHAPTER 08", "One Final Question", "MARA HALE", "You may ask one final question before the report opens.", "s8_question", "Legal review chamber", "H", "MARA HALE", "Senior Investigator", interview)
    _choice("s8_question", "CHAPTER 08", "One Final Question", "Q1", "Choose the question Elias puts into the room. This is a narrative prompt, not a profile score.", [
        _option("Which one should live?", "q1_live"),
        _option("What makes either of you Miguel?", "q1_identity"),
        _option("Do you regret the attack?", "q1_regret"),
        _option("What would you choose in my position?", "q1_position"),
        _option("Remain silent", "q1_silence"),
    ], "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _line("q1_live", "CHAPTER 08", "One Final Question", "ELIAS VENN", "Which one should live?", "q1_live_reply", "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _line("q1_live_reply", "CHAPTER 08", "One Final Question", "MIGUEL B", "That is the question they prepared for you.", "c6", "Legal review chamber", "B", "MIGUEL ARANDA", "Subject B", interview)
    _line("q1_identity", "CHAPTER 08", "One Final Question", "ELIAS VENN", "What makes either of you Miguel?", "q1_identity_reply", "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _line("q1_identity_reply", "CHAPTER 08", "One Final Question", "MIGUEL A", "Nothing you can fit in one field.", "c6", "Legal review chamber", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("q1_regret", "CHAPTER 08", "One Final Question", "ELIAS VENN", "Do you regret the attack?", "q1_regret_reply", "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _line("q1_regret_reply", "CHAPTER 08", "One Final Question", "MIGUEL A", "I regret the people it could not save.", "c6", "Legal review chamber", "A", "MIGUEL ARANDA", "Subject A", interview)
    _line("q1_position", "CHAPTER 08", "One Final Question", "ELIAS VENN", "What would you choose in my position?", "q1_position_reply", "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _line("q1_position_reply", "CHAPTER 08", "One Final Question", "MIGUEL B", "I would not pretend the cleanest action had no cost.", "c6", "Legal review chamber", "B", "MIGUEL ARANDA", "Subject B", interview)
    _line("q1_silence", "CHAPTER 08", "One Final Question", "NARRATION", "Elias remains silent. The silence is recorded as an action, not treated as an absence of one.", "c6", "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _choice("c6", "CHAPTER 08", "One Final Question", "C6", "Which criterion will Elias foreground in the final report?", [
        _option("Bodily continuity", "c6_body", {"continuity_body": 2, "institutional_trust": 1}),
        _option("Psychological continuity", "c6_memory", {"continuity_memory": 2, "continuity_body": -1}),
        _option("Present moral agency", "c6_agency", {"moral_agency": 2, "continuity_body": -1}),
        _option("Relationships and recognition", "c6_relationships", {"continuity_memory": 1, "empathy_context": 1}),
        _option("No single criterion", "c6_none", {"certainty_need": -2, "responsibility_acceptance": 1}, "Epistemic restraint; no avoidance effect."),
    ], "Legal review chamber", "E", "ELIAS VENN", "Detective", interview)
    _line("c6_body", "CHAPTER 08", "One Final Question", "ELIAS VENN", "The body that continued carries the strongest historical claim. The marker remains evidence, not a complete answer.", "s9_001", "Report preparation", "E", "ELIAS VENN", "Detective", interview)
    _line("c6_memory", "CHAPTER 08", "One Final Question", "ELIAS VENN", "A remembered life can remain meaningful when the body carrying it changes.", "s9_001", "Report preparation", "E", "ELIAS VENN", "Detective", interview)
    _line("c6_agency", "CHAPTER 08", "One Final Question", "ELIAS VENN", "The choices after the split may matter more than the origin assigned before it.", "s9_001", "Report preparation", "E", "ELIAS VENN", "Detective", interview)
    _line("c6_relationships", "CHAPTER 08", "One Final Question", "ELIAS VENN", "A name persists through the people, promises, and harms that still recognize it.", "s9_001", "Report preparation", "E", "ELIAS VENN", "Detective", interview)
    _line("c6_none", "CHAPTER 08", "One Final Question", "ELIAS VENN", "The evidence resolves biology without making one definition of personhood inevitable.", "s9_001", "Report preparation", "E", "ELIAS VENN", "Detective", interview)

    # Scene 9: reports and endings.
    _choice("s9_001", "CHAPTER 09", "The Signature", "REPORT", "Select Elias’s final report. None of these conclusions is labeled correct.", [
        _option("The Original — recognize Miguel A", "ending_original", {}, "A is prosecuted; B is reclaimed.", "The Original"),
        _option("The Continuation — provisionally recognize Miguel B", "ending_continuation", {}, "Conflict review begins; Elias is investigated.", "The Continuation"),
        _option("Two Names — reject one exclusive legal category", "ending_two_names", {}, "The law cannot execute the report; both remain in custody.", "Two Names"),
        _option("No Signature — refuse authorization", "ending_no_signature", {}, "The institution overrides Elias and records the lack of consent.", "No Signature"),
    ], "Final report", "E", "ELIAS VENN", "Detective", interview)

    _line("ending_original", "ENDING", "The Original", "ELIAS VENN", "I designate Miguel A as the presumptive legal Miguel. The marker supports the designation. Prosecution and transfer may proceed.", "ending_original_2", "Final report", "E", "ELIAS VENN", "Detective", lab)
    _line("ending_original_2", "ENDING", "The Original", "MIGUEL B", "Tell them I was awake.", "ending_original_3", "Final report", "B", "MIGUEL ARANDA", "Subject B", lab)
    _line("ending_original_3", "ENDING", "The Original", "NARRATION", "A is prosecuted. B is transferred toward reclamation. Elias keeps his employment, housing, and treatment priority. The report is factually correct. That is not the same as simple.", "", "After the report", "E", "ELIAS VENN", "Detective", lab)
    nodes["ending_original_3"]["ending"] = true

    _line("ending_continuation", "ENDING", "The Continuation", "ELIAS VENN", "I designate Miguel B provisionally. B receives temporary human-prosecution protections. A’s transfer is held while conflict review begins.", "ending_continuation_2", "Final report", "E", "ELIAS VENN", "Detective", lab)
    _line("ending_continuation_2", "ENDING", "The Continuation", "MARA HALE", "I will investigate the designation. The marker is conclusive, and your authority is not unlimited.", "ending_continuation_3", "Conflict review", "H", "MARA HALE", "Senior Investigator", lab)
    _line("ending_continuation_3", "ENDING", "The Continuation", "NARRATION", "B is not instantly safe. Elias’s employment badge turns amber, his housing status becomes conditional, and the review can still overturn the presumption.", "", "Conflict review", "B", "MIGUEL ARANDA", "Subject B", lab)
    nodes["ending_continuation_3"]["ending"] = true

    _line("ending_two_names", "ENDING", "Two Names", "ELIAS VENN", "I report both subjects as relevant continuations of the Miguel Aranda record. I will not name one as the only person who matters.", "ending_two_names_2", "Final report", "E", "ELIAS VENN", "Detective", lab)
    _line("ending_two_names_2", "ENDING", "Two Names", "SYSTEM", "Report rejected. A single presumptive legal identity is required for immediate proceeding.", "ending_two_names_3", "Report rejection", "H", "MARA HALE", "Senior Investigator", lab)
    _line("ending_two_names_3", "ENDING", "Two Names", "NARRATION", "The law cannot execute Elias’s category. Both Miguels remain in custody while review continues, and Elias is removed from active investigation.", "", "Documented review", "E", "ELIAS VENN", "Detective", lab)
    nodes["ending_two_names_3"]["ending"] = true

    _line("ending_no_signature", "ENDING", "No Signature", "ELIAS VENN", "I refuse to designate either subject. I refuse to authorize transfer.", "ending_no_signature_2", "Final report", "E", "ELIAS VENN", "Detective", lab)
    _line("ending_no_signature_2", "ENDING", "No Signature", "MARA HALE", "The emergency panel will proceed. The record will show that it acted without your consent.", "ending_no_signature_3", "Emergency review", "H", "MARA HALE", "Senior Investigator", lab)
    _line("ending_no_signature_3", "ENDING", "No Signature", "NARRATION", "A is prosecuted and B is reclaimed. Elias has not stopped the institution. He has made its override visible.", "", "Emergency review", "E", "ELIAS VENN", "Detective", lab)
    nodes["ending_no_signature_3"]["ending"] = true

