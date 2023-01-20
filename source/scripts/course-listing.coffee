
newCourse = (e)->
  if e.key == 'Enter' || e == 'onClick'
    if input.value.length > 0
      inputText = input.value
      createdElm = yourCourses.appendChild(newCourseTemplate.content.cloneNode(true))
      yourCourses.append(newCourseContainer)
      courseCreateInput = document.querySelector(".course.short")

      courses = yourCourses.querySelectorAll(".course")
      createdCourse = courses[courses.length - 2]
      input.value = ""

      newCourseTitle = createdCourse.querySelector(".course-title")
      newCourseTitle.textContent = inputText
      input = document.querySelector("#new-course-field")
      courseCreateAnimation(createdCourse)

Make "course-listing"