# This is dead code waiting to be rebuilt


Take ["Database", "DeleteMaterial", "AutosizeTextArea", "Draggable"], (Database, DeleteMaterial, AutosizeTextArea, Draggable)->
  Make "OpenCourse", OpenCourse = (id)->

    courses = Database.get "courses"
    return unless courses

    courseData = courses.find (obj)-> obj.id is id

    courseViewTitle = document.querySelector(".course-view-title")
    courseViewTitle.value = courseData.name

    scroller = document.querySelector(".scroller")
    scroller.innerHTML = "<svg id='timeline' xmlns='http://www.w3.org/2000/svg'></svg>"

    elmUpper = document.createElement("div")
    elmUpper.className = "upper-row"

    elmLower = document.createElement("div")
    elmLower.className = "lower-row"

    scroller.append(elmUpper)
    scroller.append(elmLower)

    if courseData.materials[0]?
      for material in courseData.materials
        transparentBackground = if material.text == "" then "transparent" else ""
        templateUpper = "
          <h2 class='item-header'>#{material.name}</h2>
          <h3 class='item-subheader'>#{material.item_type}</h3>
          "
        templateAddMaterial = "
          <div class='add-material'>
            <div class='add-material-inner'>
              <a>+</a>
            </div>
          </div>
        "
        templateLower = "
          <div class='course-view-icon #{material.imageType}'>
            <img class='course-view-icon-image' src='#{material.image}'>
          </div>
          <label class='field-label'>Directions</label>
          <textarea class='field-text' rows='1' maxlength='350' readonly>#{material.text}</textarea>
          <a class='delete-material-button'>Delete</a>
        "

        itemTop = document.createElement("div")
        itemTop.className = "item-top"
        addMaterial = document.createElement("div")
        addMaterial.className = "add-material-container"
        itemCard = document.createElement("div")
        itemCard.className = "item-card"

        # Draggable elm
        # elm.setAttribute("draggable", true)
        itemTop.innerHTML = templateUpper
        elmUpper.append itemTop

        addMaterial.innerHTML = templateAddMaterial
        elmLower.append addMaterial

        itemCard.innerHTML = templateLower
        elmLower.append itemCard





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

    textElements = document.querySelectorAll('.field-text')
    textElements.forEach (element) =>
      element.style.cssText = "height: #{element.scrollHeight}px;"
      AutosizeTextArea(element)
