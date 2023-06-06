Take ["BackToCourses", "CourseViewTitle", "CourseAdminButtons"], (BackToCourses, CourseViewTitle, CourseAdminButtons)->

  Make "CourseTitleBar", CourseTitleBar = (course)->
    ["div", { class: "course-title-bar" }, [
        BackToCourses()
        CourseViewTitle(course)
        CourseAdminButtons(course)
    ]]
