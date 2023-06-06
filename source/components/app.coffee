Take ["Database", "Render", "Route"], (Database, Render, Route)->
  Take ["CourseView", "HeaderView", "ListingView"], (CourseView, HeaderView, ListingView)->

    render = ()->
      Render document.body, [
        HeaderView()
        CourseView()
        ListingView()
      ]

    Database.subscribe "courses", render
    Route.subscribeAll render
