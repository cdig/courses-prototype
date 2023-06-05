# This is dead code waiting to be rebuilt
#


Take ["Database", "Render", "Route"], (Database, Render, Route)->

  upperRow = document.querySelector(".upper-row")
  lowerRow = document.querySelector(".lower-row")

  renderUpperMaterial = ({id, name, item_type, image, imageType, text})->
    ["div", { class: "item-top", id: "item-#{id}" }, [
      ["div", { class: "item-header" }, name]
      ["div", { class: "item-subheader" }, item_type]
    ]]

  renderAddItem = (courseId, index)->
    href = "/explore?course=#{courseId}&position=#{index}"
    ["div", { class: "add-material-container", id: "add-#{index}" }, [
      ["div", {class: "add-material"}, [
        ["div", { class: "add-material-inner" }, [
          ["a", { class: "add-material-link", href }, "+"]
        ]]
      ]]
    ]]

  renderLowerMaterial = ({id, name, item_type, image, imageType, text})->
    ["div", { class: "item-card", id: "item-#{id}" }, [
      ["div", { class: "course-view-icon #{imageType}" }, [
        ["img", { class: "course-view-icon-image", src: image }]
      ]]
      ["label", { class: "field-label" }, "Directions"]
      ["textarea", { class: "field-text", rows: "1", maxlength: "350", readonly: "true" }, text]
      ["a", { class: "delete-material-button" }, "Delete"]
    ]]

  lowerRowGenerator = (courseId, materials)->
    for material, index in materials
      yield renderAddItem courseId, index
      yield renderLowerMaterial material
    yield renderAddItem courseId, materials.length

  courseId = null

  renderItems = ()->
    return unless Route.path() is "course"
    return unless courses = Database.get "courses"
    [courseId] = Route.args()

    # TODO: Courses should be stored in a hash?? Database should support queries?
    courseData = courses.find (course)-> course.id is courseId

    upperDefns = courseData.materials.map renderUpperMaterial
    lowerDefns = [...lowerRowGenerator(courseId, courseData.materials)]

    Render upperRow, upperDefns
    Render lowerRow, lowerDefns


  Database.subscribe "courses", renderItems
  Route.subscribe "course", renderItems


  # courseViewTitle = document.querySelector(".course-view-title")
  # courseViewTitle.value = courseData.name


  # scroller.innerHTML = "<svg id='timeline' xmlns='http://www.w3.org/2000/svg'></svg>"

  # elmUpper = document.createElement("div")
  # elmUpper.className = "upper-row"

  # elmLower = document.createElement("div")
  # elmLower.className = "lower-row"

  # scroller.append(elmUpper)
  # scroller.append(elmLower)

  # if courseData.materials[0]?
  #   for material in courseData.materials
  #     transparentBackground = if material.text == "" then "transparent" else ""




  #     itemTop = document.createElement("div")
  #     itemTop.className = "item-top"
  #     addMaterial = document.createElement("div")
  #     addMaterial.className = "add-material-container"
  #     itemCard = document.createElement("div")
  #     itemCard.className = "item-card"

  #     # Draggable elm
  #     # elm.setAttribute("draggable", true)
  #     itemTop.innerHTML = templateUpper
  #     elmUpper.append itemTop

  #     addMaterial.innerHTML = templateAddMaterial
  #     elmLower.append addMaterial

  #     itemCard.innerHTML = templateLower
  #     elmLower.append itemCard





      # TODO: After generating the elements in for the item card, add the following to .field-text

      # Automatically resize the text area whenever its contents change
      # fieldTextElm.addEventListener "input", ()-> AutosizeTextArea(element)


  # else
  #   noStuffHeader = document.createElement("div")
  #   noStuffHeaderText = document.createElement("h2")
  #   noStuffHeaderText.className = "no-stuff-header"
  #   noStuffHeaderText.textContent = "Add Stuff To Your Course"

  #   scroller.append(noStuffHeader)
  #   noStuffHeader.append(noStuffHeaderText)

  # textElements = document.querySelectorAll('.field-text')
  # textElements.forEach (element) =>
  #   element.style.cssText = "height: #{element.scrollHeight}px;"
  #   AutosizeTextArea(element)
