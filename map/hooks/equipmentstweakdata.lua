Hooks:PostHook( EquipmentsTweakData, "init", "hardware_store_custom_equipments", function(self, tweak_data)

	self.specials.hs_tools = {
		sync_possession = true,
		icon = "equipment_bfd_tool",
		transfer_quantity = 4,
		text_id = "hud_equipment_hs_tools"
	}
		
end)