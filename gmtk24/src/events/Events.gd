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
var avail_dept = [DEPT.SPACE, DEPT.HUMAN, DEPT.NATURE]

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
	EVENT.SAT_COL : ["Satellite collision","Chief, we have detected a collision between two satellites in low Earth orbit. Debris is minimal, but it may pose a potential risk to our active communication satellites."],
	EVENT.MIN_AST : ["Minor asteroid","Chief, an asteroid the size of a small building will pass within the Moon’s orbit in 36 hours. Its presence does not pose a direct threat, but its proximity does warrant monitoring."],
	EVENT.SOL_FLAR : ["Solar flare","Chief, a solar flare has erupted and is the cause of several minor disruptions to our communication networks."],
	EVENT.LARG_AST : ["Large asteroid detected","Chief, our deep-space telescopes have identified a large asteroid on a potential collision course with Earth. Impact probability is at 42%, with a margin for error."],
	EVENT.SOL_STORM : ["Solar storm","Chief, a significant solar storm is currently impacting our geomagnetic field. Power grids are currently destabilizing across the city."],
	EVENT.SPACE_DEBRIS : ["Space debris","Chief, space debris from a defunct satellite has struck one of our orbital stations. Structural integrity is compromised, though repair crews are en route."],
	EVENT.SUN_DEATH : ["Explosion of the sun","Chief... The Sun, our once steady star, is in its death throes. The catastrophic explosion has begun and its shockwaves are being felt throughout the solar system. We have le—this is the end, unless we move beyonlimited time to execute our escape protocols. The numbers are irrefutabd the reach of its wrath."],
	EVENT.ALIENS : ["Alien contact achieved","Chief, while I customarily refrain from excitement, I must admit I am delighted to report we have established contact with an extraterrestrial civilization. Their technology far surpasses ours. Communication is rudimentary, but we’ve detected no signs of hostility as of now."],
	EVENT.ROGUE_PLANET : ["Rogue planet in solar system","Chief, an uncharted rogue planet has intruded into our solar system and has already begun to disrupt planetary orbits. We are observing gravitational anomalies as we speak."],
	EVENT.BLACK_HOLE : ["Discovery of Black Hole","Chief, our sensors have detected a massive black hole on a direct course towards our solar system. Its gravitational pull is immense, enough to warp space-time itself. We must prepare to evacuate or initiate extreme countermeasures."],
	
	EVENT.CIV_UNREST : ["Civil unrest","Chief, we have detected a collision between two satellites in low Earth orbit. Debris is minimal, but it may pose a potential risk to our active communication satellites."],
	EVENT.CYBERATTACK : ["Cyberattack","Chief, an asteroid the size of a small building will pass within the Moon’s orbit in 36 hours. Its presence does not pose a direct threat, but its proximity does warrant monitoring."],
	EVENT.ECON_DOWN : ["Downturn of the economy","Chief, a solar flare has erupted and is the cause of several minor disruptions to our communication networks."],
	EVENT.HAPPY_DECILNE : ["Happiness Index decline","Chief, I’ve noticed the happiness index is dropping. Perhaps we could introduce some community programs, ease things up a bit. But hey, before we make any moves, I’m all ears for your thoughts. You’ve got the final say."],
	EVENT.PROTESTS : ["Widespread protests","Chief, protests are cropping up across the country. We need to keep this under control, but I’ll follow your lead on how firm we should be. I’m thinking crowd control and maybe some talks with local leaders. What do you think? No rush—just want to make sure we’re on the same page."],
	EVENT.RECESSION : ["Recession","Chief, looks like we’re slipping into a recession. It’s going to take a careful approach—stimulating the economy, job programs—But I’d like to hear your take on it, we’ve got time to strategize."],
	EVENT.CULT : ["Emerging cult","Chief, we’ve got a new cult on the rise—seems harmless for now, but you know how these things can grow. I’d suggest keeping tabs on them, maybe even some outreach to the communities they’re targeting. But as always, I’ll defer to your judgment on how to handle it."],
	EVENT.NUCLEAR_WAR : ["Global nuclear war","Chief, we’re on the brink of a global nuclear conflict. It’s a delicate situation—I recommend we exhaust every diplomatic option before we consider more drastic measures. But I wanted to make sure we’re in sync on this. Your call, as always."],
	EVENT.PANDEMIC : ["Pandemic","Chief, we’re facing a pandemic with a devastating mortality rate. Quarantines, vaccines—these are just the first steps. I know this is critical, but I’d like to hear your thoughts before we move forward."],
	EVENT.ECON_COLLAPSE : ["Complete economic collapse","Chief, the economy’s in ruins. We’re looking at widespread poverty, civil unrest, maybe even a breakdown of order. We might need to consider some extreme measures. But before we take any action, I’d like to get your input. This is too important to rush."],
	EVENT.REVOLUTION : ["Revolution against the government","Chief, there’s a full-blown revolution underway. It’s spreading fast, and we need to decide how to respond. We could suppress it with force or try to negotiate. I’d like to hear your thoughts. We’ll figure this out together."],

	EVENT.RAIN : ["Downpour","Chief, just a little rain today—nothing to worry about, unless you’ve left your windows open. But hey, you never know with Mother Nature. Let’s make sure the drainage systems are in top shape, just in case. What do you say we check in on that over a cup of coffee?"],
	EVENT.THUNDER : ["Severe Thunderstorms","Chief, a storm’s brewing. Nothing we haven’t seen before, but we should prepare for potential outages and minor damage. Maybe remind folks to cozy up at home with a good book—it’s the perfect weather for it. "],
	EVENT.EARTHQUAKE : ["Small earthquake","Chief, we felt a little shake this morning—nothing serious, just the Earth reminding us who’s boss. "],
	EVENT.DROUGHT : ["Drought","Chief, the northern regions are starting to dry up a bit. It’s nothing too serious yet, but we should start thinking about water rationing if it gets worse. The land’s just a bit thirsty, that’s all. We’ve got this."],
	EVENT.FLOOD : ["Flooding","Chief, the rivers are rising, and we’re looking at a potential flood situation. We might need to think about evacuating the low-lying areas. It’s like the rivers are trying to reclaim their old territory—we just need to remind them who’s in charge."],
	EVENT.TORNADO : ["Tornado","Chief, a tornado’s just landed by the South of the city. It’s tearing up the countryside, and we need to act fast. Evacuations, emergency shelters, the whole nine yards, and fast before she starts to shake everything up. "],
	EVENT.VOLCANO : ["Volcano blots out the sun","Chief, I hope you’ve packed your winter coat because we’re in for a long, cold spell. A supervolcano has erupted, and it’s pumping enough ash into the atmosphere to blot out the sun. It’s like the Earth decided to take a little break from sunshine—unfortunately, that’s bad news for us. We’ll need to prepare for global cooling, crop failures, and widespread panic. On the bright side, at least we won’t need sunscreen for a while. But seriously, we need to act fast."],
	EVENT.CLIMATE_SHIFT : ["Global climate shift","Chief, it looks like Mother Nature’s hit the reset button. We’re seeing rapid and unpredictable changes in the global climate—deserts turning into swamps, polar ice caps melting like popsicles in the sun, the works. It’s as if the planet’s gone on a wild ride, and we’re all just hanging on for dear life here. We’re going to need a few creative solutions right about now. How do you want to steer this ship through the storm?"],
	EVENT.ECOSYS_COLLAPSE : ["Ecosystem collapse","Chief, this is it—the big one. We’re looking at a full-blown extinction event. Ecosystems are collapsing left and right, species are disappearing faster than we can count, and the entire food chain is unraveling. It’s like watching the planet’s life support system get unplugged. We need to pull out all the stops before everything goes completely South."]
}

func reduce_countdown(delta):
	for active_event in cur_events:
		active_event.reduce_countdown(delta)
