Hooks:PostHook( InteractionTweakData, "init", "hardware_store_custom_interactions", function(self, tweak_data)

	self.gen_pku_golden_toilet = {
		text_id = "hud_int_hold_take_golden_toilet",
		action_text_id = "hud_action_taking_golden_toilet",
		timer = 5,
		sound_start = "bar_bag_money",
		sound_interupt = "bar_bag_money_cancel",
		sound_done = "bar_bag_money_finished",
		blocked_hint = "carry_block"
	}
	self.use_files_hs = {
		text_id = "hud_int_use_files_hs",
		action_text_id = "hud_action_use_files_hs",
		equipment_text_id = "hud_equipment_need_files_hs",
		special_equipment = "files",
		equipment_consume = true,
		timer = 1,
		contour = "interactable_icon",
		interact_distance = 200
	}
	self.hs_toolbox = {
		text_id = "hud_take_hs_tools",
		interact_distance = 200,
		special_equipment_block = "hs_tools",
		start_active = false
	}
	self.hs_use_tools = {
		text_id = "hud_hs_use_tools",
		action_text_id = "hud_action_hs_using_tools",
		interact_distance = 150,
		timer = 10,
		equipment_text_id = "hint_no_hs_tools",
		special_equipment = "hs_tools",
		start_active = false,
		equipment_consume = true,
		sound_start = "bar_huge_lance_fix",
		sound_interupt = "bar_huge_lance_fix_cancel",
		sound_done = "bar_huge_lance_fix_finished"
	}
end)