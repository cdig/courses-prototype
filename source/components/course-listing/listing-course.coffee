Take ["Route"], (Route)->

  Make "ListingCourse", ListingCourse = ({category, creator, id, materials, name, status})->
    #TODO: Remove this line when changing material to item in rails
    items = materials

    click = ()-> Route "course", id

    buttonColor = if status is "continue" then "green" else "blue"
    buttonText = if status is "complete"
      "Review"
    else
      status[0].toUpperCase() + status[1..]

    ["div", { id: "course-#{id}", class: "course", courseId: id }, [
      ["h2", { class: "course-title" }, name ]
      ["div", { class: "course-buttons" }, [
        ["a", { class: "course-button #{buttonColor}", click }, buttonText]
      ]]
      ["div", { class: "course-bottom" }, [
        ["div", { class: "left-meta" }, "#{items.length} Items"]
        ["div", { class: "right-meta" }, creator]
      ]]
    ]]
