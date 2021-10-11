<template>
<div > 
<div class="section">
<md-card md-with-hover >
     
       <md-card-header>
         <div class="md-title" >Device ~ {{device.device_name}}</div>
        </md-card-header>
        <md-card-content>
          <md-field>
            <label for="name">Device name:</label>
            <md-input id="name" @change="namechange" v-model="device.device_name"></md-input>
          </md-field>
    <p><Deviceactivity :lastonline="device.last_online" /></p> 

      <md-field>
      <p >Choose mode:</p>
   <b-select id="select" @change="achange" v-model="device.mode">
     <b-select-option v-for="mode in devm" :key="mode.type" :value="mode.type">{{mode.name}}</b-select-option>
   </b-select>
        </md-field>
       <DeviceInput :mode="device.mode" :v-model="device.status" />
       </md-card-content>
       <md-card-actions>
      <md-button class="md-raised md-primary" @click="duplicatedevice">Duplicate device with same settings</md-button>
      <md-button class="md-raised md-primary" @click="download_file">Download Config file</md-button>
      <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Device</md-button>
      </md-card-actions>
     </md-card>
   </div>
   <div class="section">
<md-card md-with-hover  v-if="serial_supported">
      <md-card-header>
        <div class="md-title" >Flashing Device</div>
      </md-card-header>
		  <md-card-content>
        <p>Only supported devices are  <a href="https://en.wikipedia.org/wiki/ESP32">ESP32</a> family.</p>
        Connected device : {{serial.device_name}};

        <div >
          <p></p>
        </div>

      </md-card-content>

      <md-card-actions>
        <md-button class="md-raised md-secondary" :v-if="bluetooth_active" @click="bluetooth_connect">Try to connect with Bluetooth (alpha)</md-button>
        <md-button class="md-raised md-primary" @click="check_ports_usb">Connect to device through Serial port</md-button>
        <md-button class="md-raised md-primary" @click="flash_config">Flash config</md-button>
      </md-card-actions>
    </md-card>
<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this device?"
      md-content="Your device settings will be deleted and cant be recovered."
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="adelete()" />

</div>
</div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import Deviceactivity from '@/components/parts/Deviceactivity';
import DeviceInput from '@/components/parts/DeviceInput';
import {check_serial_supported,check_bluetooth_supported,list_coms} from '@/components/flash_device';
import {devicemodes} from "@/datas";
import BluetoothTerminal from "@/bluetooth/BluetoothTerminal";

import {get_data_fromroomitemdb} from "@/mod_data/get_data";
import {add_device} from "@/mod_data/set_data";
import {delete_device} from "@/mod_data/del_data";
import {saveTextAsFile} from "@/file";
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
      serial_supported:false,
      serial_device:null,
      serial_reader:null,
      connected:false,
      defaultDeviceName:"mcu",
      serial:{device_name:"",terminalcontainer:""},
      bluetooth_uuid:"00001101-0000-1000-8000-00805F9B34FB",
      terminal : null,
      bluetooth_active:false,
      encoder:null,
      decoder:null,
      signals:null,
      reader: null,
      writer: null


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
        this.serial_supported=check_serial_supported();
        this.bluetooth_active=check_bluetooth_supported();
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
       //setTimeout(this.serial_log, 3000);
      if(this.serial_supported)
       {
          navigator.serial.addEventListener("connect",(event)=> {this.connect_device(event)});
          navigator.serial.addEventListener("disconnect",(event)=> {this.disconnect_device(event)});
       }
       console.log(navigator.bluetooth);
       if(this.bluetooth_active)
       {
      let serviveUuid = 0xFFE0, characteristicUuid = 0xFFE1;
      this.terminal=new BluetoothTerminal(serviveUuid,characteristicUuid,'\n','\n');
    }
    this.encoder = new TextEncoder();
    this.decoder = new TextDecoder();
    
    },
    methods:
    {
        adelete()
        {
          delete_device(this.$route.params.rid,this.$route.params.did);
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
                    async check_ports()
                    {
                      let config_for_join={ baudRate: 9600 };
                      const filters=[
                        { usbVendorId: 4292, usbProductId: 60000 }
                      ]

                      this.serial_device = await navigator.serial.requestPort({ filters});
                      //this.serial_device.open(config_for_join);
                      console.log( this.serial_device);
                      console.log(this.serial_device.getInfo());

                      await this.serial_device.open(config_for_join);

                      //this.serial_reader=this.serial_device.readable.getReader();
                      this.serial_log();
                    },
                    async check_ports_usb()
                    {
                      let config_for_join={ baudRate: 115200 };
                      const filters=[
                        { usbVendorId: 4292, usbProductId: 60000 }
                      ]

                      this.serial_device = await navigator.serial.requestPort({ filters});
                      //this.serial_device.open(config_for_join);
                      console.log( this.serial_device);
                      console.log(this.serial_device.getInfo());

                      await this.serial_device.open(config_for_join);

                      this.writer = this.serial_device.writable.getWriter();
                      this.reader = this.serial_device.readable.getReader();

                      //this.serial_reader=this.serial_device.readable.getReader();
                      this.serial_log();

                      

                    },
                   
                    flash_config()
                    {

                    },
                    achange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/mode`);
                        set(_ref,this.device.mode);
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
                    connect_device()
                    {
                      if(this.connected) return;
                        this.$noty.success("Device connected!");
                        this.check_ports();
                        this.connected=true;
                    },
                    disconnect_device()
                    {
                      if(!this.connected) return;
                      this.$noty.success("Device disconnected!");
                      this.connected=false;
                    },
                    get_config()
                    {
                      const userId = FirebaseAuth.currentUser.uid;
                      
                      let l={
                      data:this.device,wifiname:get_data_fromroomitemdb(this.$route.params.rid,"wifi_name"),
                      wifipassword:get_data_fromroomitemdb(this.$route.params.rid,"wifi_password"),
                      device_id:this.$route.params.did,
                      room:this.$route.params.rid,
                      user:userId,
                      user_email:FirebaseAuth.currentUser.user_email,
                      device_mode:this.device.mode,
                      database_url:"https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app",
                      api_key:"Rko9QOoaBDbXAndM0UGhKbZBFFZWFGsl6KiUNnGt",
                      mod:"setup",
                      accessToken:FirebaseAuth.currentUser.accessToken
                      };

                      return l;
                    },
                    bluetooth_connect()
                    {
                     /* var serviveUuid = null;
                      var characteristicUuid = null;
                      navigator.bluetooth.requestDevice({acceptAllDevices: true})
                        .then(device => {
                              console.log(device);
                        });*/
                       if(this.bluetooth_active)
                    {
                      this.terminal.connect().
                      then(() => {
                        this.serial.device_name = this.terminal.getDeviceName() ?
                            this.terminal.getDeviceName() : this.defaultDeviceName;
                        });
                      }
                    },


                    download_file()
                    {
                      let filename="config.json";
                      let l=this.get_config();
                      saveTextAsFile(JSON.stringify(l),filename);
                    },
                    async serial_log()
                     {
                       let string="";
                      
                      if( !ReadableStream.prototype.pipeTo ) {
                        this.$noty.error( "Your browser doesn't support pipeTo");
                        return;
                      }
                      
                     /*global TextDecoderStream, textDecoder*/
                      /*eslint no-undef: "error"*/

                      /*const textDecoder = new TextDecoderStream();
                      const readableStreamClosed = this.serial_device.readable.pipeTo(textDecoder.writable);
                      const reader = textDecoder.readable.getReader();

                      
                      const encoder = new TextEncoderStream();
                      outputDone = encoder.readable.pipeTo(port.writable);
                      outputStream = encoder.writable;*/

   

                      // Listen to data coming from the serial device.
                     /*eslint no-constant-condition: ["error", { "checkLoops": false }]*/
                   
                        
                    },
                  write_to_serial(text){
                     if (this.serial_device && this.serial_device.writable) {
                        //const value = parseInt(text);
                        const bytes = new Uint8Array([text]);
                        const writer = this.serial_device.writable.getWriter();
                        writer.write(bytes);
                        writer.releaseLock();
                     
                     }


                  },
                   async write(data){
                    const dataArrayBuffer = this.encoder.encode(data);
                    return await this.writer.write(dataArrayBuffer);
                  },
                   async read() {
                    try {
                      const readerData = await this.reader.read();
                      return this.decoder.decode(readerData.value);
                    } catch (err) {
                      const errorMessage = `error reading data: ${err}`;
                      console.error(errorMessage);
                      return errorMessage;
                    }
                  }
                }


    }
                   
    
  



</script>
