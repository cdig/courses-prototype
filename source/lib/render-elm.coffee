Take ["DOOM"], (DOOM)->

  # Turn this on if you'd like to see flashes when elements are created or updated
  DEBUG = false

  # TODO: Mutates the attrs, which is probably not good

  Make "RenderElm", RenderElm = (tag, parent, attrs)->
    query = switch
      when attrs.query then attrs.query
      when attrs.id then "#" + attrs.id
      when attrs.class then "." + attrs.class.replace " ", "."
      else throw new Error "Need a query"

    delete attrs.query

    elm = parent.querySelector query

    if elm
      update elm, attrs
    else
      elm = create tag, parent, attrs

    elm


  create = (tag, parent, attrs)->
    elm = DOOM.create tag, parent, attrs

    if DEBUG
      DOOM elm, debugRendering: "create"
      elm.onanimationend = ()-> DOOM elm, debugRendering: null

    elm


  update = (elm, attrs)->
    isChanged = DOOM elm, attrs

    if DEBUG and isChanged
      DOOM elm, debugRendering: "update"
      elm.onanimationend = ()-> DOOM elm, debugRendering: null
      elm.style.display = "none"
      elm.offsetHeight
      elm.style.display = null
