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
					path: '/room/:id',
					component: Room,
				},
				{
					path: '/device/:id',
					component: Device,
				},
				{
					path: '/program/:id',
					component: Program,
				},
				{
					path: '/lobby/:id',
					component: Lobby,
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
		},
		{
			path: '/device',
			component: Device,
			children: [
				{
					path: '/device/:id',
					name: 'device-info',
					component: Device,
				}
			]
		},
		
		{
			path: '/program',
			component: Program,
			children: [
				{
					path: '',
					name: 'program-info',
					component: Program,
				},
				
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
