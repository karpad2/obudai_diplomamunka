<template>
<div class="center">
    
    <div class="section">
    <div ></div>
    </div>
    <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Rooms</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Room Name</md-table-head>
        <md-table-head>Edit Room</md-table-head>
        <md-table-head>Enter into Lobby</md-table-head>
        <md-table-head>Active Devices:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in rooms" :key="row.devID">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.room_name}}</md-table-cell>
        <md-table-cell><router-link :to="{ path: '/room/'+row.devID}">Edit</router-link></md-table-cell>
        <md-table-cell><router-link :to="{ path: '/room/'+row.devID+'/lobby/'}">Lobby</router-link></md-table-cell>
        <md-table-cell>{{get_active_devices(row.devID)}}</md-table-cell>
    </md-table-row>
      
      </md-table>
    
<md-dialog-prompt
      :md-active.sync="showDialog"
      v-model="room_name"
      md-title="Add Room"
      md-input-maxlength="30"
      md-input-placeholder="Room name ..."
      md-confirm-text="Done"
      :md-confirm="add_room()" />
    <md-button class="md-raised md-primary" @click="showDialog = true">Add room</md-button>
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";

import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";

export default {
    name: 'Rooms',
    data(){      
      return {
      showDialog: false,
      rooms:[],
      room_keys:[],
      room_name:"",
      test:"aaa",
      rows:[],
      devices:[],
      users:[]}
    },
    
    mounted()
    {
       this.get_rooms(); 
        //console.log(this.rooms);
    },
   methods:{
    add_room()
    {
      console.log("Add Room");
      console.log(this.room_name);
      if(this.room_name==="") return;
      console.log("Add Room");
        
    const postData = {
                        "room_name":this.room_name,
                        "programs":{
                           "program_1": {
                                "program_name":"test program",
                                "active_program":true,
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
       this.get_rooms();
       this.room_name=""; 
    },
     get_rooms(){
     const userId = FirebaseAuth.currentUser.uid;
     onValue(ref(FireDb, `/users/${userId}/rooms`),(sn)=>
     {
       if(sn.exists())
       {
         sn.forEach((element) => {
          this.rooms.push(
             {
               data:element.val(),
               devID:element.key
             });
         });
       }
       else
       {
         this.rooms.push(
           {
             data:{room_name:"Nincs szoba"}
           }
         );
       }
     });
      
   
  },
  get_active_devices(index)
    {
     this.get_data_fromdb(index,"devices");
     let active=0,inactive=0,k;

      this.devices.forEach(element => {
        console.log(element.data.lastonline);
        k=Date.now()-Date(element.data.lastonline);
        if(k<120)
        {
          active++;
        }
        else
        {
          inactive++;
        }
       
       // console.log(k);
      });
       if(inactive==0)
        {
          return "All device online";
        }
        else if(active==0)
        {
          return "All device offline";
        }
        else
        {
          return `${active} are online, and ${inactive} are offline`;
        }
      
    },
     get_data_fromdb(room_id,k){
    const userId = FirebaseAuth.currentUser.uid;
    let b=[];
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
      sn.forEach((l)=>
     {
       b.push({
         data:l.val(),
         dev_id:l.key
       });
     })});
    switch(k)
    {
     
      case "devices": this.devices=b; break;
      
    } 
  },
},
  computed:{
    
  }
 

 
  }

</script>

<style lang="scss" scoped>
  .md-list {
    width: 320px;
    max-width: 100%;
    display: inline-block;
    vertical-align: top;
    border: 1px solid rgba(#000, .12);
  }
</style>