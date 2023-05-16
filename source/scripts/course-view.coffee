Take [], ()->
  Make "CreateSVGLine", CreateSVGLine = (firstElm, lastElm, animate)->
    linesContainer = document.querySelector("#course-material-lines")
    console.log(linesContainer)
    lines = linesContainer.querySelectorAll("line")
    if lines?
      for line in lines
        line.remove()

    courseView = document.querySelector("#course-view")
    courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material")
    
    firstElm = courseMaterialsToLoad[0]
    lastElm = courseMaterialsToLoad[courseMaterialsToLoad.length - 1]
    console.log(firstElm, lastElm)
    return if !firstElm? or !lastElm?
    console.log(firstElm, lastElm.offsetLeft)
    return unless firstElm? and lastElm?
    courseMaterialLines = document.querySelector("#course-material-lines")

    lineCoords = {
      x1: (firstElm.getBoundingClientRect().left + (firstElm.getBoundingClientRect().width/2) + window.scrollX), 
      y1: (firstElm.getBoundingClientRect().top), 
      x2: (lastElm.getBoundingClientRect().left + (lastElm.getBoundingClientRect().width/2) + window.scrollX),
      y2: (lastElm.getBoundingClientRect().top)
      }
    
    line = document.createElementNS("http://www.w3.org/2000/svg", "line")
    courseMaterialLines.appendChild line

    line.setAttribute("style", "stroke:#E9EAED;stroke-width:15;stroke-linecap:round;")
    line.setAttribute("x1", lineCoords.x1)
    line.setAttribute("x2", lineCoords.x2)
    line.setAttribute("y1", lineCoords.y1)
    line.setAttribute("y2", lineCoords.y2)

    lineLength = line.getTotalLength()
    line.style.strokeDasharray = lineLength
    line.style.strokeDashoffset = "0"

    lineData = {lineElm: line, lineLength: lineLength}
    return lineData


Make "CreateSVGEndCaps", CreateSVGEndCaps = (firstMaterial, lastMaterial, firstButton, lastButton, animate)->
  courseMaterialLines = document.querySelector("#course-material-lines")
  # courseMaterialLines.innerHTML = ""
  # End Cap 1
  lineCoords = {
      x1: (firstMaterial.offsetLeft + (firstMaterial.offsetParent.offsetLeft) + (firstMaterial.offsetWidth/2)), 
      y1: (firstMaterial.offsetParent.offsetTop), 
      x2: (firstButton.offsetLeft + (firstButton.offsetWidth/2)),
      y2: (firstMaterial.offsetParent.offsetTop)
      }

  endCap = document.createElementNS("http://www.w3.org/2000/svg", "line")

  courseMaterialLines.appendChild endCap
  
  endCap.setAttribute("style", "stroke:#E9EAED;stroke-width:15;")
  endCap.setAttribute("x1", lineCoords.x1)
  endCap.setAttribute("x2", lineCoords.x2)
  endCap.setAttribute("y1", lineCoords.y1)
  endCap.setAttribute("y2", lineCoords.y2)
  endCap.setAttribute("class", "end-cap-lines")

  # End Cap 2
  lineCoords = {
      x1: (lastButton.offsetLeft + (lastButton.offsetWidth/2)), 
      y1: (lastMaterial.offsetParent.offsetTop), 
      x2: (lastMaterial.offsetLeft + (lastMaterial.offsetParent.offsetLeft) + (lastMaterial.offsetWidth/2)),
      y2: (lastMaterial.offsetParent.offsetTop)
      }

  endCap2 = document.createElementNS("http://www.w3.org/2000/svg", "line")

  courseMaterialLines.appendChild endCap2
  
  endCap2.setAttribute("style", "stroke:#E9EAED;stroke-width:15;")
  endCap2.setAttribute("x1", lineCoords.x1)
  endCap2.setAttribute("x2", lineCoords.x2)
  endCap2.setAttribute("y1", lineCoords.y1)
  endCap2.setAttribute("y2", lineCoords.y2)
  endCap2.setAttribute("class", "end-cap-lines")

  lineLengthEndCap = endCap.getTotalLength()
  endCap.style.strokeDasharray = lineLengthEndCap
  endCap.style.strokeDashoffset = "0"

  lineLengthEndCap2 = endCap2.getTotalLength()
  endCap2.style.strokeDasharray = lineLengthEndCap2
  endCap2.style.strokeDashoffset = "0"


  lineData = {
    line1: 
      line1Elm: endCap,
      line1Length: lineLengthEndCap,
    ,
    line2:
      line2Elm: endCap2,
      line2Length: lineLengthEndCap2,
    animate: animate
    }

  return lineData
  
Take ["CreateSVGLine", "CreateSVGEndCaps", "Database"], (CreateSVGLine, CreateSVGEndCaps, Database)->
  Make "DeleteMaterial", DeleteMaterial = (container, editMode)-> ()->
    editMode ?= !Database.get("editBool")

    # Partial Application
    deleteThis = document.querySelectorAll("." + container.classList[1])

    addMaterialContainer = container.nextSibling
    addMaterialContainer.remove()

    for material in deleteThis
      material.remove()

    courseLines = document.querySelector("#course-material-lines")
    lines = courseLines.querySelectorAll("line")
    for line in lines
      line.remove()

    courseMaterialsToLoad = document.querySelectorAll(".course-view-material-container")

    courseMaterials = courseView.querySelectorAll(".course-view-material")
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
        currentCourse.materials[i].text = material.querySelector(".course-view-text").textContent

      Database.notify("courses")

    CreateSVGLine(courseMaterialsToLoad[0], courseMaterialsToLoad[courseMaterialsToLoad.length - 1], false)
    CreateSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, false)


Take [], ()->

  getScrollHeight = (elm)->
    savedValue = elm.value
    elm.value = ''
    elm._baseScrollHeight = elm.scrollHeight
    elm.value = savedValue
    return

  Make "AutosizeTextArea", AutosizeTextArea = (elm)->
    minRows = elm.getAttribute('data-min-rows') | 0
    rows = undefined
    !elm._baseScrollHeight and getScrollHeight(elm)
    elm.rows = minRows
    rows = Math.ceil((elm.scrollHeight - (elm._baseScrollHeight)) / 20) 
    elm.rows = minRows + rows
    console.log("Rows: ", elm.rows)
    console.log("Autosizing")
    return
    
    

