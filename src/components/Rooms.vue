<template>
<div class="center">
    <h2>Rooms</h2>
    <md-button class="md-raised md-primary">Add room</md-button>
</div>
</template>
<script>
import {FireDb,FirebaseAuth} from "@/firebase";
import {ref, set ,onValue,get, child} from "firebase/database";
export default {
    name: 'Rooms',
    data: () => ({
      showDialog: false
    }),
    mounted()
    {
   /* 
   let read = ref(FireDb,'/users/'+FirebaseAuth.uid);
    onValue(read, (snapshot) => {
        let data = snapshot.val();
        console.log("Im here")
        console.log(data);
        });*/
        const dbRef = ref(FireDb);
        console.log()
        get(child(dbRef, `users/${FirebaseAuth._currentUser.uid}`)).then((snapshot) => {
        if (snapshot.exists()) {
          console.log(snapshot.val());
        } else {
        console.log("No data available");
        }
          }).catch((error) => {
            console.error(error);
          });

    }
  }


</script>
