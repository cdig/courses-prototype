Take ["ChangeView", "Database", "DeleteMaterial", "AutosizeTextArea", "Draggable"], (ChangeView, Database, DeleteMaterial, AutosizeTextArea, Draggable)->
  Make "OpenCourse", OpenCourse = (courseData)->

    courseViewTitle = document.querySelector(".course-view-title")
    courseViewTitle.value = courseData.name

    scroller = document.querySelector(".scroller")
    scroller.innerHTML = "<svg id='timeline' xmlns='http://www.w3.org/2000/svg'></svg>"

    if courseData.materials[0]?
      for material in courseData.materials
        transparentBackground = if material.text == "" then "transparent" else ""
        templateUpper = "
          <div class='item-top'>
            <h2 class='item-header'>#{material.name}</h2>
            <h3 class='item-subheader'>#{material.item_type}</h3>
          </div>
          "
        templateLower = "
          <div class='add-material'>
            <div class='add-material-inner'>
              <a>+</a>
            </div>
          </div>
          <div class='item-card'>
            <div class='course-view-icon #{material.imageType}'>
              <img class='course-view-icon-image' src='#{material.image}'>
            </div>
            <label class='field-label'>Directions</label>
            <textarea class='field-text' rows='1' maxlength='350' readonly>#{material.text}</textarea>
            <a class='delete-material-button'>Delete</a>
          </div>
        "

        elmUpper = document.createElement("div")
        elmUpper.className = "upper-row"
        # Draggable elm
        # elm.setAttribute("draggable", true)
        elmUpper.innerHTML = templateUpper

        elmLower = document.createElement("div")
        elmLower.className = "lower-row"
        # Draggable elm
        # elm.setAttribute("draggable", true)
        elmLower.innerHTML = templateLower

        scroller.append(elmUpper)
        scroller.append(elmLower)


        # TODO: After generating the elements in for the item card, add the following to .field-text

        # Automatically resize the text area whenever its contents change
        # fieldTextElm.addEventListener "input", ()-> AutosizeTextArea(element)


    else
      noStuffHeader = document.createElement("div")
      noStuffHeaderText = document.createElement("h2")
      noStuffHeaderText.className = "no-stuff-header"
      noStuffHeaderText.textContent = "Add Stuff To Your Course"

      scroller.append(noStuffHeader)
      noStuffHeader.append(noStuffHeaderText)

    # This is good, generic "switch from one page to another" routing logic
    # TODO: Make a router
    courseListing = document.querySelector("#course-listing")
    courseView = document.querySelector("#course-view")
    ChangeView(courseListing, courseView, "horizontal", "flex")

    textElements = document.querySelectorAll('.field-text')
    textElements.forEach (element) =>
      element.style.cssText = "height: #{element.scrollHeight}px;"
      AutosizeTextArea(element)
