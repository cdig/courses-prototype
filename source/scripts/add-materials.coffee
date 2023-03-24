Take ["ChangeView", "CreateSVGLine"], (ChangeView, CreateSVGLine)->
  Make "AddMaterialToggle", AddMaterialToggle = (button)-> ()->
    courseViewContainer = document.querySelector(".course-view-container")

    toggled = !toggled
    toggleButtons = button.querySelectorAll(".toggle-button")

    if toggled
      newElm = courseViewContainer.appendChild(newMaterialTemplate.content.cloneNode(true))

      # The truth is in the DOM, be careful about the DOM - don't do, set up a call with Ivan to fix this issue in prototype

      toggleButtons[0].style.transform = "translateY(-100%)"
      toggleButtons[1].style.transform = "translateY(-100%)"

      courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material-container")


    else
      # TODO This only works for one toggled material, should create an array of nodes or something
      if newElm?
        newElm.remove()

      toggleButtons[0].style.transform = "translateY(0%)"
      toggleButtons[1].style.transform = "translateY(0%)"



    

