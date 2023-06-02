# This is dead code waiting to be rebuilt
# Render lowerRow, [
#   ["div", { class: "add-material-container" }, [
#     ["div", { class: "add-material-inner" }, [
#       ["a", { }, "+"]
#     ]]
#   ]]
# ]


Take ["Database", "DeleteMaterial", "AutosizeTextArea", "Draggable", "Render", "Route"], (Database, DeleteMaterial, AutosizeTextArea, Draggable, Render, Route)->
 
    renderItem = ({name, item_type, image, image_type, text})->

      upperRow = document.querySelector(".upper-row")
      lowerRow = document.querySelector(".lower-row")
      console.log(upperRow)

      Render upperRow, [
        ["div", { class: "item-top" }, [
          ["div", { class: "item-header" }, name]
          ["div", { class: "item-subheader" }, item_type]
        ]]
      ]


 

      #  Render sublistingElm, [
      #     ["div", { id: "course-#{id}", class: "course", courseId: id }, [
      #       ["h2", { class: "course-title" }, name ]
      #       ["div", { class: "course-buttons" }, [
      #         ["a", { class: "course-button #{buttonColor}", click }, buttonText]
      #       ]]
      #       ["div", { class: "course-bottom" }, [
      #         ["div", { class: "left-meta" }, "#{materials.length} Items"]
      #         ["div", { class: "right-meta" }, creator]
      #       ]]
      #     ]]
      #   ]

      
      console.log("Rendering")
      Render lowerRow, [
        ["div", { class: "item-card" }, [
          ["div", { class: "course-view-icon #{image_type}" }, [
              ["img", { class: "course-view-icon-image", src: image }, null]
          ]]
          ["label", { class: "field-label" }, "Directions"]
          ["textarea", { class: "field-text", rows: "1", maxlength: "350", readonly: "true" }, text]
          ["a", { class: "delete-material-button" }, "Delete"]
        ]]
      ]

    renderItems = (id)->
      console.log("Right", Route())
      console.log( id )
      if Route() is "course"
        if courses = Database.get "courses"
          courseData = courses.find (obj)-> obj.id is id
          console.log(courseData)
          for item in courseData.materials
            renderItem item


    Database.subscribe "courses", renderItems
    Route.subscribe "course", (id)-> renderItems(id)



    # courses = Database.get "courses"
    # return unless courses

    # courseData = courses.find (obj)-> obj.id is id

    
    

   

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
