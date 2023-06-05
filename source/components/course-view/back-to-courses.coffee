Take ["Route"], (Route)->

  Make "BackToCourses", BackToCourses = ()->

    click = ()-> Route "listing"

    ["a", { class: "back-to-courses", click}, [
      ["svg", { xmlns:"http://www.w3.org/2000/svg", height:"1em", width:"1.625em", viewBox:"0 0 65 40", fill:"none", stroke:"#fff", strokeWidth:"7px" }, [
        ["polyline", { points:"15 32 3.5 20 15 8" }]
        ["line", { x1:"65", y1:"20", x2:"5", y2:"20" }]
      ]]
    ]]
