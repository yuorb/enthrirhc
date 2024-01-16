'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"manifest.json": "15330aaf22975f0fc1be757f09852f73",
"index.html": "695921ddf6ea37dd3cf7f0c07185a761",
"/": "695921ddf6ea37dd3cf7f0c07185a761",
"sqlite3.wasm": "79a4cf7ac1cf1f9d5081474f5a7bb5ba",
"assets/AssetManifest.bin": "8a00880517d5ca534cb0f8665df1b873",
"assets/fonts/MaterialIcons-Regular.otf": "776e3b1e5fdb08b60af4c597d6000627",
"assets/assets/icons_compiled/telegram.svg.vec": "581561ce85a8120b9880b9baa930070f",
"assets/assets/icons_compiled/transition_fade.svg.vec": "cf90bf3ad999a120c1890561248b927c",
"assets/assets/icons_compiled/discord.svg.vec": "d24f455c77253fcd09345c43ad272f34",
"assets/assets/icons_compiled/github.svg.vec": "c640cf5d4fa6dfdcfb43b39102511fe7",
"assets/assets/icons_compiled/airwave.svg.vec": "6c0dbb3076fcd30dbbf3f88940da8382",
"assets/assets/icons_compiled/line_start_circle.svg.vec": "f6fba17ae3b00b0eb681a96725b7cd70",
"assets/assets/icons_compiled/jump_to_element.svg.vec": "b2541931f8b7569a6d6429f62109f17e",
"assets/assets/icons_compiled/reddit.svg.vec": "fa6ef5812e7eb49ef3dc278cd22b8711",
"assets/assets/icons_compiled/steppers.svg.vec": "aefe95c038023c544a1fb16c16a27189",
"assets/assets/icons_compiled/communities.svg.vec": "4ca1cf121eef833273eb6a522e03ed8d",
"assets/assets/icons_compiled/shapes.svg.vec": "7d403c432588b22d7ca345fc9ded0ff3",
"assets/assets/icons_compiled/tencentqq.svg.vec": "3d19384a1b5b8d213e6117b31b291059",
"assets/assets/icons_compiled/logo.svg.vec": "17921029a6b7313a478d552fa08e2d14",
"assets/assets/icons_compiled/quick_reference_all.svg.vec": "29655cc3478e917112ce3302c22a6300",
"assets/AssetManifest.bin.json": "7edf0f02da87872b17c8f07420b211e3",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/NOTICES": "606da4572cefa548a9d0dca1fe5c59a4",
"assets/AssetManifest.json": "858cc5b1730ccc7cf62012de9843dd5b",
"favicon.png": "dfd385f1164c78a105798b8b008166f0",
"main.dart.js": "9c93be934f0f49a08b06cfd7bf080fea",
"version.json": "f13a513488707bd4e1d9d47c94870df6",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"icons/Icon-512.png": "8b65b312782062a346c25b14f224b70b",
"icons/Icon-192.png": "d9548e24dde74f6393eb639e770ec59c",
"icons/Icon-maskable-192.png": "d9548e24dde74f6393eb639e770ec59c",
"icons/Icon-maskable-512.png": "8b65b312782062a346c25b14f224b70b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
