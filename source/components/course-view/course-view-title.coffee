Take ["Database", "Route"], (Database, Route)->

  Make "CourseViewTitle", CourseViewTitle = (course)->

    update = (e)->
      name = e.target.value
      course.name = name # TODO: This sucks extreme ass
      Database.update "courses", (courses)-> courses # Kick the database

    attrs =
      class: "course-view-title"
      type: "text"
      maxlength: "500"
      rows: "1"
      value: course.name
      readonly: if Route.path() is "edit" then null else ""
      input: update
      change: update

    ["input", attrs]
