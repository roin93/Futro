// ==UserScript==
// @name         RedirectToSurflink
// @version      1.0
// @description  nach 10 minuten wird automatisch auf den surflink navigiert
// @author       Blin4ik
// @match        https://*/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=cnoops.de
// @grant        none
// ==/UserScript==

(function() {
     'use strict';
     var surflink = "https://www.ebesucher.de/surfbar/[surflink]" // dein surflink
     var currentUrl = document.URL;
     setTimeout(function() 
     {
          var activeUrl = document.URL;
          if (currentUrl == activeUrl) 
          {
               window.location.assign(surflink);
          }
     }, 600000); // wait 10 minutes
})();
