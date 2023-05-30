Take ["Database"], (Database)->

  Make "NewCourse", NewCourse = (name)->
    return unless name

    # TODO: This should go in some sort of model that has defaults for all the fields except name
    Database.update "courses", (courses)->
      courses.concat
        category: "your-courses",
        name: name,
        creator: "Keelan Wollms"
        status: "start",
        materials: []
