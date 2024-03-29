module.exports = {
    // ...other vue-cli plugin options...
    pwa: {
      name: 'Escape Room Mangement Software',
      themeColor: '#4DBA87',
      msTileColor: '#000000',
      appleMobileWebAppCapable: 'yes',
      appleMobileWebAppStatusBarStyle: 'black',
      gcm_sender_id: "BM6YzLuzrt6MiOzbKf7QFnEgxmGTofpknXrEyJR09BT8DDhSkI3KRmCGVIlSZIc6dMBj7gF6pYeN9UHmNfLRXtc",
   
      // configure the workbox plugin
      workboxPluginMode: 'InjectManifest',
      workboxOptions: {
        // swSrc is required in InjectManifest mode.
        swSrc: 'src/sw.js',
        // ...other Workbox options...
      }
    }
  }