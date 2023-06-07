Take [], ()->

  db = {
    # TODO: These need to live inside some component that has ownership over them — not in the (otherwise totally abstracted) database system.
    editBool: false
    reorderBool: false
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

  freeze = (value)->
#     if value? and typeof value is "object"
#       Reflect.ownKeys(value).forEach (key)-> freeze value[key]
#       Object.freeze value
    value
#
#   getPathTo = (parent, object, path = [])->
#     for child, key in Reflect.ownKeys root
#       if child is object
#         return path.concat key
#       else if typeof child is "object"
#         if result = getPathTo child, object, path.concat key
#           return result
#     return false
#
#   changeAt = (path, props, subject = db)->
#     for p in path
#       nextSubject = subject[p]
#       subject[p] = Object.assign {}, nextSubject # Unfreeze
#       subject = nextSubject
#     for k, v in props
#       subject[k] = v
#     null


  Make "Database", Database =
    db: db # For debugging

    get: (key)->
      db[key]

    set: (key, value)->
      db[key] = freeze value
      notifySubscribers(key)
      value

    # change: (object, props)->
    #   path = getPathTo db, object
    #   changeAt path, props
    #   freeze db[path[0]]

    update: (key, fn)->
      Database.set fn Database.get(key)

    subscribe: (key, cb)->
      subscribers[key] ?= {dirty: false, cbs: []}
      subscribers[key].cbs.push cb
      # Note: Because we delay this callback invocation, it could end up running notifySubscribers twice if notifySubscribers is called again before the end of the current turn of the event loop
      queueMicrotask ()-> cb Database.get(key)

    notify: (key)->
      notifySubscribers(key)

    delete: (key)->
      delete db[key]
      notifySubscribers(key)

    has: (key)->
      db[key]?

