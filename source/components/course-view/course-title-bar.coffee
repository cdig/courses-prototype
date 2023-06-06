Take ["BackToCourses", "CourseViewTitle", "CourseAdminButtons"], (BackToCourses, CourseViewTitle, CourseAdminButtons)->

  Make "CourseTitleBar", CourseTitleBar = (courseData)->
    ["div", { class: "course-title-bar" }, [
        BackToCourses()
        CourseViewTitle(courseData)
        CourseAdminButtons()
    ]]
