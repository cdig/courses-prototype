Take ["Database"], (Database)->
    scroller = document.querySelector(".scroller")

    scroller.addEventListener "mousedown", ()->
        if Database.get("reorderBool")
            scroller.removeAttribute "scroll-snapping"
    window.addEventListener "mouseup", ()->
        scroller.setAttribute "scroll-snapping", ""


    # TODO: Test this on a touch device


