Take ["Database"], (Database)->

    increment = (value)->
        return value + 1

    Database.update("count", increment)
