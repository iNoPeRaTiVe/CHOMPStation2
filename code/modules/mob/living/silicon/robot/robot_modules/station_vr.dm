/obj/item/weapon/robot_module
	languages = list(LANGUAGE_SOL_COMMON= 1,
					LANGUAGE_TRADEBAND	= 1,
					LANGUAGE_UNATHI		= 0,
					LANGUAGE_SIIK		= 0,
					LANGUAGE_SKRELLIAN	= 0,
					LANGUAGE_GUTTER		= 0,
					LANGUAGE_SCHECHI	= 0,
					LANGUAGE_SIGN		= 0,
					LANGUAGE_BIRDSONG	= 0,
					LANGUAGE_SAGARU		= 0,
					LANGUAGE_CANILUNZT	= 0,
					LANGUAGE_ECUREUILIAN= 0,
					LANGUAGE_DAEMON		= 0,
					LANGUAGE_ENOCHIAN	= 0,
					LANGUAGE_DRUDAKAR	= 0 //CHOMPedit
					)
	var/vr_sprites = list()
	var/pto_type = null

/obj/item/weapon/robot_module/robot/clerical
	languages = list(
					LANGUAGE_SOL_COMMON	= 1,
					LANGUAGE_TRADEBAND	= 1,
					LANGUAGE_UNATHI		= 1,
					LANGUAGE_SIIK		= 1,
					LANGUAGE_SKRELLIAN	= 1,
					LANGUAGE_ROOTLOCAL	= 0,
					LANGUAGE_GUTTER		= 0,
					LANGUAGE_SCHECHI	= 1,
					LANGUAGE_EAL		= 1,
					LANGUAGE_SIGN		= 0,
					LANGUAGE_BIRDSONG	= 1,
					LANGUAGE_SAGARU		= 1,
					LANGUAGE_CANILUNZT	= 1,
					LANGUAGE_ECUREUILIAN= 1,
					LANGUAGE_DAEMON		= 1,
					LANGUAGE_ENOCHIAN	= 1,
					LANGUAGE_DRUDAKAR	= 1,
					LANGUAGE_TAVAN		= 1
					)

/hook/startup/proc/robot_modules_vr()
	robot_modules["Medihound"] = /obj/item/weapon/robot_module/robot/medical/medihound
	robot_modules["K9"] = /obj/item/weapon/robot_module/robot/security/knine
	robot_modules["ERT"] = /obj/item/weapon/robot_module/robot/security/ert
	robot_modules["Janihound"] = /obj/item/weapon/robot_module/robot/janitor/scrubpup
	robot_modules["Sci-borg"] = /obj/item/weapon/robot_module/robot/research/sciencehound
	robot_modules["Pupdozer"] = /obj/item/weapon/robot_module/robot/engineering/engiedog
	robot_modules["Service-Hound"] = /obj/item/weapon/robot_module/robot/clerical/butler/brodog
	robot_modules["BoozeHound"] = /obj/item/weapon/robot_module/robot/clerical/butler/booze
	robot_modules["KMine"] = /obj/item/weapon/robot_module/robot/miner/kmine
	robot_modules["Stray"] = /obj/item/weapon/robot_module/robot/stray
	robot_modules["TraumaHound"] = /obj/item/weapon/robot_module/robot/medical/traumahound
	return 1

//Just add a new proc with the robot_module type if you wish to run some other vore code
/obj/item/weapon/robot_module/proc/vr_new() // Any Global modules, just add them before the return (This will also affect all the borgs in this file)
	return

/obj/item/weapon/robot_module/proc/vr_add_sprites() // Adds sprites from this file into list of avialible ones for global modules
	sprites += vr_sprites
	return

/obj/item/weapon/robot_module/robot/medical/surgeon/vr_new() //Surgeon Bot
	src.modules += new /obj/item/device/sleevemate(src) //Lets them scan people.
	. = ..() //Any Global vore modules will come from here

/obj/item/weapon/robot_module/robot/medical/crisis/vr_new() //Crisis Bot
	src.modules += new /obj/item/device/sleevemate(src) //Lets them scan people.
	. = ..() //Any Global vore modules will come from here

/obj/item/weapon/robot_module/robot/medical
	pto_type = PTO_MEDICAL

/obj/item/weapon/robot_module/robot/medical/surgeon
	vr_sprites = list(
						"Acheron" = "mechoid-Medical",
						"Shellguard Noble" = "Noble-MED",
						"ZOOM-BA" = "zoomba-medical",
						"W02M" = "worm-surgeon",
						"Feminine Humanoid" = "uptall-medical"
					 )

/obj/item/weapon/robot_module/robot/medical/crisis
	vr_sprites = list(
						"Handy" = "handy-med",
						"Acheron" = "mechoid-Medical",
						"Shellguard Noble" = "Noble-MED",
						"ZOOM-BA" = "zoomba-crisis",
						"W02M" = "worm-crisis",
						"Feminine Humanoid" = "uptall-crisis"
					 )

/obj/item/weapon/robot_module/robot/clerical
	pto_type = PTO_CIVILIAN

/obj/item/weapon/robot_module/robot/clerical/butler/general
	vr_sprites = list(
						"Handy - Service" = "handy-service",
						"Handy - Hydro" = "handy-hydro",
						"Acheron" = "mechoid-Service",
						"Shellguard Noble" = "Noble-SRV",
						"ZOOM-BA" = "zoomba-service",
						"W02M" = "worm-service",
						"Feminine Humanoid" = "uptall-service"
					 )

/obj/item/weapon/robot_module/robot/clerical/general
	vr_sprites = list(
						"Handy" = "handy-clerk",
						"Acheron" = "mechoid-Service",
						"Shellguard Noble" = "Noble-SRV",
						"ZOOM-BA" = "zoomba-clerical",
						"W02M" = "worm-service",
						"Feminine Humanoid" = "uptall-service"
					 )

/obj/item/weapon/robot_module/robot/janitor
	pto_type = PTO_CIVILIAN

/obj/item/weapon/robot_module/robot/janitor/general
	vr_sprites = list(
						"Handy" = "handy-janitor",
						"Acheron" = "mechoid-Janitor",
						"Shellguard Noble" = "Noble-CLN",
						"ZOOM-BA" = "zoomba-janitor",
						"W02M" = "worm-janitor",
						"Feminine Humanoid" = "uptall-janitor"
					 )

/obj/item/weapon/robot_module/robot/security
	pto_type = PTO_SECURITY

/obj/item/weapon/robot_module/robot/security/general
	vr_sprites = list(
						"Handy" = "handy-sec",
						"Acheron" = "mechoid-Security",
						"Shellguard Noble" = "Noble-SEC",
						"ZOOM-BA" = "zoomba-security",
						"W02M" = "worm-security",
						"Feminine Humanoid" = "uptall-security"
					 )

/obj/item/weapon/robot_module/robot/security/combat
	vr_sprites = list(
						"Acheron" = "mechoid-Combat",
						"ZOOM-BA" = "zoomba-combat",
						"W02M" = "worm-combat",
						"Feminine Humanoid" = "uptall-security"
					 )

/obj/item/weapon/robot_module/robot/miner
	pto_type = PTO_CARGO

/obj/item/weapon/robot_module/robot/miner/general
	vr_sprites = list(
						"Handy" = "handy-miner",
						"Acheron" = "mechoid-Miner",
						"Shellguard Noble" = "Noble-DIG",
						"ZOOM-BA" = "zoomba-miner",
						"W02M" = "worm-miner",
						"Feminine Humanoid" = "uptall-miner"
					 )

/obj/item/weapon/robot_module/robot/standard
	pto_type = PTO_CIVILIAN
	vr_sprites = list(
						"Handy" = "handy-standard",
						"Acheron" = "mechoid-Standard",
						"Shellguard Noble" = "Noble-STD",
						"ZOOM-BA" = "zoomba-standard",
						"W02M" = "worm-standard",
						"Feminine Humanoid" = "uptall-standard",
						"Feminine Humanoid, Variant 2" = "uptall-standard2"
					 )

/obj/item/weapon/robot_module/robot/engineering
	pto_type = PTO_ENGINEERING

/obj/item/weapon/robot_module/robot/engineering/general
	vr_sprites = list(
						"Acheron" = "mechoid-Engineering",
						"Shellguard Noble" = "Noble-ENG",
						"ZOOM-BA" = "zoomba-engineering",
						"W02M" = "worm-engineering",
						"Feminine Humanoid" = "uptall-engineering"
					 )

/obj/item/weapon/robot_module/robot/research
	pto_type = PTO_SCIENCE

/obj/item/weapon/robot_module/robot/research/general
	vr_sprites = list(
						"Acheron" = "mechoid-Science",
						"ZOOM-BA" = "zoomba-research",
						"XI-GUS" = "spiderscience",
						"W02M" = "worm-janitor",
						"Feminine Humanoid" = "uptall-science"
					 )

/obj/item/weapon/robot_module/robot/security/knine
	name = "k9 robot module"
	sprites = list(
					"K9 hound" = "k9",
					"K9 Alternative" = "k92",
					"Secborg model V-2" = "secborg",
					"Borgi" = "borgi-sec",
					"Otieborg" = "oties",
					"Secborg model V-3" = "SecVale", //CHOMPEdit
					"Cat" = "vixsec", //CHOMPEdit
					"Drake" = "drakesec",
					"Raptor V-4" = "secraptor"
					)

/obj/item/weapon/robot_module/robot/security/knine/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/weapon/handcuffs/cyborg(src) //You need cuffs to be a proper sec borg!
	src.modules += new /obj/item/weapon/dogborg/jaws/big(src) //In case there's some kind of hostile mob.
	src.modules += new /obj/item/weapon/melee/baton/robot(src) //Since the pounce module refused to work, they get a stunbaton instead.
	src.modules += new /obj/item/device/dogborg/boop_module(src) //Boop people on the nose.
	src.modules += new /obj/item/taperoll/police(src) //Block out crime scenes.
	src.modules += new /obj/item/weapon/gun/energy/taser/mounted/cyborg(src) //They /are/ a security borg, after all.
	src.modules += new /obj/item/weapon/dogborg/pounce(src) //Pounce
	src.modules += new /obj/item/device/ticket_printer(src)
	src.emag 	 = new /obj/item/weapon/gun/energy/laser/mounted(src) //Emag. Not a big problem.

	var/datum/matter_synth/water = new /datum/matter_synth(500) //Starts full and has a max of 500
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	R.water_res = water
	synths += water

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/dogborg/sleeper/K9/B = new /obj/item/device/dogborg/sleeper/K9(src) //Eat criminals. Bring them to the brig.
	B.water = water
	src.modules += B

	R.icon 		 = 'icons/mob/widerobot_sec_vr.dmi'
	R.wideborg_dept = 'icons/mob/widerobot_sec_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/security/knine/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/device/flash/F = locate() in src.modules
	if(F.broken)
		F.broken = 0
		F.times_used = 0
		F.icon_state = "flash"
	else if(F.times_used)
		F.times_used--
	var/obj/item/weapon/gun/energy/taser/mounted/cyborg/T = locate() in src.modules
	if(T.power_supply.charge < T.power_supply.maxcharge)
		T.power_supply.give(T.charge_cost * amount)
		T.update_icon()
	else
		T.charge_tick = 0
	/*var/obj/item/weapon/melee/baton/robot/B = locate() in src.modules //Borg baton uses borg cell.
	if(B && B.bcell)
		B.bcell.give(amount)*/


/obj/item/weapon/robot_module/robot/medical/medihound
	name = "MediHound module"
	sprites = list(
					"Medical Hound" = "medihound",
					"Dark Medical Hound (Static)" = "medihounddark",
					"Mediborg model V-2" = "vale",
					"Borgi" = "borgi-medi",
					"Mediborg model V-3" = "vale2", //CHOMPEdit
					"Cat" = "vixmed", //CHOMPEdit
					"Drake" = "drakemed",
					"Raptor V-4" = "medraptor"
					)

/obj/item/weapon/robot_module/robot/medical/medihound/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src) //In case a patient is being attacked by carp.
	src.modules += new /obj/item/device/dogborg/boop_module(src) //Boop the crew.
	src.modules += new /obj/item/device/healthanalyzer(src) // See who's hurt specificially.
	src.modules += new /obj/item/borg/sight/hud/med(src) //See who's hurt generally.
	src.modules += new /obj/item/weapon/reagent_containers/syringe(src) //In case the chemist is nice!
	src.modules += new /obj/item/weapon/reagent_containers/glass/beaker/large(src)//For holding the chemicals when the chemist is nice, made it the large variant in 2022
	src.modules += new /obj/item/device/sleevemate(src) //Lets them scan people.
	src.modules += new /obj/item/weapon/shockpaddles/robot/hound(src) //Paws of life
	src.modules += new /obj/item/weapon/inflatable_dispenser/robot(src) //This is kinda important for rescuing people without making it worse for everyone
	src.modules += new /obj/item/weapon/gripper/medical(src) //Let them do literally anything in medbay other than patch external damage and lick people
	src.modules += new /obj/item/weapon/reagent_containers/dropper/industrial(src) //dropper is nice to have for so much actually
	src.emag 	 = new /obj/item/weapon/dogborg/pounce(src) //Pounce
	src.modules += new /obj/item/weapon/gripper/medical(src)//Now you can set up cyro or make peri. //CHOMPEdit

	var/datum/matter_synth/medicine = new /datum/matter_synth/medicine(15000)  //CHOMPedit
	synths += medicine

	var/obj/item/stack/medical/advanced/clotting/C = new (src)
	var/obj/item/stack/medical/splint/S = new /obj/item/stack/medical/splint(src)
	C.uses_charge = 1
	C.charge_costs = list(5000)
	C.synths = list(medicine)
	S.uses_charge = 1
	S.charge_costs = list(1000)
	S.synths = list(medicine)
	src.modules += C
	src.modules += S

	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	water.max_energy = 1000  //CHOMPedit increased water storage from 500 to 1000
	R.water_res = water
	synths += water

	var/obj/item/weapon/reagent_containers/borghypo/hound/H = new /obj/item/weapon/reagent_containers/borghypo/hound(src)
	H.water = water
	src.modules += H

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/dogborg/sleeper/B = new /obj/item/device/dogborg/sleeper(src) //So they can nom people and heal them
	B.water = water
	src.modules += B

	//CHOMPEdit Start - Give back the ATK/ABP since we don't have the surgeryhound
	var/obj/item/stack/medical/advanced/ointment/O = new /obj/item/stack/medical/advanced/ointment(src)
	var/obj/item/stack/medical/advanced/bruise_pack/P = new /obj/item/stack/medical/advanced/bruise_pack(src)
	O.uses_charge = 1
	O.charge_costs = list(1000)
	O.synths = list(medicine)
	P.uses_charge = 1
	P.charge_costs = list(1000)
	P.synths = list(medicine)
	src.modules += O
	src.modules += P
	//CHOMPEdit End

	R.icon = 'icons/mob/widerobot_vr.dmi'

	src.modules += new /obj/item/weapon/dogborg/pounce(src) //CHOMPEdit - Switch to the more balanced pounce module
	R.icon = 'icons/mob/widerobot_med_vr.dmi'
	R.wideborg_dept = 'icons/mob/widerobot_med_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x  	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/medical/traumahound
	name = "traumahound robot module"
	sprites = list(
					"Traumahound" = "traumavale",
					"Drake" = "draketrauma",
					"Borgi" = "borgi-trauma",
					"Raptor V-4" = "traumaraptor"
					)

/obj/item/weapon/robot_module/robot/medical/traumahound/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/healthanalyzer(src)
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/device/dogborg/boop_module(src)
	src.modules += new /obj/item/weapon/autopsy_scanner(src)
	src.modules += new /obj/item/weapon/surgical/scalpel/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/hemostat/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/retractor/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/cautery/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/bonegel/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/FixOVein/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/bonesetter/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/circular_saw/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/surgicaldrill/cyborg(src)
	src.modules += new /obj/item/weapon/surgical/bioregen/cyborg(src) //let them succ
	src.modules += new /obj/item/weapon/gripper/no_use/organ(src)
	src.modules += new /obj/item/weapon/gripper/medical(src)
	src.modules += new /obj/item/weapon/shockpaddles/robot/hound(src) //Paws of life
	src.modules += new /obj/item/weapon/reagent_containers/dropper(src) // Allows surgeon borg to fix necrosis
	src.modules += new /obj/item/weapon/reagent_containers/syringe(src)
	src.emag 	= new /obj/item/weapon/dogborg/pounce(src) //Pounce, also, lets not give them polyacid spray

	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 0
	R.water_res = water
	synths += water

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/weapon/reagent_containers/borghypo/hound/trauma/H = new /obj/item/weapon/reagent_containers/borghypo/hound/trauma(src) //surgeon chems
	H.water = water
	src.modules += H

	var/obj/item/device/dogborg/sleeper/compactor/trauma/B = new /obj/item/device/dogborg/sleeper/compactor/trauma(src) //So they can nom people and heal them
	B.water = water
	src.modules += B

	var/datum/matter_synth/medicine = new /datum/matter_synth/medicine(10000) //this is so they can do brute/burn surgeries and fix assisted/prosthetic organs
	synths += medicine

	var/obj/item/stack/nanopaste/N = new /obj/item/stack/nanopaste(src)
	var/obj/item/stack/medical/advanced/bruise_pack/S = new /obj/item/stack/medical/advanced/bruise_pack(src)
	var/obj/item/stack/medical/advanced/ointment/O = new /obj/item/stack/medical/advanced/ointment(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(medicine)
	S.uses_charge = 1
	S.charge_costs = list(1000)
	S.synths = list(medicine)
	O.uses_charge = 1
	O.charge_costs = list(1000)
	O.synths = list(medicine)
	src.modules += N
	src.modules += S
	src.modules += O

	R.icon = 'icons/mob/widerobot_trauma_vr.dmi'
	R.wideborg_dept = 'icons/mob/widerobot_trauma_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x  	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/security/ert
	name = "Emergency Responce module"
	sprites = list(
					"Standard" = "ert",
					"Classic" = "ertold",
					"Borgi" = "borgi"
					)

/obj/item/weapon/robot_module/robot/security/ert/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/weapon/handcuffs/cyborg(src)
	src.modules += new /obj/item/weapon/dogborg/jaws/ert(src)
	src.modules += new /obj/item/taperoll/police(src)
	src.modules += new /obj/item/weapon/gun/energy/taser/mounted/cyborg/ertgun(src)
	src.modules += new /obj/item/weapon/dogborg/swordtail(src)
	src.modules += new /obj/item/weapon/tool/crowbar(src)
	src.modules += new /obj/item/weapon/dogborg/pounce(src) //CHOMPEdit - Switch to the more balanced pounce module
	src.emag     = new /obj/item/weapon/gun/energy/laser/mounted(src)

	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	R.water_res = water
	synths += water

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/dogborg/sleeper/K9/B = new /obj/item/device/dogborg/sleeper/K9/ert(src)
	B.water = water
	src.modules += B

	R.icon 		 = 'icons/mob/widerobot_ert_vr.dmi'
	R.wideborg_dept = 'icons/mob/widerobot_ert_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/janitor/scrubpup
	name = "Custodial Hound module"
	sprites = list(
					"Custodial Hound" = "scrubpup",
					"Janihound model V-2" = "J9",
					"Borgi" = "borgi-jani",
					"Otieborg" = "otiej",
					"Cat" = "vixjani", //CHOMPEdit
					"Drake" = "drakejanit",
					"Raptor V-4" = "janiraptor"
					)
	can_be_pushed = 0

/obj/item/weapon/robot_module/robot/janitor/scrubpup/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/device/dogborg/boop_module(src)
	src.modules += new /obj/item/pupscrubber(src)
	src.modules += new /obj/item/device/vac_attachment(src) //CHOMPAdd
	src.emag 	 = new /obj/item/weapon/dogborg/pounce(src) //Pounce

	//Starts empty. Can only recharge with recycled material.
	var/datum/matter_synth/metal = new /datum/matter_synth/metal()
	metal.name = "Steel reserves"
	metal.recharge_rate = 0
	metal.max_energy = 50000
	metal.energy = 0
	var/datum/matter_synth/glass = new /datum/matter_synth/glass()
	glass.name = "Glass reserves"
	glass.recharge_rate = 0
	glass.max_energy = 50000
	glass.energy = 0
	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 0
	R.water_res = water

	synths += metal
	synths += glass
	synths += water

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/lightreplacer/dogborg/LR = new /obj/item/device/lightreplacer/dogborg(src)
	LR.glass = glass
	src.modules += LR

	var/obj/item/device/dogborg/sleeper/compactor/C = new /obj/item/device/dogborg/sleeper/compactor(src)
	C.metal = metal
	C.glass = glass
	C.water = water
	src.modules += C

	//Sheet refiners can only produce raw sheets.
	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.name = "steel recycler"
	M.desc = "A device that refines recycled steel into sheets."
	M.synths = list(metal)
	M.recipes = list()
	M.recipes += new/datum/stack_recipe("steel sheet", /obj/item/stack/material/steel, 1, 1, 20)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.name = "glass recycler"
	G.desc = "A device that refines recycled glass into sheets."
	G.material = get_material_by_name("placeholder") //Hacky shit but we want sheets, not windows.
	G.synths = list(glass)
	G.recipes = list()
	G.recipes += new/datum/stack_recipe("glass sheet", /obj/item/stack/material/glass, 1, 1, 20)
	src.modules += G

	R.icon 		 = 'icons/mob/widerobot_jan_vr.dmi'
	R.wideborg_dept  = 'icons/mob/widerobot_jan_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/research/sciencehound
	name = "Research Hound Module"
	sprites = list(
					"Research Hound" = "science",
					"Borgi" = "borgi-sci",
					"SciHound" = "scihound",
					"SciHoundDark" = "scihounddark",
					"Cat" = "vixsci", //CHOMPEdit
					"Drake" = "drakesci",
					"Raptor V-4" = "sciraptor"
					)
	can_be_pushed = 0

/obj/item/weapon/robot_module/robot/research/sciencehound/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/device/dogborg/boop_module(src)
	src.modules += new /obj/item/weapon/gripper/research(src)
	src.modules += new /obj/item/weapon/gripper/no_use/loader(src)
	src.modules += new /obj/item/weapon/tool/screwdriver/cyborg(src)
	src.modules += new /obj/item/weapon/weldingtool/electric/mounted/cyborg(src)
	src.modules += new /obj/item/weapon/tool/wrench/cyborg(src)
	src.modules += new /obj/item/weapon/tool/wirecutters/cyborg(src)
	src.modules += new /obj/item/device/multitool(src)
	src.modules += new /obj/item/weapon/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/weapon/storage/part_replacer(src)
	src.modules += new /obj/item/device/robotanalyzer(src)
	src.modules += new /obj/item/weapon/card/robot(src)
	//Added a circuit gripper
	src.modules += new /obj/item/weapon/gripper/circuit(src)
	src.modules += new /obj/item/weapon/gripper/no_use/organ/robotics(src)
	//src.modules += new /obj/item/weapon/surgical/scalpel/cyborg(src) //these are on the normal one, but do not appear to have a purpose other than borging
	//src.modules += new /obj/item/weapon/surgical/circular_saw/cyborg(src) //so I am leaving them here but commented out because robotics no do the borging w/o medical
	src.modules += new /obj/item/weapon/portable_destructive_analyzer(src) //destructive analyzer option for pref respect while also being able to do job
	src.modules += new /obj/item/weapon/gripper/no_use/mech(src)
	src.modules += new /obj/item/weapon/shockpaddles/robot/jumper(src) //unkilling synths may be important actually
	src.modules += new /obj/item/weapon/melee/baton/slime/robot(src) //save the xenobio from themselves
	src.modules += new /obj/item/weapon/gun/energy/taser/xeno/robot(src) //save the xenobio from themselves from a distance
	src.modules += new /obj/item/device/xenoarch_multi_tool(src) //go find fancy rock
	src.modules += new /obj/item/weapon/pickaxe/excavationdrill(src) //go get fancy rock
	src.emag = new /obj/item/weapon/hand_tele(src)

	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	R.water_res = water
	synths += water

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/dogborg/sleeper/compactor/analyzer/B = new /obj/item/device/dogborg/sleeper/compactor/analyzer(src)
	B.water = water
	src.modules += B

	var/datum/matter_synth/nanite = new /datum/matter_synth/nanite(10000)
	synths += nanite
	var/datum/matter_synth/wire = new /datum/matter_synth/wire()
	synths += wire

	var/obj/item/stack/nanopaste/N = new /obj/item/stack/nanopaste(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(nanite)
	src.modules += N

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	R.icon 		 = 'icons/mob/widerobot_sci_vr.dmi'
	R.wideborg_dept  = 'icons/mob/widerobot_sci_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/engineering/engiedog
	name = "Construction Hound module"
	sprites = list(
					"Pupdozer" = "pupdozer",
					"Borgi" = "borgi-eng",
					"V2 Engidog" = "thottbot",
					"EngiHound" = "engihound",
					"EngiHoundDark" = "engihounddark",
					"Cat" = "vixengi", //CHOMPEdit
					"Drake" = "drakeeng",
					"Raptor V-4" = "engiraptor"
					)
	can_be_pushed = 0

/obj/item/weapon/robot_module/robot/engineering/engiedog/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/borg/sight/meson(src)
	src.modules += new /obj/item/weapon/weldingtool/electric/mounted/cyborg(src)
	src.modules += new /obj/item/weapon/tool/screwdriver/cyborg(src)
	src.modules += new /obj/item/weapon/tool/wrench/cyborg(src)
	src.modules += new /obj/item/weapon/tool/wirecutters/cyborg(src)
	src.modules += new /obj/item/device/multitool(src)
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/device/analyzer(src)
	src.modules += new /obj/item/device/geiger(src)
	src.modules += new /obj/item/taperoll/engineering(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser/robot(src)
	src.modules += new /obj/item/weapon/gripper/no_use/loader(src)
	src.modules += new /obj/item/weapon/pickaxe(src)
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/device/dogborg/boop_module(src)
	src.modules += new /obj/item/weapon/gripper(src)
	src.modules += new /obj/item/weapon/gripper/circuit(src)
	// The RPD does the exact same thing, this just take space.
	//src.modules += new /obj/item/device/pipe_painter(src)
	src.modules += new /obj/item/device/floor_painter(src)
	src.modules += new /obj/item/weapon/rms(src)
	src.modules += new /obj/item/weapon/rcd/electric/mounted/borg(src)  //CHOMPedit: add RCD
	src.modules |= new /obj/item/weapon/pipe_dispenser(src) //CHOMPEDIT: only add one if our core didnt already
	src.emag 	 = new /obj/item/weapon/dogborg/pounce(src)
	//src.modules += new /obj/item/weapon/pipe_dispenser(src) //YW change //CHOMPREMOVE: duplicate definition

	//Painfully slow charger regen but high capacity. Also starts with low amount.
	var/datum/matter_synth/metal = new /datum/matter_synth/metal()
	metal.name = "Steel reserves"
	metal.recharge_rate = 1000  //CHOMPedit Make less slow
	metal.max_energy = 50000
	metal.energy = 40000  //CHOMPedit Make less awful
	var/datum/matter_synth/glass = new /datum/matter_synth/glass()
	glass.name = "Glass reserves"
	glass.recharge_rate = 1000  //CHOMPedit Make less slow
	glass.max_energy = 50000
	glass.energy = 40000  //CHOMPedit Make less awful
	var/datum/matter_synth/wood = new /datum/matter_synth/wood()
	wood.name = "Wood reserves"
	wood.recharge_rate = 1000  //CHOMPedit Make less slow
	wood.max_energy = 50000
	wood.energy = 40000  //CHOMPedit Make less awful
	var/datum/matter_synth/plastic = new /datum/matter_synth/plastic()
	plastic.name = "Plastic reserves"
	plastic.recharge_rate = 1000  //CHOMPedit Make less slow
	plastic.max_energy = 50000
	plastic.energy = 40000  //CHOMPedit Make less awful
	var/datum/matter_synth/plasteel = new /datum/matter_synth/plasteel()
	plasteel.name = "Plasteel reserves"// Adding plasteel synthesizer to move in-line with Engiborg.
	plasteel.recharge_rate = 1000  //CHOMPedit Make less slow
	plasteel.max_energy = 20000
	plasteel.energy = 40000  //CHOMPedit Make less awful
	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	R.water_res = water

	var/datum/matter_synth/wire = new /datum/matter_synth/wire()
	synths += metal
	synths += glass
	synths += wood
	synths += plastic
	synths += wire
	synths += water
	synths += plasteel

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/lightreplacer/dogborg/LR = new /obj/item/device/lightreplacer/dogborg(src)
	LR.glass = glass
	src.modules += LR

	var/obj/item/device/dogborg/sleeper/compactor/decompiler/MD = new /obj/item/device/dogborg/sleeper/compactor/decompiler(src)
	MD.metal = metal
	MD.glass = glass
	MD.wood = wood
	MD.plastic = plastic
	MD.water = water
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/RD = new /obj/item/stack/rods/cyborg(src)
	RD.synths = list(metal)
	src.modules += RD

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/floor/cyborg/S = new /obj/item/stack/tile/floor/cyborg(src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/tile/wood/cyborg/WT = new /obj/item/stack/tile/wood/cyborg(src)
	WT.synths = list(wood)
	src.modules += WT

	var/obj/item/stack/material/cyborg/wood/W = new (src)
	W.synths = list(wood)
	src.modules += W

	var/obj/item/stack/material/cyborg/plastic/PL = new (src)
	PL.synths = list(plastic)
	src.modules += PL
	//YW changes start, plasteel manipulator
	var/obj/item/stack/material/cyborg/plasteel/PS = new (src)
	PS.synths = list(plasteel)
	src.modules += PS
	//YW changes end, plasteel manipulator
	R.icon 		 = 'icons/mob/widerobot_vr.dmi'

	R.icon 		 = 'icons/mob/widerobot_eng_vr.dmi'
	R.wideborg_dept  = 'icons/mob/widerobot_eng_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

// Uses modified K9 sprites.
/obj/item/weapon/robot_module/robot/clerical/butler/brodog
	name = "service-hound module"
	sprites = list(
					"Blackhound" = "k50",
					"Pinkhound" = "k69",
					"ServicehoundV2" = "serve2",
					"ServicehoundV2 Darkmode" = "servedark",
					"Cat" = "vixserv", //CHOMPEdit
					"Drake" = "drakemine",
					"Raptor V-4" = "serviraptor",
					"Raptor V-4000" = "fancyraptor"
					)
	can_be_pushed = 0


// In a nutshell, basicly service/butler robot but in dog form. - Port from CitadelRP
/obj/item/weapon/robot_module/robot/clerical/butler/brodog/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/weapon/gripper/service(src)
	src.modules += new /obj/item/weapon/reagent_containers/glass/bucket(src)
	src.modules += new /obj/item/weapon/material/minihoe(src)
	src.modules += new /obj/item/weapon/material/knife/machete/hatchet(src)
	src.modules += new /obj/item/device/analyzer/plant_analyzer(src)
	src.modules += new /obj/item/weapon/storage/bag/dogborg(src)
	src.modules += new /obj/item/weapon/robot_harvester(src)
	src.modules += new /obj/item/weapon/material/knife(src)
	src.modules += new /obj/item/weapon/material/kitchen/rollingpin(src)
	src.modules += new /obj/item/device/multitool(src) //to freeze trays
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/device/dogborg/boop_module(src)
	src.emag 	 = new /obj/item/weapon/dogborg/pounce(src) //Pounce

	var/datum/matter_synth/water = new /datum/matter_synth(500) // buffy fix, was 0
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	water.max_energy = 1000
	R.water_res = water
	synths += water


	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/weapon/rsf/M = new /obj/item/weapon/rsf(src)
	M.stored_matter = 30
	src.modules += M

	src.modules += new /obj/item/weapon/reagent_containers/dropper/industrial(src)

	var/obj/item/weapon/flame/lighter/zippo/L = new /obj/item/weapon/flame/lighter/zippo(src)
	L.lit = 1
	src.modules += L

	src.modules += new /obj/item/weapon/tray/robotray(src)
	src.modules += new /obj/item/weapon/reagent_containers/borghypo/service(src)

/* // I don't know what kind of sleeper to put here, but also no need if you already have "Robot Nom" verb. - revisit later
	var/obj/item/device/dogborg/sleeper/K9/B = new /obj/item/device/dogborg/sleeper/K9(src)
	B.water = water
	src.modules += B
*/

	R.icon 		 = 'icons/mob/widerobot_ser_vr.dmi'
	R.wideborg_dept  = 'icons/mob/widerobot_ser_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/miner/kmine
	name = "Supply Hound Module"
	sprites = list(
					"KMine" = "kmine",
					"CargoHound" = "cargohound",
					"CargoHoundDark" = "cargohounddark",
					"Borgi" = "borgi-mine", //CHOMPEdit
					"Cat Mining" = "vixmine", //CHOMPEdit
					"Cat Cargo" = "vixcargo", //CHOMPEdit
					"Drake" = "drakemine",
					"Raptor V-4" = "mineraptor"
					)
	can_be_pushed = 0

/obj/item/weapon/robot_module/robot/miner/kmine/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/borg/sight/material(src)
	src.modules += new /obj/item/weapon/tool/wrench/cyborg(src)
	src.modules += new /obj/item/weapon/tool/screwdriver/cyborg(src)
	src.modules += new /obj/item/weapon/storage/bag/ore(src)
	src.modules += new /obj/item/weapon/pickaxe/borgdrill(src)
	src.modules += new /obj/item/weapon/storage/bag/sheetsnatcher/borg(src)
	src.modules += new /obj/item/weapon/gripper/miner(src)
	src.modules += new /obj/item/weapon/mining_scanner(src)
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/weapon/gun/energy/locked/phasegun/unlocked/mounted/cyborg(src)  //Chompedit To let the borg defend themselves
	src.modules += new /obj/item/device/vac_attachment(src) //CHOMPAdd
	// New Emag gear for the minebots!
	src.emag = new /obj/item/weapon/kinetic_crusher/machete/dagger(src)

	// No reason for these, upgrade modules replace them.
	//src.emag = new /obj/item/weapon/pickaxe/plasmacutter(src)
	//src.emag = new /obj/item/weapon/pickaxe/diamonddrill(src)

	var/datum/matter_synth/water = new /datum/matter_synth(500)
	water.name = "Water reserves"
	water.recharge_rate = 10  //CHOMPedit water shouldn't be a giant pain to get, rechargers should provide it.
	R.water_res = water
	synths += water

	var/obj/item/device/dogborg/tongue/T = new /obj/item/device/dogborg/tongue(src)
	T.water = water
	src.modules += T

	var/obj/item/device/dogborg/sleeper/B = new /obj/item/device/dogborg/sleeper/compactor/supply(src)
	B.water = water
	src.modules += B

	R.icon = 'modular_chomp/icons/mob/widerobot_car_ch.dmi' //CHOMPEdit
	R.wideborg_dept = 'modular_chomp/icons/mob/widerobot_car_ch.dmi' //CHOMPEdit
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x  	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style

	..()

/obj/item/weapon/robot_module/Reset(var/mob/living/silicon/robot/R)
	R.pixel_x = initial(pixel_x)
	R.pixel_y = initial(pixel_y)
	R.icon = initial(R.icon)
	R.dogborg = FALSE
	R.wideborg = FALSE
	R.ui_style_vr = FALSE
	R.default_pixel_x = initial(pixel_x)
	R.scrubbing = FALSE
	R.verbs -= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs -= /mob/living/silicon/robot/proc/robot_mount
	R.verbs -= /mob/living/proc/toggle_rider_reins
	R.verbs -= /mob/living/proc/shred_limb
	R.verbs -= /mob/living/silicon/robot/proc/rest_style
	..()

/obj/item/weapon/robot_module/robot/clerical/butler/booze
	name = "BoozeHound robot module"
	can_be_pushed = 0
	sprites = list(
				"Beer Buddy" = "boozeborg",
				"Brilliant Blue" = "boozeborg(blue)",
				"Caffine Dispenser" = "boozeborg(coffee)",
				"Gamer Juice Maker" = "boozeborg(green)",
				"Liqour Licker" = "boozeborg(orange)",
				"The Grapist" = "boozeborg(purple)",
				"Vampire's Aid" = "boozeborg(red)",
				"Vodka Komrade" = "boozeborg(vodka)"
				) //CHOMP Edit Added Vodka Komrade

/obj/item/weapon/robot_module/robot/clerical/butler/booze/New(var/mob/living/silicon/robot/R)
	..()
	src.modules += new /obj/item/weapon/gripper/service(src)
	//src.modules += new /obj/item/weapon/reagent_containers/glass/bucket(src)
	//src.modules += new /obj/item/weapon/material/minihoe(src)
	//src.modules += new /obj/item/device/analyzer/plant_analyzer(src)
	//src.modules += new /obj/item/weapon/storage/bag/plants(src)
	//src.modules += new /obj/item/weapon/robot_harvester(src)
	src.modules += new /obj/item/weapon/material/knife(src)
	src.modules += new /obj/item/weapon/material/kitchen/rollingpin(src)
	src.modules += new /obj/item/device/multitool(src) //to freeze trays
	src.modules += new /obj/item/weapon/dogborg/jaws/small(src)
	src.modules += new /obj/item/weapon/tray/robotray
	src.modules += new /obj/item/device/dogborg/boop_module(src)
	src.modules += new /obj/item/device/dogborg/sleeper/compactor/brewer(src)
	src.emag 	 = new /obj/item/weapon/dogborg/pounce(src)
	R.verbs += /mob/living/silicon/robot/proc/reskin_booze

	var/obj/item/weapon/rsf/M = new /obj/item/weapon/rsf(src)
	M.stored_matter = 30
	src.modules += M

	src.modules += new /obj/item/weapon/reagent_containers/dropper/industrial(src)

	var/obj/item/weapon/flame/lighter/zippo/L = new /obj/item/weapon/flame/lighter/zippo(src)
	L.lit = 1
	src.modules += L

	src.modules += new /obj/item/weapon/tray/robotray(src)
	src.modules += new /obj/item/weapon/reagent_containers/borghypo/service(src)

	R.icon 		 = 'icons/mob/widerobot_colors_vr.dmi'
	R.wideborg_dept = 'icons/mob/widerobot_colors_vr.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.ui_style_vr = TRUE
	R.pixel_x 	 = -16
	R.old_x 	 = -16
	R.default_pixel_x = -16
	R.dogborg = TRUE
	//CHOMPEdit - Add vore capacity
	R.vore_capacity = 1
	R.vore_capacity_ex = list("stomach" = 1)
	//CHOMPEdit End
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	..()

/obj/item/weapon/robot_module/robot/clerical/butler/booze/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/weapon/reagent_containers/food/condiment/enzyme/E = locate() in src.modules
	E.reagents.add_reagent("enzyme", 2 * amount)

//CHOMP addition start BORGHYPO
/obj/item/weapon/reagent_containers/borghypo/service/booze
	name = "cyborg drink synthesizer"
	desc = "A portable drink dispencer."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "shaker"
	charge_cost = 20
	recharge_time = 3
	volume = 120
	possible_transfer_amounts = list(1 ,5, 10, 20, 30)
//Chomp addition end

/obj/item/weapon/robot_module/Reset(var/mob/living/silicon/robot/R)
	R.pixel_x = initial(pixel_x)
	R.pixel_y = initial(pixel_y)
	R.icon = initial(R.icon)
	R.dogborg = FALSE
	R.wideborg = FALSE
	R.ui_style_vr = FALSE
	R.default_pixel_x = initial(pixel_x)
	R.scrubbing = FALSE
	R.verbs -= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs -= /mob/living/silicon/robot/proc/robot_mount
	R.verbs -= /mob/living/proc/toggle_rider_reins
	R.verbs -= /mob/living/proc/shred_limb
	R.verbs -= /mob/living/silicon/robot/proc/rest_style
	..()
