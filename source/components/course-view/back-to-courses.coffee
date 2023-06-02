Take ["Database", "EditCourse", "ReorderCourse"], (Database, EditCourse, ReorderCourse)->

  elm = document.querySelector ".back-to-courses"

  elm.addEventListener "click", ()->

    # This is good, generic "switch from one page to another" routing logic
    # TODO: Make a router
    courseListing = document.querySelector("#listing")
    courseView = document.querySelector("#course-view")

    # This is logic specific to the Course View, and should go in some sort of "UnmountComponent"-like callback that is triggered by the above routing logic
    courseMaterialLines = document.querySelector("#timeline")
    courseMaterialLines.remove()
    EditCourse(false)
    ReorderCourse(false)
