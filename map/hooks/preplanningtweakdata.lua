PrePlanningTweakData.hardware_store_create_locations = PrePlanningTweakData._create_locations
PrePlanningTweakData.hardware_store_init = PrePlanningTweakData.init

function PrePlanningTweakData:init(...)

	PrePlanningTweakData:hardware_store_init(...)
	
	
	self.types.hardware_store_escape_truck = {}
	self.types.hardware_store_escape_truck.name_id = "hardware_store_escape_truck"
	self.types.hardware_store_escape_truck.desc_id = "hardware_store_escape_truck_desc"
	self.types.hardware_store_escape_truck.category = "escape_plan"
	self.types.hardware_store_escape_truck.plan = "escape_plan"
	self.types.hardware_store_escape_truck.icon = 54
	self.types.hardware_store_escape_truck.total = 1
	self.types.hardware_store_escape_truck.post_event = "gus_preplan_12"
	self.types.hardware_store_escape_truck.prio = 3
	self.types.hardware_store_escape_truck.budget_cost = 0
	self.types.hardware_store_escape_truck.cost = 0
	self.types.hardware_store_escape_truck.pos_not_important = false
	
	self.types.hardware_store_escape_helicopter_carpark = {}
	self.types.hardware_store_escape_helicopter_carpark.name_id = "hardware_store_escape_helicopter_carpark"
	self.types.hardware_store_escape_helicopter_carpark.desc_id = "hardware_store_escape_helicopter_carpark_desc"
	self.types.hardware_store_escape_helicopter_carpark.category = "escape_plan"
	self.types.hardware_store_escape_helicopter_carpark.plan = "escape_plan"
	self.types.hardware_store_escape_helicopter_carpark.icon = 54
	self.types.hardware_store_escape_helicopter_carpark.total = 1
	self.types.hardware_store_escape_helicopter_carpark.post_event = "gus_preplan_17"
	self.types.hardware_store_escape_helicopter_carpark.prio = 3
	self.types.hardware_store_escape_helicopter_carpark.budget_cost = 6
	self.types.hardware_store_escape_helicopter_carpark.cost = 0
	self.types.hardware_store_escape_helicopter_carpark.pos_not_important = false
	
	self.types.hardware_store_escape_helicopter_back = {}
	self.types.hardware_store_escape_helicopter_back.name_id = "hardware_store_escape_helicopter_back"
	self.types.hardware_store_escape_helicopter_back.desc_id = "hardware_store_escape_helicopter_back_desc"
	self.types.hardware_store_escape_helicopter_back.category = "escape_plan"
	self.types.hardware_store_escape_helicopter_back.plan = "escape_plan"
	self.types.hardware_store_escape_helicopter_back.icon = 54
	self.types.hardware_store_escape_helicopter_back.total = 1
	self.types.hardware_store_escape_helicopter_back.post_event = "gus_preplan_13"
	self.types.hardware_store_escape_helicopter_back.prio = 3
	self.types.hardware_store_escape_helicopter_back.budget_cost = 10
	self.types.hardware_store_escape_helicopter_back.cost = 0
	self.types.hardware_store_escape_helicopter_back.pos_not_important = false
	
	self.types.hardware_store_ladder = {}
	self.types.hardware_store_ladder.name_id = "hardware_store_ladder"
	self.types.hardware_store_ladder.desc_id = "hardware_store_ladder_desc"
	self.types.hardware_store_ladder.category = "mission_equipment"
	self.types.hardware_store_ladder.icon = 63
	self.types.hardware_store_ladder.total = 3
	self.types.hardware_store_ladder.post_event = "gus_preplan_15"
	self.types.hardware_store_ladder.prio = 5
	self.types.hardware_store_ladder.budget_cost = 1
	self.types.hardware_store_ladder.cost = 0
	self.types.hardware_store_ladder.pos_not_important = false
	
	self.types.hardware_store_electric_boxes = {}
	self.types.hardware_store_electric_boxes.name_id = "hardware_store_electric_boxes"
	self.types.hardware_store_electric_boxes.desc_id = "hardware_store_electric_boxes_desc"
	self.types.hardware_store_electric_boxes.category = "mission_equipment"
	self.types.hardware_store_electric_boxes.icon = 42
	self.types.hardware_store_electric_boxes.total = 1
	self.types.hardware_store_electric_boxes.post_event = "gus_preplan_13"
	self.types.hardware_store_electric_boxes.prio = 1
	self.types.hardware_store_electric_boxes.budget_cost = 8
	self.types.hardware_store_electric_boxes.cost = 0
	self.types.hardware_store_electric_boxes.pos_not_important = false
	
	self.types.hardware_store_fak = {}
	self.types.hardware_store_fak.name_id = "hardware_store_fak"
	self.types.hardware_store_fak.desc_id = "hardware_store_fak_desc"
	self.types.hardware_store_fak.deployable_id = "first_aid_kit"
	self.types.hardware_store_fak.category = "dead_drop"
	self.types.hardware_store_fak.icon = 31
	self.types.hardware_store_fak.total = 2
	self.types.hardware_store_fak.post_event = "none"
	self.types.hardware_store_fak.prio = 2
	self.types.hardware_store_fak.budget_cost = 2
	self.types.hardware_store_fak.cost = 0
	
	self.types.hardware_store_loot_drop_off = {}
	self.types.hardware_store_loot_drop_off.name_id = "hardware_store_loot_drop_off"
	self.types.hardware_store_loot_drop_off.desc_id = "hardware_store_loot_drop_off_desc"
	self.types.hardware_store_loot_drop_off.category = "hired_help"
	self.types.hardware_store_loot_drop_off.icon = 34
	self.types.hardware_store_loot_drop_off.total = 1
	self.types.hardware_store_loot_drop_off.post_event = "gus_preplan_16"
	self.types.hardware_store_loot_drop_off.prio = 1
	self.types.hardware_store_loot_drop_off.cost = 0
	self.types.hardware_store_loot_drop_off.budget_cost = 4

	
end

function PrePlanningTweakData:_create_locations(...)

	PrePlanningTweakData:hardware_store_create_locations(...)
	
	self.locations.hardware_store = {
		default_plans = {
				escape_plan = "hardware_store_escape_truck"
			},
			total_budget = 14,
			mission_briefing_texture = "guis/custom/pre_planning/hardware_store_briefing",
			start_location = {
				group = "a",
				x = 1024,
				y = 1024,
				zoom = 1.5
			},
			{
				name_id = "menu_pp_hardware_store_outside",
				texture = "guis/custom/pre_planning/hardware_store_outside",
				map_x = -1.0,
				map_y = 0,
				map_size = 1,
				x1 = -5000,
				y1 = -3000,
				x2 = 4800,
				y2 = 11300,
				rotation = 0,
				custom_points = {
				}
			},
			{
				name_id = "menu_pp_hardware_store_ground_floor",
				texture = "guis/custom/pre_planning/hardware_store_ground",
				map_x = 0.1,
				map_y = -0.35,
				map_size = 1,
				x1 = -5000,
				y1 = -3000,
				x2 = 4800,
				y2 = 11300,
				rotation = 0,
				custom_points = {
				}
			},
			{
				name_id = "menu_pp_hardware_store_first_floor",
				texture = "guis/custom/pre_planning/hardware_store_first",
				map_x = 0.1,
				map_y = 0.35,
				map_size = 1,
				x1 = -5000,
				y1 = -3000,
				x2 = 4800,
				y2 = 11300,
				rotation = 0,
				custom_points = {
				}
			}
		}

end