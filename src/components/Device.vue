<template>
<div class="center">
    <h2>Device {{device_name}}</h2>

            <div class="section">

     <md-field>
      <label>Device name:</label>
      <md-input v-model="device_name"></md-input>
    </md-field>
               <p><Deviceactivity :lastonline="device.last_online" /></p> 
            </div>



</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import Deviceactivity from '@/components/parts/Deviceactivity'
export default {
 name: 'Devices',
    data: () => ({
      showDialog: false,
      found_devices:[],
      device:[],
      showDDialog:false,
      device_name:"",
     
    }),
    components:{
    Deviceactivity
    },
    mounted()
    {
        console.log(this.$route.params);
        localStorage.setItem('device',JSON.stringify(null));
        const userId = FirebaseAuth.currentUser.uid;
        const devId = FirebaseAuth.currentUser.uid;
        onValue(ref(FireDb, `/users/${userId}/rooms/devices${devId}`),(sn)=>
     {
       if(sn.exists())
       {
        
        console.log(sn.val());
        this.device=sn.val();
            //a.push()
         
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
