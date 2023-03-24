Take ["EditCourse", "ChangeView", "Database", "CreateSVGLine"], (EditCourse, ChangeView, Database, CreateSVGLine)->

    courseView = document.querySelector("#course-view")
    addMaterialView = document.querySelector("#add-material-view")

    addMaterialGrid = addMaterialView.querySelector(".add-material-grid")

    sessionCategorySelector = document.querySelector("#session-category-selector")


    renderTopic = (topicData)->
        template = "
            <h2>#{topicData.name.name}</h2>
        "

        elm = document.createElement("a")
        elm.className = "sessions-category" + " #{topicData.name.name.toLowerCase().replace(" ", "-")}-category-selector"
        elm.innerHTML = template

        container = document.createElement("div")
        container.id = "#{topicData.name.name.toLowerCase().replace(" ", "-")}-session-category"
        container.className = "session-category-grid"

        addMaterialGrid.appendChild(container)

        sessionCategorySelector.appendChild(elm)
        

    renderSessions = (sessionData)->

        category = sessionData.name.name.toLowerCase()
        categoryString = "#{category.replace(" ", "-")}-session-category"
        categoryGrid = document.querySelector("##{categoryString}")

        for session in sessionData.name.sessions
            template = "
                <div class='grid-info'>
                    <img class='grid-image' src='./image/fuckIt.png'>
                    <div class='grid-title-container'>
                        <h2 class='grid-title'>#{session}</h2>
                        <h4 class='grid-subtitle'>Session</h4>
                        <h4 class='grid-materials-subtitle'>Includes X Learning Materials</h4>
                    </div>
                    <div class='grid-background'></div>
                </div>
                <div class='grid-button-container'>
                    <a class='add-material-toggle'>
                        <div class='toggle-button blue'>Add Session</div>
                        <div class='toggle-button green'>✓</div>
                    </a>
                    <a class='add-material-toggle'>
                        <div class='toggle-button blue'>Add Materials</div>
                    </a>
                </div>
            "

            elm = document.createElement("div")
            elm.className = "grid-element"
            elm.innerHTML = template

            categoryGrid.appendChild(elm)

    Database.subscribe "sessions", (sessions)->
        if sessions?
            sessionCategorySelector.innerHTML = ""
            for topicData in sessions
                renderTopic(topicData)
                renderSessions(topicData)


    Make "BackToCourse", BackToCourse = (e)->
        courseView = document.querySelector("#course-view")
        courseMaterials = courseView.querySelectorAll(".course-view-material-container")

        ChangeView(addMaterialView, courseView, "horizontal")

        lineData = CreateSVGLine(courseMaterials[0], courseMaterials[courseMaterials.length - 1], false)

        toggled = false

    Make "AddMaterials", AddMaterials = (e)->
        EditCourse(false)

        ChangeView(courseView, addMaterialView, "vertical")
