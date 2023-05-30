Take ["ReorderCourse"], (ReorderCourse)->
  elm = document.querySelector ".reorder-button"

  elm.addEventListener "click", ()-> ReorderCourse() # ReorderCourse takes a boolean arg, so don't give it a MouseEvent!
