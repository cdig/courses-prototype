Take ["Route"], (Route)->

  Make "CourseViewTitle", CourseViewTitle = (currentCourse)->

    attrs =
      class: "course-view-title"
      type: "text"
      maxlength: "500"
      rows: "1"
      value: currentCourse.name

    # if Route.get() isnt "edit"
    #   attrs.readonly = ""

    ["input", attrs]
