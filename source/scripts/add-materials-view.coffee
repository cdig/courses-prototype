Take ["EditCourse", "ChangeView", "Database", "CreateSVGLine"], (EditCourse, ChangeView, Database, CreateSVGLine)->

    courseView = document.querySelector("#course-view")
    addMaterialView = document.querySelector("#add-material-view")

    addMaterialGrid = addMaterialView.querySelector(".add-material-grid")

    renderSession = (sessionData)->
        template = "
            <div class='grid-info'>
                <img class='grid-image' src='./image/fuckIt.png'>
                <div class='grid-title-container'>
                    <h2 class='grid-title'>#{sessionData.name}</h2>
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

        addMaterialGrid.appendChild(elm)

    Database.subscribe "sessions", (sessions)->
        if sessions?
            addMaterialGrid.innerHTML = ""
            for sessionData in sessions
                renderSession(sessionData)

    # if sessions
    #     for sessionData in sessions

    #         renderSession(sessionData)

    Make "BackToCourse", BackToCourse = (e)->

        ChangeView(addMaterialView, courseView, "horizontal")

        courseMaterials = courseView.querySelectorAll(".course-view-material")
        CreateSVGLine(courseMaterials[0], courseMaterials[courseMaterials.length - 1], false)

        toggled = false

    Make "AddMaterials", AddMaterials = (e)->
      if Database.get("editBool") == false
        EditCourse()

      ChangeView(courseView, addMaterialView, "vertical")
