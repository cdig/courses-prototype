Take ["AutosizeTextArea"], (AutosizeTextArea)->
  window.addEventListener "resize", ()->
    textElements = document.querySelectorAll('.field-text')
    textElements.forEach (element) =>
      # TODO: The following line might be necessary, but Ivan has temporarily disabled it while refactoring
      # element.style.cssText = "height: #{element.scrollHeight}px;"
      AutosizeTextArea(element)
