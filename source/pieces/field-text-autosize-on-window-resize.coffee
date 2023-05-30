Take ["AutosizeTextArea"], (AutosizeTextArea)->
  window.addEventListener "resize", ()->
    for elm in document.querySelectorAll('.field-text')
      # TODO: The following line might be necessary, but Ivan has temporarily disabled it while refactoring
      # element.style.cssText = "height: #{element.scrollHeight}px;"
      AutosizeTextArea elm
