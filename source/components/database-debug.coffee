Take ["Database"], (Database)->

  # Turn this on if you'd like to see a giant printout of the database
  DEBUG = false

  Make "DatabaseDebug", DatabaseDebug = ()->
    return unless DEBUG

    # customize this to pull out just the data that you want to see
    data = Database.get("courses")
      ?.filter (c)-> c.id in [32]
      # ?.map (c)-> Object.assign({}, c, {materials: []})

    ["div", { id: "database-debug" }, JSON.stringify data, null, 2]
