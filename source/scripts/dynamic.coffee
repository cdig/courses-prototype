courseListing = document.querySelector("#course-listing")
courseView = document.querySelector("#course-view")

courseBackground = document.querySelector(".course-background")
courseTitleBanner = document.querySelector(".course-title-background")
courseMaterialLines = document.querySelector("#timeline")
courseListingCourseTitles = document.querySelectorAll(".course-listing-course-titles")
addMaterialElms = document.querySelectorAll(".add-material")

addMaterialBanner = document.querySelector(".add-material-background")
newMaterialTemplate = document.querySelector("#new-material")
lunchboxSessionsCoursesElm = document.querySelector("#lunchbox-sessions-courses")
courseEditButton = document.querySelector(".edit-button")

setTitlePosition = (elm, selected)->
  elm.style.top = selected.getBoundingClientRect().top + window.scrollY

Make "AddListener", AddListener = (type ,target, callback)->
      target.addEventListener "click", ()->
        callback()

Make "AnimateElement", AnimateElement = (elm, keyframes, props)->
  elm.animate(keyframes, props).finished

Take ["ChangeView", "CreateSVGLine", "Database", "AddListener", "DeleteMaterial", "AutosizeTextArea", "Draggable"], (ChangeView, CreateSVGLine, Database, AddListener, DeleteMaterial, AutosizeTextArea, Draggable)->
  Make "OpenCourse", OpenCourse = (elm, courseData)->

    # Avoiding shadowing by declaring variables outside blocks
    # Logic Code
    for course, i in Database.get("courses")
      if course == courseData
        Database.set("openCourseIndex", i)
        break

    selectedCourse = elm.setAttribute("id", "selected")
    selected = elm.querySelector("#selected")
    title = elm.querySelector(".course-title")
    console.log(title)
    courseViewTitle = document.querySelector(".course-view-title")
    pageContent = document.querySelectorAll(".course:not(#selected, #header)")

    scroller = document.querySelector(".scroller")

    scroller.innerHTML = "<svg id='timeline' xmlns='http://www.w3.org/2000/svg'></svg>"

    addMaterialButtonTemplate = "
        
    "


    if courseData.materials[0]?
      for material, k in courseData.materials
        transparentBackground = if material.text == "" then "transparent" else ""
        templateTop = "
          <div class='item-top'>
            <h2 class='item-header'>#{material.name}</h2>
            <h3 class='item-subheader'>#{material.item_type}</h3>
          </div>
          "
        templateBottom = "
            <div class='add-material'>
              <div class='add-material-inner'>
                <a>
                  +
                </a>
              </div>
            </div>
            <div class='item-card'>
              <div class='icon-wrapper'>
                <div class='course-view-icon #{material.imageType}'><img class='course-view-icon-image' src='#{material.image}'></div>
              </div>
              <label class='field-label'>Directions</label>
              <textarea class='field-text' rows='1' maxlength='350' readonly>#{material.text}</textarea>
              <a class='delete-material-button'><div>Delete</div></a>
            </div>   
        "
        

        if k == 0
          addMaterialElm = document.createElement("div")
          addMaterialElm.className = "add-material-container"
          addMaterialElm.innerHTML = addMaterialButtonTemplate
          scroller.append(addMaterialElm)

          # for button in document.querySelectorAll(".add-material")
          # AddListener addMaterialElm, AddMaterials

          # Delete Material Listeners
    



        elm = document.createElement("div")
        elm.className = "lower-row"
        # Draggable elm
        # elm.setAttribute("draggable", true)
        # elm.innerHTML = template

        scroller.append(template)
        addMaterialElm = document.createElement("div")
        addMaterialElm.className = "add-material-container"
        addMaterialElm.innerHTML = addMaterialButtonTemplate
        scroller.append(addMaterialElm)
    else
      noStuffHeader = document.createElement("div")
      noStuffHeaderText = document.createElement("h2")
      noStuffHeaderText.className = "no-stuff-header"
      noStuffHeaderText.innerHTML = "Add Stuff To Your Course"

      scroller.append(noStuffHeader)
      noStuffHeader.append(noStuffHeaderText)

    console.log("textContent", title.textContent)
    courseViewTitle.value = title.textContent

    # TODO: Add in delete button functionality for new system

    # for button in document.querySelectorAll(".delete-material-button")
    #   AddListener "click", button, DeleteMaterial(button.closest(".course-view-material-container"))

    # for button in document.querySelectorAll(".add-material-container")
    #     AddListener "click", button, AddMaterialsView(button) 

    ChangeView(courseListing, courseView, "horizontal", "flex")

    textElements = document.querySelectorAll('.field-text')
    textElements.forEach (element) =>
      element.style.cssText = "height: #{element.scrollHeight}px;"
      AutosizeTextArea(element)
    
    CreateSVGLine()


  Take ["Database"], (Database)->
    Make "EditCourse", EditCourse = (editMode)->
      if !Database.get("reorderBool")
        editMode ?= !Database.get("editBool")

      # console.log
      # State Code
      Database.set("editBool", editMode)
      # reorderMode = Database.get("reorderBool")
      console.log(editMode)
      if editMode
        ReorderCourse(false)
        console.log("HereEdit")

      # View Code
      courseMaterials = courseView.querySelectorAll(".lower-row")
      courseViewTitle = document.querySelector(".course-view-title")

      # Redraw end caps every time
      endCapElms = document.querySelectorAll(".end-cap-lines")
      for endCap in endCapElms
          endCap.remove()

      if editMode
        if courseMaterials[0]?
          addMaterialButtons = courseView.querySelectorAll(".add-material-container")
          firstButton = addMaterialButtons[0]
          lastButton = addMaterialButtons[addMaterialButtons.length - 1]
          firstMaterial = courseMaterials[0].querySelector(".course-view-icon")
          lastMaterial = courseMaterials[courseMaterials.length - 1].querySelector(".course-view-icon")


      # View Code
      if editMode 
        document.body.setAttribute("edit-course-mode", "")
        courseViewTitle.removeAttribute("readonly")
      else
        document.body.removeAttribute("edit-course-mode")
        courseViewTitle.setAttribute("readonly", "")
        

      linkText = courseEditButton
      linkText.innerHTML = if editMode then "View" else "Edit"


      for material in courseMaterials
        text = material.querySelector(".field-text")
        if editMode
          text.removeAttribute("readonly")
          if !text.value.trim().length then material.classList.remove("transparent")
        else
          text.setAttribute("readonly", "")
          if !text.value.trim().length then material.classList.add("transparent")
          
          

      # State Maintenance
      courseIndex = Database.get("openCourseIndex")
      currentCourse = Database.get("courses")[courseIndex]

      if currentCourse? and !editMode
        currentCourse.name = courseViewTitle.value
        for material, i in courseMaterials
          image = material.querySelector(".course-view-icon-image").src.replace("#{window.location.href}", "/")
          currentCourse.materials[i].name = material.parentElement.querySelector(".item-header").textContent
          currentCourse.materials[i].item_type = material.parentElement.querySelector(".item-subheader").textContent
          currentCourse.materials[i].image = image
          currentCourse.materials[i].imageType = if material.querySelector(".screenshot") then "screenshot" else "icon"
          currentCourse.materials[i].text = material.querySelector(".field-text").value

        Database.notify("courses")

      # This should all be extracted to a function
      if editMode
        if courseMaterials[0]?
          courseIndex = Database.get("openCourseIndex")
          currentCourse = Database.get("courses")[courseIndex]
          for link, i in courseView.querySelectorAll(".add-material-container a")
            link.href = "http://localhost:3000/explore?course=#{currentCourse.id}&position=#{i}"


    Make "ReorderCourse", ReorderCourse = (reorderMode)->
      
      reorderMode ?= !Database.get("reorderBool")
      
      # State Code
      Database.set("reorderBool", reorderMode)

      if reorderMode
        EditCourse(false)

      courseView = document.querySelector("#course-view")

      courseContainer = document.querySelector(".scroller")
      courseMaterials = document.querySelectorAll(".upper-row")
      if reorderMode
        courseContainer.style.transform = "scale(0.75, 0.75)"
        for courseMaterial in courseMaterials
          courseMaterial.style.transform = "scale(1, 1)"
      else
        courseContainer.style.transform = "scale(1, 1)"
        for courseMaterial in courseMaterials
          courseMaterial.style.transform = "scale(1, 1)"

      courseViewContainer = document.querySelector(".scroller")

      CreateSVGLine()

      # State Maintenance
      courseIndex = Database.get("openCourseIndex")
      currentCourse = Database.get("courses")[courseIndex]

      if currentCourse? and !reorderMode
        for material, i in courseMaterials
          image = material.querySelector(".course-view-icon-image").src.replace("#{window.location.href}", "/")
          currentCourse.materials[i].name = material.querySelector(".item-header").textContent
          currentCourse.materials[i].item_type = material.querySelector(".item-subheader").textContent
          currentCourse.materials[i].image = image
          currentCourse.materials[i].imageType = if material.querySelector(".screenshot") then "screenshot" else "icon"
          currentCourse.materials[i].text = material.querySelector(".field-text").value

        Database.notify("courses")

      

  
  Take ["ChangeView", "Database", "EditCourse", "ReorderCourse"], (ChangeView, Database, EditCourse, ReorderCourse)->
    Make "CloseCourse", CloseCourse = (e)->

      # Select all the elements we need.
      body = document.querySelector("body")
      courseView = document.querySelector("#course-view")
      courseViewTitle = document.querySelector(".course-view-title")
      body.classList.remove("horizontal-scroll")
      body.classList.add("vertical-scroll")
      courseMaterialLines = document.querySelector("#timeline")
      

      EditCourse(false)
      ReorderCourse(false)

      selectedPos = 0
      courseViewTitle.style.top = null

      ChangeView(courseView, courseListing, "veritical", "block")
      courseMaterialLines.remove()
      Database.delete("openCourseIndex")
      

# Set Up Event Listeners
  Take ["NewCourse", "OpenCourse", "EditCourse", "CloseCourse", "DeleteMaterial", "AddMaterialToggle", "Database", "AddListener", "ReorderCourse", "CreateSVGLine", "AutosizeTextArea"], (NewCourse, OpenCourse, EditCourse, CloseCourse, DeleteMaterial, AddMaterialToggle, Database, AddListener, ReorderCourse, CreateSVGLine, AutosizeTextArea)->

    # New Course Listeners
    newCourseContainer = document.querySelector(".course.short")
    newCourseButton = newCourseContainer.querySelector(".course-button")
    newCourseInput = newCourseContainer.querySelector("input")

    newCourseButton.addEventListener "click", (e)->
      NewCourse(e, newCourseContainer)

    newCourseInput.addEventListener "keyup", (e)->
      NewCourse(e, newCourseContainer)


    # Edit Course Listeners
    editButton = document.querySelector(".edit-button")

    editButton.addEventListener "click", ()->
      EditCourse()

    reorderButton = document.querySelector(".reorder-button")

    reorderButton.addEventListener "click", ()->
      ReorderCourse()

    # Close Course Listeners
    backToCoursesElm = document.querySelector(".back-to-courses")

    backToCoursesElm.addEventListener "click", ()->
      CloseCourse()


    window.addEventListener "resize", ()->
      CreateSVGLine()

      textElements = document.querySelectorAll('.field-text')
      textElements.forEach (element) =>
        element.style.cssText = "height: #{element.scrollHeight}px;"
        AutosizeTextArea(element)

    Database.subscribe "editBool", (editBool)->
      if editBool
        textElements = document.querySelectorAll('.field-text')

        textElements.forEach (element) =>
          element.addEventListener "input", ()->
            AutosizeTextArea(element)

    # Add Material Listeners

    Database.subscribe "topics", (topics)->
      if topics?
        for button in document.querySelectorAll(".add-material-toggle")
          AddListener "click", button, AddMaterialToggle(button)


    Database.subscribe "reorderBool", (reorderBool)->
      draggableElements = document.querySelectorAll('.upper-row')
      
      for elm in draggableElements
        elm._draggable = reorderBool



  