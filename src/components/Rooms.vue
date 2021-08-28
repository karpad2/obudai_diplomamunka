<template>
<div class="center">
    <h2>Rooms</h2>
    <div v-for="row in rooms" :key="row.id" class="">
			<span>{{row.room_name}}</span><br/>
		</div>

<md-dialog-prompt
      :md-active.sync="showDialog"
      v-model="room_name"
      md-title="Add Room"
      md-input-maxlength="30"
      md-input-placeholder="Room name ..."
      md-confirm-text="Done"
      :md-confirm="add_room" />
    <md-button class="md-raised md-primary" @click="showDialog = true">Add room</md-button>
</div>
</template>
<script>
import {FireDb,FirebaseAuth} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
export default {
    name: 'Rooms',
    data: () => ({
      showDialog: false,
      rooms:[],
      room_keys:[],
      room_name:""
    }),
    mounted()
    {
       this.get_rooms();
        
        //console.log(this.rooms);
    },
   methods:{
    add_room()
    {
      if(this.room_name=="") return;
      console.log("Add Room");
        
    const postData = {
                        "room_name":this.room_name,
                        "programs":{
                           "program_1": {
                                "program_name":"test program",
                                "program_xml":"",
                                "program_javascript":"",
                                "program_active":true}
                        }
                        ,
                        "devices":[]};
                        try
                        {
      let frooms= ref(FireDb, `users/${FirebaseAuth._currentUser.uid}/rooms`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }
      //this.showDialog=false;
        
    },
     get_rooms(){
     let dbRef = ref(FireDb);
     this.rooms=[];
        get(child(dbRef.once, `users/${FirebaseAuth._currentUser.uid}/rooms`)).then((snapshot) => {
        if (snapshot.exists()) {
            //this.rooms=snapshot;
          console.log(snapshot);
          snapshot.forEach((sn)=>
          { 
            this.rooms.push(
              {"room_name":sn.val().room_name,
              "id":sn.key});
            //console.log(sn.val().room_name)
            
          });
          
          
      } else {
      console.log("No data available");
    }
          }).catch((error) => {
            console.error(error);
          });
   console.log(this.rooms);       
  }

    
  }
 
  }

</script>
