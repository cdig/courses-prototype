# Sleep
sleep = (ms)->
  new Promise (resolve) ->
    window.setTimeout resolve, (ms)

    
changeView = (fadeOut, fadeIn, scrollDirection)->

  fadeOut.style.display = "none"
  fadeOut.style.pointerEvents = "none"
  fadeIn.style.display = "block"
  fadeIn.style.pointerEvents = "auto"

  if scrollDirection == "horizontal"
    window.removeEventListener "wheel", changeScollToHorizontal
    body.classList.remove("vertical-scroll")
    body.classList.add("horizontal-scroll")
  else
    window.removeEventListener "wheel", changeScollToHorizontal
    body.classList.remove("horizontal-scroll")
    body.classList.add("vertical-scroll")


fading = (elm, type)->
  if type == "In"
    elm.style.display = "block"
  if type == "Out"
    elm.style.display = "none"

changeScollToHorizontal = (e)->
  if ( e.deltaY != 0 )
    window.scroll(window.scrollX + e.deltaY * 2, window.scrollY );
    e.preventDefault();

Make "page-functions"
# Take "some-other-thing", (question)->
#     console.log(question)
