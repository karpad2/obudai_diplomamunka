import firebase from 'firebase/app';
import {getAuth} from 'firebase/auth';
import user_default from "./user_default.json";
const { initializeAppCheck, ReCaptchaV3Provider } = require("firebase/app-check");
import {getDatabase,ref,set, onValue,onDisconnect,child} from 'firebase/database';
import { initializeApp } from "firebase/app";
import { enableIndexedDbPersistence } from "firebase/firestore"; 

import firebaseCredentials from './credentials';
const app = initializeApp(firebaseCredentials.config);

const appCheck = initializeAppCheck(app, {
	provider: new ReCaptchaV3Provider('6LelvRIcAAAAAEKE72hWevy4k3efJ7PJFrLdo5md'),
  
	// Optional argument. If true, the SDK automatically refreshes App Check
	// tokens as needed.
	isTokenAutoRefreshEnabled: true
  });
// key for recatchpa3 
//const appcheck=firebase.appCheck();

//appcheck.setTokenAutoRefreshEnabled();
const FirebaseAuth = getAuth();
const Firebase = firebase;
const FireDb = getDatabase();
const presenceRef = ref(FireDb, "disconnectmessage");

onDisconnect(presenceRef).set("I disconnected!");


const connectedRef = ref(FireDb, ".info/connected");
onValue(connectedRef, (snap) => {
  if (snap.val() === true) {
    console.log("connected");
  } else {
    console.log("not connected");
  }
});



const auth = getAuth();
const user= getAuth._currentUser;

//const user_data = child(dbRef, `users/${FirebaseAuth._currentUser.uid}`);
let user_data ="";
const change_Theme_Fb= (value)=>{
	if (localStorage.userTheme=="light")
	{ localStorage.userTheme = "dark";
	}
	else
	{
		localStorage.userTheme = "light";
	}
};
/*const change_Theme_Fb= (value)=>
{	let dbRef= ref(FireDb);
	let user_data = child(dbRef, `users/${FirebaseAuth._currentUser.uid}`);
	if (localStorage.userTheme=="light")
	{ localStorage.userTheme = "dark";
	user_data.update({"user_profile_color":"dark"});
	}
				else 
				{
					localStorage.userTheme = "light";
					user_data.update({"user_profile_color":"light"});
				}
				console.log("Change theme");
				//user_data.update({"":""});
				
       
};*/


const db = FireDb;
let read = ref(FireDb,'users/'+FirebaseAuth.uid);
onValue(read, (snapshot) => {
	let data = snapshot.val();
	console.log("Im here")
	console.log(data);
  });
if (read===null || read===undefined) 
   {
	
	  
    set(ref('users/'+FirebaseAuth.uid),user_default);      
	localStorage.user=user_default;
}
   else 
   {
	localStorage.user=read;
	console.log(read);
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
export { 
	change_Theme_Fb
}
export {
	user
}