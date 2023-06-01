Take ["Database", "DOOM", "Render", "Route"], (Database, DOOM, Render, Route)->

  renderCourse = ({category, creator, id, materials, name, status})->

    sublistingElm = document.querySelector "##{category} > .loaded-courses"

    click = ()-> Route "course", id

    buttonColor = if status is "continue" then "green" else "blue"
    buttonText = if status is "complete"
      "Review"
    else
      status[0].toUpperCase() + status[1..]

    Render sublistingElm, [
      ["div", { id: "course-#{id}", class: "course", courseId: id }, [
        ["h2", { class: "course-title" }, name ]
        ["div", { class: "course-buttons" }, [
          ["a", { class: "course-button #{buttonColor}", click }, buttonText]
        ]]
        ["div", { class: "course-bottom" }, [
          ["div", { class: "left-meta" }, "#{materials.length} Items"]
          ["div", { class: "right-meta" }, creator]
        ]]
      ]]
    ]


  renderCourses = ()->
    if Route() is "listing"
      if courses = Database.get "courses"
        for courseData, courseIndex in courses
          renderCourse courseData, courseIndex


  Database.subscribe "courses", renderCourses
  Route.subscribe "listing", renderCourses
