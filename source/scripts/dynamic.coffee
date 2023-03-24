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

Take ["ChangeView", "CreateSVGLine", "Database", "AddListener", "DeleteMaterial"], (ChangeView, CreateSVGLine, Database, AddListener, DeleteMaterial)->
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
    courseViewTitle = document.querySelector(".course-view-title")
    addMaterialViewTitle = document.querySelector(".add-material-view-title")
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


    if courseData.materials?
      for material, k in courseData.materials
        transparentBackground = if material.text == "" then "transparent" else ""
        template = "
          <div class='course-view-material #{transparentBackground}'>
            <h2 class='course-view-header'>#{material.name}</h2>
            <h3 class='course-view-subheader'>#{material.type}</h3>
            <div class='icon-wrapper'>
              <div class='course-view-icon #{material.imageType}'><img class='course-view-icon-image' src='/image/#{material.image}'></div>
            </div>
            <p class='course-view-text'>#{material.text}</p>
            <!-- <div class='course-view-material-background'></div> -->
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
        elm.setAttribute("draggable", "true")
        elm.innerHTML = template

        courseViewContainer.append(elm)
        addMaterialElm = document.createElement("div")
        addMaterialElm.className = "add-material-container"
        addMaterialElm.innerHTML = addMaterialButtonTemplate
        courseViewContainer.append(addMaterialElm)


    courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material-container")
    courseViewTitle.textContent = title.textContent
    addMaterialViewTitle.textContent = title.textContent

    for button in document.querySelectorAll(".delete-material-button")
        AddListener "click", button, DeleteMaterial(button.closest(".course-view-material-container")) 

    ChangeView(courseListing, courseView, "horizontal")
    
    lineData = CreateSVGLine(courseMaterialsToLoad[0], courseMaterialsToLoad[courseMaterialsToLoad.length - 1])


  Take ["Database"], (Database)->
    Make "EditCourse", EditCourse = (editMode)->
      editMode ?= !Database.get("editBool")
      # State Code
      Database.set("editBool", editMode)

      # View Code
      courseMaterials = courseView.querySelectorAll(".course-view-material")
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

          lineData = CreateSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, true)

      # View Code
      if editMode 
        document.body.setAttribute("edit-course-mode", "")
        courseViewTitle.setAttribute("contenteditable", "")
      else
        document.body.removeAttribute("edit-course-mode")
        courseViewTitle.removeAttribute("contenteditable")

      linkText = courseEditButton.querySelector("a")
      linkText.innerHTML = if editMode then "View" else "Edit"


      for material in courseMaterials
        text = material.querySelector(".course-view-text")
        if editMode
          text.setAttribute("contenteditable", "")
          if !text.textContent.trim().length then material.classList.remove("transparent")
        else
          text.removeAttribute("contenteditable")
          if !text.textContent.trim().length then material.classList.add("transparent")
          
          

      # State Maintenance
      courseIndex = Database.get("openCourseIndex")
      currentCourse = Database.get("courses")[courseIndex]

      if currentCourse? and !editMode
        currentCourse.name = courseViewTitle.textContent
        for material, i in courseMaterials
          currentCourse.materials[i].text = material.querySelector(".course-view-text").textContent

        Database.notify("courses")


  Take ["Database", "EditCourse"], (Database, EditCourse)->
    Make "ReorderCourse", ReorderCourse = (reorderMode)->
      reorderMode ?= !Database.get("reorderBool")
      editMode = Database.get("editBool")
      
      # State Code
      Database.set("reorderBool", reorderMode)

      if reorderMode and editMode
        EditCourse()
      else if !reorderMode and editMode
        EditCourse()


      courseContainer = document.querySelector(".course-view-container")
      courseMaterials = document.querySelectorAll(".course-view-material-container")
      if reorderMode
        courseContainer.style.transform = "scale(0.75, 0.75)"
        for courseMaterial in courseMaterials
          courseMaterial.style.transform = "scale(1.05, 1.05)"
          courseMaterial.classList.add("draggable")
      else
        courseContainer.style.transform = "scale(1, 1)"
        for courseMaterial in courseMaterials
          courseMaterial.style.transform = "scale(1, 1)"
          courseMaterial.classList.remove("draggable")

      courseViewContainer = document.querySelector(".course-view-container")

      

  
  Take ["ChangeView", "Database", "EditCourse"], (ChangeView, Database, EditCourse)->
    Make "CloseCourse", CloseCourse = (e)->

      # Select all the elements we need.
      body = document.querySelector("body")
      courseView = document.querySelector("#course-view")
      courseViewTitle = document.querySelector(".course-view-title")
      body.classList.remove("horizontal-scroll")
      body.classList.add("vertical-scroll")

      EditCourse(false)

      selectedPos = 0
      courseViewTitle.style.top = null

      ChangeView(courseView, courseListing, "veritical")
      Database.delete("openCourseIndex")
      

# Set Up Event Listeners
  Take ["NewCourse", "OpenCourse", "EditCourse", "CloseCourse", "DeleteMaterial", "AddMaterials", "AddMaterialToggle", "BackToCourse", "Database", "AddListener", "ReorderCourse"], (NewCourse, OpenCourse, EditCourse, CloseCourse, DeleteMaterial, AddMaterials, AddMaterialToggle, BackToCourse, Database, AddListener, ReorderCourse)->
    
    
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

    


    # Add Material Listeners
    backToCourseElm = document.querySelector(".back-to-course")

    backToCourseElm.addEventListener "click", ()->
      BackToCourse()

    Database.subscribe "sessions", (sessions)->
      if sessions?
        for button in document.querySelectorAll(".add-material-toggle")
          AddListener "click", button, AddMaterialToggle(button)



    getDrag = (container, x)->
      draggableElements = [...container.querySelectorAll(".draggable:not(.dragging)")]

      return draggableElements.reduce((closest, child)->
        box = child.getBoundingClientRect()
        offset = x - box.left - box.width / 2
        # console.log(offset)
        console.log(closest.offset)
        if offset < 0 && offset > closest.offset
          return { offset: offset, element: child}
        else
          # console.log(closest)
          return closest

      , {offset: Number.NEGATIVE_INFINITY, }).element

    Database.subscribe "reorderBool", (reorderBool)->
      if reorderBool
        draggableItems = document.querySelectorAll(".draggable")

        # draggableItems.forEach()
        draggableItems.forEach (draggable, index) ->
          draggable.addEventListener 'dragstart', ->
            draggable.classList.add("dragging")
            return
          return

        draggableItems.forEach (draggable, index) ->
          draggable.addEventListener 'dragend', ->
            draggable.classList.remove("dragging")
            return
          return
        
        container = document.querySelector(".course-view-container")
        container.addEventListener "dragover", (e)->
          e.preventDefault()
          afterElement = getDrag(container, e.clientX)
          
          # console.log(afterElement)
          draggable = document.querySelector(".dragging")
          console.log(afterElement)
          if afterElement == null
            container.appendChild(draggable)
          else
            container.insertBefore(draggable, afterElement)
          
          

        
# const offset = x - box.left + box.width / 2
#     if (offset < 0 && offset > closest.offset) {
#       return { offset: offset, element: child }
#     } else {
#       return closest
#     }

