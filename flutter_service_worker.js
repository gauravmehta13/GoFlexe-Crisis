'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "0f7f791acd968b0651c83049585ba5a2",
"assets/assets/AC%2520Install.jpg": "b5f6912edd33bd0504663705af403609",
"assets/assets/AC.png": "0b31935733f80b31eb556aa234416072",
"assets/assets/ApartMove.png": "80a4c62b844b6cc1ee73048a743ac032",
"assets/assets/bed.png": "609dda61332fdb54bdace3870d5d5465",
"assets/assets/box.png": "8271a523ee63948ebab80594cc6dd6f8",
"assets/assets/car_icon.png": "607e3dc1ee7403c1cbe11b90b4dcb004",
"assets/assets/check.png": "447226438e108f375b385edef59124eb",
"assets/assets/CommercialMove.png": "9dfbf76f7fb1b469efe07e891dcafa7e",
"assets/assets/cupboard.png": "bca5508dbc23e2d63c17465dce9322b5",
"assets/assets/delivery.png": "8f5a6537dd8987b3c8e85bd47a0a6fbc",
"assets/assets/Dining%2520Table.png": "4f8c43f7aa21c1385aaf9be128296fdd",
"assets/assets/Dressing%2520Table.png": "091079cdd8204580f9bfb1d2dd318fc1",
"assets/assets/Folding%2520Table.png": "2f44d0343013286004dcee76acc6ea3c",
"assets/assets/furniture.png": "3bdb78247908b38d21df6c6030785a88",
"assets/assets/holding-phone.png": "90d8a60b21ea30840c8a89f8b6ab500f",
"assets/assets/hotel.png": "b47d7678d07fea3d29ca52e0e5c9c961",
"assets/assets/insurance%2520(1).png": "227159e5cdd4cf6871dc08ef741eb15d",
"assets/assets/insurance%2520(2).png": "2674268ae83dfa53913b9851f19a9362",
"assets/assets/insurance.png": "e03f9daa5b782451e1b713afd9e11d84",
"assets/assets/Music%2520System.png": "7fc9441a3a5445279438ace127f49eb9",
"assets/assets/pack.jpg": "4e0e0ce053144fd22d16ccdc66b27628",
"assets/assets/package.png": "b85d2e487beea7f785274ec336684e4f",
"assets/assets/packers.png": "c902579765e8069563a8994b9531a552",
"assets/assets/Piano.png": "03873f508bb0d7ab1b4ebaec3ed0f4fc",
"assets/assets/premium.png": "1d8e0c5260fcc6604a35780625823adf",
"assets/assets/premiumInstall.png": "6f880526d38c50cc42db049e3f20c33f",
"assets/assets/premiumPacking.png": "66b15b73690687a8fe6cf2ddc81de449",
"assets/assets/rating.png": "37c280a8425d4226aa18b0873619f225",
"assets/assets/Refridgerator.png": "d90ee215c10b41e7fc3028d5587e638a",
"assets/assets/Single%2520Bed.png": "f224109ed66fa6db9cee5f63516daab3",
"assets/assets/Sofa.png": "032be868fd0155ff796550799913881f",
"assets/assets/standard.png": "46017064f77c02b91032f82e1ce0f65e",
"assets/assets/store.png": "188c4035f3a5e9ff2a22d1b8ab5cb995",
"assets/assets/tools.png": "4ed1b25fa9f2fa2b0c4eb237ff895aa6",
"assets/assets/tracking.png": "5f4a0fcf07e40f2d09270f95e6bab542",
"assets/assets/Treadmill.png": "b94ef8bb030a0c7c006ab3074c5228ae",
"assets/assets/truck.png": "fde9e897522520b27c6c63b43309c31f",
"assets/assets/TV.png": "ff74ee6c322c16fb33ab64c2f4e1e12f",
"assets/assets/unpacking.png": "c3841a2796bb22b21b55eb5700a1581c",
"assets/assets/warehouse.png": "b8c94110c5003517ac6e931c824c7d79",
"assets/assets/warehouse1.png": "6292f4be4cbb742fd23baaa8c96a5387",
"assets/assets/Washing%2520Machine.png": "806ee409325c98138ec99c143dfe4598",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "8c2bd5b329318ca4e6652a692b9bde21",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "00bb2b684be61e89d1bc7d75dee30b58",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "4b6a9b7c20913279a3ad3dd9c96e155b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dffd9504fcb1894620fa41c700172994",
"favicon.png": "466cb6d06d4bb71c745a8c2f703677f5",
"icons/icon-192x192.png": "e81e425597f5b3ed75e9013665f57ae5",
"icons/icon-256x256.png": "1bff694c81c42c85631214459327f94d",
"icons/icon-384x384.png": "9452436d86511f299365201854d5a9b3",
"icons/icon-512x512.png": "aefa8c9226b036cd7dc5d0c8d8ed67d3",
"index.html": "dd8858eb8d925e2ae22550b8996db6b4",
"/": "dd8858eb8d925e2ae22550b8996db6b4",
"main.dart.js": "2872aeef5035e8d020562f9283130bca",
"manifest.json": "60320ba02c37509221c1002ecc6c9f23",
"version.json": "c237c2309dcdd2a210496344dac05f37"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
