# do ()->

 # Initialize Variables
selectedPos = 0
body = document.querySelector("body")
input = document.querySelector("#new-course-field")
yourCourses = document.querySelector("#your-courses")
newCourseContainer = document.querySelector(".new")
newCourseTemplate = document.querySelector("#new-course")
createCourseTemplate = document.querySelector("#create-course")
courseView = document.querySelector("#course-view")
courseViewContainer = document.querySelector(".course-view-container")
courseListing = document.querySelector("#course-listing")
courseCreateInput = document.querySelector(".course.short")
courseBackground = document.querySelector(".course-background")
courseTitleBanner = document.querySelector(".course-title-background")
backToCoursesElm = document.querySelector(".back-to-courses")
courseMaterialLines = document.querySelector("#course-material-lines")
courseListingCourseTitles = document.querySelectorAll(".course-listing-course-titles")
addMaterialElms = document.querySelectorAll(".add-material")
addMaterialView = document.querySelector("#add-material-view")
addMaterialBanner = document.querySelector(".add-material-background")
newMaterialTemplate = document.querySelector("#new-material")
lunchboxSessionsCoursesElm = document.querySelector("#lunchbox-sessions-courses")
courseEditButton = document.querySelector(".edit-button")

Take ["page-functions", "course-listing", "course-view", "add-materials"], ()->
  # console.log("Greetings from dynamic")
  # Make "some-other-thing", "?"

 

  toggled = false
  editBool = true

  setTitlePosition = (elm, selected)->
    elm.style.top = selected.getBoundingClientRect().top + window.scrollY

  openCourse = (elm)->

    selectedCourse = elm.setAttribute("id", "selected")
    selected = elm.querySelector("#selected")
    title = elm.querySelector(".course-title")
    courseView = document.querySelector("#course-view")
    courseViewTitle = document.querySelector(".course-view-title")
    addMaterialViewTitle = document.querySelector(".add-material-view-title")
    pageContent = document.querySelectorAll(".course:not(#selected, #header)")

    courseViewTitle.textContent = title.textContent
    addMaterialViewTitle.textContent = title.textContent 

    window.scrollTo({ top: 0, behavior: 'smooth' });
    
    changeView(courseListing, courseView, "horizontal")

    courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material-container")

    bannerHeight = courseViewTitle.getBoundingClientRect().height + 50
    courseTitleBanner.style.height = bannerHeight
    addMaterialBanner.style.height = bannerHeight
    
    lineData = createSVGLine(courseMaterialsToLoad[0], courseMaterialsToLoad[courseMaterialsToLoad.length - 1])

    window.addEventListener "wheel", changeScollToHorizontal

  editCourse = ()->
    editBool = !editBool

    linkText = courseEditButton.querySelector("a")
    courseMaterials = courseView.querySelectorAll(".course-view-material")
    addMaterialButtons = courseView.querySelectorAll(".add-material-container")
    endCapElms = document.querySelectorAll(".end-cap-lines")

    if editBool == true
      for endCap in endCapElms
        endCap.remove()
      
      for button in addMaterialButtons
        button.style.opacity = "0"

      linkText.innerHTML = "Edit"

      for material in courseMaterials
        deleteButton = material.querySelector(".delete-material-button")

        topStyle = window.getComputedStyle(deleteButton).getPropertyValue("top")
        topStyle = topStyle.replace("p", "")
        topStyle = topStyle.replace("x", "")
        
        target = +topStyle - -40

        deleteButton.style.top = target + "px"
        
    else

      for button in addMaterialButtons
        button.style.opacity = "1"

      linkText.innerHTML = "View"

      for material in courseMaterials
        deleteButton = material.querySelector(".delete-material-button")

        topStyle = window.getComputedStyle(deleteButton).getPropertyValue("top")
        topStyle = topStyle.replace("p", "")
        topStyle = topStyle.replace("x", "")
        
        target = +topStyle + +40

        deleteButton.style.top = target + "px"

      courseMaterials = courseView.querySelectorAll(".course-view-material")
      addMaterialButtons = courseView.querySelectorAll(".add-material-container")

      firstButton = addMaterialButtons[0]
      lastButton = addMaterialButtons[addMaterialButtons.length - 1]
      firstMaterial = courseMaterials[0].querySelector(".course-view-icon")
      lastMaterial = courseMaterials[courseMaterials.length - 1].querySelector(".course-view-icon")

      lineData = createSVGEndCaps(firstMaterial, lastMaterial, firstButton, lastButton, true)

  addMaterials = (e)->
    if editBool == false
      editCourse()

    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'smooth'
    })

    changeView(courseView, addMaterialView, "vertical")

  closeCourse = (e)->
    # Select all the elements we need.
    body = document.querySelector("body")
    courseView = document.querySelector("#course-view")
    courseViewTitle = document.querySelector(".course-view-title")
    body.classList.remove("horizontal-scroll")
    body.classList.add("vertical-scroll")

    if editBool == false
      editCourse()

    window.removeEventListener "wheel", changeScollToHorizontal

    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'smooth'
    })

    selectedPos = 0
    courseViewTitle.style.top = null

    changeView(courseView, courseListing)

    document.querySelector("#selected").removeAttribute("id", "selected") 

  input.addEventListener "keyup", newCourse






