Take ["DOOM", "RenderElm"], (DOOM, RenderElm)->

  Make "Render", Render = (parent, elementDefinitions)->
    child.stillExists = false for child in Array.from parent.children

    previousElm = null

    for def, defIndex in elementDefinitions
      continue if not def?

      [tag, attrs, contents] = def

      unless typeof tag is "string"
        throw "You have incorrect nesting in your element definition. Look at the `parent` local variable to see where this definition was encountered."

      # If you just want simple elements, don't pass any attrs and we'll use the DOM ordering as the query
      attrs ?= query: ":nth-child(#{defIndex+1})"

      elm = RenderElm tag, parent, attrs

      elm.stillExists = true

      if contents instanceof Array
        Render elm, contents
      else if contents instanceof Function
        contents elm
      else
        DOOM elm, textContent: contents

      # If the order of the defs has changed since the last time we rendered, the DOM elements will still be
      # in their old ordering. So, we need to carefully reorder them to account for this without thrashing the DOM.
      if previousElm? and previousElm isnt elm.previousElementSibling
        previousElm.after elm

      previousElm = elm


    child.remove() for child in Array.from parent.children when not child.stillExists
