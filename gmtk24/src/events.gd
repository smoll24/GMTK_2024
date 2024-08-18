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
	EVENT.PROTESTS : ["",""],
	EVENT.RECESSION : ["",""],
	EVENT.CULT : ["",""],
	EVENT.NUCLEAR_WAR : ["",""],
	EVENT.PANDEMIC : ["",""],
	EVENT.ECON_COLLAPSE : ["",""],
	EVENT.REVOLUTION : ["",""],

	EVENT.RAIN : ["",""],
	EVENT.THUNDER : ["",""],
	EVENT.EARTHQUAKE : ["",""],
	EVENT.DROUGHT : ["",""],
	EVENT.FLOOD : ["",""],
	EVENT.TORNADO : ["",""],
	EVENT.VOLCANO : ["",""],
	EVENT.CLIMATE_SHIFT : ["",""],
	EVENT.ECOSYS_COLLAPSE : ["",""]
}
