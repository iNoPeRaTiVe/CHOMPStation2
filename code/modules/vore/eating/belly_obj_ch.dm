//CHOMP vore additions.

/obj/belly
	//CHOMP - liquid bellies
	var/reagentbellymode = FALSE			// Belly has abilities to make liquids from digested/absorbed/drained prey and/or nutrition
	var/reagent_mode_flags = 0

	var/tmp/static/list/reagent_mode_flag_list= list(
		"Produce Liquids" = DM_FLAG_REAGENTSNUTRI,
		"Digestion Liquids" = DM_FLAG_REAGENTSDIGEST,
		"Absorption Liquids" = DM_FLAG_REAGENTSABSORB,
		"Draining Liquids" = DM_FLAG_REAGENTSDRAIN
		)

	var/show_liquids = FALSE //Moved from vorepanel_ch to be a belly var
	var/show_fullness_messages = FALSE //Moved from vorepanel_ch to be a belly var

	var/nutri_reagent_gen = FALSE					//if belly produces reagent over time using nutrition, needs to be optimized to use subsystem - Jack
	var/list/generated_reagents = list("water" = 1) //Any number of reagents, the associated value is how many units are generated per process()
	var/reagent_name = "water" 						//What is shown when reagents are removed, doesn't need to be an actual reagent
	var/reagentid = "water"							//Selected reagent's id, for use in puddle system currently
	var/reagentcolor = "#0064C877"					//Selected reagent's color, for use in puddle system currently
	var/gen_cost = 1 								//amount of nutrient taken from the host everytime nutrition is used to make reagents
	var/gen_amount = 1							//Does not actually influence amount produced, but is used as a way to tell the system how much total reagent it has to take into account when filling a belly

	var/gen_interval = 0							//Interval in seconds for generating fluids, once it reaches the value of gen_time one cycle of reagents generation will occur
	var/gen_time = 5								//Time it takes in seconds to produce one cycle of reagents, technically add 1 second to it for the tick where the fluid is produced
	var/gen_time_display = "1 hour"					//The displayed time it takes from a belly to go from 0 to 100
	var/custom_max_volume = 100						//Variable for people to limit amount of liquid they can receive/produce in a belly
	var/digest_nutri_gain = 0						//variable to store temporary nutrition gain from digestion and allow a seperate proc to ease up on the wall of code
	var/reagent_transfer_verb = "injects"			//verb for transfer of reagent from a vore belly

	var/vorefootsteps_sounds = FALSE				//If this belly can make sounds when someone walks around
	var/liquid_fullness1_messages = FALSE
	var/liquid_fullness2_messages = FALSE
	var/liquid_fullness3_messages = FALSE
	var/liquid_fullness4_messages = FALSE
	var/liquid_fullness5_messages = FALSE
	var/vorespawn_blacklist = FALSE

	var/list/fullness1_messages = list(
		"%pred's %belly looks empty"
		)
	var/list/fullness2_messages = list(
		"%pred's %belly looks filled"
		)
	var/list/fullness3_messages = list(
		"%pred's %belly looks like it's full of liquid"
		)
	var/list/fullness4_messages = list(
		"%pred's %belly is quite full!"
		)
	var/list/fullness5_messages = list(
		"%pred's %belly is completely filled to it's limit!"
		)

	// Stuff to add in future!
	/*
	var/list/empty_message = list("You feel as though your internal reagent implant is almost empty.")
	var/list/full_message = "You feel as though your internal reagent implant is full."

	var/list/emote_descriptor = list("tranfers something") //In format of [x] [emote_descriptor] into [container]
	var/list/self_emote_descriptor = list("transfer") //In format of You [self_emote_descriptor] some [generated_reagent] into [container]
	*/

	var/tmp/reagent_chosen = "Water"				// variable for switch to figure out what to set variables when a certain reagent is selected
	var/tmp/static/list/reagent_choices = list(		// List of reagents people can chose, maybe one day expand so it covers criterias like dogborgs who can make meds, booze, etc - Jack
	"Water",
	"Milk",
	"Cream",
	"Honey",
	"Cherry Jelly",
	"Digestive acid",
	"Diluted digestive acid",
	"Lube",
	"Biomass"
	)

	//CHOMP - vore sprites
	var/vore_sprite_flags = DM_FLAG_VORESPRITE_BELLY
	var/tmp/static/list/vore_sprite_flag_list= list(
		"Normal belly sprite" = DM_FLAG_VORESPRITE_BELLY,
		//"Tail adjustment" = DM_FLAG_VORESPRITE_TAIL,
		//"Marking addition" = DM_FLAG_VORESPRITE_MARKING,
		"Undergarment addition" = DM_FLAG_VORESPRITE_ARTICLE,
		)

	var/affects_vore_sprites = FALSE
	var/count_absorbed_prey_for_sprite = TRUE
	var/absorbed_multiplier = 1
	var/count_liquid_for_sprite = FALSE
	var/liquid_multiplier = 1
	var/count_items_for_sprite = FALSE
	var/item_multiplier = 1
	var/health_impacts_size = TRUE
	var/resist_triggers_animation = TRUE
	var/size_factor_for_sprite = 1
	var/belly_sprite_to_affect = "stomach"
	var/undergarment_chosen = "Underwear, bottom"
	var/undergarment_if_none
	var/undergarment_color = COLOR_GRAY
	var/datum/sprite_accessory/tail/tail_to_change_to = FALSE
	var/tail_colouration = FALSE
	var/tail_extra_overlay = FALSE
	var/tail_extra_overlay2 = FALSE
	//var/marking_to_add = NULL
	//var/marking_color = NULL
	var/special_entrance_sound				// Mob specific custom entry sound set by mob's init_vore when applicable
	var/slow_digestion = FALSE				// Gradual corpse digestion
	var/slow_brutal = FALSE					// Gradual corpse digestion: Stumpy's Special
	var/sound_volume = 100					// Volume knob.
	var/speedy_mob_processing = FALSE		// Independent belly processing to utilize SSobj instead of SSbellies 3x speed.
	var/cycle_sloshed = FALSE				// Has vorgan entrance made a wet slosh this cycle? Soundspam prevention for multiple items entered.

/obj/belly/proc/GetFullnessFromBelly()
	if(!affects_vore_sprites)
		return 0
	var/belly_fullness = 0
	for(var/mob/living/M in src)
		if(count_absorbed_prey_for_sprite || !M.absorbed)
			var/fullness_to_add = M.size_multiplier
			fullness_to_add *= M.mob_size / 20
			if(M.absorbed)
				fullness_to_add *= absorbed_multiplier
			if(health_impacts_size)
				if(ishuman(M))
					fullness_to_add *= (M.health + 100) / (M.getMaxHealth() + 100)
				else
					fullness_to_add *= M.health / M.getMaxHealth()
			if(fullness_to_add > 0)
				belly_fullness += fullness_to_add
	if(count_liquid_for_sprite)
		belly_fullness += (reagents.total_volume / 100) * liquid_multiplier
	if(count_items_for_sprite)
		for(var/obj/item/I in src)
			var/fullness_to_add = 0
			if(I.w_class == ITEMSIZE_TINY)
				fullness_to_add = ITEMSIZE_COST_TINY
			else if(I.w_class == ITEMSIZE_SMALL)
				fullness_to_add = ITEMSIZE_COST_SMALL
			else if(I.w_class == ITEMSIZE_NORMAL)
				fullness_to_add = ITEMSIZE_COST_NORMAL
			else if(I.w_class == ITEMSIZE_LARGE)
				fullness_to_add = ITEMSIZE_COST_LARGE
			else if(I.w_class == ITEMSIZE_HUGE)
				fullness_to_add = ITEMSIZE_COST_HUGE
			else
				fullness_to_add = ITEMSIZE_COST_NO_CONTAINER
			fullness_to_add /= 32
			belly_fullness += fullness_to_add * item_multiplier
	belly_fullness *= size_factor_for_sprite
	return belly_fullness


///////////////////// NUTRITION REAGENT PRODUCTION /////////////////

/obj/belly/proc/HandleBellyReagents()
	if(reagentbellymode && reagent_mode_flags & DM_FLAG_REAGENTSNUTRI && reagents.total_volume < custom_max_volume) //Removed if(reagentbellymode == TRUE) since that's less optimized
		if(isrobot(owner))
			var/mob/living/silicon/robot/R = owner
			if(R.cell.charge >= gen_cost*10 && gen_interval >= gen_time)
				GenerateBellyReagents()
				gen_interval = 0
			else
				gen_interval++
		else
			if(owner.nutrition >= gen_cost && gen_interval >= gen_time)
				GenerateBellyReagents()
				gen_interval = 0
			else
				gen_interval++
	if(reagents.total_volume)
		for(var/mob/living/L in contents)
			if(L.digestable && digest_mode == DM_DIGEST)
				if(reagents.total_volume)
					reagents.trans_to(L, reagents.total_volume, 0.1 / (LAZYLEN(contents) ? LAZYLEN(contents) : 1), FALSE)
			vore_fx(L, FALSE, reagents.total_volume)
		for(var/obj/item/I in contents)
			if(reagents.total_volume)
				reagents.trans_to(I, reagents.total_volume, 0.1 / (LAZYLEN(contents) ? LAZYLEN(contents) : 1), FALSE)

/obj/belly/proc/GenerateBellyReagents()
	if(isrobot(owner))
		var/mob/living/silicon/robot/R = owner
		R.cell.charge -= gen_cost*10
	else
		owner.nutrition -= gen_cost
	for(var/reagent in generated_reagents)
		reagents.add_reagent(reagent, generated_reagents[reagent])
	if(count_liquid_for_sprite)
		owner.update_fullness() //This is run whenever a belly's contents are changed.

//////////////////////////// REAGENT_DIGEST ////////////////////////

/obj/belly/proc/GenerateBellyReagents_digesting()	//The rate isnt based on selected reagent, due to the fact that the price of the reagent is already paid by nutrient not gained.
	if(reagents.total_volume + (digest_nutri_gain * gen_amount) <= custom_max_volume) //By default a reagent with an amount of 1 should result in pred getting 100 units from a full health prey
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] * digest_nutri_gain / gen_cost)
	else
		owner.adjust_nutrition((4.5 * digest_nutri_gain) * owner.get_digestion_efficiency_modifier())
		digest_nutri_gain = 0

/obj/belly/proc/GenerateBellyReagents_digested()
	if(reagents.total_volume <= custom_max_volume - 25 * gen_amount)
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] * 25)
	else
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] / gen_amount * (custom_max_volume - reagents.total_volume))

//////////////////////////// REAGENT_ABSORB ////////////////////////

/obj/belly/proc/GenerateBellyReagents_absorbing()
	if(reagents.total_volume <= custom_max_volume - 1.5 * gen_amount) //Going for 1.5 amount of reagent per cycle, can be adjusted in future if need adjustments
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] * 1.5)
	else
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] / gen_amount * (custom_max_volume - reagents.total_volume))

/obj/belly/proc/GenerateBellyReagents_absorbed()
	if(reagents.total_volume <= custom_max_volume - 25 * gen_amount) //Going for 25 amount of reagent for absorbing the prey, can be adjusted in future if need adjustments
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] * 10)
	else
		for(var/reagent in generated_reagents)
			reagents.add_reagent(reagent, generated_reagents[reagent] / gen_amount * (custom_max_volume - reagents.total_volume))

//////////////////////////// REAGENT_DRAIN ///////////////////////// //Currently not needed, maybe later a specific proc for drain needs to be made - Jack



//////////////////////////// REAGENT SELECTION /////////////////////

//This is gonna end up a long proc, but its gonna have to make do for now

/obj/belly/proc/ReagentSwitch()
	switch(reagent_chosen)
		if("Water")
			generated_reagents = list("water" = 1)
			reagent_name = "water"
			gen_amount = 1
			gen_cost = 1
			reagentid = "water"
			reagentcolor = "#0064C877"
		if("Milk")
			generated_reagents = list("milk" = 1)
			reagent_name = "milk"
			gen_amount = 1
			gen_cost = 5
			reagentid = "milk"
			reagentcolor = "#DFDFDF"
		if("Cream")
			generated_reagents = list("cream" = 1)
			reagent_name = "cream"
			gen_amount = 1
			gen_cost = 5
			reagentid = "cream"
			reagentcolor = "#DFD7AF"
		if("Honey")
			generated_reagents = list("honey" = 1)
			reagent_name = "honey"
			gen_amount = 1
			gen_cost = 10
			reagentid = "honey"
			reagentcolor = "#FFFF00"
		if("Cherry Jelly")	//Kinda WIP, allows slime like folks something to stuff others with, should make a generic jelly in future
			generated_reagents = list("cherryjelly" = 1)
			reagent_name = "cherry jelly"
			gen_amount = 1
			gen_cost = 10
			reagentid = "cherryjelly"
			reagentcolor = "#801E28"
		if("Digestive acid")
			generated_reagents = list("stomacid" = 1)
			reagent_name = "digestive acid"
			gen_amount = 1
			gen_cost = 1
			reagentid = "stomacid"
			reagentcolor = "#664330"
		if("Diluted digestive acid")
			generated_reagents = list("diet_stomacid" = 1)
			reagent_name = "diluted digestive acid"
			gen_amount = 1
			gen_cost = 1
			reagentid = "diet_stomacid"
			reagentcolor = "#664330"
		if("Space cleaner")
			generated_reagents = list("cleaner" = 1)
			reagent_name = "space cleaner"
			gen_amount = 1
			gen_cost = 10
			reagentid = "cleaner"
			reagentcolor = "#A5F0EE"
		if("Lube")
			generated_reagents = list("lube" = 1)
			reagent_name = "lube"
			gen_amount = 1
			gen_cost = 10
			reagentid = "lube"
			reagentcolor = "#009CA8"
		if("Biomass")
			generated_reagents = list("biomass" = 1)
			reagent_name = "biomass"
			gen_amount = 1
			gen_cost = 10
			reagentid = "biomass"
			reagentcolor = "#DF9FBF"

/////////////////////// FULLNESS MESSAGES //////////////////////

// Get the line that should show up in Examine message if the owner of this belly is examined.
// Returns a string which shoul be appended to the Examine output.
// Yes I know it doesnt look great with 5 almost identical procs in a row, I didnt have a better idea at the time - Jack
/obj/belly/proc/get_reagent_examine_msg1()
	if(fullness1_messages.len)
		var/formatted_message
		var/raw_message = pick(fullness1_messages)

		formatted_message = replacetext(raw_message,"%belly",lowertext(name))
		formatted_message = replacetext(formatted_message,"%pred",owner)

		return("<span class='warning'>[formatted_message]</span><BR>")

/obj/belly/proc/get_reagent_examine_msg2()
	if(fullness1_messages.len)
		var/formatted_message
		var/raw_message = pick(fullness2_messages)

		formatted_message = replacetext(raw_message,"%belly",lowertext(name))
		formatted_message = replacetext(formatted_message,"%pred",owner)

		return("<span class='warning'>[formatted_message]</span><BR>")

/obj/belly/proc/get_reagent_examine_msg3()
	if(fullness1_messages.len)
		var/formatted_message
		var/raw_message = pick(fullness3_messages)

		formatted_message = replacetext(raw_message,"%belly",lowertext(name))
		formatted_message = replacetext(formatted_message,"%pred",owner)

		return("<span class='warning'>[formatted_message]</span><BR>")

/obj/belly/proc/get_reagent_examine_msg4()
	if(fullness1_messages.len)
		var/formatted_message
		var/raw_message = pick(fullness4_messages)

		formatted_message = replacetext(raw_message,"%belly",lowertext(name))
		formatted_message = replacetext(formatted_message,"%pred",owner)

		return("<span class='warning'>[formatted_message]</span><BR>")

/obj/belly/proc/get_reagent_examine_msg5()
	if(fullness1_messages.len)
		var/formatted_message
		var/raw_message = pick(fullness5_messages)

		formatted_message = replacetext(raw_message,"%belly",lowertext(name))
		formatted_message = replacetext(formatted_message,"%pred",owner)

		return("<span class='warning'>[formatted_message]</span><BR>")


// The next function gets the messages set on the belly, in human-readable format.
// This is useful in customization boxes and such. The delimiter right now is \n\n so
// in message boxes, this looks nice and is easily delimited.
/obj/belly/proc/get_reagent_messages(var/type, var/delim = "\n\n")
	ASSERT(type == "full1" || type == "full2" || type == "full3" || type == "full4" || type == "full5")
	var/list/raw_messages

	switch(type)
		if("full1")
			raw_messages = fullness1_messages
		if("full2")
			raw_messages = fullness2_messages
		if("full3")
			raw_messages = fullness3_messages
		if("full4")
			raw_messages = fullness4_messages
		if("full5")
			raw_messages = fullness5_messages

	var/messages = raw_messages.Join(delim)
	return messages

// The next function sets the messages on the belly, from human-readable var
// replacement strings and linebreaks as delimiters (two \n\n by default).
// They also sanitize the messages.
/obj/belly/proc/set_reagent_messages(var/raw_text, var/type, var/delim = "\n\n")
	ASSERT(type == "full1" || type == "full2" || type == "full3" || type == "full4" || type == "full5")

	var/list/raw_list = splittext(html_encode(raw_text),delim)
	if(raw_list.len > 10)
		raw_list.Cut(11)
		log_debug("[owner] tried to set [lowertext(name)] with 11+ messages")

	for(var/i = 1, i <= raw_list.len, i++)
		if(length(raw_list[i]) > 160 || length(raw_list[i]) < 10) //160 is fudged value due to htmlencoding increasing the size
			raw_list.Cut(i,i)
			log_debug("[owner] tried to set [lowertext(name)] with >121 or <10 char message")
		else
			raw_list[i] = readd_quotes(raw_list[i])
			//Also fix % sign for var replacement
			raw_list[i] = replacetext(raw_list[i],"&#37;","%")

	ASSERT(raw_list.len <= 10) //Sanity

	switch(type)
		if("full1")
			fullness1_messages = raw_list
		if("full2")
			fullness2_messages = raw_list
		if("full3")
			fullness3_messages = raw_list
		if("full4")
			fullness4_messages = raw_list
		if("full5")
			fullness5_messages = raw_list

	return

/////////////////////////// Process Cycle Lite /////////////////////////// CHOMP PCL
/obj/belly/proc/quick_cycle() //For manual belly cycling without straining the bellies subsystem.
	HandleBellyReagents()	//CHOMP reagent belly stuff.
	// VERY early exit
	if(!contents.len)
		return

	var/to_update = FALSE //Did anything update worthy happen?

/////////////////////////// Exit Early //////////////////////////// CHOMP PCL
	var/list/touchable_atoms = contents - items_preserved
	if(!length(touchable_atoms))
		return

	var/datum/digest_mode/DM = GLOB.digest_modes["[digest_mode]"]
	if(!DM)
		log_debug("Digest mode [digest_mode] didn't exist in the digest_modes list!!")
		return FALSE
	if(DM.handle_atoms(src, touchable_atoms))
		updateVRPanels()
		return

	var/list/touchable_mobs = null

	var/list/hta_returns = handle_touchable_atoms(touchable_atoms)
	if(islist(hta_returns))
		if(hta_returns["touchable_mobs"])
			touchable_mobs = hta_returns["touchable_mobs"]
		if(hta_returns["to_update"])
			to_update = hta_returns["to_update"]

	if(!LAZYLEN(touchable_mobs))
		return

///////////////////// Time to actually process mobs ///////////////////// CHOMP PCL
	for(var/target in touchable_mobs)
		var/mob/living/L = target
		if(!istype(L))
			continue
		var/list/returns = DM.process_mob(src, target)
		if(istype(returns) && returns["to_update"])
			to_update = TRUE

	if(to_update)
		updateVRPanels()
/////////////////////////// CHOMP PCL END ///////////////////////////

/obj/belly/proc/update_internal_overlay()
	for(var/A in contents)
		if(isliving(A))
			vore_fx(A,1)

/obj/belly/deserialize(var/list/data)
	..()
	STOP_PROCESSING(SSbellies, src)
	STOP_PROCESSING(SSobj, src)
	if(speedy_mob_processing)
		START_PROCESSING(SSobj, src)
	else
		START_PROCESSING(SSbellies, src)
