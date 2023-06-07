Take ["DOOM", "RenderElm"], (DOOM, RenderElm)->

  # TODO: This does not handle cases where DOM elements need to be reordered

  Make "Render", Render = (parent, elementDefinitions)->
    child.dirty = true for child in Array.from parent.children

    for def in elementDefinitions
      continue if not def?

      [tag, attrs, contents] = def

      unless typeof tag is "string"
        throw "You have incorrect nesting in your element definition. Look at the `parent` local variable to see where this definition was encountered."

      elm = RenderElm tag, parent, attrs

      elm.dirty = false

      if contents instanceof Array
        Render elm, contents
      else
        DOOM elm, textContent: contents

    child.remove() for child in Array.from parent.children when child.dirty
