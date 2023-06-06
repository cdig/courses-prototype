Take ["Database"], (Database)->
  Make "DeleteItem", DeleteItem = (someKindOfUniqueReferenceToTheThingInTheDB)->
    return unless Database.get "editBool"
    # TODO: someKindOfUniqueReferenceToTheThingInTheDB
    Database.delete someKindOfUniqueReferenceToTheThingInTheDB
