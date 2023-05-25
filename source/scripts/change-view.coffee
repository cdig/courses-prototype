Take [], ()->
  # changeScollToHorizontal = (e)->
  #   if ( e.deltaY != 0 )
  #     window.scroll(window.scrollX + e.deltaY * 2, window.scrollY );
  #     e.preventDefault();


  # setHorizontalScrolling = (bool)->
  #   window.removeEventListener "wheel", changeScollToHorizontal
  #   if bool
  #     window.addEventListener "wheel", changeScollToHorizontal, {passive: false}
      

  Make "ChangeView", ChangeView = (fadeOut, fadeIn, scrollDirection, displayType)->

    fadeOut.style.display = "none"
    fadeIn.style.display = displayType

      



