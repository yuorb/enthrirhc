'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"favicon.svg": "cffdf7a40fe5ab8f21346070909a8c91",
"manifest.json": "15330aaf22975f0fc1be757f09852f73",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"index.html": "1a7ec67a561be285454e800522f4c9f8",
"/": "1a7ec67a561be285454e800522f4c9f8",
"sqlite3.wasm": "79a4cf7ac1cf1f9d5081474f5a7bb5ba",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin": "f63718b83b05434a1d2fd87cfcc017bf",
"assets/assets/icons_compiled/line_start_circle.svg.vec": "f6fba17ae3b00b0eb681a96725b7cd70",
"assets/assets/icons_compiled/counter_5.svg.vec": "28082c7fd58af8caf5810fe69bfd8d47",
"assets/assets/icons_compiled/counter_9.svg.vec": "fe181e2510c956ecaa509a78f025db5a",
"assets/assets/icons_compiled/discord.svg.vec": "d24f455c77253fcd09345c43ad272f34",
"assets/assets/icons_compiled/reddit.svg.vec": "fa6ef5812e7eb49ef3dc278cd22b8711",
"assets/assets/icons_compiled/counter_1.svg.vec": "51e5602ce3995012c58fcd20d8e77876",
"assets/assets/icons_compiled/counter_8.svg.vec": "427276f0fdb6e3d9910d0f32bd1db315",
"assets/assets/icons_compiled/tencentqq.svg.vec": "3d19384a1b5b8d213e6117b31b291059",
"assets/assets/icons_compiled/transition_fade.svg.vec": "cf90bf3ad999a120c1890561248b927c",
"assets/assets/icons_compiled/counter_2.svg.vec": "10e90a6d8a922b482b4f1ca10631c480",
"assets/assets/icons_compiled/jump_to_element.svg.vec": "b2541931f8b7569a6d6429f62109f17e",
"assets/assets/icons_compiled/counter_6.svg.vec": "a295a1d107a9281fbde68f557f0017fa",
"assets/assets/icons_compiled/quick_reference_all.svg.vec": "29655cc3478e917112ce3302c22a6300",
"assets/assets/icons_compiled/counter_0.svg.vec": "aad78bcb03ca5e62fdc791c4b8e6f3e7",
"assets/assets/icons_compiled/counter_4.svg.vec": "12b49ba7cfb926fa8b092c403bcde6c6",
"assets/assets/icons_compiled/counter_7.svg.vec": "5a978911f98dd2fb0b9572037e69b2ef",
"assets/assets/icons_compiled/steppers.svg.vec": "aefe95c038023c544a1fb16c16a27189",
"assets/assets/icons_compiled/list_alt_add.svg.vec": "5f7e63e85b7a34bba33161f753d8d78b",
"assets/assets/icons_compiled/communities.svg.vec": "4ca1cf121eef833273eb6a522e03ed8d",
"assets/assets/icons_compiled/sweep.svg.vec": "ac66d34d70c5c3ff8467a94b1416e59f",
"assets/assets/icons_compiled/telegram.svg.vec": "581561ce85a8120b9880b9baa930070f",
"assets/assets/icons_compiled/shapes.svg.vec": "7d403c432588b22d7ca345fc9ded0ff3",
"assets/assets/icons_compiled/github.svg.vec": "c640cf5d4fa6dfdcfb43b39102511fe7",
"assets/assets/icons_compiled/airwave.svg.vec": "6c0dbb3076fcd30dbbf3f88940da8382",
"assets/assets/icons_compiled/counter_3.svg.vec": "8b592a7b958f0f9c4271d7d9bf75fe13",
"assets/assets/icons_compiled/logo.svg.vec": "17921029a6b7313a478d552fa08e2d14",
"assets/AssetManifest.bin.json": "aaf52921ba352dd3d6d901f4ade09800",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "d4d10c3b5211438bf666a62ce68b880d",
"assets/fonts/MaterialIcons-Regular.otf": "874d15094003588051896ce5b1bb422a",
"assets/AssetManifest.json": "3f2ba98127cf0f0ac6a8dbf26e3019a5",
"main.dart.js": "339875a9451d5cc0ae4d8198dc103458",
"version.json": "f57945fb6e5c25401f435ac2dccf468c",
"icons/Icon-maskable-192.png": "d9548e24dde74f6393eb639e770ec59c",
"icons/Icon-192.png": "d9548e24dde74f6393eb639e770ec59c",
"icons/Icon-512.png": "8b65b312782062a346c25b14f224b70b",
"icons/Icon-maskable-512.png": "8b65b312782062a346c25b14f224b70b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
