Take [], ()->
    # Proxy Objects
    # Might want more easy control or over loading and saving
    persistence = false

    KEY = "key"
    db = {
        editBool: false
        reorderBool: false
        # runSeeds: true
    }



    # if persistence
    #     # console.log(JSON.parse(localStorage.getItem(KEY)) || defaultDB)
    #     db = JSON.parse(localStorage.getItem(KEY)) || defaultDB
    # else
    #     db = defaultDB


    subscribers = {}

    notifySubscribers = (key)->

        if subscribers[key] && !subscribers[key].dirty
            
            subscribers[key].dirty = true
            queueMicrotask ()->
                # console.log(key)
                subscribers[key].dirty = false
                for cb in subscribers[key].cbs
                    cb db[key]
            

    Make "Database", Database = {
        get: (key)->
            # console.log("Database.get Request: ", key)
            return db[key]

        set: (key, value)->
            # console.log("Database.set Request: ", key, value)
            db[key] = value
            notifySubscribers(key)
            return db[key]

        update: (key, fn)->
            # console.log("Database.update Request: ", key, fn)
            db[key] = fn db[key]
            notifySubscribers(key)
            return db[key]

        subscribe: (key, cb)->
            subscribers[key] ?= {dirty: false, cbs: []}
            subscribers[key].cbs.push cb

            queueMicrotask ()->
                cb db[key]

        notify: (key)->
            # console.log("Database.notify Request: ", key)
            notifySubscribers(key)

        delete: (key)->
            # console.log("Database.delete Request: ", key)
            delete db[key]
            notifySubscribers(key)

        #has:
        has: (key)->
            # console.log("Database.has Request: ", key)
            return db[key]?
    }

    if persistence
        Take ["beforeunload"], (beforeunload)->
            localStorage.setItem(KEY, JSON.stringify(db))


    

