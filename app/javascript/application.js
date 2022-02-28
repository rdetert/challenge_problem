// import "@hotwired/turbo-rails"

import React from "react"
import ReactDOM from "react-dom"
import PlayerTable from "./components/players/PlayerTable.js"

window.renderPage = function(page, csrfToken) {
  switch(page) {
    case "/devices":
      break;
    case "/offers":
      break;
    case "/offer_targets":
      break;
    default:
      ReactDOM.render(
        <PlayerTable csrfToken={csrfToken} modelName={"player"} />,
        document.getElementById('content')
      );
  }
}