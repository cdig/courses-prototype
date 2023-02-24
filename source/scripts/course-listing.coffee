Take ["Database", "OpenCourse"], (Database, OpenCourse)->
    # await Database.get("courses")
    courseListing = document.querySelector("#course-listing")
    yourCourses = document.querySelector("#your-courses")

    renderCourse = (courseData)->
        
        template = "
            <div class='course tall'>
                <h2 class='course-title'>#{courseData.name}</h2>
                <div class='course-buttons'>
                    <a class='course-button green'>Continue</a>
                </div>
                <div class='course-bottom'>
                    <span class='left-meta'><p>#{courseData.numOfMaterials} Materials</p></span>
                    <span class='right-meta'><p>#{courseData.creator}</p></span>
                </div>
            </div>
        "

        elm = document.createElement("div")
        elm.className = "course-container"
        elm.innerHTML = template

        yourCourses.prepend(elm)
        
        # Open Course Listeners
        openCourseOnClick = (button)->
            courseElm = button.closest(".course:not(.short)")
            button.addEventListener "click", ()->
                OpenCourse courseElm

        openCourseOnClick elm.querySelector(".course-button")


    Database.subscribe "courses", (courses)->
        if courses?
            yourCourses.innerHTML = ""
            for courseData in courses

                renderCourse(courseData)

    

    