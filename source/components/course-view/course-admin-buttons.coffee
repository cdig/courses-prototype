Take ["Route"], (Route)->

  Make "CourseAdminButtons", CourseAdminButtons = ()->

    clickEdit = ()-> Route "edit"
    clickReorder = ()-> Route "reorder"

    ["div", { class: "course-admin-buttons"}, [
      ["a", { class: "edit-button blue admin-button", click: clickEdit }, "Edit"]
      ["a", { class: "reorder-button blue admin-button", click: clickReorder }, "Reorder"]
    ]]


    # <div class="course-admin-buttons">
    #   <a class="edit-button blue admin-button">
    #     Edit
    #   </a>
    #   <a class="reorder-button blue admin-button">
    #     Reorder
    #   </a>
    # </div>

