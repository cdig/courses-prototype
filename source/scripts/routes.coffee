Take "Route", (Route)->

  Route.add null, "listing"

  Route.add "listing", "course"
  Route.add "course", "listing"

  Route.add "course", "edit"
  Route.add "edit", "course"

  Route.add "course", "reorder"
  Route.add "reorder", "course"

  Route.add "edit", "reorder"
  Route.add "reorder", "edit"

  Route.add "edit", "listing"
  Route.add "reorder", "listing"

  # TODO: Parse the URL and figure out which route to initialize to
  Route "listing"
