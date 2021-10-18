<template>
<div >

    <div  v-if="rooms.length>0">

      <md-card  >
          <md-card-header><div class="md-title">Rooms</div></md-card-header>
    <md-card-content>  
    <md-table  md-card>
      

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Room Name</md-table-head>
        <md-table-head>Edit Room</md-table-head>
        <md-table-head>Enter into Lobby</md-table-head>
        
      </md-table-row>
      
      <md-table-row v-for="(row,index) in rooms" :key="row.devID">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.room_name}}</md-table-cell>
        <md-table-cell><router-link :to="{ path: '/room/'+row.devID}">Edit</router-link></md-table-cell>
        <md-table-cell><router-link :to="{ path: '/room/'+row.devID+'/lobby/'}">Lobby</router-link></md-table-cell>
       
    </md-table-row>
    
      </md-table>
      </md-card-content>
      <md-card-actions> 
      <md-button class="md-raised md-primary" @click="showDialog = true">Add room</md-button>
      </md-card-actions>
       </md-card> 
    </div>
    
      <md-empty-state v-else
			md-icon="other_houses"
			md-label="Create your first room"
			md-description="Create beautiful project with this program, and you'll be able to create great things.">
			<md-button class="md-primary md-raised" @click="showDialog = true" >Add Room</md-button>
		</md-empty-state>
    
<md-dialog-prompt
      :md-active.sync="showDialog"
      v-model="room_name"
      md-title="Add Room"
      md-input-maxlength="30"
      md-input-placeholder="Room name ..."
      md-confirm-text="Done"
      :md-confirm="padd_room()" />
    
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_fromroomdb,get_rooms} from "@/mod_data/get_data";
import {add_room} from "@/mod_data/set_data";


export default {
    name: 'Rooms',
    data(){      
      return {
      showDialog: false,
      
      room_keys:[],
      room_name:"",
      test:"aaa",
      rows:[],
      
      users:[]}
    },
    
    beforeMount()
    {
      
        //console.log(this.rooms);
    },
   methods:{
    padd_room() {
     add_room(this.room_name);
      //this.showDialog=false;
      this.room_name="";
      
       
    },
     
  get_active_devices(index)
    {
    this.devices=get_data_fromroomdb(index,"devices");
    let active=0,inactive=0,k;

      this.devices.forEach(element => {
        console.log(element.data.lastonline);
        let k = new Date();

        k=k.getUTCSeconds()-Date(element.data.lastonline);
        if(k<120)
        {
          active++;
        }
        else
        {
          inactive++;
        }
       
       // console.log(k);
      });
       if(inactive==0)
        {
          return "All device online";
        }
        else if(active==0)
        {
          return "All device offline";
        }
        else
        {
          return `${active} are online, and ${inactive} are offline`;
        }
      
    },
    
     
},
computed:{
  rooms()
  {
    return get_rooms();
  }
}
 

 
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