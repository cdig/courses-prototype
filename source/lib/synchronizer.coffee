# This file will "synchronize" a value in our Database with the LBS server.
# It will watch the Database for changes and push them up to the LBS server.
# Note that it does not listen to the LBS server for remote changes to be pulled down.

Take ["AJAX", "Database"], (AJAX, Database)->

    Make "Synchronizer", Synchronizer = (key)->

        # Which URL should we use to hit the LBS server?
        lbsURL = "http://localhost:3000/#{key}" # TODO: Change this to the prod server

        # Store the most recently seen data (post-JSON conversion) so we can quickly check if there's any diff.
        cachedJSON = null

        Database.subscribe key, (newData)->
            return unless newData? # Guard against accidental nulls — would be better if we had a type system

            newJSON = JSON.stringify newData

            return if cachedJSON is newJSON

            cachedJSON = newJSON

            AJAX
                url: lbsURL
                method: "PUT"
                data: data: newData
                success: (res)-> # Cool and good
                error: (error)-> alert "Saving changes failed. Please reload the page." # TODO: Make this nicer for the average user
