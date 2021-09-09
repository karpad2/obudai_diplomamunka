<template>
<div class="center">
    <h2>Cameras</h2>
    <div>
        To add Cameras and to use them only supported cameras are IP cameras:
        <p> You can use them in your local network example http://{ camera ip address}:{camera port}</p>
        <p>To remotely use cameras from different location you must proxied them through a vpn or from public IP (this is not recommended)</p>
    </div>
     <div class="section">
  <md-table  md-card v-if="cameras.length>0">
      <md-table-toolbar>
        <h1 class="md-title">Cameras of all room:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Camera Name:</md-table-head>
        <md-table-head>Camera Live Image</md-table-head>
        <md-table-head>Camera Edit</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in cameras" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.camera_name}}</md-table-cell>
        <md-table-cell><img :src="row.data.camera_url" class="" /></md-table-cell>
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/camera/${row.dev_id}`}">Edit</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>

      <md-empty-state v-else
			md-icon="videocam"
			md-label="You do not have cameras"
			md-description="You do not have cameras. You can create camera inside the Room. :/">
			
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
      cameras:[]
    }
  },
  beforeMount()
  {
    this.cameras=get_data_from_allroomdb("cameras");

  },
  methods:{
  
  }
}

</script>
