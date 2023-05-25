Take ["AJAX", "Database"], (AJAX, Database)->
    localURL = "http://localhost:3000/courses"

    AJAX
        url: localURL
        success: (res)->
            Database.set("courses", res.courses)
            Database.set("topics", res.topics)
            addListeners()

        error: (error)->
            console.log error


    addListeners = ()->
        Database.subscribe "courses", (courses)->
            AJAX
                url: localURL
                method: "PUT"
                data: data: courses
                success: (res)->
                    console.log res
                error: (error)->
                    console.log error
