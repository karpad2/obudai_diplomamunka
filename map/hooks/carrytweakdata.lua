Hooks:PostHook( CarryTweakData, "init", "hardware_store_custom_carrys", function(self, tweak_data)

	self.golden_toilet = {
		type = "very_heavy",
		name_id = "hud_carry_golden_toilet",
		bag_value = "sandwich",
		visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1",
		AI_carry = {SO_category = "enemies"},
		unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	}
		
end)