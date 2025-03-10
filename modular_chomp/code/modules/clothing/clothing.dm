/obj/item/clothing
	var/update_icon_define_orig = null // temp storage for original update_icon_define (if it exists)
	var/update_icon_define_digi = null
	var/fit_for_digi = FALSE // flag for if clothing has already been reskinned to digitigrade

/obj/item/clothing/shoes
	update_icon_define_digi = "modular_chomp/icons/inventory/feet/mob_digi.dmi"

/obj/item/clothing/suit
	update_icon_define_digi = "modular_chomp/icons/inventory/suit/mob_digi.dmi"

/obj/item/clothing/under
	update_icon_define_digi = "modular_chomp/icons/inventory/uniform/mob_digi.dmi"

/obj/item/clothing/shoes/MouseDrop_T(mob/living/target, mob/living/user)
	if(!istype(user)) return ..() // If the user passed in isn't a living mob, exit
	if(target != user) return ..() // If the user didn't drag themselves, exit
	if(user.incapacitated() || user.buckled) return ..() // If user is incapacitated or buckled, exit
	if(get_holder_of_type(src, /mob/living/carbon/human) == user) return ..() // No jumping into your own equipment
	if(ishuman(user) && user.get_effective_size() > 0.25) return ..() // Only micro characters

	var/full = 0
	for(var/mob/M in src)
		if(istype(M,/mob/living/voice)) //Don't count voices as people!
			continue
		full++
	if(full >= 2)
		to_chat(user, "<span class='warning'>It doesn't seem like there is room in \the [src]!</span>")
	else
		to_chat(user, "<span class='warning'>You crawl into \the [src]!</span>")
		user.forceMove(src)

	return ..()


/obj/item/clothing/proc/handle_digitigrade(var/mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user

		// if digitigrade-use flag is set
		if(H.digitigrade)

			// figure out what slot we care about
			if(!update_icon_define_digi)
				return

			// Don't reset if already set
			if(!fit_for_digi)
				fit_for_digi = TRUE // set flag even if no icon_state exists, so we don't repeat checks

				//if update_icon_define is already set to something, place it in a var to hold it temporarily
				if(update_icon_define)
					update_icon_define_orig = update_icon_define

				// only override icon if a corresponding digitigrade replacement icon_state exists
				// otherwise, keep the old non-digi icon_define (or nothing)
				if(icon_state && icon_states(update_icon_define_digi).Find(icon_state))
					update_icon_define = update_icon_define_digi


		// if not-digitigrade, only act if the clothing was previously fit for a digitigrade char
		else
			if(fit_for_digi)
				fit_for_digi = FALSE

				//either reset update_icon_define to it's old value
				// or reset update_icon_define to null
				if(update_icon_define_orig)
					update_icon_define = update_icon_define_orig
					update_icon_define_orig = null
				else
					update_icon_define = null

/obj/item/clothing/shoes/equipped(var/mob/user, var/slot)
	. = ..()
	handle_digitigrade(user)

/obj/item/clothing/suit/equipped(var/mob/user, var/slot)
	. = ..()
	handle_digitigrade(user)

/obj/item/clothing/under/equipped(var/mob/user, var/slot)
	. = ..()
	handle_digitigrade(user)

//In shoe steppies!
/obj/item/clothing/shoes/proc/handle_inshoe_stepping(var/mob/living/carbon/human/pred, var/mob/living/carbon/human/prey)
	if(!istype(pred)) return //Sorry, inshoe steppies only for carbon/human/ for now. Based on the regular stepping mechanics
	if(!istype(prey)) return
	if(!pred.canmove || pred.buckled) return //We can't be stepping on anyone if buckled or incapable of moving
	if(pred in buckled_mobs) return
	if(pred.flying) return //If we're flying, can't really step.

	// I kept interactions very similar to normal steppies, and removed some attack logs unless harm intent:
	// I_HELP: No painful description, messages only sent to prey. Similar to inshoe steppies from before.
	// I_DISARM: Painful yet harmless descriptions, weaken on walk. Attack logs on weaken.
	// I_GRAB: Grabby/Squishing descriptions, weaken on walk. Attack logs on weaken.
	// I_HARM: Rand .5-1.5 multiplied by .25 min or 1.75 max, multiplied by 3.5 on walk. Ranges from .125 min to 9.1875 max damage to each limb
	var/message_pred = null
	var/message_prey = null

	switch(pred.a_intent)
		if(I_HELP)
			if(prob(40)) //Reducing spam exclusively on I_HELP. Still more frequent than old pitiful prob(1)
				if(pred.m_intent == "run")
					message_prey = pick(
						"You feel weightless for a brief moment as \the [name] move upwards.",
						"[pred]'s weight bears down on you with each of their steps.",
						"\The [name] are a ride you've got no choice but to participate in as the wearer moves.",
						"The wearer of \the [name] moves, and their feet press down on you with each step.",
						"With each step, you're sandwiched again between [pred]'s feet and the insole of their boots.",
						"As [pred] moves, their foot presses you tightly against the insole of their boots with each step.")
				else
					message_prey = pick(
						"You feel weightless for a brief moment as \the [name] move upwards.",
						"[pred]'s weight bears down on you with each of the calm steps of their walk.",
						"\The [name] are a ride you've got no choice but to participate in as the wearer walks.",
						"The wearer of \the [name] walks, and their feet press down on you heavily with each step.",
						"With each step of their unhurried walk, you're tightly sandwiched between [pred]'s feet and the insole of their boots.",
						"As [pred] walks, their foot presses you tightly against the insole of their boots with each step.")
				to_chat(prey, span_emote_subtle("<I>[message_prey]</I>"))

			return  //No message for pred if I_HELP

		if(I_DISARM)
			if(pred.m_intent == "run")
				message_pred = "You step on [prey], squishing and pinning them within your [name]!"
				message_prey = "[pred] steps on you, squishing and pinning you within their [name]!"
			else
				message_pred = "You firmly push your foot down on [prey], painfully but harmlessly pinning them to the sole of your [name]!"
				message_prey = "[pred] firmly pushes their foot down on you, painfully but harmlessly pinning you to the sole of their [name]!"
				prey.Weaken(5) // For flavour, only noticed prey if tossed out of shoe
				add_attack_logs(pred, prey, "Pinned inshoe (walk, weaken(5))")

		if(I_GRAB)
			if(pred.m_intent == "run")
				message_pred = "You step down onto [prey], squishing and trapping them inbetween your toes!"
				message_prey = "[pred] steps down on you, squishing and trapping you inbetween their toes!"
			else
				message_pred = "You pin [prey] down against the sole of your [name] with your foot, your toes curling up around their body, tightly trapping them inbetween them!"
				message_prey = "[pred] pins you down against the sole of their [name] with their foot, their toes curling up around your body, tighly trapping you inbetween them!"
				prey.Weaken(5) // For flavour, only noticed prey if tossed out of shoe
				add_attack_logs(pred, prey, "Grabbed inshoe (walk, weaken(5))")

		if(I_HURT)
			var/size_damage_multiplier = pred.size_multiplier - prey.size_multiplier

			if(size_damage_multiplier < 0) // In case of odd situations such as wearing a shoe containing someone bigger than you.
				size_damage_multiplier = 0

			//Assuming regular micro pickup sizes outside dorms, size_damage multiplier should range from .25 to 1.75... right?
			var/damage = (rand(5, 15) * size_damage_multiplier) / 10 // This will sting, but not kill unless pred walks. Will range from .125 to 2.625 damage, randomly, to each limb

			if(pred.m_intent == "run")
				message_pred = "You carelessly step down onto [prey], crushing them within your [name]!"
				message_prey = "[pred] steps carelessly on your body, crushing you within their [name]!"
				add_attack_logs(pred, prey, "Crushed underfoot (run, about [damage] damage per limb)")
			else
				message_pred = "You methodically place your foot down upon [prey]'s body, applying pressure, crushing them against the sole of your [name]!"
				message_prey = "[pred] methodically places their foot upon your body, applying pressure, crushing you against the sole of their [name]!"
				damage *= 3.5 //Walking damage multiplier
				add_attack_logs(pred, prey, "Crushed underfoot (walk, about [damage] damage per limb)")

			for(var/obj/item/organ/external/I in prey.organs)
				// Running Total: 1.50 damage min, 28.875 damage max, depending on size & RNG.
				// Walking Total: 5.25 damage min, 101.0625 damage max, depending on size & RNG. Ouch.
				I.take_damage(damage, 0)

	if(message_pred != null)
		to_chat(pred, span_warning(message_pred))
	to_chat(prey, span_warning(message_prey))

	return
