courseListing = document.querySelector("#course-listing")
courseView = document.querySelector("#course-view")

courseBackground = document.querySelector(".course-background")
courseTitleBanner = document.querySelector(".course-title-background")
courseMaterialLines = document.querySelector("#course-material-lines")
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

Take ["ChangeView", "CreateSVGLine", "Database", "AddListener", "DeleteMaterial", "AutosizeTextArea"], (ChangeView, CreateSVGLine, Database, AddListener, DeleteMaterial, AutosizeTextArea)->
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

    courseViewContainer = document.querySelector(".course-view-container")

    courseViewContainer.innerHTML = "<svg id='course-material-lines' xmlns='http://www.w3.org/2000/svg'></svg>"

    addMaterialButtonTemplate = "
        <div class='add-material'>
          <div class='add-material-inner'>
            <a>
              +
            </a>
          </div>
        </div>
    "


    if courseData.materials[0]?
      for material, k in courseData.materials
        transparentBackground = if material.text == "" then "transparent" else ""
        template = "
          <h2 class='course-view-header'>#{material.name}</h2>
          <h3 class='course-view-subheader'>#{material.item_type}</h3>
          <div class='course-view-material #{transparentBackground}'>
            <div class='icon-wrapper'>
              <div class='course-view-icon #{material.imageType}'><img class='course-view-icon-image' src='#{material.image}'></div>
            </div>
            <label class='course-view-label'>Directions</label>
            <textarea class='course-view-text' rows='3' data-min-rows='3' maxlength='350' readonly>#{material.text}</textarea>
            <a class='delete-material-button'><div>Delete</div></a>
          </div>     
        "

        if k == 0
          addMaterialElm = document.createElement("div")
          addMaterialElm.className = "add-material-container"
          addMaterialElm.innerHTML = addMaterialButtonTemplate
          courseViewContainer.append(addMaterialElm)

          # for button in document.querySelectorAll(".add-material")
          # AddListener addMaterialElm, AddMaterials

          # Delete Material Listeners
    



        elm = document.createElement("div")
        elm.className = "course-view-material-container material-#{k}"
        # elm.setAttribute("draggable", true)
        elm.innerHTML = template

        courseViewContainer.append(elm)
        addMaterialElm = document.createElement("div")
        addMaterialElm.className = "add-material-container"
        addMaterialElm.innerHTML = addMaterialButtonTemplate
        courseViewContainer.append(addMaterialElm)
    else
      noStuffHeader = document.createElement("div")
      noStuffHeaderText = document.createElement("h2")
      noStuffHeaderText.className = "no-stuff-header"
      noStuffHeaderText.innerHTML = "Add Stuff To Your Course"

      console.log("Here")
      courseViewContainer.append(noStuffHeader)
      noStuffHeader.append(noStuffHeaderText)

    courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material-container")
    console.log("textContent", title.textContent)
    courseViewTitle.value = title.textContent

    for button in document.querySelectorAll(".delete-material-button")
        AddListener "click", button, DeleteMaterial(button.closest(".course-view-material-container"))

    # for button in document.querySelectorAll(".add-material-container")
    #     AddListener "click", button, AddMaterialsView(button) 

    ChangeView(courseListing, courseView, "horizontal")

    textElements = document.querySelectorAll('.course-view-text')
    textElements.forEach (element) =>
      AutosizeTextArea(element)
    
    CreateSVGLine()


  Take ["Database"], (Database)->
    Make "EditCourse", EditCourse = (editMode)->
      if !Database.get("reorderBool")
        editMode ?= !Database.get("editBool")
      # State Code
      Database.set("editBool", editMode)
      # reorderMode = Database.get("reorderBool")

      # ReorderCourse()

      # View Code
      courseMaterials = courseView.querySelectorAll(".course-view-material")
      courseViewTitle = document.querySelector(".course-view-title")

      reorderButton = document.querySelector(".reorder-button")

      if editMode
        reorderButton.style.opacity = "1"
        reorderButton.style.pointerEvents = "auto"
      # else
      #   reorderButton.style.opacity = "0"
      #   reorderButton.style.pointerEvents = "none"

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

          # lineData = CreateSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, true)

      # View Code
      if editMode 
        document.body.setAttribute("edit-course-mode", "")
        courseViewTitle.removeAttribute("readonly")
      else
        document.body.removeAttribute("edit-course-mode")
        courseViewTitle.setAttribute("readonly", "")
        

      linkText = courseEditButton.querySelector("a")
      linkText.innerHTML = if editMode then "View" else "Edit"


      for material in courseMaterials
        text = material.querySelector(".course-view-text")
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
          currentCourse.materials[i].name = material.parentElement.querySelector(".course-view-header").textContent
          currentCourse.materials[i].item_type = material.parentElement.querySelector(".course-view-subheader").textContent
          currentCourse.materials[i].image = image
          currentCourse.materials[i].imageType = if material.querySelector(".screenshot") then "screenshot" else "icon"
          currentCourse.materials[i].text = material.querySelector(".course-view-text").value

        Database.notify("courses")

      # This should all be extracted to a function
      if editMode
        if courseMaterials[0]?
          courseIndex = Database.get("openCourseIndex")
          currentCourse = Database.get("courses")[courseIndex]
          for link, i in courseView.querySelectorAll(".add-material-container a")
            link.href = "http://localhost:3000/explore?course=#{currentCourse.id}&position=#{i}"


  Take ["Database", "EditCourse"], (Database, EditCourse)->
    Make "ReorderCourse", ReorderCourse = (reorderMode)->
      
      reorderMode ?= !Database.get("reorderBool")
      editMode = Database.get("editBool")
      
      # State Code
      Database.set("reorderBool", reorderMode)

      EditCourse()

      courseView = document.querySelector("#course-view")

      courseContainer = document.querySelector(".course-view-container")
      courseMaterials = document.querySelectorAll(".course-view-material-container")
      html = document.querySelector("html")
      if reorderMode
        courseContainer.style.transform = "scale(0.75, 0.75)"
        # html.style.transform = "scale(0.75, 0.75)"
        # courseView.style.transform = "scale(0.75, 0.75)"
        for courseMaterial in courseMaterials
          courseMaterial.style.transform = "scale(1, 1)"
          courseMaterial.classList.add("draggable")
      else
        courseContainer.style.transform = "scale(1, 1)"
        for courseMaterial in courseMaterials
          courseMaterial.style.transform = "scale(1, 1)"
          courseMaterial.classList.remove("draggable")

      courseViewContainer = document.querySelector(".course-view-container")

      CreateSVGLine()

      # State Maintenance
      courseIndex = Database.get("openCourseIndex")
      currentCourse = Database.get("courses")[courseIndex]

      if currentCourse? and !editMode and !reorderMode
        for material, i in courseMaterials
          image = material.querySelector(".course-view-icon-image").src.replace("#{window.location.href}", "/")
          currentCourse.materials[i].name = material.querySelector(".course-view-header").textContent
          currentCourse.materials[i].item_type = material.querySelector(".course-view-subheader").textContent
          currentCourse.materials[i].image = image
          currentCourse.materials[i].imageType = if material.querySelector(".screenshot") then "screenshot" else "icon"
          currentCourse.materials[i].text = material.querySelector(".course-view-text").value

        Database.notify("courses")

      

  
  Take ["ChangeView", "Database", "EditCourse", "ReorderCourse"], (ChangeView, Database, EditCourse, ReorderCourse)->
    Make "CloseCourse", CloseCourse = (e)->

      # Select all the elements we need.
      body = document.querySelector("body")
      courseView = document.querySelector("#course-view")
      courseViewTitle = document.querySelector(".course-view-title")
      body.classList.remove("horizontal-scroll")
      body.classList.add("vertical-scroll")
      courseMaterialLines = document.querySelector("#course-material-lines")
      

      EditCourse(false)
      ReorderCourse(false)

      selectedPos = 0
      courseViewTitle.style.top = null

      ChangeView(courseView, courseListing, "veritical")
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

    Database.subscribe "editBool", (editBool)->
      if editBool
        textElements = document.querySelectorAll('.course-view-text')
        textElements.forEach (element) =>
          element.addEventListener "input", ()->
            AutosizeTextArea(element)

    # Add Material Listeners

    Database.subscribe "topics", (topics)->
      if topics?
        for button in document.querySelectorAll(".add-material-toggle")
          AddListener "click", button, AddMaterialToggle(button)



    # getClosestElm = (container, x)->
    #   draggableElements = container.querySelectorAll(".draggable:not(.dragging)")

    #   closestElm = null
    #   closestDistance = Infinity

    #   for elm in draggableElements
    #     box = elm.getBoundingClientRect()
    #     distance = box.right - x

    #     if distance > 0 and distance < closestDistance
    #       closestDistance = distance
    #       closestElm = elm

    #   return closestElm


      # Reduce
      # draggableElements = [...container.querySelectorAll(".draggable:not(.dragging)")]
      # return draggableElements.reduce((closest, child)->
      #   box = child.getBoundingClientRect()
      #   offset = x - box.left - box.width / 2
      # FUNCTIONAL PROGRAMMING WAY: Map over draggables, as you map over them you turn each element into an array where you have the elm the second spot would be the distance
      # then filter them to remove distances that are positive and then reduce over them to find the closest elm -> offset > closest.offset
      #   if offset < 0 && offset > closest.offset
      #     return { offset: offset, element: child}
      #   else
      #     return closest

      # , {offset: Number.NEGATIVE_INFINITY, }).element

    # getClosestElm = (container, x) ->
    #     draggableElements = container.querySelectorAll(".draggable:not(.dragging)")

    #     closestElm = null
    #     closestDistance = Infinity
    #     lastElm = null

    #     for elm in draggableElements
    #       box = elm.getBoundingClientRect()
    #       middleX = (box.left + box.right) / 2
    #       distance = Math.abs(middleX - x)
    #       lastElm = elm

    #       if x > middleX and distance < closestDistance
    #         closestDistance = distance
    #         closestElm = elm.nextSibling
    #         if closestElm?.classList.contains('add-material-container')
    #           closestElm = closestElm.nextSibling

    #       if x <= middleX and distance < closestDistance
    #         closestDistance = distance
    #         closestElm = elm
    #         if closestElm?.previousSibling?.classList.contains('add-material-container')
    #           closestElm = closestElm.previousSibling

    #     console.log("Distance to closest element:", closestDistance) # Add console.log to see the distance

    #     if closestElm == null
    #       closestElm = lastElm.nextSibling
    #     else if x > lastElm.getBoundingClientRect().right
    #       closestElm = lastElm.nextSibling

    #     return closestElm



    Database.subscribe "reorderBool", (reorderBool)->
      if reorderBool
        draggableElements = document.querySelectorAll('.course-view-material-container.draggable')
        container = document.querySelector('.course-view-container')

        for element in draggableElements
          new Draggable element

    Draggable = (element) ->
      deviceType = ''
      events =
        mouse:
          down: 'mousedown'
          move: 'mousemove'
          up: 'mouseup'
        touch:
          down: 'touchstart'
          move: 'touchmove'
          up: 'touchend'
      drag = null

      init = ->
        isTouchDevice()
        element.addEventListener events[deviceType].down, (event) =>
          dragStart event

        element.addEventListener events[deviceType].up, (event) =>
          dragEnd event

      isTouchDevice = ->
        try
          document.createEvent('TouchEvent')
          deviceType = 'touch'
          return true
        catch e
          deviceType = 'mouse'
          return false

      getClosestElm = (container, x) ->
        draggableElements = container.querySelectorAll(".draggable:not(.dragging)")

        closestElm = null
        closestDistance = Infinity

        for elm in draggableElements
          box = elm.getBoundingClientRect()
          distance = box.right - box.width - x

          if distance > 0 and distance < closestDistance
            closestDistance = distance
            closestElm = elm

        return closestElm

      dragStart = (event) ->
        event.preventDefault()
        element.style.opacity = '0.5'
        element.style.zIndex = '1000'
        element.classList.add 'dragging'

        initialX = if not isTouchDevice() then event.clientX else event.touches[0].clientX
        initialY = if not isTouchDevice() then event.clientY else event.touches[0].clientY
        offsetLeft = initialX - element.getBoundingClientRect().left

        moveElement = true

        addMaterialContainer = element.nextElementSibling

        drag = (event) ->
          if moveElement
            event.preventDefault()
            newX = if not isTouchDevice() then event.clientX else event.touches[0].clientX
            newY = if not isTouchDevice() then event.clientY else event.touches[0].clientY

            deltaX = newX - initialX + offsetLeft
            element.style.transform = "translateX(#{deltaX - element.style.width}px)"

            if addMaterialContainer?
              addMaterialContainer.style.transform = "translateX(#{deltaX}px)"

            closestElm = getClosestElm(element.parentNode, newX - offsetLeft)
            if closestElm?
              if closestElm.previousSibling == null
                element.parentNode.insertBefore element, closestElm
                if addMaterialContainer?
                  element.parentNode.insertBefore addMaterialContainer, element
              else
                element.parentNode.insertBefore element, closestElm
                if addMaterialContainer?
                  element.parentNode.insertBefore addMaterialContainer, element.nextSibling
            else
              element.parentNode.appendChild element
              if addMaterialContainer?
                element.parentNode.appendChild addMaterialContainer

            # closestElm = getClosestElm(element.parentNode, newX - offsetLeft)
            # if closestElm?
            #   if closestElm.previousSibling == null
            #     element.parentNode.insertBefore element, closestElm
            #   else
            #     element.parentNode.insertBefore element, closestElm.nextSibling

        document.addEventListener events[deviceType].move, drag
        document.addEventListener events[deviceType].up, dragEnd

      dragEnd = (event) ->
        moveElement = false
        document.removeEventListener events[deviceType].move, drag
        element.style.opacity = '1'
        element.style.zIndex = ''
        element.style.transform = ''
        element.classList.remove 'dragging'

        if addMaterialContainer?
          addMaterialContainer.style.transform = ''

      init()
