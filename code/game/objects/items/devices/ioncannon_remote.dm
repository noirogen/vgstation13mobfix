

/obj/item/device/loic_remote
	name = "\improper strange remote"
	desc = "Press the big button to upset people."
	icon = 'icons/obj/device.dmi'
	icon_state = "batterer"
	w_class = W_CLASS_TINY
	flags = FPRINT
	var/cooldown = 0
	mech_flags = MECH_SCAN_FAIL

/obj/item/device/loic_remote/process()
	if(cooldown - world.time < 0)		//Set the icon back to the default if the cooldown expires
		icon_state = "batterer"
		processing_objects.Remove(src)


/obj/item/device/loic_remote/attack_self(var/mob/user)
	var/turf/T = get_turf(src)
	if(cooldown - world.time > 0)
		to_chat(user, "<span class='notice'>The Low Orbit Ion Cannon is still on cooldown.</span>")
		return
	if(!is_type_in_list(get_area(src), the_station_areas))
		to_chat(user, "The remote can't establish a connection. You need to be on the station.")
		return
	if(alert(user, "A cryptic message appears on the screen: \"Activate the Low Orbit Ion-Cannon?\".", name, "Yes", "No") != "Yes")
		return
	if(user.incapacitated() || !Adjacent(user))
		return
	generate_ion_law()
	command_alert(/datum/command_alert/ion_storm_malicious)
	cooldown = world.time + 15 MINUTES
	icon_state = "battererburnt"
	processing_objects.Add(src)

	to_chat(user, "<span class='notice'>\The [src]'s screen flashes green for a moment.</span>")

	message_admins("[key_name_admin(user)] generated an ion law using a LOIC remote.")
	log_admin("[key_name(user)] generated an ion law using a LOIC remote.")

	for (var/obj/machinery/computer/communications/C in machines)
		if(! (C.stat & (BROKEN|NOPOWER) ) )
			var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( C.loc )
			P.name = "'[command_name()] Update.'"
			P.info = "Station Time: <B>[worldtime2text()]</B><br><br>Malicious Interference with standard AI-Subsystems detected.<br><br>Signal traced to <B>[get_area(src).name]</B>. Investigation recommended."
			P.update_icon()
			C.messagetitle.Add("[command_name()] Update")
			C.messagetext.Add(P.info)

	



