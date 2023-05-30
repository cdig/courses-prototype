Take [], ()->
  Make "CreateSVGLine", CreateSVGLine = ()->
    # linesContainer = document.querySelector("#timeline")
    # lines = linesContainer.querySelectorAll("line")
    # if lines?
    #   for line in lines
    #     line.remove()

    # courseView = document.querySelector("#course-view")
    # courseMaterialsToLoad = courseView.querySelectorAll(".lower-row")

    # firstElm = courseMaterialsToLoad[0]
    # lastElm = courseMaterialsToLoad[courseMaterialsToLoad.length - 1]
    # return unless firstElm? and lastElm?

    # lineCoords = {
    #   x1: (firstElm.getBoundingClientRect().left + (firstElm.getBoundingClientRect().width/2)),
    #   y1: (firstElm.getBoundingClientRect().top),
    #   x2: (lastElm.getBoundingClientRect().left + (lastElm.getBoundingClientRect().width/2)),
    #   y2: (lastElm.getBoundingClientRect().top)
    #   }

    # line = document.createElementNS("http://www.w3.org/2000/svg", "line")
    # linesContainer.appendChild line

    # line.setAttribute("style", "stroke:#E9EAED;stroke-width:15;stroke-linecap:round;")
    # line.setAttribute("x1", lineCoords.x1)
    # line.setAttribute("x2", lineCoords.x2)
    # line.setAttribute("y1", lineCoords.y1)
    # line.setAttribute("y2", lineCoords.y2)
    console.log("CreateSVGLine Called")


Take ["CreateSVGLine", "Database"], (CreateSVGLine, Database)->
  Make "DeleteMaterial", DeleteMaterial = (container, editMode)-> ()->
    editMode ?= !Database.get("editBool")

    # Partial Application
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

    courseIndex = Database.get("openCourseIndex")
    currentCourse = Database.get("courses")[courseIndex]

    if currentCourse? and !editMode
      for material, i in courseMaterials
        currentCourse.materials[i].text = material.querySelector(".field-text").textContent

      Database.notify("courses")

    CreateSVGLine()
