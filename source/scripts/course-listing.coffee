Take ["Database", "DOOM", "OpenCourse"], (Database, DOOM, OpenCourse)->

  # TODO: This does not handle cases where DOM elements need to be reordered
  # TODO: Mutuates the attrs, which is probably not good
  renderElm = (tag, parent, attrs)->
    query = switch
      when attrs.query then attrs.query
      when attrs.id then "#" + attrs.id
      when attrs.class then "." + attrs.class.replace " ", "."
      else throw new Error "Need a query"

    elm = parent.querySelector(query) or DOOM.create tag, parent

    delete attrs.query

    DOOM elm, attrs

    elm


  declarativeRender = (parent, elementDefinitions)->

    for [tag, attrs, contents] in elementDefinitions
      elm = renderElm tag, parent, attrs

      if contents instanceof Array
        declarativeRender elm, contents
      else
        DOOM elm, textContent: contents

    null


  renderCourse = ({category, creator, id, materials, name, status})->

    sublistingElm = document.querySelector "##{category} > .loaded-courses"

    click = ()-> OpenCourse id

    buttonColor = if status is "continue" then "green" else "blue"
    buttonText = if status is "complete"
      "Review"
    else
      status[0].toUpperCase() + status[1..]

    declarativeRender sublistingElm, [
      ["div", { id: "course-#{id}", class: "course", courseId: id }, [
        ["h2", { class: "course-title" }, name ]
        ["div", { class: "course-buttons" }, [
          ["a", { class: "course-button #{buttonColor}" }, buttonText]
        ]]
        ["div", { class: "course-bottom" }, [
          ["div", { class: "left-meta" }, "#{materials.length} Items"]
          ["div", { class: "right-meta" }, creator]
        ]]
      ]]
    ]


#     courseElm = renderElm "div", sublistingElm,
#       query: "[course-id='#{id}']"
#       class: "course"
#       courseId: id
#
#
#     renderElm "h2", courseElm,
#       class: "course-title"
#       textContent: name
#
#
#     courseButtons = renderElm "div", courseElm,
#       class: "course-buttons"
#
#     DOOM.empty courseButtons
#     DOOM.create "a", courseButtons,
#       class: "course-button #{courseButtonConfig[status].color}"
#       textContent: courseButtonConfig[status].text
#       click: ()-> OpenCourse id
#
#
#     courseBottom = renderElm "div", courseElm,
#       class: "course-bottom"
#
#     renderElm "div", courseBottom,
#       class: "left-meta"
#       textContent: "#{materials.length} Items"
#
#     renderElm "div", courseBottom,
#       class: "right-meta"
#       textContent: creator




  renderCourses = ()->
    if courses = Database.get "courses"
      for courseData, courseIndex in courses
        renderCourse courseData, courseIndex


  # TODO: Maybe only do this if the course listing is visible, so that we're not thrashing invisible DOM stuff
  Database.subscribe "courses", renderCourses


