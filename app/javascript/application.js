// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import React from "react";
import ReactDOM from "react-dom";
import App from "./components/App";

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");
  if (root) {
    ReactDOM.render(<App />, root);
  }
});


// // app/javascript/application.js
// import React from "react";
// import ReactDOM from "react-dom";
// import OrderUpdates from "./components/OrderUpdates";  // Ensure the path is correct

// ReactDOM.render(<OrderUpdates />, document.getElementById("root"));
