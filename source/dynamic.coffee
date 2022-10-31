selectedPos = 0
animationSpeed = 1
input = document.querySelector('input')
yourCourses = document.querySelector("#your-courses")
newCourseContainer = document.querySelector(".new")
newCourseTemplate = document.querySelector("#new-course")
createCourseTemplate = document.querySelector("#create-course")
courseView = document.querySelector("#course-view")
courseListing = document.querySelector("#course-listing")
courseCreateInput = document.querySelector(".course.short")
courseBackground = document.querySelector(".course-background")
courseTitleBanner = document.querySelector(".course-title-background")
backToCoursesElm = document.querySelector(".back-to-courses")
animateFalling = [{ transform: 'translateY(-1000%)'}]
timing = {duration: "1s"}

animateElement = (elm, keyframes, props)->
  elm.animate(keyframes, props).finished

# getSelectedCoursePos = (elm)->
#   return elm.querySelector(".course-title").getBoundingClientRect().top + window.scrollY
setTitlePosition = ()->


openCourse = (elm)->

  courseView.style.pointerEvents = "auto"
  body = document.querySelector("body")
  selectedCourse = elm.setAttribute("id", "selected")
  selected = elm.querySelector("#selected")
  title = elm.querySelector(".course-title")

  selectedPos = title.getBoundingClientRect().top + window.scrollY

  courseView = document.querySelector("#course-view")
  courseViewTitle = document.querySelector(".course-view-title")
  courseViewTitle.textContent = title.textContent

  courseViewTitle.style.top = selectedPos

  pageContent = document.querySelectorAll(".course:not(#selected, #header)")
  

  console.log(selectedPos)
  courseViewTitle.style.top = selectedPos

  console.log courseViewTitle.style.top


  for i in pageContent
    await i.animate([{ transform: 'translateY(0)'},{ transform: 'translateY(100vh)'}], {duration: 1000 / animationSpeed, iterations: 1, fill: "both", easing: "ease-in-out"})
  
  window.scrollTo({ top: 0, behavior: 'smooth' });

  courseView.style.display = "block"
  courseListing.style.pointerEvents = "none"
  backToCoursesElm.style.left = "-300px"
  body.classList.add("horizontal-scroll")

  console.log(courseViewTitle.style.top)

  fading(courseView, "In")
  fading(courseListing, "Out")

  courseMaterialsToLoad = courseView.querySelectorAll(".course-view-material")

  for i in courseMaterialsToLoad
    i.style.transform = "translateY(700px)"
    icon = i.querySelector(".course-view-icon")
    icon.style.width = "0"
    icon.style.height = "0"



  await sleep 1000 / animationSpeed
  courseViewTitle.style.top = selectedPos
  # courseListing.classList.toggle("horizontal-scroll")

  courseTitleBanner.style.height = courseViewTitle.getBoundingClientRect().height + 50

  await animateElement courseViewTitle, [{ fontSize: "1.5em"},{ fontSize: "2em"}],
    duration: 200 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseViewTitle, [{top: selectedPos}, {top: "115px"}],
    duration: 200 / animationSpeed
    fill: "both" 
    iterations: 1
    easing: "ease-in-out"

  animateElement backToCoursesElm, [{left: "-300px"}, {left: "100px"}],
    duration: 200 / animationSpeed
    fill: "both" 
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseTitleBanner, [{width: "0"}, {width: "100%"}],
    duration: 500 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  for i in courseMaterialsToLoad
    icon = i.querySelector(".course-view-icon")
    await animateElement i, [{transform: "translateY(700px)"}, {transform: "translate(0px)"}],
      duration: 300 / animationSpeed
      fill: "both"
      iterations: 1
      easing: "ease-in-out"

    animateElement icon, [{width: "0", height: "0"}, {width: "175px", height: "175px"}, {width: "150px", height: "150px"}],
      duration: 400 / animationSpeed
      fill: "both"
      iterations: 1
      easing: "ease-in-out"

  await animateElement courseTitleBanner, [{borderBottom: "0px solid #1C325E"}, {borderBottom: "15px solid #1C325E"}, {borderBottom: "10px solid #1C325E"}],
    duration: 500 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseTitleBanner, [{background: "hsl(230, 50%, 30%)"}, {background: "linear-gradient(90deg, hsl(230, 50%, 30%) 0%, hsl(227, 45%, 40%) 50%, hsl(230, 50%, 30%) 100%)"}],
    duration: 500 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  

  console.log(courseMaterialsToLoad)

  


closeCourse = (e)->

  body = document.querySelector("body")
  courseView = document.querySelector("#course-view")
  courseViewTitle = document.querySelector(".course-view-title")
  body.classList.remove("horizontal-scroll")
  body.classList.add("vertical-scroll")
  
  animateElement backToCoursesElm, [{left: "100px"}, {left: "-300px"}],
    duration: 200 / animationSpeed
    fill: "both" 
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseTitleBanner, [{background: "linear-gradient(90deg, hsl(230, 50%, 30%) 0%, hsl(227, 45%, 40%) 50%, hsl(230, 50%, 30%) 100%)"}, {background: "hsl(230, 50%, 30%)"}],
    duration: 500 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseTitleBanner, [{borderBottom: "10px solid #1C325E"}, {borderBottom: "15px solid #1C325E"}, {borderBottom: "0px solid #1C325E"}],
    duration: 500 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseTitleBanner, [{width: "100%"}, {width: "0"}],
    duration: 500 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  # courseListing.style.display = "inline"
  
  await animateElement courseViewTitle, [{top: "115px"}, {top: selectedPos}],
    duration: 200 / animationSpeed
    fill: "both" 
    iterations: 1
    easing: "ease-in-out"

  await animateElement courseViewTitle, [{ fontSize: "2em" }, { fontSize: "1.5em" }],
    duration: 200 / animationSpeed
    fill: "both"
    iterations: 1
    easing: "ease-in-out"

  fading(courseListing, "In")

  courseListingLoadAnimation(courseListing)

  await sleep 1000 / animationSpeed

  fading(courseView, "Out")
  
  body.classList.remove("horizontal-scroll")
  body.classList.add("vertical-scroll")

  courseListing.style.pointerEvents = "auto"

  courseView.style.pointerEvents = "none"

  selectedPos = 0
  courseViewTitle.style.top = "0px"
  console.log(selectedPos)
  document.querySelector("#selected").removeAttribute("id", "selected")
  
  

newCourse = (e)->
  if e.key == 'Enter' || e == 'onClick'
    if input.value.length > 0
      inputText = input.value
      createdElm = yourCourses.appendChild(newCourseTemplate.content.cloneNode(true))
      yourCourses.append(newCourseContainer)
      courseCreateInput = document.querySelector(".course.short")

      courses = yourCourses.querySelectorAll(".course")
      createdCourse = courses[courses.length - 2]
      input.value = ""

      newCourseTitle = createdCourse.querySelector(".course-title")
      newCourseTitle.textContent = inputText
      input = document.querySelector('input')
      courseCreateAnimation(createdCourse)

courseListingLoadAnimation = (page)->

  coursesToLoad = courseListing.querySelectorAll(".course:not(#selected, #header)")
  console.log coursesToLoad
  for i in coursesToLoad
    i.style.opacity = 0
  for i in coursesToLoad
    i.animate([{ transform: "translateY(50px)", opacity: "0" }, {transform: "translateY(25px)", opacity: "0" }, { transform: "translateY(0)", opacity: "1" }], { duration: 1000 / animationSpeed, fill: "both", easing: "ease-in-out", iterations: 1 })
    await sleep 100 / animationSpeed


courseCreateAnimation = (e)->
  titleLoadIn = e.querySelector(".course-title")
  leftMeta = e.querySelector(".left-meta")
  leftMetaText = leftMeta.querySelector("p")
  rightMeta = e.querySelector(".right-meta")
  rightMetaText = rightMeta.querySelector("p")

  courseCreateInput = document.querySelector(".course.short")

  courseCreateInput.style.transform = "translateY(-175)"
  newCourseContainer.style.zIndex = "-1"

  leftMetaText.style.transform = "translateY(50px)"
  rightMetaText.style.transform = "translateY(50px)"

  
  e.animate([{ transform: "scale(1.1)" }], { delay: 300 / animationSpeed, duration: 300 / animationSpeed, fill: "both", easing: "ease-in-out" }).finished.then(()->
    e.animate([{ transform: "scale(1)" }], { delay: 200 / animationSpeed, duration: 200 / animationSpeed, fill: "both", easing: "ease-in-out", iterations: 1 })

  titleLoadIn.animate([{ transform: "scale(1) rotate(0deg)" }, { transform: "scale(1.4) rotate(5deg)" }, { transform: "scale(1.4) rotate(-5deg)" }, { transform: "scale(1) rotate(0deg)" }], { duration: 700 / animationSpeed, fill: "both", easing: "ease-in-out", iterations: 1 })
  leftMetaText.animate([{ transform: "translateY(50px)" }, { transform: "translateY(-10px)" }, { transform: "translateY(0px)" }], { duration: 700 / animationSpeed, fill: "both", easing: "ease-in-out"})
  rightMetaText.animate([{ transform: "translateY(50px)" }, { transform: "translateY(-10px)" }, { transform: "translateY(0px)" }], { duration: 700 / animationSpeed, fill: "both", easing: "ease-in-out"}))

  courseCreateInput.animate([{ transform: "translateY(-175px)" }, {transform: "translateY(0px)"}],{ delay: 1000, duration: 300 / animationSpeed, fill: "both", easing: "ease-in-out", iterations: 1 })

  await sleep 3000

  newCourseContainer.style.zIndex = "1"

# Sleep
sleep = (ms)->
  new Promise (resolve) ->
    window.setTimeout resolve, ms

fading = (elm, type)->
  if type == "In"
    await animateElement elm, [{opacity: 0}, {opacity: 1}],
      duration: 1000 / animationSpeed
      fill: "both"
      iterations: 1
      easing: "ease-in-out"
  if type == "Out"
    await animateElement elm, [{opacity: 1}, {opacity: 0}],
      duration: 1000 / animationSpeed
      fill: "both"
      iterations: 1
      easing: "ease-in-out"

input.addEventListener "keyup", newCourse
document.addEventListener "onLoad", courseListingLoadAnimation(courseListing)



