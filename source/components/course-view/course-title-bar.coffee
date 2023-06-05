Take ["Database", "Render", "Route"], (Database, Render, Route)->

  BackToCourses = await Take "BackToCourses"
  CourseViewTitle = await Take "CourseViewTitle"

  # TODO: If we make #course-view render dynamically, the following needs to be changed
  parent = document.querySelector "#course-view"

  # TODO: This should not be duplicated in multiple places across the codebase
  return unless Route.path() is "course"
  return unless courses = Database.get "courses"
  [courseId] = Route.args()
  courseData = courses.find (course)-> course.id is courseId


  Render parent, [
    ["div", { class: "course-title-bar" }, [
      BackToCourses()
      CourseViewTitle(courseData)
      CourseAdminButtons()
    ]]
  ]
