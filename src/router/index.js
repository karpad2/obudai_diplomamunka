import Vue from 'vue';
import VueRouter  from 'vue-router';
import {FirebaseAuth} from '../firebase';
Vue.use(VueRouter);

import Index from "../components/Index";
import Error404 from "../components/Error404";
import AccountIndex from "../components/account/Index";
import AccountInfo from "../components/account/AccountInfo";
import AccountLogin from "../components/account/Login";

import Home from "../components/Home";
import Info from "../components/Info";
import Rooms from "../components/Rooms";
import Room from "../components/Room";

import Devices from "../components/Devices";
import Device from "../components/Device";

import Programs from "../components/Programs";
import Program from "../components/Program";

import Lobby from "../components/Lobby";
import Camera from "../components/Camera";
import Cameras from "../components/Cameras";
import PreviousRuns from "@/components/PreviousRuns";
import PreviousRun from "@/components/PreviousRun";

import Events from "@/components/Events";
import Event from "@/components/Event";
import Support from "@/components/Support";




const router = new VueRouter ({
	mode: 'history',
	base: '/',
	routes: [
		{
			path: '*',
			name: 'error404',
			component: Error404,
		},
		{
			path: '/',
			component: Index,
			meta: {
				requiresAuth: true
			},
			children: [
				{
					path: 'home',
					name: 'home',
					component: Home,
				},
				{
					path: 'rooms',
					name: 'rooms',
					component: Rooms,
				},
				{
					path: 'devices',
					name: 'devices',
					component: Devices,
				},
				{
					path: 'programs',
					name: 'programs',
					component: Programs,
				},
				//
				{
					path: 'cameras',
					name: 'cameras',
					component: Cameras,
				},
				{
					path: 'pruns',
					name: 'pruns',
					component: PreviousRuns,
				},
				{
					path: 'room',
					name: 'room',
					component: Room,
				},
				{
					path: 'info',
					name: 'info',
					component: Info,
				},
				{
					path: 'logout',
					name: 'logout',
					component: Info,
				},
				{
					path: 'events',
					name: 'event',
					component: Events,
				},
				{
					path: 'support',
					name: 'support',
					component: Support,
				},
				{
					path: '/room/:rid',
					component: Room,
				},
				{
					path: '/room/:rid/device/:did',
					component: Device,
				},
				{
					path: '/room/:rid/program/:pid',
					component: Program,
				},
				{
					path: '/room/:rid/event/:eid',
					component: Event,
				},
				{
					path: '/room/:rid/lobby',
					component: Lobby,
				},
				
				{
					path: '/room/:rid/camera/:cid',
					component: Camera
				},
				{
					path: '/room/:rid/prun/:prid',
					component: PreviousRun
				},
			]
		},
		{
			path: '/account',
			component: AccountIndex,
			children: [
				{
					path: '',
					name: 'account-info',
					component: AccountInfo,
				},
				{
					path: 'login',
					name: 'account-login',
					component: AccountLogin,
				}
			]
		}

	]
});

router.beforeEach((to, from, next) => {
	let currentUser = FirebaseAuth.currentUser;
	let requiresAuth = to.matched.some(record => record.meta.requiresAuth);
	if(requiresAuth && !currentUser) next('/account/login');
	else next();
})

export default router;
