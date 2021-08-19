import firebase from 'firebase/app';
import {getAuth} from 'firebase/auth';
import 'firebase/app-check';
import {getDatabase,ref,set} from 'firebase/database';
import { initializeApp } from "firebase/app";

import firebaseCredentials from './credentials';
const firebaseApp = initializeApp(firebaseCredentials.config);
//const appcheck=firebase.appCheck();

//appcheck.setTokenAutoRefreshEnabled();
const FirebaseAuth = firebase.auth();
const Firebase = firebase;
const FireDb = firebase.app().database();


const auth = getAuth();
const user= auth.c


const userdata= ()=>{
	let user_data=null;
	const db = getDatabase();
	let user=JSON.parse(localStorage.getItem('user'));

	set(ref(db, 'users/' + user.uid), {
	devices:[],
	rooms:[],
	programs:[]
	});
	

	return user_data;
} 
export {
	Firebase
}
export {
	FirebaseAuth
}
export { 
	FireDb
}