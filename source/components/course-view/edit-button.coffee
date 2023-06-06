# Take ["Database", "EditCourse"], (Database, EditCourse)->

#   await elm = document.querySelector ".edit-button"

#   elm.addEventListener "click", ()-> EditCourse() # EditCourse takes a boolean arg, so don't give it a MouseEvent!

#   Database.subscribe "editBool", (v)->
#     elm.textContent = if v then "View" else "Edit"
