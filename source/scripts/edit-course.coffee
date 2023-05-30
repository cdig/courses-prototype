Take ["Database"], (Database)->
  Make "EditCourse", EditCourse = (editMode)->

    # Toggle the reorderBool if it wasn't passed in
    editMode ?= Database.update "editBool", (b)-> !b

    # Turn off ReorderCourse whenever we turn on EditCourse — TODO: Reorder and Edit should just be sub-routes of Course View
    ReorderCourse = await Take.async "ReorderCourse"
    ReorderCourse(false) if editMode

    # Make the course title editable
    courseViewTitle = document.querySelector(".course-view-title")
    if editMode
      courseViewTitle.removeAttribute("readonly")
    else
      courseViewTitle.setAttribute("readonly", "")

    # Toggle the edit mode attr on body so that styles are updated accordingly
    if editMode
      document.body.setAttribute("edit-course-mode", "")
    else
      document.body.removeAttribute("edit-course-mode")

    # Update all item elms in the course
    courseMaterials = courseView.querySelectorAll(".lower-row")
    for material in courseMaterials
      text = material.querySelector(".field-text")
      if editMode
        text.removeAttribute("readonly")
        material.classList.remove("transparent") # TODO: This should happen whenever the text changes (eg: if the server pushes an update, say) — but when we make the view code a pure function of the DB, that should happen automagically
      else
        text.setAttribute("readonly", "")
        if !text.value.trim().length then material.classList.add("transparent")


  # Persist changes to materials to the Database
#     courseIndex = Database.get("openCourseIndex")
#     currentCourse = Database.get("courses")[courseIndex]
#
#     if currentCourse? and !editMode
#       currentCourse.name = courseViewTitle.value
#       for material, i in courseMaterials
#         image = material.querySelector(".course-view-icon-image").src.replace("#{window.location.href}", "/")
#         currentCourse.materials[i].name = material.parentElement.querySelector(".item-header").textContent
#         currentCourse.materials[i].item_type = material.parentElement.querySelector(".item-subheader").textContent
#         currentCourse.materials[i].image = image
#         currentCourse.materials[i].imageType = if material.querySelector(".screenshot") then "screenshot" else "icon"
#         currentCourse.materials[i].text = material.querySelector(".field-text").value
#
#       Database.notify("courses")

    # Set up the Add Item buttons
    # if editMode
    #   if courseMaterials[0]?
    #     # TODO: we removed openCourseIndex — good luck!
    #     courseIndex = Database.get("openCourseIndex")
    #     currentCourse = Database.get("courses")[courseIndex]
    #     for link, i in courseView.querySelectorAll(".add-material-container a")
    #       link.href = "http://localhost:3000/explore?course=#{currentCourse.id}&position=#{i}"
