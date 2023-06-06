Take ["Database", "Route"], (Database, Route)->

  renderCourse = ({category, creator, id, materials, name, status})->
    #TODO: Remove this line when changing material to item in rails
    items = materials

    click = ()-> Route "course", id

    buttonColor = if status is "continue" then "green" else "blue"
    buttonText = if status is "complete"
      "Review"
    else
      status[0].toUpperCase() + status[1..]

    [
      ["div", { id: "course-#{id}", class: "course", courseId: id }, [
        ["h2", { class: "course-title" }, name ]
        ["div", { class: "course-buttons" }, [
          ["a", { class: "course-button #{buttonColor}", click }, buttonText]
        ]]
        ["div", { class: "course-bottom" }, [
          ["div", { class: "left-meta" }, "#{items.length} Items"]
          ["div", { class: "right-meta" }, creator]
        ]]
      ]]
    ]

  Make "ListingView", ListingView = ()->
    return unless Route.path() is "listing"
    return unless courses = Database.get "courses"

    yourCoursesDefs = courses.filter((c)-> c.category is "your-courses").map(renderCourse)
    lbsCoursesDefs = courses.filter((c)-> c.category is "lunchbox-sessions-courses").map(renderCourse)
    completedCoursesDefs = courses.filter((c)-> c.category is "completed-courses").map(renderCourse)

    ["div", { id: "listing" }, [

    ]]


    #   <div id="your-courses">
    #
    #     <div class="listing-course-titles">
    #       <h1 class="title">Your Courses</h1>
    #       <h2 class="subtitle">Courses you have already started, or that have been assigned to your team.</h2>
    #     </div>
    #
    #     # ["div", { class: "loaded-courses" }, yourCoursesDefs ]
    #     <div class="loaded-courses"></div>
    #
    #     <div class="new course-container">
    #       <div class="course">
    #         <div class="text-grid-container">
    #           <input autosize id="new-course-field" type="text" maxlength="500" rows="1" placeholder="Type a new course name."></input>
    #         </div>
    #         <div class="course-buttons">
    #           <a class="course-button blue">Create</a>
    #         </div>
    #         <div class="course-bottom"></div>
    #       </div>
    #     </div>
    #
    #   </div>
    #
    #   <div id="lunchbox-sessions-courses">
    #     <div class="listing-course-titles">
    #       <h1 class="title">LunchBox Sessions Courses</h1>
    #       <h2 class="subtitle">Courses created by LunchBox Sessions for you.</h2>
    #     </div>
    #     <div class="loaded-courses"></div>
    #   </div>
    #
    #   <div id="completed-courses">
    #     <div class="listing-course-titles">
    #       <h1 class="title">Completed Courses</h1>
    #       <h2 class="subtitle">Courses you have already completed.</h2>
    #     </div>
    #     <div class="loaded-courses"></div>
    #   </div>
