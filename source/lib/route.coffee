Take [], ()->

  routes = {}
  allSubscribers = []
  pathSubscribers = {}
  currentPath = null # TODO: This should potentially be stored in the database (so that we can more easily introspect)
  currentArgs = []

  Make.async "Route", Route = (path, ...args)->
    if canTransitionTo path
      currentPath = path
      currentArgs = args
      notifySubscribers()


  Route.path = ()-> currentPath
  Route.args = ()-> currentArgs


  Route.add = (fromPath, toPath)->
    route = routes[fromPath] ?= new Set()
    route.add toPath


  Route.subscribe = (path, cb)->
    (pathSubscribers[path] ?= []).push cb
    cb currentPath, ...currentArgs if currentPath is path


  Route.subscribeAll = (cb)->
    allSubscribers.push cb
    cb currentPath, ...currentArgs


  notifySubscribers = ()->
    allSubscribers.forEach (cb)-> cb currentPath, ...currentArgs
    pathSubscribers[currentPath]?.forEach (cb)-> cb currentPath, ...currentArgs


  canTransitionTo = (path)->
    routes[currentPath]?.has path
