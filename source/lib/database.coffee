Take [], ()->

    db = {
        # TODO: These need to live inside some component that has ownership over them — not in the (otherwise totally abstracted) database system.
        editBool: false
        reorderBool: false
        openCourseIndex: null
    }

    subscribers = {}


    notifySubscribers = (key)->
        if subscribers[key] && !subscribers[key].dirty
            subscribers[key].dirty = true
            queueMicrotask ()->
                subscribers[key].dirty = false
                for cb in subscribers[key].cbs
                    cb db[key]
                null


    Make "Database", Database = {
        get: (key)->
            db[key]

        set: (key, value)->
            db[key] = value
            notifySubscribers(key)
            db[key]

        update: (key, fn)->
            db[key] = fn db[key]
            notifySubscribers(key)
            db[key]

        subscribe: (key, cb)->
            subscribers[key] ?= {dirty: false, cbs: []}
            subscribers[key].cbs.push cb
            queueMicrotask ()-> cb db[key] # TODO: Possible bug — this could run twice if notifySubscribers is called before the end of the current turn of the event loop

        notify: (key)->
            notifySubscribers(key)

        delete: (key)->
            delete db[key]
            notifySubscribers(key)

        has: (key)->
            db[key]?
    }

