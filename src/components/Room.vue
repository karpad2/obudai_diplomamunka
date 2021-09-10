<template>
<div >
    
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
    <h4>Network Settings:</h4>
       <md-field>
         <label for="input">Wifi Name:</label>
        <md-input id="input" @change="send_wifi" v-model="room.wifi_name"></md-input>
        </md-field>
        <md-field>
         <label for="input">Wifi Password:</label>
        <md-input id="input" @change="send_wifi" v-model="room.wifi_password"></md-input>
        </md-field>

</div>
<div class="section">
      <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Room</md-button>
      <md-button class="md-raised md-secondary" @click="duplicate_room()">Duplicate Room</md-button>
      </div>    
      </div>   

<md-dialog-prompt
      :md-active.sync="showPDialog"
      v-model="program_name"
      md-title="Add Program"
      md-input-maxlength="30"
      md-input-placeholder="Program name ..."
      md-confirm-text="Done"
      @md-confirm="padd_program()" />

 <md-dialog-prompt
      :md-active.sync="showDDialog"
      v-model="device_name"
      md-title="Add Device"
      md-input-maxlength="30"
      md-input-placeholder="Device name ..."
      md-confirm-text="Done"
      @md-confirm="padd_device()" />

      <md-dialog-prompt
      :md-active.sync="showCDialog"
      v-model="camera_name"
      md-title="Add Camera"
      md-input-maxlength="30"
      md-input-placeholder="Camera name ..."
      md-confirm-text="Done"
      @md-confirm="padd_camera()" />

      <md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this room?"
      md-content="Entire project will be empty, your device needed to reconnect to the base, your camera settings will be forgotten, and all of your programs in this room will be deleted."
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="del_room()" />
</div>
</template>
<script>

import Activedevice from "@/components/parts/Activedevice";
import ElapsedTime from "@/components/ElapsedTime";
import router from "@/router";
import {BIconCheck2,BIconPlus} from 'bootstrap-icons-vue'
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_fromdb,get_data_fromroomdb} from "@/mod_data/get_data";
import {add_program,add_camera,add_device,add_room} from "@/mod_data/set_data";
import {delete_room} from "@/mod_data/del_data";


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
  padd_program()
  {
    add_program(this.$route.params.rid,this.device_name,null)
  },
  padd_camera()
  {
    add_camera(this.$route.params.rid,this.camera_name,null)
  },
  padd_device()
  {
    add_device(this.$route.params.rid,this.device_name,null)
  },
  
changeprogram()
{
      const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/active_program`);
      set(frooms,this.room.active_program);
},
send_wifi()
{
    if(this.room.wifi_password.length<8 || this.room.wifi_name.length<3 ) return;
      const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/wifi_name`);
      set(frooms,this.room.wifi_name);
      frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/wifi_password`);
      set(frooms,this.room.wifi_password);
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
     this.cameras=get_data_fromroomdb(room_id,"cameras");
     this.devices=get_data_fromroomdb(room_id,"devices");
     this.programs=get_data_fromroomdb(room_id,"programs");  
     console.log(this.cameras);
     //console.log(this.devices);
  },
    
    edit(l)
      {
        router.push(l);
      },
    del_room()
        {
        delete_room(this.$route.params.rid);
        },
        duplicate_room()
        {
          add_room(`${this.room_name} duplicate`,this.room)
        },
onCancel () {
        //this.value = 'Disagreed'
      }
},

}

</script>
