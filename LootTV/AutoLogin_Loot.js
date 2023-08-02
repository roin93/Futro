// ==UserScript==
// @name         LootAutoLogin
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Auto login in loot.tv
// @author       Blinchik
// @match        https://loot.tv/account/login
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

            setTimeout(() => {document.getElementsByClassName(' css-1ey59fx')[0].click();}, 20000);
        setTimeout(() => {
              for (let item of document.getElementsByTagName('Button')) {
    if (item.innerText == 'Sign In') { item.click(); break; }
           }
         }, 30000);
})();
