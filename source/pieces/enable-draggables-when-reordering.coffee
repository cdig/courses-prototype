# Take ["Database"], (Database)->
#   Database.subscribe "reorderBool", (reorderBool)->
#     draggableElements = document.querySelectorAll('[is-draggable]')
#     for elm in draggableElements
#       elm._draggable = reorderBool
