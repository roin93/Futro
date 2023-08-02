// ==UserScript==
// @name         LootAutoClick
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Auto clicks the first video to start looot
// @author       Blinchik
// @match        https://loot.tv/
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
   // window.addEventListener('load', function () {
    setTimeout(() => {
       window.location.assign('https://loot.tv/playlist/ckh82nuqm000101kxc67k4c6c');
        // document.getElementsByClassName("  VideoInfiniteLoader_noWhitespacewHV0f  VideoInfiniteLoader_infiniteLoadWrapperIJYpg")[0].children[0].click();
    },10000);
  //  })
})();
