Take ["NewCourse"], (NewCourse)->

  newCourseContainer = document.querySelector(".course.short")
  newCourseButton = newCourseContainer.querySelector(".course-button")
  newCourseInput = newCourseContainer.querySelector("input")

  newCourseButton.addEventListener "click", (e)->
    NewCourse(e, newCourseContainer)

  newCourseInput.addEventListener "keyup", (e)->
    NewCourse(e, newCourseContainer)

