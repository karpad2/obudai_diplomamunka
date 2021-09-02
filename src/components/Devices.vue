<template>
<div class="center">
<h2>Devices</h2>
<p>How to add device?</p>
<p>There is two method.</p>
<p>First you will need to add a device manually on the website.</p>
<p>Our method is using a "config.json" and flash this file to microcontroller, this file will contains the data for reaching server,
and network settings for it.</p>
<div class="section">
    <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Devices</h1>
      </md-table-toolbar>
      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Device Name:</md-table-head>
        <md-table-head>Device Mode:</md-table-head>
        <md-table-head>Device is Online?</md-table-head>
        <md-table-head>Devices Edit:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in devices" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell>{{row.mode}}</md-table-cell>
        <md-table-cell><activedevice :lastonline="row.lastonline"/></md-table-cell>
        <md-table-cell><md-button class="md-raised md-primary" @click="showDDialog = true">Edit Device </md-button></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDDialog = true">Add Device </md-button>
    </div>

<h2>Searching for Devices</h2>
<md-list v-if="!found_devices || !found_devices.length">
    <md-list-item>
    </md-list-item>
</md-list>

<md-list v-for="fdevice in found_devices" :key="fdevice.device_id">
 <md-list-item>
        <md-avatar>
          <img src="https://placeimg.com/40/40/people/6" alt="People">
        </md-avatar>

        <span class="md-list-item-text">Mary Johnson</span>

        <md-button class="md-icon-button md-list-action">
          <md-icon>chat_bubble</md-icon>
        </md-button>
      </md-list-item>
</md-list>


 <md-button class="md-raised md-primary">Add device</md-button>
</div>
</template>
<script>

import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {BIconCheck2,BIconPlus} from 'bootstrap-icons-vue'
export default {
    

    name: 'Devices',
    data: () => ({
      showDialog: false,
      scan : navigator.bluetooth.requestLEScan({"acceptAllAdvertisements":true}),
      found_devices:[],
      devices:[],
      showDDialog:false
     
    }),
    components:{
    
    },
    mounted()
    {        
       const userId = FirebaseAuth.currentUser.uid;
       this.get_data_fromdb();
        /*
            még nincs implementálva a böngészőkben OwO
            navigator.bluetooth.addEventListener('advertisementreceived',this.findADevice(event));
        */
    },
    methods:
    {/*
        findADevice(event)
        {
            this.found_devices.push(
                {
                    name:event.device_name,
                    device_id:event.device.id
                }
            )
        },
        stopScan() {
            console.log('Stopping scan...');
            this.scan.stop();
            console.log('Stopped.  scan.active = ' + this.scan.active);
            },
        search_devices()
        {setTimeout(this.stopScan, 10000);},*/

get_data_fromdb(){
          this.devices=[];
          let k="devices";
          let room_id="";
          //let l=[];

          const userId = FirebaseAuth.currentUser.uid;
          let b=[];
      onValue(ref(FireDb, `/users/${userId}/rooms`),(sn_out)=>{
            if(sn_out.exists()){
              sn_out.forEach((l)=>{
              room_id=l.key;
              //console.log(room_id);
             // console.log(`/users/${userId}/rooms/${room_id}/${k}`);
             onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sna)=>{
                 if(sna.exists())
                    {
                    //console.log(sna);
                    sna.forEach((lb)=>{
                      b.push(lb.val());
                     
                    });
                    }
                  });
              });

            }
          });

           //console.log(b);
          switch(k)
          {
            case "devices": this.devices=b; break;
          }
          console.log(this.devices); 
  },

        },
        
    
  }

</script>
