Take ["DOOM"], (DOOM)->

  # TODO: This does not handle cases where DOM elements need to be reordered
  # TODO: Mutates the attrs, which is probably not good
  renderElm = (tag, parent, attrs)->
    query = switch
      when attrs.query then attrs.query
      when attrs.id then "#" + attrs.id
      when attrs.class then "." + attrs.class.replace " ", "."
      else throw new Error "Need a query"

    elm = parent.querySelector(query) or DOOM.create tag, parent

    delete attrs.query

    DOOM elm, attrs

    elm


  Make "Render", Render = (parent, elementDefinitions)->
    child.dirty = true for child in Array.from parent.children

    for def in elementDefinitions
      continue if not def?

      [tag, attrs, contents] = def

      unless typeof tag is "string"
        throw "You have incorrect nesting in your element definition. Look at the `parent` local variable to see where this definition was encountered."

      elm = renderElm tag, parent, attrs

      elm.dirty = false

      if contents instanceof Array
        Render elm, contents
      else
        DOOM elm, textContent: contents

    child.remove() for child in Array.from parent.children when child.dirty

