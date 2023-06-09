Take ["AutosizeTextArea" ,"Database", "Route"], (AutosizeTextArea, Database, Route)->

  renderUpperItem = ({id, name, item_type, image, imageType, text})->
    ["div", { class: "item-top", id: "item-#{id}" }, [
      ["div", { class: "item-header" }, name]
      ["div", { class: "item-subheader" }, item_type]
    ]]


  renderAddItem = (courseId, index)->
    addAttrs =
      class: "add-item-container"
      id: "add-#{index}"
      isEditing: if Route.path() is "edit" then "" else null

    href = "http://localhost:3000/explore?course=#{courseId}&position=#{index}"
    ["div", addAttrs, [
      ["div", {class: "add-item"}, [
        ["div", { class: "add-item-inner" }, [
          ["a", { class: "add-item-link", href },

            # TODO Keelan: This should be an SVG that draws a +, rather than a "+" character
            "+"
          ]
        ]]
      ]]
    ]]


  renderLowerItem = (courseId, item)->
    {id, name, item_type, image, imageType, text} = item

    updateField = (e)->
      item.text = e.target.value # TODO: This sucks extreme ass
      Database.update "courses", (courses)-> courses # Kick the database

    fieldAttrs =
      class: "field-text"
      rows: "2"
      maxlength: "350"
      readonly: if Route.path() is "edit" then null else ""
      change: updateField
      input: updateField

    click = ()->
      Database.update "courses", (courses)->
        # TODO: This will break when we update Rails to use items instead of materials
        # TODO: This sucks mutable ass
        course = courses.find (c)-> c.id is courseId
        course.materials = course.materials.filter (v)-> v.id isnt id
        courses

    isEditing = if Route.path() is "edit" then "" else null

    transparent = if !text.trim().length and Route.path() isnt "edit" then "transparent" else null
    # transparentLabel

    ["div", { class: "item-card", id: "item-#{id}", transparent }, [
      ["div", { class: "course-view-icon #{imageType}" }, [
        ["img", { class: "course-view-icon-image", src: image }]
      ]]
      ["label", { class: "field-label", transparent }, "Directions"]

      # TODO: Find a way to visually indicate when the text is at the character length limit
      ["textarea", fieldAttrs, (elm)->
        DOOM elm, textContent: text
        AutosizeTextArea elm
      ]

      ["a", { class: "delete-item-button", click, isEditing }, "Delete"]
    ]]

  renderBar = (index, counter)->
    isEditing = if Route.path() is "edit" then "" else null
    ["timeline-bar", { class: "bar bar-#{index}-#{counter}", isEditing }, [
      ["div"]
    ]]


  lowerRowGenerator = (courseId, items)->
    for item, index in items
      yield renderAddItem courseId, index
      yield renderBar index, 1
      yield renderLowerItem courseId, item
      yield renderBar index, 2
    yield renderAddItem courseId, items.length


  Make "Scroller", Scroller = (course)->

    #TODO: Update this line when changing material to item in rails
    items = course.materials

    upperDefns = items.map renderUpperItem
    lowerDefns = [...lowerRowGenerator(course.id, items)]

    ["div", { class: "scroller", scrollSnapping: "" }, [
      ["div", { class: "upper-row" }, upperDefns]
      ["div", { class: "lower-row" }, lowerDefns]
    ]]

    # TODO: Add this stuff again
    # scroller.addEventListener "mousedown", ()->
    #     if Database.get("reorderBool")
    #         scroller.removeAttribute "scroll-snapping"
    # window.addEventListener "mouseup", ()->
    #     scroller.setAttribute "scroll-snapping", ""

