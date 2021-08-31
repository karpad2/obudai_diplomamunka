<template>
<div  class="center">
    
    <h2>Room ~ {{room_name}}</h2>
    <div class="section">
     <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Show Previous Runs</h1>
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
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell>{{row.mode}}</md-table-cell>
        <md-table-cell><activedevice :lastonline="row.lonline"/></md-table-cell>
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
        <md-table-cell><router-link :to="{ path: '/Room/'+row.key}">Edit</router-link></md-table-cell>
        <md-table-cell><router-link :to="{ path: '/Lobby/'+row.key}">Lobby</router-link></md-table-cell>
        <md-table-cell>{{row.devices}}</md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
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

<md-dialog :md-active.sync="showDDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>
		
		
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showDDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showDDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>

<md-dialog-prompt
      :md-active.sync="showPDialog"
      v-model="program_name"
      md-title="Add Program"
      md-input-maxlength="30"
      md-input-placeholder="Program name ..."
      md-confirm-text="Done"
      :md-confirm="add_program" />



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
            room_name:"",
            program_name:""

        }
    },
    components:
            {BIconPlus,
            Activedevice,
            ElapsedTime
                        
            },
mounted()
{
   const room_id=this.$route.params.id;
   console.log(room_id);
   const userId = FirebaseAuth.currentUser.uid;
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
       this.room_name=sn.val().room_name;
       this.devices=sn.val().devices;
       this.programs=sn.val().programs;
       this.activeprogram=sn.val().activeprogram;
       this.rans=sn.val().rans;
     });
},
methods:
{
    add_program()
    {
     
      if(this.room_name=="") return;
      console.log("Add Room");
      const room_id=this.$route.params.id;
      const userId = FirebaseAuth.currentUser.uid;
        
    const postData =  {
                                "program_name":this.program_name,
                                "program_xml":"",
                                "program_javascript":"",
                                "program_active":true};
                        try
                        {
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }


    }
}
}
</script>
