Take ["Database"], (Database)->
  Make "NewCourse", NewCourse = (e, container)->
    # newCourseContainer = document.querySelector(".new")
    # newCourseTemplate = document.querySelector("#new-course")
    input = document.querySelector("#new-course-field")

    # yourCourses = document.querySelector("#your-courses")


    
    if e.key == 'Enter' || e.type == "click"
      if input.value.length > 0

        Database.update "courses", (courses)->
          console.log courses
          courses.push({
                "name": input.value,
                "numOfMaterials": Math.random() * 100 | 0,
                "creator": "Keelan Wollms"
            })

          console.log courses

          return courses
        # createdElm = yourCourses.appendChild(newCourseTemplate.content.cloneNode(true))
        # yourCourses.append(newCourseContainer)

        # courses = yourCourses.querySelectorAll(".course")
        # createdCourse = courses[courses.length - 2]
        input.value = ""

        # newCourseTitle = createdCourse.querySelector(".course-title")
        # newCourseTitle.textContent = inputText




