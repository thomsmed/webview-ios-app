// script.js

console.log("script loaded")

let echoResultContainer = document.getElementById("echo-result");
window.setTimeout(function () {
    window.webkit.messageHandlers.EchoPlugin.postMessage("Hello from iframe via plugin!")
}, 10000)

window.somePropFromIFrame = "Hi from iFrame!";

let somePropContainer = document.getElementById("the-prop");
somePropContainer.textContent = window.somePropFromMainDoc || "No prop here :(";