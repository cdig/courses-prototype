Take ["Database"], (Database)->
  Make "NewCourse", NewCourse = (e, container)->
    # newCourseContainer = document.querySelector(".new")
    # newCourseTemplate = document.querySelector("#new-course")
    input = document.querySelector("#new-course-field")

    # yourCourses = document.querySelector("#your-courses")


    
    if e.key == 'Enter' || e.type == "click"
      if input.value.length > 0

        Database.update "courses", (courses)->
          courses.push({
                "category": "your-courses",
                "name": input.value,
                "creator": "Keelan Wollms"
                "status": "start",
                "materials": []
            })

          return courses
        # createdElm = yourCourses.appendChild(newCourseTemplate.content.cloneNode(true))
        # yourCourses.append(newCourseContainer)

        # courses = yourCourses.querySelectorAll(".course")
        # createdCourse = courses[courses.length - 2]
        input.value = ""

        # newCourseTitle = createdCourse.querySelector(".course-title")
        # newCourseTitle.textContent = inputText




