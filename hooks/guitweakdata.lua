Hooks:PostHook( GuiTweakData, "init", "pd2concepts_contact", function(self)
	local contact_data = {
		id = "pd2concepts",
		name_id = "heist_contact_pd2concepts",
		{
			desc_id = "heist_contact_pd2concepts_desc",
			video = "dragon1",
			post_event = nil
		},
		{
			desc_id = "heist_contact_pd2concepts_crew_desc",
			video = "dragon1",
			post_event = nil
		}
	}

	table.insert(self.crime_net.codex[1], contact_data)
end)