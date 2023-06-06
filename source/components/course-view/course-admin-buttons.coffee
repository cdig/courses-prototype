Take ["Route"], (Route)->

  Make "CourseAdminButtons", CourseAdminButtons = (course)->

    editButtonText = "Edit"
    clickEdit = ()-> Route "edit", course.id

    reorderButtonText = "Reorder"
    clickReorder = ()-> Route "reorder", course.id

    switch Route.path()
      when "edit"
        editButtonText = "View"
        clickEdit = ()-> Route "course", course.id
      when "reorder"
        reorderButtonText = "Done"
        clickReorder = ()-> Route "course", course.id


    ["div", { class: "course-admin-buttons"}, [
      ["a", { class: "edit-button button", click: clickEdit }, editButtonText]
      ["a", { class: "reorder-button button", click: clickReorder }, reorderButtonText]
    ]]
