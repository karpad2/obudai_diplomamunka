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
        <md-table-head md-numeric>ID</md-table-head>
        <md-table-head>Room Name</md-table-head>
        <md-table-head>Edit Room</md-table-head>
        <md-table-head>Enter into Lobby</md-table-head>
        <md-table-head>Active Devices:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in rows" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell><router-link :to="'edit/'+key">Edit</router-link></md-table-cell>
        <md-table-cell>Lobby</md-table-cell>
        <md-table-cell>Active devices:</md-table-cell>
    </md-table-row>
      
      </md-table>
    
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
       this.get_rooms(); 
    },
     get_rooms(){
    this.room_keys=[];
    this.rows=[];
     localStorage.setItem('rooms',JSON.stringify([]));
     const userId = FirebaseAuth.currentUser.uid;
     onValue(ref(FireDb, `/users/${userId}/rooms`),(sn)=>
     {
       if(sn.exists())
       {
         sn.forEach((element,i) => {
           let a=JSON.parse(localStorage.getItem('rooms'));
           console.log(a);
            a.push(element.val());
            localStorage.setItem('rooms',JSON.stringify(a));
            this.room_keys.push(element.key);
            
            this.rows.push({i:i,name:element.val().room_name,key:element.key});
         });
      localStorage.setItem("rows",JSON.stringify(this.rows));
      this.rooms=JSON.parse(localStorage.getItem('rooms'));
       console.log(this.rooms);
       }
       else
       {
         this.rooms.push(
           {
             room_name:"Nincs szoba"
           }
         );
       }
     });
      
   
  }

    
  },
 

 
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