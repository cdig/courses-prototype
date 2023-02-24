
Take [], ()->
  Make "CreateSVGLine", CreateSVGLine = (firstElm, lastElm, animate)->
    return unless firstElm? and lastElm?

    lineCoords = {
      x1: (firstElm.offsetLeft + (firstElm.offsetWidth/2)), 
      y1: (firstElm.offsetTop), 
      x2: (lastElm.offsetLeft + (lastElm.offsetWidth/2)),
      y2: (lastElm.offsetTop)
      }
    
    line = document.createElementNS("http://www.w3.org/2000/svg", "line")
    courseMaterialLines.appendChild line

    line.setAttribute("style", "stroke:#E9EAED;stroke-width:15;")
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
  
Take ["CreateSVGLine", "CreateSVGEndCaps"], (CreateSVGLine, CreateSVGEndCaps)->
  Make "DeleteMaterial", DeleteMaterial = (container)-> ()->
    # Partial Application
    deleteThis = document.querySelectorAll("." + container.classList[1])

    for material in deleteThis
      material.remove()

    lines = document.querySelectorAll("line")
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

    CreateSVGLine(courseMaterialsToLoad[0], courseMaterialsToLoad[courseMaterialsToLoad.length - 1], false)
    CreateSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, false)



