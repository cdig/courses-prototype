Take ["Database", "OpenCourse"], (Database, OpenCourse)->

    courseButtonConfig =
        start:
            color: "blue", text: "Start"
        continue:
            color: "green", text: "Continue"
        complete:
            color: "blue", text: "Review"


    renderCourse = (courseData)->

        category = document.querySelector "##{courseData.category}"

        elm = document.createElement "div"
        elm.className = "course-container"
        category.append elm

        elm.innerHTML = "
            <div class='course'>
                <h2 class='course-title'>#{courseData.name}</h2>
                <div class='course-buttons'>
                    <a class='course-button #{courseButtonConfig[courseData.status].color}'>
                        #{courseButtonConfig[courseData.status].text}
                    </a>
                </div>
                <div class='course-bottom'>
                    <span class='left-meta'>#{courseData.materials.length} Items</span>
                    <span class='right-meta'>#{courseData.creator}</span>
                </div>
            </div>
        "

        # Open Course Listeners
        button = elm.querySelector ".course-button"
        courseElm = elm.firstElementChild
        button.addEventListener "click", ()-> OpenCourse courseElm, courseData


    Database.subscribe "courses", (courses)->
        if courses?
            for courseData in courses
                renderCourse courseData
