Take [], ()->
  Make "Draggable", Draggable = (element) ->
    deviceType = ''
    events =
      mouse:
        down: 'mousedown'
        move: 'mousemove'
        up: 'mouseup'
      touch:
        down: 'touchstart'
        move: 'touchmove'
        up: 'touchend'
    initialMouseX = null
    initialElementLeft = null
    container = null

    isTouchDevice = ->
      try
        document.createEvent('TouchEvent')
        deviceType = 'touch'
        return true
      catch e
        deviceType = 'mouse'
        return false

    getNewPreviousDraggable = (newElementLeft) ->
      draggableElements = container.querySelectorAll("[is-draggable]:not(.dragging)")

      rightmostElm = null
      rightmostElmLeft = -Infinity

      for elm in draggableElements
        box = elm.getBoundingClientRect()

        if box.left <= newElementLeft and box.left > rightmostElmLeft
          rightmostElmLeft = box.left
          rightmostElm = elm

      return rightmostElm

    intitializeElement = ()->
      element.style.transform = ""
      initialElementLeft = element.getBoundingClientRect().left



    dragStart = (event) ->
      # Will be set to true when reorder mode is active.
      return unless element._draggable
      container ?= element.parentElement
      event.preventDefault()
      element.style.opacity = '0.5'
      element.style.zIndex = '1000'
      element.classList.add 'dragging'

      document.body.setAttribute "block-touch-scrolling", ""

      initialMouseX = if not isTouchDevice() then event.clientX else event.touches[0].clientX

      intitializeElement()
      

      window.addEventListener events[deviceType].move, drag
      window.addEventListener events[deviceType].up, dragEnd

    drag = (event) ->
      event.preventDefault()
      newMouseX = if not isTouchDevice() then event.clientX else event.touches[0].clientX



      deltaMouseX = newMouseX - initialMouseX
      deltaMouseX = deltaMouseX / 0.75

      element.style.transform = "translateX(#{deltaMouseX}px)"

      newPreviousDraggable = getNewPreviousDraggable(initialElementLeft + deltaMouseX)
      return if newPreviousDraggable is element
      return if newPreviousDraggable is element.previousSibling.previousSibling

      # To insert at the start of the list we need to account for the SVG line
      newPreviousDraggable ?= container.firstElementChild
      newPreviousDraggable.after element.previousSibling, element
        

      oldInitialElementLeft = initialElementLeft

      intitializeElement()

      initialMouseX = initialMouseX + (initialElementLeft - oldInitialElementLeft)

      deltaMouseX = newMouseX - initialMouseX
      deltaMouseX = deltaMouseX / 0.75

      element.style.transform = "translateX(#{deltaMouseX}px)"

    dragEnd = (event) ->
      window.removeEventListener events[deviceType].move, drag
      element.style.opacity = "1"
      element.style.zIndex = ""
      element.style.transform = ""
      element.classList.remove "dragging"

      document.body.removeAttribute "block-touch-scrolling"

      if addMaterialContainer?
        addMaterialContainer.style.transform = ""

    isTouchDevice()
    element.addEventListener events[deviceType].down, dragStart
    element.setAttribute("is-draggable", "")
