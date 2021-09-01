<template>
<div  class="center">
    
    <h2>Room ~ {{room_name}}</h2>
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
      <activedevice :lastonline="Date.now()"/>
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
        <md-table-cell>{{row.device_name}}</md-table-cell>
        <md-table-cell>{{row.mode}}</md-table-cell>
        <md-table-cell><activedevice :lastonline="row.lastonline"/></md-table-cell>
        <md-table-cell><md-button class="md-raised md-primary" @click="showDDialog = true">Delete Device <BIconPlus/></md-button></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDDialog = true">Add Device <BIconPlus/></md-button>
    </div>
      <div class="section">
  <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Programs:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Program Name:</md-table-head>
        <md-table-head>Program is Active?</md-table-head>
        <md-table-head>Delete Program:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in programs" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell><md-radio v-model="a_program" :value="row.key" class="primary">Active</md-radio></md-table-cell>
        <md-table-cell><router-link :to="{ path: '/Lobby/'+row.key}">Lobby</router-link></md-table-cell>
        <md-table-cell>{{row.devices}}</md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
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
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell></md-table-cell>
        <md-table-cell></md-table-cell>
        <md-table-cell></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDialog = true">Add Camera</md-button>
      </div>    
<md-dialog :md-active.sync="showPDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>	
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showPDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showPDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>



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

</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import Activedevice from "@/components/parts/Activedevice";
import ElapsedTime from "@/components/ElapsedTime";
import {BIconCheck2,BIconPlus} from 'bootstrap-icons-vue'
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";


export default {
    data()
    {
        return{
            programs:[],
            devices:[],
            rans:[],
            active_program:"",
            showPDialog:false,
            showDDialog:false,
            showCDialog:false,
            room_name:"",
            program_name:"",
            device_name:"",
            a_program:"",
            camera_name:"",
            cameras:[]

        }
    },
    components:
            {BIconPlus,
            Activedevice,
            ElapsedTime
            },
mounted()
{
   this.get_data();
},
methods:
{

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
       this.room_name=sn.val().room_name;       
       this.activeprogram=sn.val().activeprogram;
    });
     this.get_data_fromdb("cameras");
     this.get_data_fromdb("devices");
     this.get_data_fromdb("programs");  
     //console.log(this.devices);
  },

  get_data_fromdb(k)
  {
    const room_id=this.$route.params.rid;
    const userId = FirebaseAuth.currentUser.uid;
    let b=[];
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
      sn.forEach((l)=>
     {
       b.push(l.val());
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
                                "camera_url":""};
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
                                "mode":"",
                                "status":""
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
    }
}
}
</script>
