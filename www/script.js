// script.js

console.log("script loaded")

let echoResultContainer = document.getElementById("echo-result");
window.plugins.echo.postMessage("Hello from WebView via plugin!")

window.somePropFromMainDoc = "Hi from main document!";