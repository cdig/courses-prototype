Take ["CourseTitleBar", "Database", "Route", "Scroller"], (CourseTitleBar, Database, Route, Scroller)->

  Make "CourseView", CourseView = ()->
    return unless Route.path() is "course"
    return unless courses = Database.get "courses"
    [courseId] = Route.args()

    # TODO: Courses should be stored in a hash?? Database should support queries?
    course = courses.find (course)-> course.id is courseId

    ["div", { id: "course-view" }, [
      CourseTitleBar(course)
      Scroller(course)
    ]]


  # TODO:
  # scroller.innerHTML = "<svg id='timeline' xmlns='http://www.w3.org/2000/svg'></svg>"
  # transparentBackground = if material.text == "" then "transparent" else ""
  # Draggable elm
  # Automatically resize the text area whenever its contents change
  # noStuffHeaderText.textContent = "Add Stuff To Your Course"
