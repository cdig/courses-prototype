Take ["Route"], (Route)->

  first = true

  Route.subscribeAll (path, ...args)->

    # When we first initialize, we'll get a callback from the router with a null path, which we want to ignore
    return unless path?

    # If for some reason we're transitioning from a state to the same state, that's an error condition
    throw new Error "Unexpected Route transition from a state to the same state" if noChange path, ...args

    # Set a global attribute so that we can style based on the current route
    document.documentElement.setAttribute "current-route", path

    # When we first initialize, we don't want to create a new history state
    return first = false if first

    # TODO: Figuring out which URL to use should be part of the data definition of our routes, not hard-coded here
    url = switch path
      when "listing" then "/"
      when "course" then "#" + args.join("::::BAD::::")
      when "edit" then "#" + args.join("::::BAD::::") + "/edit"
      when "reorder" then "#" + args.join("::::BAD::::") + "/reorder"
      else throw new Error "Unexpected route"

    state = {path, args}

    # TODO: Broken
    # history.pushState state, "", url


  noChange = (...newState)->
    JSON.stringify(history.state) is JSON.stringify(newState)



  # window.addEventListener "popstate", (e)->
  #   {path, args} = e.state
  #   Route path, ...args

