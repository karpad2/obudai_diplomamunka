<template>
<div class="center">
<h2>Programs</h2>
<div class="section">
    <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Programs</h1>
      </md-table-toolbar>
      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Program Name:</md-table-head>
        <md-table-head>Program edit:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in programs" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.program_name}}</md-table-cell>
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/program/${row.program_id}`}">Edit</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>
      
    </div>
<md-dialog :md-active.sync="showDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>
		
		
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>

<md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
export default {
    name: 'Programs',
    data () {
      return{
      showDialog: false,
      programs:[]}
    },
    methods:
    {
  get_data_fromdb()
        {
          let k="programs";
          let room_id="";
          let l=[];

          const userId = FirebaseAuth.currentUser.uid;
          let b=[];
      onValue(ref(FireDb, `/users/${userId}/rooms`),(sn_out)=>
          {
            if(sn_out.exists())
            {
              sn_out.forEach((la)=>{
              room_id=la.key;
                  onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
                  {
                    if(sn.exists())
                    console.log(sn);
                    sn.forEach((l)=>
                  {
                    b.push({
                      room_id:la.key,
                      program_id:l.key,
                      data:l.val()
                      });
                  })});});

            }
          });

          
          switch(k)
          {
            case "programs": this.programs=b; break;
          }
          
        },
    },
    mounted()
    {
      this.get_data_fromdb();
    }
  }
</script>
