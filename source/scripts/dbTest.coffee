Take ["Database"], (Database)->
    console.log(Database.set("count", 0))

    increment = (value)->
        return value + 1

    Database.update("count", increment)

    console.log(Database.get("count"))