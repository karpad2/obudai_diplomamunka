import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/app-check';

import firebaseCredentials from './credentials';
firebase.initializeApp(firebaseCredentials.config);
const appcheck=firebase.appCheck();

appcheck.setTokenAutoRefreshEnabled();
const FirebaseAuth = firebase.auth();
const Firebase = firebase;

export {
	Firebase
}
export {
	FirebaseAuth
}