Take ["Database", "Render", "Route"], (Database, Render, Route)->
  Take ["CourseView", "DatabaseDebug", "HeaderView", "ListingView"], (CourseView, DatabaseDebug, HeaderView, ListingView)->

    render = ()->
      Render document.body, [
        HeaderView()
        ListingView()
        CourseView()
        DatabaseDebug()
      ]

    Database.subscribe "courses", render
    Route.subscribeAll render
    window.addEventListener "resize", render
