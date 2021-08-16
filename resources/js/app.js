require('./bootstrap');

// Import modules...
import { createApp, h } from 'vue';
import {IconsPlugin } from 'bootstrap-vue';
import { App as InertiaApp, plugin as InertiaPlugin } from '@inertiajs/inertia-vue3';
import { InertiaProgress } from '@inertiajs/progress';

const el = document.getElementById('app');

createApp({
    render: () =>
        h(InertiaApp, {
            initialPage: JSON.parse(el.dataset.page),
            resolveComponent: (name) => require(`./Pages/${name}`).default,
        }),
})
    .mixin({ methods: { route } })
    .use(InertiaPlugin)
    //.use(BootstrapVue)
    //.use(IconsPlugin)
   // .config.devtools = true
    .mount(el);

InertiaProgress.init({ color: '#043343' });
