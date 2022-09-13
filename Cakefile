glob = require "glob"
require "sweetbread"

task "build", "Compile everything.", ()->
  mkdir "public"
  return unless Compilers.coffee glob.sync("source/**/*.coffee"), "public/scripts.js"
  return unless Compilers.scss glob.sync("source/**/*.scss"), "public/styles.css"
  return unless Compilers.html glob.sync("source/**/*.html"), "public/index.html"

  # Static
  start = performance.now()
  for p in glob.sync "source/**/*.!(html|scss|coffee)"
    dest = p.replace "source/", "public/"
    mkdir dest.split("/")[...-1].join "/"
    return unless Compilers.static p, dest, quiet: true
  log "Copied static assets      " + duration start


task "watch", "Recompile on changes.", ()->
  watch "source", "build", reload


task "serve", "Spin up a live reloading server.", ()->
  serve "public"


task "start", "Build, watch, and serve.", ()->
  doInvoke "build"
  doInvoke "watch"
  doInvoke "serve"
