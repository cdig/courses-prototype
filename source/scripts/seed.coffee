seedDatabase = ()->
    
    Take ["Database"], (Database)->
        return unless Database.get("runSeeds")
        console.log "seeding"
        # Add Material View Seeds
        sessionSeed = [
            "Kootenay Canal",
            "Boomer M2C",
            "Boltec MC",
            "Ruskin Generating Station",
            "SB3000",
            "Starting & Charging Systems",
            "Excavators & Shovels",
            "Sequence Valves",
            "Pit Viper 275",
            "Dozers",
            "Position Sensors",
            "G. M. Shrum Station",
            "Compounding",
            "Golden BC",
            "Loader",
            "Mining Dredge",
            "Mining Haul Trucks",
            "Cabletec",
            "Counterbalance Valves",
            "Open & Short Circuit Faults",
            "Bin Handler",
            "Plywood",
            "Smelter",
            "Cheakamus Station",
            "Oriented Strand Board",
            "Hydraulic Training Panel",
            "Basic Electrical Concepts",
            "Scooptram ST18",
            "TLD 929 Cargo Loader",
            "Pulp Mill",
            "Hydraulics Challenges",
            "Seven Mile",
            "Test Bench",
            "Electrical Measurements",
            "Machine Shop",
            "Sawmill",
            "Pilot Controllers",
            "Fuses & Circuit Breakers",
            "Flow & Directional Control Valves",
            "Hydraulic Governors",
            "Blast Hole Drills",
            "Lube Systems",
            "Steel Mill",
            "Revelstoke",
            "Coiled Tubing Units",
            "Puntledge",
            "Mica Dam",
            "Air Compressors",
            "Civic Machines",
            "Pressure Sensors",
            "CAN Bus",
            "Troubleshooting Processes",
            "Graders",
            "Minetruck MT54 and MT65",
            "Hydraulic Hazards & Safety",
            "Variable Resistors",
            "Unloading Valves",
            "Intensifiers",
            "Minetruck MT42",
            "Peace Canyon",
            "Hydraulic Accessories",
            "Hydrostatic (Closed Loop) Systems",
            "Series & Parallel Circuit Basics",
            "Parallel & Series Systems",
            "Paper Mill",
            "Cartridge Valves",
            "Bridge River",
            "DC Series",
            "Semiconductors",
            "Flow Sensors",
            "Oilfield Cementing",
            "DT65H",
            "Hydraulic Schematic Symbols",
            "Load Sensing Pumps",
            "Relays",
            "Hydraulic Actuators",
            "Temperature Sensors",
            "Fluid Power Basics",
            "RCS",
            "Interpreting Electrical Schematics",
            "Cement Plants",
            "Fixed & Variable Displacement Pumps",
            "Concrete Pump",
            "Electrical Hazards & Safety",
            "Boomer M2C MK10",
            "Scooptram ST14",
            "Pressure Relief Valves",
            "Duncan Dam",
            "Open & Closed Center Systems",
            "Pressure & Flow",
            "Electro-Hydraulic Valves",
            "Connectors",
            "Oilfield Pumping",
            "Loaders",
            "Cross-Port Relief Valves",
            "Switches",
            "Ports & Terminals",
            "Sensor Basics",
            "Hydraulic Steering",
            "Diodes",
            "Pressure Reducing Valves",
            "Aerial Work Platforms",
            "Positive & Non-Positive Pumping",
            "Electrical Training Panel",
            "Waveforms & Signal Generation"
        ]

        courseSeed = [
            {
                "name": "This is a really long title for testing, I'm not sure why you would ever name a course something this long. But someone will do it at some point.",
                "numOfMaterials": "2",
                "creator": "Keelan Wollms"
            },
            {
                "name": "Short Title",
                "numOfMaterials": "15",
                "creator": "LunchBox"
            },
            {
                "name": "Test First Course",
                "numOfMaterials": "10",
                "creator": "Keelan Wollms"
            }
        ]

        courses = []

        for course in courseSeed
            courses.push(course)

        Database.set("courses", courses)



        sessions = []
        
        for sessionName in sessionSeed
            sessions.push({name: sessionName})

        Database.set("sessions", sessions)

        

        
# setTimeout seedDatabase, 5000
setTimeout seedDatabase, 1000



