Take [], ()->
  Make "AutosizeTextArea", AutosizeTextArea = (elm)->
    elm.style.height = "auto"
    elm.style.height = "#{elm.scrollHeight}px"
