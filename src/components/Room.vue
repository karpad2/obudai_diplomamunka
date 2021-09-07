<template>
<div  class="center">
    
    <h2>Room ~ {{room.room_name}}</h2>
    <div class="section">
     <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Previous Runs:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Team Name:</md-table-head>
        <md-table-head>Program Name:</md-table-head>
        <md-table-head>Run time:</md-table-head>
      </md-table-row>
      <md-table-row v-if="rans">
          <md-table-cell col-span="4">No previous run</md-table-cell>
       </md-table-row> 
      <md-table-row v-else v-for="(row,index) in rans" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.team_name}}</md-table-cell>
        <md-table-cell>{{row.program_name}}</md-table-cell>
        <md-table-cell><ElapsedTime :firstdate="row.firstdate" :lastdate="row.lastdate" /></md-table-cell>
    </md-table-row>
      
      </md-table>
      </div>
      
      <div class="section">
    <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Devices</h1>
      </md-table-toolbar>
      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Device Name:</md-table-head>
        <md-table-head>Device Activity:</md-table-head>
        <md-table-head>Device is Active</md-table-head>
        <md-table-head>Delete Device:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in devices" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.device_name}}</md-table-cell>
        <md-table-cell>{{row.data.mode}}</md-table-cell>
        <md-table-cell><activedevice :lastonline="row.data.lastonline"/></md-table-cell>
        <md-table-cell><md-button class="md-raised md-primary"  @click="edit(`/room/${$route.params.rid}/device/${row.dev_id}`)">Settings <BIconPlus/></md-button></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDDialog = true">Add Device <BIconPlus/></md-button>
    </div>
      <div class="section">
        
   <h3>Choose Active Program:</h3>
   <b-select @change="changeprogram" v-model="room.active_program">
     <b-select-option v-for="row in programs" :key="row.devID" :value="row.devID">{{row.data.program_name}}</b-select-option>
   </b-select>

  <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Programs:</h1>
      </md-table-toolbar>
      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Program Name:</md-table-head>
        <md-table-head>Program edit:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in programs" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.program_name}}</md-table-cell>
       <md-table-cell><md-button class="md-raised md-primary"  @click="edit(`/room/${$route.params.rid}/program/${row.dev_id}`)">Settings <BIconPlus/></md-button></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showPDialog = true">Add program</md-button>
      </div>

      <div class="section">
  <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Cameras:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Camera Name:</md-table-head>
        <md-table-head>Camera is Active?</md-table-head>
        <md-table-head>Modify Camera:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in cameras" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.camera_name}}</md-table-cell>
        <md-table-cell></md-table-cell>
        <md-table-cell><md-button class="md-raised md-primary"  @click="edit(`/room/${$route.params.rid}/camera/${row.dev_id}`)">Settings <BIconPlus/></md-button></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showCDialog = true">Add Camera</md-button>
<div class="section">
      <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Room</md-button>
      </div>    
      </div>   

<md-dialog-prompt
      :md-active.sync="showPDialog"
      v-model="program_name"
      md-title="Add Program"
      md-input-maxlength="30"
      md-input-placeholder="Program name ..."
      md-confirm-text="Done"
      @md-confirm="add_program()" />

 <md-dialog-prompt
      :md-active.sync="showDDialog"
      v-model="device_name"
      md-title="Add Device"
      md-input-maxlength="30"
      md-input-placeholder="Device name ..."
      md-confirm-text="Done"
      @md-confirm="add_device()" />

      <md-dialog-prompt
      :md-active.sync="showCDialog"
      v-model="camera_name"
      md-title="Add Camera"
      md-input-maxlength="30"
      md-input-placeholder="Camera name ..."
      md-confirm-text="Done"
      @md-confirm="add_camera()" />

      <md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this room?"
      md-content="Entire project will be empty, your device needed to reconnect to the base, your camera settings will be forgotten, and all of your programs in this room will be deleted."
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="delete_room()" />

</div>
</template>
<script>

import Activedevice from "@/components/parts/Activedevice";
import ElapsedTime from "@/components/ElapsedTime";
import router from "@/router";
import {BIconCheck2,BIconPlus} from 'bootstrap-icons-vue'
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";



export default {
    data()
    {
        return{
            programs:[],
            devices:[],
            room:{},
            rans:[],
            active_program:"",
            showPDialog:false,
            showDDialog:false,
            showCDialog:false,
            showDeleteDialog:false,
            room_name:"",
            program_name:"",
            device_name:"",
            a_program:"",
            camera_name:"",
            cameras:[]

        }
    },
    components:
        {
            BIconPlus,
            Activedevice,
            ElapsedTime
        },
mounted()
{
   this.get_data();
},
methods:
{
changeprogram()
{
      const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/active_program`);
      set(frooms,this.room.active_program);
},
  get_data()
  {
  const room_id=this.$route.params.rid;
   console.log(this.$route.params);
   console.log(room_id);
   const userId = FirebaseAuth.currentUser.uid;
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
       this.room=sn.val();
       this.room_name=sn.val().room_name;       
       this.activeprogram=sn.val().active_program;
       console.log( this.activeprogram);
    });
     this.get_data_fromdb("cameras");
     this.get_data_fromdb("devices");
     this.get_data_fromdb("programs");  
     console.log(this.cameras);
     //console.log(this.devices);
  },

  get_data_fromdb(k){
    const room_id=this.$route.params.rid;
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
      case "cameras": this.cameras=b; break;
      case "devices": this.devices=b; break;
      case "programs": this.programs=b; break;
    } 
  },
    add_program()
    {
     if(this.program_name=="") return;
      console.log("Add program");
      const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
        
    const postData =  {
                        "program_name":this.program_name,
                        "program_xml":"",
                        "program_javascript":"",
                      };
     try
        {
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/programs`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }

      this.program_name="";
    },
    add_camera()
    {
     
      if(this.camera_name=="") return;
      console.log("Add Camera");
      const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
        
    const postData =  {
          "camera_name":this.camera_name,
          "camera_url":""
          };
                        try
                        {
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/cameras/`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }
      this.camera_name="";

    },
    add_device()
    {
     
      if(this.device_name=="") return;
      console.log("Add Device");
      const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
        
    const postData =  {
                                "device_name":this.device_name,
                                "mode":"relay",
                                "status":"0"
                      };
   try
      {
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/devices/`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }
      this.device_name="";
      this.get_data();
    },
    edit(l)
      {
        router.push(l);
      },
    delete_room()
{
console.log("Delete process");
const room_id=this.$route.params.rid;
    const userId = FirebaseAuth.currentUser.uid;
    let b=[];
    let _ref= ref(FireDb, `/users/${userId}/rooms/${room_id}`);
    set(_ref,null);
     router.go(-1); 

},
onCancel () {
        //this.value = 'Disagreed'
      }
},

}

</script>
