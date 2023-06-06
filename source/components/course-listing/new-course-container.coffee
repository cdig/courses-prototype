Take ["NewCourse"], (NewCourse)->

#   newCourseButton = document.querySelector(".new.course-container .course-button")
#   newCourseInput = document.querySelector(".new.course-container input")
#
#   createCourse = ()->
#     NewCourse newCourseInput.value
#     newCourseInput.value = ""
#
#   newCourseButton.addEventListener "click", createCourse
#
#   newCourseInput.addEventListener "keyup", (e)->
#     # TODO: Make sure e.key is the one we're supposed to use
#     createCourse() if e.key is "Enter"
