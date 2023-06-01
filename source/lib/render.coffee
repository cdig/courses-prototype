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

    for [tag, attrs, contents] in elementDefinitions
      elm = renderElm tag, parent, attrs

      if contents instanceof Array
        Render elm, contents
      else
        DOOM elm, textContent: contents

    null
