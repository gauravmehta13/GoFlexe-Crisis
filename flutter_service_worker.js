'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "86294067530d39217c39640209fb0733",
"assets/assets/alert.png": "78f1369d46d09567736dcdf88c10bda5",
"assets/assets/anxiety.png": "b3faed779db63beb1c92601988800482",
"assets/assets/bed.png": "c7ae24f023cdbcbcba100bb5a5b3f32b",
"assets/assets/bloodPressure.png": "efa324ad543078aa7afe9336f1eac3c8",
"assets/assets/charity.png": "46743cc91028b473fd9f672a09c370da",
"assets/assets/check.png": "447226438e108f375b385edef59124eb",
"assets/assets/confusion.png": "df22ea1155f0a9d0f9fe541735c8efbf",
"assets/assets/covidsymptom.png": "913c33f2e1cd367ff14d5e3e6b1329fa",
"assets/assets/coviself.png": "57ecbc5651ef17d7e280c2b833a9eb96",
"assets/assets/device.png": "f835a3489e9489a3610c789f1fb81b1a",
"assets/assets/diagnose.png": "ae18295560ebf9536c6c68c5587912fb",
"assets/assets/diet.png": "161d1a272074a1b2bb1a4244639f45f9",
"assets/assets/error-404.png": "cd305903f683b8c6ec8dabd25a0f193a",
"assets/assets/examination.png": "e7b3c74f2c6073af124ee8664063c58a",
"assets/assets/facebook.png": "8b9c428d8aa83dac96750101d9fd513a",
"assets/assets/fever.png": "2668d41aa5228c103ca4f3b9aa35e901",
"assets/assets/fight-corona.png": "5c4959c009bcf0c4fb832b86e90ace05",
"assets/assets/found.png": "3ddeff281d3e47d4d02b316e6908a6ce",
"assets/assets/glucometer.png": "352d1781666edfe1f566d72163d8f953",
"assets/assets/google.png": "3fdff700f0f6e77602e5e9022d29ca67",
"assets/assets/graph.png": "0351d5d07d9db4bac7cdf61fe1e0f95d",
"assets/assets/help.png": "362d1a545f53ea819a259ee57dd4f0da",
"assets/assets/helpRequest.png": "05ecf4f78b5c947f58749a645824c4ed",
"assets/assets/holding-phone.png": "90d8a60b21ea30840c8a89f8b6ab500f",
"assets/assets/homeHospital.png": "c12fad56b1a3ceaf9a20313347f7ea6d",
"assets/assets/homeTest.png": "a154dcb6a887c64bd69d7a44779e572e",
"assets/assets/homeTreat.png": "29ffb3875c8b006069cd5e8ccf4988ec",
"assets/assets/homeTreatment.png": "c4c7e9cc3804a2dec3dd51270c49ea2b",
"assets/assets/homeVacc.png": "cfaf73a45fd583c4bfecb349375bcc49",
"assets/assets/hospital.png": "df33467ec50f299c304c4cdce1aa29cb",
"assets/assets/hospitalBed.png": "6b2e8bf2fd2827d5280a16dc3a1081e4",
"assets/assets/inhaler.png": "2f9d4be93fb42041411d6be6ef91edf2",
"assets/assets/injection.png": "1185b404140d5d66c467539156a41a61",
"assets/assets/isolation.png": "f6e3410ab2a6fcca8a2fa2c993c8ffd0",
"assets/assets/medical-record.png": "50fb82526fc4eccaec4ac2b2b200c139",
"assets/assets/medication.png": "2364c187a068e27dce3b22039e5bc8f5",
"assets/assets/medicine.png": "2267a9bf252fb548c48808fc5ea562e4",
"assets/assets/ngo.png": "25db12ab27729e7fda265642bbf40cd2",
"assets/assets/NGObadge.png": "3672e487a7703b6d9dc263daf82b409d",
"assets/assets/o2level.png": "b3aaaf8c7e685024bf3c5140370ac884",
"assets/assets/oximeter.png": "231a51ddddb376e3def419aa9d2f1809",
"assets/assets/pulseOximeter.png": "4d5cdce92506e5769c00506e1f9ff1ee",
"assets/assets/rating.png": "37c280a8425d4226aa18b0873619f225",
"assets/assets/research.png": "d49ccb65805275ee352ef79598a0b342",
"assets/assets/result.jpg": "b703f28786e650d639ded82f42af2dfe",
"assets/assets/safe.png": "02903800b2a22c0988adf69da8fd2001",
"assets/assets/splash.png": "370018dcec6a9dcbc1d72d844b4f4203",
"assets/assets/steroids.png": "cf710c7f04881cfba695d191a869142d",
"assets/assets/symptoms%2520(1).png": "839ec4511b11fd5b3b0e8642e9a74ef7",
"assets/assets/symptoms%2520(2).png": "c2d8bc01368aa22f1f1b3dc8bb37b3e7",
"assets/assets/symptoms.png": "cd3c176cde6e84d1fdeaea6876c2cd0e",
"assets/assets/syringe.png": "a0641aa48abcfcc74c1e3a58fc2aef04",
"assets/assets/test.jpg": "4b1012b12e869aa940fc903f38dd2496",
"assets/assets/testing.png": "e7e49bdd6b5ea794aafa5a6031083853",
"assets/assets/thermometer.png": "9dfb6bd9804876bdc5b95cc33b57091e",
"assets/assets/twitter.png": "6d15c4b76dddbf664e6f7fd06408f1fd",
"assets/assets/vaccine.png": "34563ef1c6d23cc8b4a690365c8d5135",
"assets/assets/video.png": "fd9c9a8ae43865673af7968cf8870368",
"assets/assets/vitamins.png": "45425ec968a8cbbfe65e0c3e69f801e2",
"assets/assets/volunteer.png": "2ad02a1eedc31aef2b8ced109384bfb1",
"assets/assets/warning.png": "27e28f8d3352a284662ef957558ef77d",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "92ecbbd31622ba4c67e96e135662acf4",
"assets/packages/csc_picker/lib/assets/country.json": "11b8187fd184a2d648d6b5be8c5e9908",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "00bb2b684be61e89d1bc7d75dee30b58",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "4b6a9b7c20913279a3ad3dd9c96e155b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dffd9504fcb1894620fa41c700172994",
"favicon.png": "35136776c18ce58fb74f9353d7e978a8",
"icons/icon-192x192.png": "35136776c18ce58fb74f9353d7e978a8",
"icons/icon-256x256.png": "35136776c18ce58fb74f9353d7e978a8",
"icons/icon-384x384.png": "35136776c18ce58fb74f9353d7e978a8",
"icons/icon-512x512.png": "35136776c18ce58fb74f9353d7e978a8",
"index.html": "e3834df52cb5f03d54ce69f606bce535",
"/": "e3834df52cb5f03d54ce69f606bce535",
"main.dart.js": "c6fdb237812725106b37f112503d2f10",
"manifest.json": "60320ba02c37509221c1002ecc6c9f23",
"splash/img/dark-background.png": "370018dcec6a9dcbc1d72d844b4f4203",
"splash/img/light-background.png": "370018dcec6a9dcbc1d72d844b4f4203",
"splash/style.css": "abd3b5811afac21066420e2e2459e800",
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
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
