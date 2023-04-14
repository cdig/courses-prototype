Take [], ()->
  success = (xhr, opts)-> (e)->
    if xhr.response? and (opts.success? or opts.error?)
      response = try JSON.parse xhr.response catch then xhr.response

    if xhr.status is 200
      opts.success? response, e, xhr
      console.log(opts)
    else if opts.error?
      opts.error response, e, xhr
    else
      console.log "Unhandled AJAX Failure"


  Make "AJAX", (opts)->

    xhr = new XMLHttpRequest()

    method = opts.method or "GET"

    xhr.open method, opts.url

    xhr.setRequestHeader "Content-Type", "application/json"
    xhr.setRequestHeader "X-Requested-With", "XMLHttpRequest"

    xhr.addEventListener "load", success xhr, opts
    xhr.addEventListener "error", opts.error

    if opts.data?
      xhr.send JSON.stringify opts.data
    else
      xhr.send()