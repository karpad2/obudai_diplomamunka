<template>
<div class="center">
    <h2>Cameras</h2>
    <div>
        To add Cameras and to use them only supported cameras are IP cameras:
        <p> You can use them in your local network example http://{ camera ip address}:{camera port}</p>
        <p>To remotely use cameras from different location you must proxied them through a vpn or from public IP (this is not recommended)</p>
    </div>
     <div class="section">
  <md-table  md-card>
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
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/camera/${row.cam_id}`}">Edit</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>
      
      </div>
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
export default
{
  data()
  {
    return{
      cameras:[]
    }
  },
  mounted()
  {
    

  },
  methods:{
  get_data_fromdb()
  {
    let k="cameras";
    let room_id="";
    let l=[];

    const userId = FirebaseAuth.currentUser.uid;
    let b=[];
 onValue(ref(FireDb, `/users/${userId}/rooms`),(sn_out)=>
     {
       if(sn_out.exists())
       {
         sn_out.forEach((l)=>{
        room_id=l.key;
            onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
            {
              if(sn.exists())
              console.log(sn);
              sn.forEach((l)=>
            {
              b.push({
                room_id:this.room_id,
                cam_id:l.key,
                data:l.val()
                });
            })});});

       }
     });

    
    switch(k)
    {
      case "cameras": this.cameras.push(b); break;
    } 
  },
  }
}

</script>
