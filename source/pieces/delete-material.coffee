Take ["Database"], (Database)->
  Make "DeleteMaterial", DeleteMaterial = (someKindOfUniqueReferenceToTheThingInTheDB)->
    return unless Database.get "editBool"
    # TODO: someKindOfUniqueReferenceToTheThingInTheDB
    Database.delete someKindOfUniqueReferenceToTheThingInTheDB
