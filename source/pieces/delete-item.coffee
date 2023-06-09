Take ["Database"], (Database)->
  Make "DeleteItem", DeleteItem = (item)->
      # We are getting unique data on the click we just need to get it to delete with the Object freeze system
      console.log("Hit", item)
    