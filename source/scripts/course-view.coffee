

createSVGLine = (firstElm, lastElm, animate)->
  firstSum = if firstElm.classList.contains("icon") then -1 else if firstElm.classList.contains("screenshot") then 0 else 1
  lastSum = if lastElm.classList.contains("icon") then 1 else if lastElm.classList.contains("screenshot") then 0 else 0

  icon = firstElm.querySelector(".course-view-icon")
  icon2 = lastElm.querySelector(".course-view-icon")

  lineCoords = {
    x1: (icon.offsetLeft + icon.offsetParent.offsetLeft + icon.offsetWidth + firstSum), 
    y1: (icon.offsetTop + icon.offsetParent.offsetTop), 
    x2: (icon2.offsetLeft + icon2.offsetParent.offsetLeft + lastSum), 
    y2: (icon.offsetTop + icon.offsetParent.offsetTop)
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


createSVGEndCaps = (firstMaterial, lastMaterial, firstButton, lastButton, animate)->
  # End Cap 1
  sumButton = 1
  sumIcon2 = if firstMaterial.classList.contains("icon") then 1 else if firstMaterial.classList.contains("screenshot") then 0 else 0

  lineCoords = {x1: (firstMaterial.offsetLeft + firstMaterial.offsetParent.offsetLeft + sumIcon2), y1: (firstMaterial.offsetTop + firstMaterial.offsetParent.offsetTop), x2:(firstButton.offsetLeft + firstButton.offsetWidth - sumButton), y2: (firstMaterial.offsetTop + firstMaterial.offsetParent.offsetTop)}
  endCap = document.createElementNS("http://www.w3.org/2000/svg", "line")

  courseMaterialLines.appendChild endCap
  
  endCap.setAttribute("style", "stroke:#E9EAED;stroke-width:15;")
  endCap.setAttribute("x1", lineCoords.x1)
  endCap.setAttribute("x2", lineCoords.x2)
  endCap.setAttribute("y1", lineCoords.y1)
  endCap.setAttribute("y2", lineCoords.y2)
  endCap.setAttribute("class", "end-cap-lines")

  # End Cap 2

  sumButton = 1
  sumIcon2 = if lastMaterial.classList.contains("icon") then 1 else if lastMaterial.classList.contains("screenshot") then 0 else 0

  lineCoords = {x1: (lastMaterial.offsetLeft + lastMaterial.offsetParent.offsetLeft + lastMaterial.offsetWidth - sumIcon2), y1: (lastMaterial.offsetTop + lastMaterial.offsetParent.offsetTop), x2:(lastButton.offsetLeft + sumButton), y2: (lastMaterial.offsetTop + lastMaterial.offsetParent.offsetTop)}
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
  

deleteMaterial = (e)->
  deleteThis = document.querySelectorAll("." + e.classList[1])

  for material in deleteThis
    material.remove()

  lines = document.querySelectorAll("line")
  for line in lines
    line.remove()

  courseMaterialsToLoad = document.querySelectorAll(".course-view-material-container")

  courseMaterials = courseView.querySelectorAll(".course-view-material")
  addMaterialButtons = courseView.querySelectorAll(".add-material-container")

  firstButton = addMaterialButtons[0]
  lastButton = addMaterialButtons[addMaterialButtons.length - 1]
  firstMaterial = courseMaterials[0].querySelector(".course-view-icon")
  lastMaterial = courseMaterials[courseMaterials.length - 1].querySelector(".course-view-icon")

  createSVGLine(courseMaterialsToLoad[0], courseMaterialsToLoad[courseMaterialsToLoad.length - 1], false)
  createSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, false)


Make "course-view"