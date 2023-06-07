Take ["Database", "Render", "Route"], (Database, Render, Route)->
  Take ["CourseView", "DatabaseDebug", "HeaderView", "ListingView"], (CourseView, DatabaseDebug, HeaderView, ListingView)->

    render = ()->
      Render document.body, [
        HeaderView()
        CourseView()
        ListingView()
        DatabaseDebug()
      ]

    Database.subscribe "courses", render
    Route.subscribeAll render
