Take [], ()->

  routes = {}
  subscribers = {}
  currentPath = null # TODO: This should potentially be stored in the database (so that we can more easily introspect)


  Make.async "Route", Route = (path)->

    # This allows callers to check what the current route is by calling Route()
    return currentPath unless path?

    # If we don't have a way to transition from currentPath to path, bail
    return false unless routes[currentPath]?.has path

    currentPath = path
    notifySubscribers()


  Route.add = (fromPath, toPath)->
    route = routes[fromPath] ?= new Set()
    route.add toPath


  Route.subscribe = (path, cb)->
    (subscribers[path] ?= []).push cb
    cb() if currentPath is path


  # Might not need this
  Route.init = (path)->
    currentPath = path
    notifySubscribers()


  notifySubscribers = ()->
    for cb in subscribers[currentPath]
      cb()
