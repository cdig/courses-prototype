Take ["AJAX", "Database", "Synchronizer"], (AJAX, Database, Synchronizer)->

  # Set up the course data in the database, and sync it to the LBS server whenever it changes

  # TODO: Make sure to seed the HTML with the data, and remove this AJAX,
  # because we don't want the initial setup to be arbitrarily delayed by network conditions.
  # EG: we wouldn't want the JS to finish init but this AJAX to fail, because then we'd see an empty GUI.
  await new Promise (resolve)->
    AJAX
      url: "http://localhost:3000/courses"
      success: (res)->
        Database.set "courses", res.courses
        resolve()

  # TODO: Enable this (or something like it) when we kill the above
  # Database.set "courses", LBS.courses

  # TODO: This is turned off to make deletion testing easier
  # Synchronizer "courses"
