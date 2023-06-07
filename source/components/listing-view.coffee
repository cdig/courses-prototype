Take ["Database", "ListingCourse", "Route"], (Database, ListingCourse, Route)->

  Make "ListingView", ListingView = ()->
    return unless Route.path() is "listing"
    return unless courses = Database.get "courses"

    # TODO: Not sure if this needs a better home
    courses = Array.from(courses).sort (a, b)->
      if a.status is "continue" and b.status isnt "continue"
        -1
      else if b.status is "continue" and a.status isnt "continue"
        1
      else
        a.name.localeCompare(b.name)

    yourCoursesDefs = courses.filter((c)-> c.category is "your-courses").map(ListingCourse)
    lbsCoursesDefs = courses.filter((c)-> c.category is "lunchbox-sessions-courses").map(ListingCourse)
    completedCoursesDefs = courses.filter((c)-> c.category is "completed-courses").map(ListingCourse)

    ["div", { id: "listing" }, [
      ["div", { class: "your-courses" }, [
        ["div", { class: "listing-course-titles" }, [
          ["h1", { class: "title" }, "Your Courses"]
          ["h2", { class: "subtitle" }, "Courses you have already started, or that have been assigned to your team."]
        ]]
        ["div", { class: "loaded-courses" }, yourCoursesDefs ]
      ]]
      ["div", { class: "new course-container" }, [
        ["div", { class: "course" }, [
          ["div", { class: "text-grid-container" }, [
            ["input", { autosize: "", id: "new-course-field", type: "text", maxlength: "500", rows: "1", placeholder: "Type a new course name." }]
          ]]
          ["div", { class: "course-buttons" }, [
            ["a", { class: "course-button blue" }, "Create"]
          ]]
          ["div", { class: "course-bottom"}]
        ]]
      ]]
      ["div", { class: "lunchbox-sessions-courses" }, [
        ["div", { class: "listing-course-titles" }, [
          ["h1", { class: "title" }, "LunchBox Sessions Courses"]
          ["h2", { class: "subtitle" }, "Courses created by LunchBox Sessions for you."]
        ]]
        ["div", { class: "loaded-courses" }, lbsCoursesDefs ]
      ]]
      ["div", { class: "completed-courses" }, [
        ["div", { class: "listing-course-titles" }, [
          ["h1", { class: "title" }, "Completed Courses"]
          ["h2", { class: "subtitle" }, "Courses you have already completed."]
        ]]
        ["div", { class: "loaded-courses" }, completedCoursesDefs ]
      ]]
    ]]
