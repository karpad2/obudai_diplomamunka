<template>
<div class="center">
    <h2>Device ~ {{device.device_name}}</h2>

     <div class="section">

     <md-field>
      <label>Device name:</label>
      <md-input @change="namechange" v-model="device.device_name"></md-input>
    </md-field>
    <p><Deviceactivity :lastonline="device.last_online" /></p> 

    
    <div class="md-layout md-gutter">
      <div class="md-layout-item">
        <md-field>
      <h3>Choose mode:</h3>
   <b-select @change="achange" v-model="device.mode">
     <b-select-option v-for="mode in devm" :key="mode.type" :value="mode.type">{{mode.name}}</b-select-option>
   </b-select>
        </md-field>
       <DeviceInput :mode="select" :v-model="device.status" />
      <md-button class="md-raised md-primary" @click="duplicatedevice">Duplicate device with same settings</md-button>
      </div>

    </div>
    <div class="section">
<md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Room</md-button>
</div>
<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this device?"
      md-content="Your device settings will be deleted and cant be recovered."
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="delete_device()" />

</div>
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import Deviceactivity from '@/components/parts/Deviceactivity';
import DeviceInput from '@/components/parts/DeviceInput'
import {devicemodes} from "@/datas";
import {add_device} from "@/mod_data/set_data";
export default {
 name: 'Device',
    data: () => ({
      showDialog: false,
      showDeleteDialog:false,
      device:{device_name:"_Basic",mode:"relay",status:false},
      devm:devicemodes,
      select:"relay",
      showDDialog:false,
      device_name:"",
    }),
    components:{
    Deviceactivity,
    DeviceInput
    },
    mounted()
    {

        /*
             <md-select id="operation " v-model="select" @change="achange" >
            <md-option v-for="mode in devm" :key="mode.type" :value="mode.type">{{mode.name}}</md-option>
          </md-select>

        */
        console.log(this.$route.params);
        //localStorage.setItem('device',JSON.stringify(null));
        const userId = FirebaseAuth.currentUser.uid;
        const devId = this.$route.params.did;
        const room_id=this.$route.params.rid;
        localStorage.setItem("mods",JSON.stringify(this.devm));

        onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/devices/${devId}`),(sn)=>{
       if(sn.exists()) 
       {this.device=sn.val();
        this.select=this.device.mode;
       }
        });

        

        if(this.device.status==null)
        {
            set(ref(FireDb, `/users/${userId}/rooms/${room_id}/devices/${devId}/status`),false);
        }
        /*
            még nincs implementálva a böngészőkben OwO
            navigator.bluetooth.addEventListener('advertisementreceived',this.findADevice(event));
        */
    },
    methods:
    {
        delete_device()
                {
                console.log("Delete process");
                    const userId = FirebaseAuth.currentUser.uid;
                    let b=[];
                    let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}`);
                    set(_ref,null);
                    this.$route.router.go(-1); 
                    },
                onCancel () {
                        //this.value = 'Disagreed'
                    },
                     get_type()
                    {
                        let b=[];
                        b=JSON.parse(localStorage.getItem("mods"));
                        let l="";
                        console.log(b);
                        if(this.device.mode==null) return "text";
                        if(!b||b==null) return "text"; //to b or not 2[b]
                        
                        b.forEach((k)=>{
                            if(this.device.mode===k.type)
                            {
                                l=k.control;
                                return;
                            }});
                        //this.device.mode
                        return l;
                    },
                     get_readonly()
                    {
                        let b=[];
                        b=JSON.parse(localStorage.getItem("mods"));
                        let l="";
                        if(this.device.mode==null) return "false";
                        if(!b||b==null) return "false";
                        console.log(b);
                        
                        b.forEach((k)=>{
                            if(this.device.mode===k.type)
                            {
                                l=k.readonly;
                                 return;
                            }
                        });
                        //this.device.mode
                        return l;
                    },
                    achange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/mode`);
                        set(_ref,this.select);
                        _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/status`);
                        set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/device_name`);
                        set(_ref,this.device.device_name);
                    },
                    duplicatedevice()
                    {
                      add_device(this.$route.params.rid,this.device.device_name,this.device);
                    },
                    get_config()
                    {
                      
                    }
                    },
                   
    
  }

</script>
