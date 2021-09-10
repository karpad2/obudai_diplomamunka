<template>
<div >
<h2>Programs</h2>
<div class="section" v-if="programs.length>0">
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
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/program/${row.dev_id}`}">Edit</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
    </div>
    <md-empty-state v-else
			md-icon="other_houses"
			md-label="Create your first room"
			md-description="Create beautiful project with this program, and you'll be able to create great things.">
			<md-button class="md-primary md-raised" @click="showDialog = true" >Add Room</md-button>
		</md-empty-state>
<md-dialog :md-active.sync="showDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>
		
		
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>


</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_from_allroomdb} from "@/mod_data/get_data";
export default {
    name: 'Programs',
    data () {
      return{
      showDialog: false,
      programs:[]
      }
    },
    methods:
    {

    },
    beforeMount()
    {
      this.programs=get_data_from_allroomdb("programs");
    }
  }
</script>
