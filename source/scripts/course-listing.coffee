Take ["Database", "DOOM", "OpenCourse"], (Database, DOOM, OpenCourse)->

  courseButtonConfig =
    start:
      color: "blue", text: "Start"
    continue:
      color: "green", text: "Continue"
    complete:
      color: "blue", text: "Review"


  # TODO: This does not handle cases where DOM elements need to be reordered
  # TODO: Mutuates the attrs, which is probably not good
  renderElm = (tag, parent, attrs)->

    query = switch
      when attrs.query then attrs.query
      when attrs.id then "#" + attrs.id
      when attrs.class then "." + attrs.class
      else throw new Error "Need a query"

    elm = parent.querySelector(query) or DOOM.create tag, parent

    delete attrs.query

    DOOM elm, attrs

    elm



#   getFirst = (map)-> return [k, v] for k, v of map
#
#
#   declarativeRender = (parent, children)->
#     for child in children
#       [tag, attrs] = getFirst child


  renderCourse = ({category, creator, id, materials, name, status})->

    sublistingElm = document.querySelector "##{category}"

    # declarativeRender sublistingElm, [
    #   {"div.course":
    #     query: "[course-id='#{id}']"
    #     courseId: id
    #     content: [
    #       {"h2.course-title":
    #         content: name
    #       },
    #       {"div.course-buttons":
    #         content: [
    #           {"a.course-button.#{courseButtonConfig[status].color}":
    #             click: ()-> OpenCourse id # TODO: This causes an error, as expected, when we use renderElm
    #             content: courseButtonConfig[status].text
    #           }
    #         ]
    #       },
    #       {"div.course-bottom":
    #         content: [
    #           {"div.left-meta":
    #             content: "#{materials.length} Items"
    #           },
    #           {"div.right-meta":
    #             content: creator
    #           }
    #         ]
    #       }
    #     ]
    #   }
    # ]


    courseElm = renderElm "div", sublistingElm,
      query: "[course-id='#{id}']"
      class: "course"
      courseId: id


    renderElm "h2", courseElm,
      class: "course-title"
      textContent: name


    courseButtons = renderElm "div", courseElm,
      class: "course-buttons"

    DOOM.empty courseButtons

    DOOM.create "a", courseButtons,
      class: "course-button #{courseButtonConfig[status].color}"
      textContent: courseButtonConfig[status].text
      click: ()-> OpenCourse id # TODO: This causes an error, as expected, when we use renderElm


    courseBottom = renderElm "div", courseElm,
      class: "course-bottom"

    renderElm "div", courseBottom,
      class: "left-meta"
      textContent: "#{materials.length} Items"

    renderElm "div", courseBottom,
      class: "right-meta"
      textContent: creator




  renderCourses = ()->
    if courses = Database.get "courses"
      for courseData, courseIndex in courses
        renderCourse courseData, courseIndex


  # TODO: Maybe only do this if the course listing is visible, so that we're not thrashing invisible DOM stuff
  Database.subscribe "courses", renderCourses


