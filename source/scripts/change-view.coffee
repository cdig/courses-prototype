Take [], ()->
  changeScollToHorizontal = (e)->
    if ( e.deltaY != 0 )
      window.scroll(window.scrollX + e.deltaY * 2, window.scrollY );
      e.preventDefault();


  setHorizontalScrolling = (bool)->
    window.removeEventListener "wheel", changeScollToHorizontal
    if bool
      window.addEventListener "wheel", changeScollToHorizontal
      

  Make "ChangeView", ChangeView = (fadeOut, fadeIn, scrollDirection)->
    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'smooth'
    })

    fadeOut.style.display = "none"
    fadeOut.style.pointerEvents = "none"
    fadeIn.style.display = "block"
    fadeIn.style.pointerEvents = "auto"

    setHorizontalScrolling(scrollDirection == "horizontal")
    document.body.classList.toggle("horizontal-scroll", scrollDirection == "horizontal")
    document.body.classList.toggle("vertical-scroll", scrollDirection != "horizontal")

      



