extends Node

var cur_events = []
var avail_dept = ["space"]

var events_dict = {
	"space": {
	"small":[["Satellite collision","Chief, we have detected a collision between two satellites in low Earth orbit. Debris is minimal, but it may pose a potential risk to our active communication satellites."],
	["Minor asteroid","Chief, an asteroid the size of a small building will pass within the Moon’s orbit in 36 hours. Its presence does not pose a direct threat, but its proximity does warrant monitoring."],
	["Solar flare","Chief, a solar flare has erupted and is the cause of several minor disruptions to our communication networks."]],
	"medium":[["Large asteroid detected","Chief, our deep-space telescopes have identified a large asteroid on a potential collision course with Earth. Impact probability is at 42%, with a margin for error."],
	["Solar storm","Chief, a significant solar storm is currently impacting our geomagnetic field. Power grids are currently destabilizing across the city."],
	["Space debris","Chief, space debris from a defunct satellite has struck one of our orbital stations. Structural integrity is compromised, though repair crews are en route."]],
	"large":[["Explosion of the sun","Chief... The Sun, our once steady star, is in its death throes. The catastrophic explosion has begun and its shockwaves are being felt throughout the solar system. We have limited time to execute our escape protocols. The numbers are irrefutable—this is the end, unless we move beyond the reach of its wrath."],
	["Alien contact achieved","Chief, while I customarily refrain from excitement, I must admit I am delighted to report we have established contact with an extraterrestrial civilization. Their technology far surpasses ours. Communication is rudimentary, but we’ve detected no signs of hostility as of now."],
	["Rogue planet in solar system","Chief, an uncharted rogue planet has intruded into our solar system and has already begun to disrupt planetary orbits. We are observing gravitational anomalies as we speak."],
	["Discovery of Black Hole","Chief, our sensors have detected a massive black hole on a direct course towards our solar system. Its gravitational pull is immense, enough to warp space-time itself. We must prepare to evacuate or initiate extreme countermeasures."]]	
},
	"human":{
	"small":[],
	"medium":[],
	"large":[]	
},
	"nature":{
	"small":[],
	"medium":[],
	"large":[]	
}
}
