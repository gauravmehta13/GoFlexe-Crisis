'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "e464ac31ab2a948625fda67ce1614792",
"assets/assets/0009.jpg": "0310cd7a1db0dc7db7773292606313b4",
"assets/assets/0012.jpg": "7201a563ac50a35c8fcb26c95f26a1d9",
"assets/assets/0013.jpg": "f668c0dd5cd02f9a5adca065a8d1cc02",
"assets/assets/anxiety.png": "b3faed779db63beb1c92601988800482",
"assets/assets/bed.png": "c7ae24f023cdbcbcba100bb5a5b3f32b",
"assets/assets/bloodPressure.png": "efa324ad543078aa7afe9336f1eac3c8",
"assets/assets/confusion.png": "df22ea1155f0a9d0f9fe541735c8efbf",
"assets/assets/covidsymptom.png": "913c33f2e1cd367ff14d5e3e6b1329fa",
"assets/assets/device.png": "f835a3489e9489a3610c789f1fb81b1a",
"assets/assets/diagnose.png": "ae18295560ebf9536c6c68c5587912fb",
"assets/assets/diet.png": "161d1a272074a1b2bb1a4244639f45f9",
"assets/assets/examination.png": "e7b3c74f2c6073af124ee8664063c58a",
"assets/assets/fever.png": "2668d41aa5228c103ca4f3b9aa35e901",
"assets/assets/glucometer.png": "352d1781666edfe1f566d72163d8f953",
"assets/assets/holding-phone.png": "90d8a60b21ea30840c8a89f8b6ab500f",
"assets/assets/homeTreatment.png": "c4c7e9cc3804a2dec3dd51270c49ea2b",
"assets/assets/hospital.png": "df33467ec50f299c304c4cdce1aa29cb",
"assets/assets/inhaler.png": "2f9d4be93fb42041411d6be6ef91edf2",
"assets/assets/injection.png": "1185b404140d5d66c467539156a41a61",
"assets/assets/isolation.png": "f6e3410ab2a6fcca8a2fa2c993c8ffd0",
"assets/assets/medical-record.png": "50fb82526fc4eccaec4ac2b2b200c139",
"assets/assets/medication.png": "2364c187a068e27dce3b22039e5bc8f5",
"assets/assets/medicine.png": "2267a9bf252fb548c48808fc5ea562e4",
"assets/assets/o2level.png": "b3aaaf8c7e685024bf3c5140370ac884",
"assets/assets/oximeter.png": "231a51ddddb376e3def419aa9d2f1809",
"assets/assets/pulseOximeter.png": "4d5cdce92506e5769c00506e1f9ff1ee",
"assets/assets/rating.png": "37c280a8425d4226aa18b0873619f225",
"assets/assets/result.jpg": "c1efd5e2fd18685165d66c4acfa205c3",
"assets/assets/safe.png": "02903800b2a22c0988adf69da8fd2001",
"assets/assets/splash.png": "2fd0b642199f483c10169a932ce15bc3",
"assets/assets/steroids.png": "cf710c7f04881cfba695d191a869142d",
"assets/assets/symptoms%2520(1).png": "839ec4511b11fd5b3b0e8642e9a74ef7",
"assets/assets/symptoms%2520(2).png": "c2d8bc01368aa22f1f1b3dc8bb37b3e7",
"assets/assets/symptoms.png": "cd3c176cde6e84d1fdeaea6876c2cd0e",
"assets/assets/syringe.png": "a0641aa48abcfcc74c1e3a58fc2aef04",
"assets/assets/test.jpg": "4b1012b12e869aa940fc903f38dd2496",
"assets/assets/testing.png": "e7e49bdd6b5ea794aafa5a6031083853",
"assets/assets/thermometer.png": "9dfb6bd9804876bdc5b95cc33b57091e",
"assets/assets/vaccine.png": "34563ef1c6d23cc8b4a690365c8d5135",
"assets/assets/vitamins.png": "45425ec968a8cbbfe65e0c3e69f801e2",
"assets/assets/warning.png": "27e28f8d3352a284662ef957558ef77d",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "1bb1f08b79aa2462500973a8441faa1b",
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
"index.html": "fdbf4b862c0b1aec02aaa02f36fd8186",
"/": "fdbf4b862c0b1aec02aaa02f36fd8186",
"main.dart.js": "4b92cc0365d6afe518b722568c3a3615",
"manifest.json": "60320ba02c37509221c1002ecc6c9f23",
"splash/img/light-background.png": "2fd0b642199f483c10169a932ce15bc3",
"splash/style.css": "f38b46f4946aa7c41b459ed0f982f1a6",
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
