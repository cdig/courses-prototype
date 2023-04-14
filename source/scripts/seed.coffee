seedDatabase = ()->
    
    Take ["Database"], (Database)->
        return unless Database.get("runSeeds")
        # console.log "seeding"
        # Add Material View Seeds
        sessionSeed = [
            {
                "name": "Electrical",
                "sessions": [
                    "Basic Electrical Concepts",
                    "Waveforms & Signal Generation",
                    "Series & Parallel Circuit Basics",
                    "Electrical Hazards & Safety",
                    "Interpreting Electrical Schematics",
                    "Open & Short Circuit Faults",
                    "Connectors",
                    "Electrical Measurements",
                    "Variable Resistors",
                    "Diodes",
                    "CAN Bus",
                    "Semiconductors",
                    "Switches",
                    "Sensor Basics",
                    "Relays",
                    "Fuses & Circuit Breakers",
                    "Pressure Sensors",
                    "Position Sensors",
                    "Flow Sensors",
                    "Temperature Sensors",
                    "Starting & Charging Systems"
                ]
            },
            {
                "name": "Hydraulics",
                "sessions": [
                    "Fluid Power Basics",
                    "Pressure & Flow",
                    "Hydraulic Schematic Symbols",
                    "Hydraulic Hazards & Safety",
                    "Pilot Controllers",
                    "Hydraulic Actuators",
                    "Hydraulic Steering",
                    "Positive & Non-Positive Pumping",
                    "Fixed & Variable Displacement Pumps",
                    "Parallel & Series Systems",
                    "Flow & Directional Control Valves",
                    "Hydraulic Accessories",
                    "Load Sensing Pumps",
                    "Hydrostatic (Closed Loop) Systems",
                    "Pressure Relief Valves",
                    "Cartridge Valves",
                    "Pressure Reducing Valves",
                    "Cross-Port Relief Valves",
                    "Sequence Valves",
                    "Unloading Valves",
                    "Counterbalance Valves",
                    "Open & Closed Center Systems",
                    "Troubleshooting Processes",
                    "Electro-Hydraulic Valves",
                    "Hydraulics Challenges"
                ]
            },
            {
                "name": "Machinery",
                "sessions": [
                    "Hydraulic Training Panel",
                    "Hydraulic Governors",
                    "Lube Systems",
                    "Electrical Training Panel",
                    "Machine Shop"
                ]
            },
            {
                "name": "Mobile",
                "sessions": [
                    "Concrete Pump",
                    "Oilfield Pumping",
                    "Loaders",
                    "Graders",
                    "Coiled Tubing Units",
                    "Oilfield Cementing",
                    "Mining Haul Trucks",
                    "Dozers",
                    "Blast Hole Drills",
                    "Excavators & Shovels",
                    "Civic Machines",
                    "Air Compressors",
                    "Aerial Work Platforms"
                ]
            },
            {
                "name": "Stationary",
                "sessions": [
                    "Cement Plants",
                    "Steel Mill",
                    "Sawmill",
                    "Paper Mill",
                    "Ports & Terminals",
                    "Pulp Mill",
                    "Plywood",
                    "Oriented Strand Board"
                ]
            },
            {
                "name": "Epiroc",
                "sessions": [
                    "RCS",
                    "Boomer M2C MK10",
                    "Cabletec",
                    "Boomer M2C",
                    "Boltec MC",
                    "Pit Viper 275",
                    "Scooptram ST18",
                    "Minetruck MT42",
                    "Minetruck MT54 and MT65",
                    "Scooptram ST14" 
                ]
            },
            {
                "name": "Altec",
                "sessions": [
                    "DC Series",
                    "DT65H"
                ]
            },
            {
                "name": "Applied",
                "sessions": [
                    "Bin Handler"
                ]
            },
            
            {
                "name": "BC Hydro",
                "sessions": [
                    "Kootenay Canal",
                    "Ruskin Generating Station",
                    "G. M. Shrum Station",
                    "Duncan Dam",
                    "Cheakamus Station",
                    "Revelstoke",
                    "Seven Mile",
                    "Puntledge",
                    "Peace Canyon",
                    "Mica Dam",
                    "Bridge River"   
                ]
            },
            {
                "name": "ASTEC",
                "sessions": [
                    "SB3000"
                ]
            },
            {
                "name": "HEXPOL",
                "sessions": [
                    "Compounding"
                ]
            },
            {
                "name": "LP Building",
                "sessions": [
                    "Golden BC"
                ]
            },
            {
                "name": "Sandvik",
                "sessions": [
                    "Loader"
                ]
            },
            {
                "name": "ScanWill",
                "sessions": [
                    "Intensifiers"
                ]
            },
            {
                "name": "SunSource",
                "sessions": [
                    "Test Bench"
                ]
            },
            {
                "name": "Teck",
                "sessions": [
                    "Smelter"
                ]
            },
            {
                "name": "Mosaic",
                "sessions": [
                    "Mining Dredge"
                ]
            },
            {
                "name": "UPS Airlines",
                "sessions": [
                    "TLD 929 Cargo Loader"
                ]
            }
        ]
        # "name": "Solenoid-Controlled Pilot-Operated Directional Control Valve with Pilot Chokes",
        courseSeed = [
                    {
                        "category": "your-courses",
                        "name": "Epiroc Introduction",
                        "numOfMaterials": "13",
                        "creator": "Team Owner",
                        "status": "continue",
                        "materials": [
                            {
                                "name": "Basic Electrical Concepts",
                                "type": "Session",
                                "image": "basicElectrical.png",
                                "imageType": "icon",
                                "text": "Series and parallel circuits are at the heart of every electrical system. Learn how to use Kirchoff's 
                                Law to troubleshoot both types of circuit and to predict voltage through loads and branches. This session also includes two battery hookup 
                                puzzles for practice, and a full colour printable manual."
                            }, 
                            {
                                "name": "Basic Electrical Concepts",
                                "type": "Quiz",
                                "image": "basicElectricalQuiz.png",
                                "imageType": "screenshot",
                                "text": ""
                            },
                            {
                                "name": "Basic Electrical Units",
                                "type": "Lesson",
                                "image": "electricalUnits.png",
                                "imageType": "screenshot",
                                "text": "&nbsp;&nbsp;&nbsp;&nbsp; Voltage is the difference in electrical potential between two points.
                                        This difference in electrical potential is what causes electrons to flow from one point to the other.
                                        In hydraulic terms, circuit voltage would be the pump that gives electricity the push it needs to move 
                                        electrons through a circuit. Voltage is the difference in electrical potential between two points.
                                        This difference in electrical potential is what causes electrons to flow from one point to the other.
                                        In hydraulic terms, circuit voltage would be the pump that gives electricity the push it needs to move electrons 
                                        through a circuit."
                            },
                            {
                                "name": "Waveforms & Signal Generation",
                                "type": "Session",
                                "image": "waveforms.png",
                                "imageType": "icon",
                                "text": "&nbsp;&nbsp;&nbsp;&nbsp; Direct current is common in low voltage systems, but as soon as you start working with high voltage, 
                                    you'll need to know about alternating current. AC comes in a variety of waveforms, with a lot of information encoded into it, which 
                                    we will show you how to identify, measure, and reason about."
                            },
                            {
                                "name": "Alternating Current",
                                "type": "Lesson",
                                "image": "alternatingCurrent.png",
                                "imageType": "screenshot",
                                "text": "&nbsp;&nbsp;&nbsp;&nbsp; Direct current is common in low voltage systems, but as soon as you start working with high voltage, 
                                    you'll need to know about alternating current. AC comes in a variety of waveforms, with a lot of information encoded into it, which 
                                    we will show you how to identify, measure, and reason about."
                            }
                        ]
                    },
                    {
                        "category": "your-courses",
                        "name": "Epiroc MT65",
                        "numOfMaterials": "10",
                        "creator": "Team Manager",
                        "status": "start"
                    },
                    {
                        "category": "lunchbox-sessions-courses",
                        "name": "Lunchbox Sessions Introduction",
                        "numOfMaterials": "5",
                        "creator": "LunchBox Sessions",
                        "status": "start"
                    },
                    {
                        "category": "lunchbox-sessions-courses",
                        "name": "Advanced Electrical",
                        "numOfMaterials": "21",
                        "creator": "LunchBox Sessions",
                        "status": "start"
                    },
                    {
                        "category": "lunchbox-sessions-courses",
                        "name": "Pumps",
                        "numOfMaterials": "15",
                        "creator": "LunchBox Sessions",
                        "status": "start"
                    },
                    {
                        "category": "completed-courses",
                        "name": "Valves",
                        "numOfMaterials": "13",
                        "creator": "LunchBox Sessions",
                        "status": "complete"
                    },
                    {
                        "category": "completed-courses",
                        "name": "Electrical Introduction",
                        "numOfMaterials": "6",
                        "creator": "LunchBox Sessions",
                        "status": "complete"
                    }
                ]
            # Weird
            # {
            #     "name": "This is a really long title for testing, I'm not sure why you would ever name a course something this long. But someone will do it at some point.",
            #     "numOfMaterials": "2",
            #     "creator": "Keelan Wollms"
            # },
            # {
            #     "name": "Short Title",
            #     "numOfMaterials": "15",
            #     "creator": "LunchBox"
            # },
            # {
            #     "name": "Test First Course",
            #     "numOfMaterials": "10",
            #     "creator": "Keelan Wollms"
            # }

        # sessionCatagoriesSeed = [
        #     "Hydraulics",
        #     "Electrical",
        #     "",
        #     "",
        #     ""
        # ]

        courses = []

        for course in courseSeed
            courses.push(course)

        Database.set("courses", courses)



        sessions = []
        
        for sessionName in sessionSeed
            sessions.push({name: sessionName})

        Database.set("topics", sessions)

        

        
# setTimeout seedDatabase, 5000
setTimeout seedDatabase, 1000



