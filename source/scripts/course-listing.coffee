Take ["Database", "OpenCourse"], (Database, OpenCourse)->
    # await Database.get("courses")
    courseListing = document.querySelector("#course-listing")
    yourCourses = document.querySelector("#your-courses")

    renderCourses = (courseData)->
        console.log(courseData.status)
        # console.log(courseData.materials.length)
        if courseData.status == "start"
            buttonTemplate = "<a class='course-button blue'>Start</a>"
        else if courseData.status == "continue"
            buttonTemplate = "<a class='course-button green'>Continue</a>"
        else if courseData.status == "complete"
            buttonTemplate = "<a class='course-button blue'>Review</a>"

        # console.log(courseData.materials?)
        # courseLength = if courseData.materials[0]? then courseData.materials.length() else 0

        template = "
            <div class='course tall'>
                <h2 class='course-title'>#{courseData.name}</h2>
                <div class='course-buttons'>
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

        elm.querySelector(".course-buttons").innerHTML = buttonTemplate

        category = document.querySelector("##{courseData.category}")

        category.append(elm)
            
        # Open Course Listeners
        openCourseOnClick = (button)->
            courseElm = button.closest(".course:not(.short)")
            button.addEventListener "click", ()->
                OpenCourse courseElm, courseData

        openCourseOnClick elm.querySelector(".course-button")


    Database.subscribe "courses", (courses)->
        if courses?
            yourCourses.innerHTML = ""
            for courseData in courses

                renderCourses(courseData)

    

    