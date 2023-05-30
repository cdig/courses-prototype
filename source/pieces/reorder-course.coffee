Take ["Database"], (Database)->
  Make "ReorderCourse", ReorderCourse = (reorderMode)->

    # Toggle the reorderBool if it wasn't passed in
    reorderMode ?= Database.update "reorderBool", (b)-> !b

    # Turn off EditCourse whenever we turn on ReorderCourse — TODO: Reorder and Edit should just be sub-routes of Course View
    EditCourse = await Take.async "EditCourse"
    EditCourse(false) if reorderMode