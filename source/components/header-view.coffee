Take [], ()->


  Make "HeaderView", HeaderView = ()->
    ["div", { id: "header", innerHTML: '
      <div class="inner">
        <div class="left half"><div class="buttons"><a class="explore button">Explore Library</a></div></div>
        <a class="logo"><svg width="44" height="33" fill="#FFF" fill-opacity=".95" viewBox="0 0 400 300"><path d="M116 236l6-14c-19-5-35-13-48-24l-54 20c-7-5-13-15-20-30l2 16c4 12 11 22 20 30l52-20c12 8 26 15 42 22zm-60-98l-50-4 2 14 44 4c1-6 2-11 4-14zm338 82l6-16-64-16c-7 8-16 15-28 22l8 10c9-5 16-11 20-16zm-44 38c-21 13-40 21-56 22l-40-50c-23 4-44 5-64 4l-20 50c-20-1-43-7-68-16v16c24 9 47 15 68 16l20-50c21 1 42 0 62-4l38 50c20-4 38-11 54-20zm-9-116l36-4 4-12-46 4c3 3 5 7 6 12zM264 10l6 12H130l6-12zm58 88l4-40-14-36h-30L272 0H128l-10 22H88L74 58l4 40h10l8 86h208l8-86zM130 84h22l2 34h-22zm118 0h22l-2 34h-22z"/></svg></a>
        <div class="right half"><div class="buttons"><a class="account button">Your Account</a></div></div>
      </div>
    '}]