extends Node

enum EVENT {
	SAT_COL,
	MIN_AST,
	SOL_FLAR,
	LARG_AST,
	SOL_STORM,
	SPACE_DEBRIS,
	SUN_DEATH,
	ALIENS,
	ROGUE_PLANET,
	BLACK_HOLE,
	
	CIV_UNREST,
	CYBERATTACK,
	ECON_DOWN,
	HAPPY_DECILNE,
	PROTESTS,
	RECESSION,
	CULT,
	NUCLEAR_WAR,
	PANDEMIC,
	ECON_COLLAPSE,
	REVOLUTION,
	
	RAIN,
	THUNDER,
	EARTHQUAKE,
	DROUGHT,
	FLOOD,
	TORNADO,
	VOLCANO,
	CLIMATE_SHIFT,
	ECOSYS_COLLAPSE
}

enum DEPT {
	SPACE,
	HUMAN,
	NATURE
}

enum CATG {
	SMALL,
	MEDIUM,
	LARGE
}

var cur_events = []
var cur_dept : DEPT = DEPT.SPACE
var avail_dept = [DEPT.SPACE, DEPT.HUMAN, DEPT.NATURE]

func _ready() -> void:
	cur_dept = DEPT.SPACE
	avail_dept = [DEPT.SPACE, DEPT.HUMAN, DEPT.NATURE]

var events_categories = {
	DEPT.SPACE: {
	CATG.SMALL : [EVENT.SAT_COL, EVENT.MIN_AST, EVENT.SOL_FLAR],
	CATG.MEDIUM : [EVENT.LARG_AST, EVENT.SOL_STORM, EVENT.SPACE_DEBRIS],
	CATG.LARGE : [EVENT.SUN_DEATH, EVENT.ALIENS, EVENT.ROGUE_PLANET, EVENT.BLACK_HOLE]
},
	DEPT.HUMAN: {
	CATG.SMALL : [EVENT.CIV_UNREST, EVENT.CYBERATTACK, EVENT.ECON_DOWN, EVENT.HAPPY_DECILNE],
	CATG.MEDIUM : [EVENT.PROTESTS, EVENT.RECESSION, EVENT.CULT],
	CATG.LARGE : [EVENT.NUCLEAR_WAR, EVENT.PANDEMIC, EVENT.ECON_COLLAPSE, EVENT.REVOLUTION]
},
	DEPT.NATURE: {
	CATG.SMALL : [EVENT.RAIN, EVENT.THUNDER, EVENT.EARTHQUAKE],
	CATG.MEDIUM : [EVENT.DROUGHT, EVENT.FLOOD, EVENT.TORNADO],
	CATG.LARGE : [EVENT.VOLCANO, EVENT.CLIMATE_SHIFT, EVENT.ECOSYS_COLLAPSE]
}
}

var events_desc = {
	EVENT.SAT_COL : ["Satellite collision","Chief, we have detected a collision between two satellites in low Earth orbit. Debris is minimal, but it may pose a potential risk to our active communication satellites.","Redirect satellite paths to avoid further collisions","Deploy drones to clear debris","The debris causes further collisions.", {GV.RES.ENERGY:100}, {GV.RES.METAL:100}, {GV.RES.COMMS:100}],
	EVENT.MIN_AST : ["Minor asteroid","Chief, an asteroid the size of a small building will pass within the Moon’s orbit in 36 hours. Its presence does not pose a direct threat, but its proximity does warrant monitoring.","Track and monitor further asteroids","Deploy drones to redirect the asteroid","The asteroid unexpectedly alters its course and causes panic and minor damage.",{GV.RES.ENERGY:100},{GV.RES.METAL:100},{GV.RES.FINANCE:100}],
	EVENT.SOL_FLAR : ["Solar flare","Chief, a solar flare has erupted and is the cause of several minor disruptions to our communication networks.","Reinforce communication lines","Broadcast alert and prepare for communication outage", "The flare disrupts major networks and leads to confusion and delays.",{GV.RES.ENERGY:100},{GV.RES.PEOPLE:100},{GV.RES.COMMS:100}],
	EVENT.LARG_AST : ["Large asteroid detected","Chief, our deep-space telescopes have identified a large asteroid on a potential collision course with Earth. Impact probability is at 42%, with a margin for error.", "Track and monitor further asteroids", "Initiate deflection mission", "The asteroid impacts the edge of the city and causes panic and minor damage.",{GV.RES.ENERGY:100},{GV.RES.PEOPLE:100},{GV.RES.FINANCE:100}],
	EVENT.SOL_STORM : ["Solar storm","Chief, a significant solar storm is currently impacting our geomagnetic field. Power grids are currently destabilizing across the city.","Reinforce power grids","Set up shelters for power outages","The solar storm causes widespread power outages and leads to confusion and delays.",{GV.RES.ENERGY:100},{GV.RES.PEOPLE:100},{GV.RES.COMMS:100}],
	EVENT.SPACE_DEBRIS : ["Space debris","Chief, space debris from a defunct satellite has struck one of our orbital stations. Structural integrity is compromised, though repair crews are en route.", "Redirect satellite paths to avoid further collisions","Deploy drones to clear debris","The debris causes further collisions.",{GV.RES.ENERGY:100},{GV.RES.METAL:100},{GV.RES.COMMS:100}],
	EVENT.SUN_DEATH : ["Explosion of the sun","Chief... The Sun, our once steady star, is in its death throes. The catastrophic explosion has begun and its shockwaves are being felt throughout the solar system. We have le—this is the end, unless we move beyonlimited time to execute our escape protocols. The numbers are irrefutabd the reach of its wrath.", "Activate evacuation protocols for all citizens", "Focus on preserving resources", "The city is destroyed in the explosion.",{GV.RES.ENERGY:100, GV.RES.FINANCE:100, GV.RES.METAL:100},{GV.RES.ENERGY:100, GV.RES.FINANCE: 100, GV.RES.COMMS:100},{}],
	EVENT.ALIENS : ["Alien contact achieved","Chief, while I customarily refrain from excitement, I must admit I am delighted to report we have established contact with an extraterrestrial civilization. Their technology far surpasses ours. Communication is rudimentary, but we’ve detected no signs of hostility as of now.","Communicate and establish diplomatic relations", "Prepare defense systems", "Miscommunication leads to a hostile encounter and causes tension and resource drain.",{GV.RES.ENERGY:100, GV.RES.COMMS: 100},{GV.RES.ENERGY:100, GV.RES.METAL: 100},{GV.RES.METAL:100, GV.RES.LUMBER:100, GV.RES.FOOD:100}],
	EVENT.ROGUE_PLANET : ["Rogue planet in solar system","Chief, an uncharted rogue planet has intruded into our solar system and has already begun to disrupt planetary orbits. We are observing gravitational anomalies as we speak.", "Deploy crew to readjust the orbit of the rogue planet", "Evacuate high-risk zones", "Gravitational anomalies cause severe weather and infrastructure damage.",{GV.RES.ENERGY:100, GV.RES.METAL:100, GV.RES.PEOPLE:100},{GV.RES.ENERGY:100, GV.RES.COMMS:100, GV.RES.PEOPLE:100},{GV.RES.FINANCE:100, GV.RES.PEOPLE:100}],
	EVENT.BLACK_HOLE : ["Discovery of Black Hole","Chief, our sensors have detected a massive black hole on a direct course towards our solar system. Its gravitational pull is immense, enough to warp space-time itself. We must prepare to evacuate or initiate extreme countermeasures.", "Send out research crews and study the black hole", "Prepare mass evacuations", "The black hole’s gravitational pull causes time distortions and spatial anomalies.",{GV.RES.ENERGY:100, GV.RES.COMMS:100},{GV.RES.ENERGY:100, GV.RES.PEOPLE:100},{GV.RES.FINANCE:100, GV.RES.COMMS:100}],
	
	EVENT.CIV_UNREST : ["Civil unrest","Chief, we have detected a collision between two satellites in low Earth orbit. Debris is minimal, but it may pose a potential risk to our active communication satellites.", "Initiate community dialogue programs", "Deploy peacekeeping forces", "The unrest escalates into riots and causes widespread damage.", {GV.RES.ENERGY:100}, {GV.RES.FINANCE:100}, {GV.RES.METAL:100, GV.RES.LUMBER:100} ],
	EVENT.CYBERATTACK : ["Cyberattack","Chief, an asteroid the size of a small building will pass within the Moon’s orbit in 36 hours. Its presence does not pose a direct threat, but its proximity does warrant monitoring.", "Launch cybersecurity task force", "Isolate affected systems", "The cyberattack spreads and leads to significant data breaches and operational disruptions.", {GV.RES.ENERGY:100}, {GV.RES.PEOPLE:100}, {GV.RES.COMMS:100}],
	EVENT.ECON_DOWN : ["Downturn of the economy","Chief, a solar flare has erupted and is the cause of several minor disruptions to our communication networks.", "Increase employment programs", "Implement financial stimulus package", "he economy continues to decline and leads to increased poverty and unrest.", {GV.RES.ENERGY:100}, {GV.RES.FINANCE:100}, {GV.RES.FINANCE:100}],
	EVENT.HAPPY_DECILNE : ["Happiness Index decline","Chief, I’ve noticed the happiness index is dropping. Perhaps we could introduce some community programs, ease things up a bit. But hey, before we make any moves, I’m all ears for your thoughts. You’ve got the final say.", "Expand social services", "Introduce community programs", "The happiness index continues to decline and results in decreased productivity and higher crime rates.", {GV.RES.ENERGY:100}, {GV.RES.FINANCE:100}, {GV.RES.PEOPLE:100}],
	EVENT.PROTESTS : ["Widespread protests","Chief, protests are cropping up across the country. We need to keep this under control, but I’ll follow your lead on how firm we should be. I’m thinking crowd control and maybe some talks with local leaders. What do you think? No rush—just want to make sure we’re on the same page.", "Reinforce crowd control squads", "Engage in negotiations with protest leaders","The protests grow in size and intensity and lead to clashes with law enforcement and damage to public property.", {GV.RES.ENERGY:100, GV.RES.PEOPLE:100}, {GV.RES.COMMS:100}, {GV.RES.PEOPLE:100}],
	EVENT.RECESSION : ["Recession","Chief, looks like we’re slipping into a recession. It’s going to take a careful approach—stimulating the economy, job programs—But I’d like to hear your take on it, we’ve got time to strategize.", "Cut taxes and implement job programs", "Launch large-scale infrastructure projects", "The recession deepens and leads to widespread unemployment and social unrest.", {GV.RES.ENERGY:100, GV.RES.FINANCE:100}, {GV.RES.METAL:100, GV.RES.LUMBER:100}, {GV.RES.FINANCE:100}],
	EVENT.CULT : ["Emerging cult","Chief, we’ve got a new cult on the rise—seems harmless for now, but you know how these things can grow. I’d suggest keeping tabs on them, maybe even some outreach to the communities they’re targeting. But as always, I’ll defer to your judgment on how to handle it.", "Launch public awareness campaigns", "Monitor and infiltrate the cult", "The cult grows in power and leads to increased social instability and radicalization.", {GV.RES.ENERGY:100, GV.RES.COMMS:100}, {GV.RES.PEOPLE:100}, {GV.RES.PEOPLE:100}],
	EVENT.NUCLEAR_WAR : ["Global nuclear war","Chief, we’re on the brink of a global nuclear conflict. It’s a delicate situation—I recommend we exhaust every diplomatic option before we consider more drastic measures. But I wanted to make sure we’re in sync on this. Your call, as always.", "Engage in diplomatic negotiations", "Implement nationwide defense measures", "Nuclear war erupts and causes widespread devastation throughout the city.",{GV.RES.ENERGY:100, GV.RES.COMMS: 100, GV.RES.FINANCE:100},{GV.RES.ENERGY:100, GV.RES.METAL: 100, GV.RES.PEOPLE:100},{GV.RES.PEOPLE:100, GV.RES.FOOD:100, GV.RES.METAL:100, GV.RES.LUMBER:100, GV.RES.FINANCE:100}],
		EVENT.PANDEMIC : ["Pandemic","Chief, we’re facing a pandemic with a devastating mortality rate. Quarantines, vaccines—these are just the first steps. I know this is critical, but I’d like to hear your thoughts before we move forward.", "Enforce strict quarantine and vaccination programs", "Mobilize medical resources and international aid", "The pandemic spreads uncontrollably and leads to massive loss of life and economic collapse.",{GV.RES.ENERGY:100, GV.RES.PEOPLE: 100, GV.RES.FINANCE:100},{GV.RES.ENERGY:100, GV.RES.FOOD: 100, GV.RES.COMMS:100},{GV.RES.PEOPLE:100, GV.RES.FINANCE:100, GV.RES.FOOD:100}],
	EVENT.ECON_COLLAPSE : ["Complete economic collapse","Chief, the economy’s in ruins. We’re looking at widespread poverty, civil unrest, maybe even a breakdown of order. We might need to consider some extreme measures. But before we take any action, I’d like to get your input. This is too important to rush.", "Nationalize major industries", "Seek international loans and seek aid", "The economic collapse leads to widespread poverty, hunger, and social unrest.",{GV.RES.ENERGY:100, GV.RES.FINANCE: 100},{GV.RES.ENERGY:100, GV.RES.COMMS: 100},{GV.RES.PEOPLE:100, GV.RES.FOOD:100, GV.RES.METAL:100, GV.RES.LUMBER:100, GV.RES.FINANCE:100}],
	EVENT.REVOLUTION : ["Revolution against the government","Chief, there’s a full-blown revolution underway. It’s spreading fast, and we need to decide how to respond. We could suppress it with force or try to negotiate. I’d like to hear your thoughts. We’ll figure this out together.", "Negotiate a peaceful resolution", "Use military force to suppress the revolution", "The revolution succeeds and leads to the overthrow of the government and citywide chaos.",{GV.RES.ENERGY:100, GV.RES.COMMS: 100},{GV.RES.ENERGY:100, GV.RES.METAL: 100, GV.RES.FINANCE:100},{GV.RES.FINANCE:100, GV.RES.PEOPLE:100, GV.RES.COMMS:100}],

	EVENT.RAIN : ["Downpour","Chief, just a little rain today—nothing to worry about, unless you’ve left your windows open. But hey, you never know with Mother Nature. Let’s make sure the drainage systems are in top shape, just in case. What do you say we check in on that over a cup of coffee?","Enhance drainage systems", "Issue a weather alert and prepare for minor flooding", "The downpour leads to minor flooding and causes disruptions in daily life.", {GV.RES.ENERGY:100, GV.RES.LUMBER:100}, {GV.RES.COMMS:100}, {GV.RES.PEOPLE:100, GV.RES.FINANCE:100}],
	EVENT.THUNDER : ["Severe Thunderstorms","Chief, a storm’s brewing. Nothing we haven’t seen before, but we should prepare for potential outages and minor damage. Maybe remind folks to cozy up at home with a good book—it’s the perfect weather for it.", "Reinforce power lines and secure buildings", "Advise residents to stay indoors", "The storm causes widespread power outages and structural damage.", {GV.RES.ENERGY:100}, {GV.RES.COMMS:100}, {GV.RES.PEOPLE:100, GV.RES.FINANCE:100}],
	EVENT.EARTHQUAKE : ["Small earthquake","Chief, we felt a little shake this morning—nothing serious, just the Earth reminding us who’s boss.", "Conduct building inspections and reinforcements", "Temporarily evacuate high-risk areas", "The earthquake causes minor structural damage and injuries.", {GV.RES.ENERGY:100, GV.RES.LUMBER:100}, {GV.RES.COMMS:100}, {GV.RES.PEOPLE:100, GV.RES.FINANCE:100}],
	EVENT.DROUGHT : ["Drought","Chief, the northern regions are starting to dry up a bit. It’s nothing too serious yet, but we should start thinking about water rationing if it gets worse. The land’s just a bit thirsty, that’s all. We’ve got this.", "Construct new reservoirs", "Implement water rationing", "The drought worsens and leads to crop failures and water shortages.", {GV.RES.ENERGY:100, GV.RES.LUMBER:100}, {GV.RES.COMMS:100}, {GV.RES.PEOPLE:100, GV.RES.FOOD:100}],
	EVENT.FLOOD : ["Flooding","Chief, the rivers are rising, and we’re looking at a potential flood situation. We might need to think about evacuating the low-lying areas. It’s like the rivers are trying to reclaim their old territory—we just need to remind them who’s in charge.", "Enhance drainage systems", "Issue a weather alert and prepare for major flooding", "The flood causes significant damage to infrastructure and housing.", {GV.RES.ENERGY:100, GV.RES.LUMBER:100}, {GV.RES.COMMS:100}, {GV.RES.PEOPLE:100, GV.RES.FINANCE:100}],
	EVENT.TORNADO : ["Tornado","Chief, a tornado’s just landed by the South of the city. It’s tearing up the countryside, and we need to act fast. Evacuations, emergency shelters, the whole nine yards, and fast before she starts to shake everything up.", "Strengthen tornado shelters", "Issue immediate evacuation orders", "The tornado causes significant damage to crops, infrastructure and housing.", {GV.RES.ENERGY:100, GV.RES.LUMBER:100}, {GV.RES.FINANCE:100, GV.RES.COMMS:100}, {GV.RES.PEOPLE:100, GV.RES.FOOD:100}],
	EVENT.VOLCANO : ["Volcano blots out the sun","Chief, I hope you’ve packed your winter coat because we’re in for a long, cold spell. A supervolcano has erupted, and it’s pumping enough ash into the atmosphere to blot out the sun. It’s like the Earth decided to take a little break from sunshine—unfortunately, that’s bad news for us. We’ll need to prepare for global cooling, crop failures, and widespread panic. On the bright side, at least we won’t need sunscreen for a while. But seriously, we need to act fast.", "Implement geoengineering projects", "Stockpile food and supplies and prepare the citizens", "The lack of sunlight leads to crop failures, food shortages, and widespread panic.",{GV.RES.ENERGY:100, GV.RES.FINANCE: 100},{GV.RES.COMMS:100, GV.RES.FOOD: 100, GV.RES.METAL:100, GV.RES.LUMBER:100},{GV.RES.PEOPLE:100, GV.RES.FOOD:100}],
	EVENT.CLIMATE_SHIFT : ["Global climate shift","Chief, it looks like Mother Nature’s hit the reset button. We’re seeing rapid and unpredictable changes in the global climate—deserts turning into swamps, polar ice caps melting like popsicles in the sun, the works. It’s as if the planet’s gone on a wild ride, and we’re all just hanging on for dear life here. We’re going to need a few creative solutions right about now. How do you want to steer this ship through the storm?", "Develop adaptive agricultural technique", "Relocate vulnerable populations and establish citywide shelters", "The shifting climate causes widespread habitat loss, food shortages, and economic instability.",{GV.RES.ENERGY:100, GV.RES.FINANCE: 100},{GV.RES.ENERGY:100, GV.RES.PEOPLE: 100},{GV.RES.PEOPLE:100, GV.RES.FOOD:100, GV.RES.FINANCE:100}],
	EVENT.ECOSYS_COLLAPSE : ["Ecosystem collapse","Chief, this is it—the big one. We’re looking at a full-blown extinction event. Ecosystems are collapsing left and right, species are disappearing faster than we can count, and the entire food chain is unraveling. It’s like watching the planet’s life support system get unplugged. We need to pull out all the stops before everything goes completely South.", "Launch conservation and restoration initiatives", "Prepare for resource scarcity", "The collapse leads to massive biodiversity loss and food chain disruption, causing starvation in the population.",{GV.RES.ENERGY:100, GV.RES.FINANCE: 100},{GV.RES.LUMBER:100, GV.RES.METAL: 100, GV.RES.FOOD:100},{GV.RES.FOOD:100, GV.RES.METAL:100, GV.RES.LUMBER:100}]
}

func reduce_countdown(delta):
	for active_event in cur_events:
		active_event.reduce_countdown(delta)
