function ElementAreaTrigger:project_instigators()
	local instigators = {}

	if Network:is_client() then
		if self._values.instigator == "player" or self._values.instigator == "local_criminals" or self._values.instigator == "persons" then
			table.insert(instigators, managers.player:player_unit())
		elseif self._values.instigator == "player1" or self._values.instigator == "player2" or self._values.instigator == "player3" or self._values.instigator == "player4" then
			local id = tonumber(string.match(self._values.instigator, "%d$"))

			if managers.network:session() and managers.network:session():local_peer():id() == id then
				table.insert(instigators, managers.player:player_unit())
			end
		elseif self._values.instigator == "vr_player" and _G.IS_VR then
			table.insert(instigators, managers.player:player_unit())
		end

		return instigators
	end

	if self._values.instigator == "player" then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "player_not_in_vehicle" then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "vr_player" and _G.IS_VR then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "vehicle" then
		local vehicles = managers.vehicle:get_all_vehicles()

		for _, v in pairs(vehicles) do
			if not v:npc_vehicle_driving() then
				table.insert(instigators, v)
			end
		end
	elseif self._values.instigator == "npc_vehicle" then
		local vehicles = managers.vehicle:get_all_vehicles()

		for _, v in pairs(vehicles) do
			if v:npc_vehicle_driving() then
				table.insert(instigators, v)
			end
		end
	elseif self._values.instigator == "vehicle_with_players" then
		local vehicles = managers.vehicle:get_all_vehicles()

		for _, v in pairs(vehicles) do
			table.insert(instigators, v)
		end
	elseif self._values.instigator == "enemies" then
		local state = managers.groupai:state()

		if state:police_hostage_count() <= 0 and state:get_amount_enemies_converted_to_criminals() <= 0 then
			for _, data in pairs(managers.enemy:all_enemies()) do
				table.insert(instigators, data.unit)
			end
		else
			for _, data in pairs(managers.enemy:all_enemies()) do
				if not data.unit:anim_data().surrender and not data.is_converted then
					table.insert(instigators, data.unit)
				end
			end
		end
	elseif self._values.instigator == "civilians" then
		for _, data in pairs(managers.enemy:all_civilians()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "escorts" then
		for _, data in pairs(managers.enemy:all_civilians()) do
			if tweak_data.character[data.unit:base()._tweak_table].is_escort then
				table.insert(instigators, data.unit)
			end
		end
	elseif self._values.instigator == "hostages" then
		if managers.groupai:state():police_hostage_count() > 0 then
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit:anim_data().surrender then
					table.insert(instigators, data.unit)
				end
			end
		end

		for _, data in pairs(managers.enemy:all_civilians()) do
			if data.unit:anim_data().tied then
				table.insert(instigators, data.unit)
			end
		end
	elseif self._values.instigator == "intimidated_enemies" then
		local state = managers.groupai:state()

		if state:police_hostage_count() > 0 or state:get_amount_enemies_converted_to_criminals() > 0 then
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit:anim_data().surrender or data.is_converted then
					table.insert(instigators, data.unit)
				end
			end
		end
	elseif self._values.instigator == "criminals" then
		for _, data in pairs(managers.groupai:state():all_char_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "local_criminals" then
		table.insert(instigators, managers.player:player_unit())

		for _, data in pairs(managers.groupai:state():all_AI_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "persons" then
		table.insert(instigators, managers.player:player_unit())

		for _, data in pairs(managers.groupai:state():all_char_criminals()) do
			table.insert(instigators, data.unit)
		end

		for _, data in pairs(managers.enemy:all_civilians()) do
			table.insert(instigators, data.unit)
		end

		for _, data in pairs(managers.enemy:all_enemies()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "ai_teammates" then
		for _, data in pairs(managers.groupai:state():all_AI_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "loot" or self._values.instigator == "unique_loot" then
		local all_found = World:find_units_quick("all", 14)
		local filter_func
		if self._values.instigator == "loot" then
			function filter_func(carry_data)
				local carry_id = carry_data:carry_id()
				local carry_list = tweak_data.carry:get_carry_ids()
				if table.contains(carry_list, carry_id) then
					return true
				end
			end
		else
			function filter_func(carry_data)
				local carry_id = carry_data:carry_id()
				if tweak_data.carry[carry_id].is_unique_loot then
					return true
				end
			end
		end
		for _, unit in ipairs(all_found) do
			local carry_data = unit:carry_data()
			if carry_data and filter_func(carry_data) then
				table.insert(instigators, unit)
			end
		end
	elseif self._values.instigator == "equipment" then
		if self._values.instigator_name ~= nil then
			local all_found = World:find_units_quick("all", 14)

			local function filter_func(unit)
				if unit:base() and unit:base().get_name_id and unit:base():get_name_id() == self._values.instigator_name then
					return true
				end
			end

			for _, unit in ipairs(all_found) do
				if filter_func(unit) then
					table.insert(instigators, unit)
				end
			end
		end
	elseif self._values.instigator == "player1" or self._values.instigator == "player2" or self._values.instigator == "player3" or self._values.instigator == "player4" and not Global.game_host then
		local id = tonumber(string.match(self._values.instigator, "%d$"))

		if managers.network:session() and managers.network:session():local_peer():id() == id then
			table.insert(instigators, managers.player:player_unit())
		end
	end

	return instigators
end