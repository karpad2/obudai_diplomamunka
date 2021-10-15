<template>
<div >
    <h2>Previous Runs</h2>
    <div>
        You can see Previous runs which made by teams.
        <p> You can modify or even delete this run datas.</p>
    </div>
     <div class="section" >
  <md-table  md-card v-if="pruns.length>0">
      <md-table-toolbar>
        <h1 class="md-title">Previous runs  by rooms:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Room Name:</md-table-head>
        <md-table-head>Team name:</md-table-head>
        <md-table-head>Time:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in pruns" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.room_name}}</md-table-cell>
        <md-table-cell><img :src="row.data.team_name" class="" /></md-table-cell>
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/prun/${row.dev_id}`}">Check</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>
      
      <md-empty-state v-else
			md-icon="history_toggle_off"
			md-label="You do not have previous run."
			md-description="You do not have previous run :/">
			
		</md-empty-state>
      </div>
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_from_allroomdb} from "@/mod_data/get_data";
export default
{
  data()
  {
    return{
      pruns:[]
    }
  },
  mounted()
  {
    this.pruns=get_data_from_allroomdb("pruns");

  },
  methods:{
  
  }
}
/*
<md-empty-state
			md-icon="devices_other"
			md-label="Create your first project"
			md-description="Create beautiful project with this template, you'll be able to create great things.">
			<md-button class="md-primary md-raised" to="/home">Ciao</md-button>
		</md-empty-state>
*/

</script>
