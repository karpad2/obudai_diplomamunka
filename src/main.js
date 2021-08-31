import Vue from 'vue';
import router from './router';
import ForkeMeOnGithub from 'fork-me-on-github-vue';

import VueMaterial from 'vue-material'; // TODO: import only needed component, not all
import 'vue-material/dist/vue-material.min.css';
Vue.use(VueMaterial);
Vue.use(ForkeMeOnGithub);
import VueNoty from 'vuejs-noty';
Vue.use(VueNoty, {
	timeout: 4000,
	progressBar: true,
	layout: 'topRight'
});


import App from './App.vue';
let app = null;
Vue.config.productionTip = false;





import { getAuth, onAuthStateChanged } from "firebase/auth";
const auth = getAuth();
onAuthStateChanged(auth, (user) => {
	if (!app) {
		app = new Vue({
			router,
			render: h => h(App)
		}).$mount('#app');
	}
});
/*FirebaseAuth.onAuthStateChanged(() => { // Mount app only after firebase auth initialized
	
});
*/