Take ["AJAX", "Database"], (AJAX, Database)->
    localURL = "http://localhost:3000/courses"

    AJAX
        # url: "http://192.168.0.96/3000/courses"
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
            