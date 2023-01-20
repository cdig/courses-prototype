backToCourse = (e)->

  window.scrollTo({
    top: 0,
    left: 0,
    behavior: 'smooth'
  })

  changeView(addMaterialView, courseView, "horizontal")

  courseMaterials = courseView.querySelectorAll(".course-view-material")
  createSVGLine(courseMaterials[0], courseMaterials[courseMaterials.length - 1], false)

  window.addEventListener "wheel", changeScollToHorizontal


addMaterialToggle = (e)->
  toggled = !toggled
  toggleButtons = e.querySelectorAll(".toggle-button")

  if toggled
    newElm = courseViewContainer.appendChild(newMaterialTemplate.content.cloneNode(true))

    toggleButtons[0].style.transform = "translateY(-100%)"
    toggleButtons[1].style.transform = "translateY(-100%)"

  else
    # TODO This only works for one toggled material, should create an array of nodes or something
    if newElm?
      newElm.remove()

    toggleButtons[0].style.transform = "translateY(0)"
    toggleButtons[1].style.transform = "translateY(0)"


Make "add-materials"