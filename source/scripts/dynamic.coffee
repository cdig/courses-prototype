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

Take ["ChangeView", "CreateSVGLine", "Database"], (ChangeView, CreateSVGLine, Database)->
  Make "OpenCourse", OpenCourse = (elm)->

    console.log(elm)

    selectedCourse = elm.setAttribute("id", "selected")
    selected = elm.querySelector("#selected")
    title = elm.querySelector(".course-title")
    courseViewTitle = document.querySelector(".course-view-title")
    addMaterialViewTitle = document.querySelector(".add-material-view-title")
    pageContent = document.querySelectorAll(".course:not(#selected, #header)")
    courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material-container")


    courseViewTitle.textContent = title.textContent
    addMaterialViewTitle.textContent = title.textContent

    # TESTING

    courseSeedTwo = [
        {
            "name": "Update Test",
            "numOfMaterials": "Update Test",
            "creator": "Update Test"
        },
        {
            "name": "Update Test",
            "numOfMaterials": "Update Test",
            "creator": "Update Test"
        },
        {
            "name": "Update Test",
            "numOfMaterials": "Update Test",
            "creator": "Update Test"
        }
    ]

    updateCourseTitle = (value)->
      console.log(value)
      value = "STSTSS"

    Database.update("courses[0].name", updateCourseTitle)

    # TESTING
      
    
    ChangeView(courseListing, courseView, "horizontal")

    # bannerHeight = courseViewTitle.getBoundingClientRect().height * 3
    # courseTitleBanner.style.height = bannerHeight
    # addMaterialBanner.style.height = bannerHeight
    
    lineData = CreateSVGLine(courseMaterialsToLoad[0], courseMaterialsToLoad[courseMaterialsToLoad.length - 1])


  Take ["ChangeView", "Database"], (ChangeView, Database)->
    Make "EditCourse", EditCourse = ()->
      Database.set("editBool", !Database.get("editBool"))

      linkText = courseEditButton.querySelector("a")
      courseMaterials = courseView.querySelectorAll(".course-view-material")
      addMaterialButtons = courseView.querySelectorAll(".add-material-container")
      endCapElms = document.querySelectorAll(".end-cap-lines")

      if Database.get("editBool")
        for endCap in endCapElms
          endCap.remove()
        
        for button in addMaterialButtons
          button.style.opacity = "0"

        linkText.innerHTML = "Edit"

        return unless courseMaterials?

        for material in courseMaterials
          deleteButton = material.querySelector(".delete-material-button")

          buttonHeight = deleteButton.offsetHeight

          topStyle = window.getComputedStyle(deleteButton).getPropertyValue("top")
          topStyle = topStyle.replace("px", "")
          
          target = +topStyle - +buttonHeight

          deleteButton.style.top = target + "px"

          deleteButton.toggleAttribute("not-clickable")
          
      else
        for button in addMaterialButtons
          button.style.opacity = "1"

        linkText.innerHTML = "View"

        return unless courseMaterials?

        for material in courseMaterials
          deleteButton = material.querySelector(".delete-material-button")

          buttonHeight = deleteButton.offsetHeight

          topStyle = window.getComputedStyle(deleteButton).getPropertyValue("top")
          topStyle = topStyle.replace("px", "")
          
          target = +topStyle + +buttonHeight

          deleteButton.style.top = target + "px"

          deleteButton.toggleAttribute("not-clickable")

        

        return unless courseMaterials[0]?

        courseMaterials = courseView.querySelectorAll(".course-view-material")
        addMaterialButtons = courseView.querySelectorAll(".add-material-container")

        firstButton = addMaterialButtons[0]
        lastButton = addMaterialButtons[addMaterialButtons.length - 1]
        firstMaterial = courseMaterials[0].querySelector(".course-view-icon")
        lastMaterial = courseMaterials[courseMaterials.length - 1].querySelector(".course-view-icon")

        lineData = CreateSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, true)

  
  Take ["ChangeView", "Database", "EditCourse"], (ChangeView, Database, EditCourse)->
    Make "CloseCourse", CloseCourse = (e)->
      # Select all the elements we need.
      body = document.querySelector("body")
      courseView = document.querySelector("#course-view")
      courseViewTitle = document.querySelector(".course-view-title")
      body.classList.remove("horizontal-scroll")
      body.classList.add("vertical-scroll")

      if Database.get("editBool") == false
        EditCourse()

      selectedPos = 0
      courseViewTitle.style.top = null

      ChangeView(courseView, courseListing, "veritical")

      document.querySelector("#selected").removeAttribute("id", "selected")
      

# Set Up Event Listeners
  Take ["NewCourse", "OpenCourse", "EditCourse", "CloseCourse", "DeleteMaterial", "AddMaterials", "AddMaterialToggle", "BackToCourse"], (NewCourse, OpenCourse, EditCourse, CloseCourse, DeleteMaterial, AddMaterials, AddMaterialToggle, BackToCourse)->
    
    
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

    # Close Course Listeners
    backToCoursesElm = document.querySelector(".back-to-courses")

    backToCoursesElm.addEventListener "click", ()->
      CloseCourse()

    addListener = (target, callback)->
      target.addEventListener "click", ()->
        callback()

    # Delete Material Listeners
    for button in document.querySelectorAll(".delete-material-button")
      addListener button, DeleteMaterial(button.closest(".course-view-material-container")) 

    # Add Material Listeners
    backToCourseElm = document.querySelector(".back-to-course")

    backToCourseElm.addEventListener "click", ()->
      BackToCourse()

    for button in document.querySelectorAll(".add-material")
      addListener button, AddMaterials

    for button in document.querySelectorAll(".add-material-toggle")
      addListener button, AddMaterialToggle(button)
