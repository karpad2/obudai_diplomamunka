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
        <md-table-head>Device Activity:</md-table-head>
        <md-table-head>Device is Active</md-table-head>
        <md-table-head>Delete Device:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in devices" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell>{{row.mode}}</md-table-cell>
        <md-table-cell><activedevice :lastonline="row.lastonline"/></md-table-cell>
        <md-table-cell><md-button class="md-raised md-primary" @click="showDDialog = true">Delete Device <BIconPlus /></md-button></md-table-cell>
    </md-table-row>
      
      </md-table>
      <md-button class="md-raised md-primary" @click="showDDialog = true">Add Device <BIconPlus/></md-button>
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

<md-dialog :md-active.sync="showDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>
		
		
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>

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
    BIconPlus
    },
    mounted()
    {
        localStorage.setItem('devices',JSON.stringify([]));
        const userId = FirebaseAuth.currentUser.uid;
        onValue(ref(FireDb, `/users/${userId}/rooms`),(sn)=>
     {
       if(sn.exists())
       {
         sn.forEach((element,i) => {
            let a=JSON.parse(localStorage.getItem('devices'));
            if(element.val().devices!=null)
            {   a.push(element.val().devices);
                localStorage.setItem('devices',JSON.stringify(a));
            }
            //a.push()
         });
     }});
     this.devices=localStorage.getItem('devices');
        /*
            még nincs implementálva a böngészőkben OwO
            navigator.bluetooth.addEventListener('advertisementreceived',this.findADevice(event));
        */
    },
    methods:
    {
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
        {setTimeout(this.stopScan, 10000);},



        }
    
  }

</script>
