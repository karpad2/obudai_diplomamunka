import firebase from 'firebase/app';
import 'firebase/auth';

import firebaseCredentials from './credentials';
firebase.initializeApp(firebaseCredentials.config);

const FirebaseAuth = firebase.auth();
const Firebase = firebase;

export {
	Firebase
}
export {
	FirebaseAuth
}