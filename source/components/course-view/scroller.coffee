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
      editing: if Route.path() is "edit" then "" else null

    href = "http://localhost:3000/explore?course=#{courseId}&position=#{index}"
    ["div", addAttrs, [
      ["div", {class: "add-item"}, [
        ["div", { class: "add-item-inner" }, [
          ["a", { class: "add-item-link", href }, "+"]
        ]]
      ]]
    ]]

  renderLowerItem = (item)->
    {id, name, item_type, image, imageType, text} = item

    updateField = (e)->
      AutosizeTextArea(e.target)
      text = e.target.value
      item.text = text # TODO: This sucks extreme ass
      Database.update "courses", (courses)-> courses # Kick the database

    fieldAttrs =
      class: "field-text"
      rows: "1"
      maxlength: "350"
      readonly: if Route.path() is "edit" then null else ""
      change: updateField
      input: updateField
    ["div", { class: "item-card", id: "item-#{id}" }, [
      ["div", { class: "course-view-icon #{imageType}" }, [
        ["img", { class: "course-view-icon-image", src: image }]
      ]]
      ["label", { class: "field-label" }, "Directions"]
      ["textarea", fieldAttrs, text]
      ["a", { class: "delete-item-button" }, "Delete"]
    ]]

  lowerRowGenerator = (courseId, items)->
    for item, index in items
      yield renderAddItem courseId, index
      yield renderLowerItem item
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

