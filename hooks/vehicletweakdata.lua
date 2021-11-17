Hooks:PostHook( VehicleTweakData, "init", "hardware_store_custom_vehicles", function(self, tweak_data)

	self.muscleModded = {}
	self.muscleModded.name = "Longfellow"
	self.muscleModded.hud_label_offset = 150
	self.muscleModded.animations = {
		vehicle_id = "muscle",
		driver = "drive_muscle_driver",
		passenger_front = "drive_muscle_passanger",
		passenger_back_left = "drive_muscle_back_left",
		passenger_back_right = "drive_muscle_back_right"
	}
	self.muscleModded.sound = {
		bump_treshold = 8,
		lateral_slip_treshold = 0.35,
		longitudal_slip_treshold = 0.8,
		engine_sound_event = "muscle",
		broken_engine = "falcogini_engine_broken_loop",
		door_close = "car_door_open",
		slip = "car_skid_01",
		slip_stop = "car_skid_stop_01",
		bump = "car_bumper_01",
		bump_rtpc = "car_bump_vel",
		hit = "car_hit_gen_01",
		hit_rtpc = "car_hit_vel",
		engine_speed_rtpc = "car_falcogini_speed",
		engine_rpm_rtpc = "car_falcogini_rpm"
	}
	self.muscleModded.seats = {
		driver = {name = "driver", driving = true},
		passenger_front = {
			name = "passenger_front",
			driving = false,
			allow_shooting = false,
			has_shooting_mode = true,
			shooting_pos = Vector3(50, -20, 50)
		},
		passenger_back_left = {
			name = "passenger_back_left",
			driving = false,
			allow_shooting = false,
			has_shooting_mode = true
		},
		passenger_back_right = {
			name = "passenger_back_right",
			driving = false,
			allow_shooting = false,
			has_shooting_mode = true
		}
	}
	self.muscleModded.loot_points = {
		loot_left = {name = "loot_left"},
		loot_right = {name = "loot_right"},
		loot = {name = "loot"}
	}
	self.muscleModded.trunk_point = "trunk"
	self.muscleModded.damage = {max_health = 9000000}
	self.muscleModded.max_speed = 200
	self.muscleModded.max_rpm = 10000
	self.muscleModded.loot_drop_point = "v_repair_engine"
	self.muscleModded.max_loot_bags = 50
	self.muscleModded.interact_distance = 350
	self.muscleModded.driver_camera_offset = Vector3(0, 0.2, 2.5)
	self.muscleModded.fov = 90
		
end)