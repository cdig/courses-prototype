# IVAN: We have not gone through this one yet


Take ["Database"], (Database)->
  Make "DeleteMaterial", DeleteMaterial = (container, editMode)-> ()->
    editMode ?= !Database.get("editBool")

    deleteThis = document.querySelectorAll("." + container.classList[1])

    addMaterialContainer = container.nextSibling
    addMaterialContainer.remove()

    for material in deleteThis
      material.remove()

    courseLines = document.querySelector("#timeline")
    lines = courseLines.querySelectorAll("line")
    for line in lines
      line.remove()

    courseMaterialsToLoad = document.querySelectorAll(".upper-row")

    courseMaterials = courseView.querySelectorAll(".lower-row")
    addMaterialButtons = courseView.querySelectorAll(".add-material-container")

    return unless courseMaterials[0]?

    firstButton = addMaterialButtons[0]
    lastButton = addMaterialButtons[addMaterialButtons.length - 1]
    firstMaterial = courseMaterials[0].querySelector(".course-view-icon")
    lastMaterial = courseMaterials[courseMaterials.length - 1].querySelector(".course-view-icon")


#     # TODO: we removed openCourseIndex — good luck!
#     courseIndex = Database.get("openCourseIndex")
#     currentCourse = Database.get("courses")[courseIndex]
#
#     if currentCourse? and !editMode
#       for material, i in courseMaterials
#         currentCourse.materials[i].text = material.querySelector(".field-text").textContent
#
#       Database.notify("courses")
