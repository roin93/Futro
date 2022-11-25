// ==UserScript==
// @name         SkipeBesucher
// @version      1.0
// @description  Klickt auf "jetzt surfen" und überspringt die werbelose Seite
// @author       Blin4ik
// @match        https://www.ebesucher.de/surfbar/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=tampermonkey.net
// @grant        none
// ==UserScript==


function FindButtons() {
    var buttonMatches = [],
        ButtonElems = document.getElementsByTagName("button"),
        iframes = document.getElementsByTagName('iframe'),
        l = ButtonElems.length,
        m = iframes.length, i, j;
    for( i=0; i<l; i++) buttonMatches[i] = ButtonElems[i];
    for( j=0; j<m; j++) {
        ButtonElems = iframes[j].contentDocument.getElementsByTagName("button");
        l = ButtonElems.length;
        for( i=0; i<l; i++) buttonMatches.push(ButtonElems[i]);
    }
    return buttonMatches;
}

(function() {
    'use strict';
     var surflink = "https://www.ebesucher.de/surfbar/[surflink]"  // dein surflink
     setTimeout(function() {
     var url = document.URL;
        if (url.includes("ebesucher.de")) {
           var buttons = FindButtons();
            if (buttons[0].innerText == "Jetzt surfen!")
            {
             buttons[0].click();
            }
            else
            {
                window.location.assign(surflink);
            }
        }
    }, 5000); // wait 5 seconds
})();
