<template>
   <div >
       <div class="section">
           <md-card >
               <md-card-header>
       <div class="md-title">Lobby</div>
       </md-card-header>
       <md-card-actions>
            <md-button class="md-raised md-primary" @click="showDialog = true" v-if="!started">Start</md-button>
            <md-button class="md-raised md-dense  stop" @click="send_finish()" v-if="started">Stop</md-button>
            </md-card-actions>
            </md-card>
            <md-card  >
      <md-card-header>
        <div class="md-title">Timer</div>
      </md-card-header>
    <md-card-content>
   <h2>
    <countdown :auto-start="false" ref="vac2" :end-time="run.finishing_time">
  <template
    v-slot:process="anyYouWantedScopName">
      <span>{{ `Lefttime: ${anyYouWantedScopName.timeObj.m}:${anyYouWantedScopName.timeObj.s}` }}</span>
    </template>
  <template
    v-slot:finish>
      <span>Done!</span>
  </template>
</countdown>
  </h2>
       

      </md-card-content>
        
      <md-card-actions>
          
          
      </md-card-actions>
    </md-card>

            <md-card >
               <md-card-header>
       <div class="md-title">Sound effects</div>
       </md-card-header>
       <md-card-content>
          <div v-for="sound in sounds" v-bind:key="sound">
         <audio controls>
           <source :src="sound" type="audio/mpeg"/>
         </audio>
          </div>
         </md-card-content>
       <md-card-actions>
         
            
            </md-card-actions>
            </md-card>
                
    </div>
    
    <md-card  >
      <md-card-header>
        <div class="md-title">Cameras</div>
      </md-card-header>
    <md-card-content>
        <b-carousel-slide :img-src="actual_camera">
        </b-carousel-slide>
        <img class="cameras" :src="camera_url" :alt="camera_name"  />

      </md-card-content>

      <md-card-actions>
          <md-button class="md-raised md-dense" @click="prev_camera">Previous Camera</md-button>
          <md-button class="md-raised md-dense" @click="next_camera">Next Camera</md-button>
          
      </md-card-actions>
    </md-card>


     <md-card id="devices" >
      
    <md-card-content>
       <md-table>
         <md-table-toolbar>
        <h1 class="md-title">Devices</h1>
      </md-table-toolbar>
      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Device Name:</md-table-head>
        <md-table-head>Device Activity:</md-table-head>
        <md-table-head>Device is Active:</md-table-head>
        <md-table-head></md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in devices" :key="row.devID">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.device_name}}</md-table-cell>
        <md-table-cell>{{row.data.mode}}</md-table-cell>
        <md-table-cell><activedevice :lastonline="row.data.lastonline"/></md-table-cell>
   </md-table-row>
      
      </md-table>
       

      </md-card-content>

      <md-card-actions>
          
          
      </md-card-actions>
    </md-card>

         <div class="section">
  <md-table  md-card v-if="cameras.length>0">
      <md-table-toolbar>
        <h1 class="md-title">Cameras of room:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Camera Name:</md-table-head>
        <md-table-head>Camera Live Image</md-table-head>
        
      </md-table-row>
      
      <md-table-row v-for="(row,index) in cameras" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.data.camera_name}}</md-table-cell>
        <md-table-cell><img class="image" @click="open_camera_image(index)" :src="row.data.camera_url"  /></md-table-cell>
    </md-table-row>
      
      </md-table>

      
      </div>   
       <div id="blocklyDiv"></div>
      <Blocks :devices="devices" />
       <md-dialog-prompt
      :md-active.sync="showDialog"
      v-model="team_name"
      md-title="Enter team name:"
      md-input-maxlength="30"
      md-input-placeholder="Team name ..."
      md-confirm-text="Start"
      @md-confirm="start"
      @md-cancel="cancel" />
   <div id="block_area" style="display:none;width:600px;height:400px"></div>
   </div>
  
  
</template>

<script>
    import CryptoJS from "crypto-js";
   
    import * as Blockly from 'blockly';
    import * as En from "blockly/msg/en";
    import "blockly/javascript";
    
    
    
    import Activedevice from "@/components/parts/Activedevice";

    import Blocks from "@/components/parts/Blocks";
    import 'blockly/blocks';
    import axios from "axios";
    import {FireDb,FirebaseAuth,userId} from "@/firebase";
    import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
    import {getMessaging } from "firebase/messaging";
    import {start_run,status_run,stop_run} from "@/mod_data/set_data";
    import {get_data_fromdb,get_data_fromroomdb} from "@/mod_data/get_data";
    
      import {get_encoding} from "@/mod_data/get_data";
      import {delete_program} from "@/mod_data/del_data";
      import {encode,decoding} from "@/datas";  


    export default {
        data()
        {
            return{
                showDialog:false,
                team_name:"",
                activeprogram:"",
                room:{},
                program:{},
                run:{finishing_time:new Date(),active:false},
                a_xml:"",
                a_js:"",
                act_dev:[],
                actual_camera:"",
                camera_id:0,
                camera_name:"",
                camera_url:"http://192.168.1.160:4747/video",
                Workspace:null,
                status:null,
                started:false,
                first_date:Date(),
                last_date:Date(),
                finishing_date:new Date().getTime(),
                alarm_url:"https://raw.githubusercontent.com/karpad2/obudai_diplomamunka/soundeffects/",
                sounds:[]
            }
        },
        components:{
            Blocks,
            
            Activedevice
        },
        mounted()
        {

          this.status=status_run(this.$route.params.rid);
          this.camera_url=this.cameras[this.camera_id].data.camera_url;
          this.camera_name=this.cameras[this.camera_id].data.camera_name;
          this.init_block();
         this.sounds= [`${this.alarm_url}alarmeffect.mp3`,
                       `${this.alarm_url}mexican_theme.mp3`];
           this.get_room_data();

           console.log(this.room);
            console.log(this.sounds)
            Blockly.setLocale(En);
           
          const room_id=this.$route.params.rid;
          localStorage.setItem("roomID",room_id);
          let testing_status=status_run(this.$route.params.rid);
          if(testing_status!=null) this.run=status_run(this.$route.params.rid);
          console.log(this.run);
          if(this.run==null) this.started=false;
          else {
            this.started=this.run.active;
            
          }
          
            if(this.program.program_xml==undefined) alert("Missing XML");
          this.Workspace = new Blockly.inject('block_area',{media: 'https://unpkg.com/blockly/media/',toolbox: document.getElementById('toolbox')});
          //Blockly.JavaScript.INFINITE_LOOP_TRAP = 10000;
          //Blockly.JavaScript.addReservedWords("this.set_data,this.send_finish,this.change_mode,this.get_data,this.start_room");
          
      
           this.a_xml=decoding(this.program.program_xml,get_encoding(this.$route.params.rid));
           
           let xml= Blockly.Xml.textToDom(this.a_xml);
           console.log(xml);
           try {
           Blockly.Xml.domToWorkspace(xml,this.Workspace);
           }
           catch (error) {
             console.error(error);
           }

           try {
            
             this.a_js = Blockly.JavaScript.workspaceToCode(this.Workspace);
           } catch (error) {
             console.error(error);
           }
          
           console.log(this.a_js);
           console.log(this.run);
           if(this.run==null) this.started=false;
          else {
            this.started=this.run.active;
            if (this.started) {
              setTimeout(()=>{
              this.startCountdown();
              this.start_runprocess();
              },2000);
              
            }
          }

          setInterval(()=>{
            if(this.run.active)
            {
              if(this.run.finishing_time<=Date.now())
              {
                console.log("Run out of time flag!");
                this.send_finish();
              }
            }


          },1000);

 },
        computed:{
          
            devices()
            {
              return get_data_fromroomdb(this.$route.params.rid,"devices");
            },
            cameras()
            {
              return get_data_fromroomdb(this.$route.params.rid,"cameras");
            }

        },

        methods:
        {
           get_room_data() {  
                        const userId = FirebaseAuth.currentUser.uid; 
                        onValue(ref(FireDb, `/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}`),(sn)=>{
                        if(sn.exists()) 
                            {
                            this.room=sn.val();
                            
                            }
                        });
                        console.log(this.room.active_program);
                        onValue(ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.room.active_program}`),(sn)=>{
                        if(sn.exists()) 
                            {
                            this.program=sn.val();
                            console.log(this.program);
                            }
                        });
                    },
            startCountdown() {
                      const vm = this
                      vm.$refs.vac2.startCountdown(true);
                      //console.log(vm);
                    },
                    finishCountdown() {
                      const vm = this
                      vm.$refs.vac2.finishCountdown();
                      //console.log(vm);
                    },
          open_camera_image(index)
          {
              var window=window.open(this.cameras[index].data.camera_url,this.cameras[index].data.camera_name,"DescriptiveWindowName","resizable,scrollbars,status");
          },          
          start_date()
            {
              
            },
            start_runprocess()
            {

                try {
                  eval(this.a_js);
                } catch (error) {
                  console.error(error)
                }
            },
            send_finish()
            {
              this.finishCountdown();
              let message = `Run is finished at ${this.room.room_name}`;
              /*getMessaging().send(message)
              .then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
              })
              .catch((error) => {
                console.log('Error sending message:', error);
              });*/
              stop_run();


            },
          
            async start()
            {
                if(this.team_name=="") return;
                //
                start_run(this.$route.params.rid,this.team_name,this.program.solving_time);
                this.started=true;

                this.run= await status_run(this.$route.params.rid);

                this.finishing_time=this.run.finishing_time;
                setTimeout(()=>{
              this.startCountdown();
              this.start_runprocess();
              },2000);
               // this.team_name="";
                //start_run(this.$route.params.rid,this.team_name);
            },
            cancel()
            {   
                console.warn("Cancelled start");
                this.team_name="";
            },
            stop()
            {   this.started=false;
                stop_run(this.$route.params.rid);
            },
            set_data(device,mode,value)
            {
              let res=axios.patch(this.build_link(device),{status:value});
              //res.data.headers['Content-Type'];
              console.log("Setted device");
            },
              build_link_status(device_id="")
              {
                  return `https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices/${device_id}/status.json`;
              },
              build_link_mode(device_id="")
              {
                  return `https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices/${device_id}/mode.json`;
              },
              build_link(device_id="")
              {
                  return `https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices/${device_id}.json`;
              },
              get_status(device)
              {let m;
               setTimeout(()=>{
               axios.get(this.build_link_status(`${device}`))
                .then((k)=>{
                    m=k;
                });},3000);
                return m;
              },
            next_camera()
            {
                this.camera_id++;
                //if(this.camera_id>this.cameras.length-1) this.camera_id=0;
                this.camera_url=this.cameras[this.camera_id].data.camera_url;
                this.camera_name=this.cameras[this.camera_id].data.camera_name;
            },
            prev_camera()
            {
                this.camera_id--;
                //if(this.camera_id<(0-this.cameras.length+1)) this.camera_id=0;
                this.camera_url=this.cameras[this.camera_id].data.camera_url;
                this.camera_name=this.cameras[this.camera_id].data.camera_name;

            },
            get_data(dev_id) {  
                        const userId = FirebaseAuth.currentUser.uid; 
                        let value="";
                        onValue(ref(FireDb, `/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices/${dev_id}/status`),(sn)=>{
                        if(sn.exists()) 
                            {
                            value=sn.val();
                            
                            }
                        });
                    return value;
                    },
        init_block()
              {
                console.log("Blokkok incializálása");
                Blockly.defineBlocksWithJsonArray([
            {
                "type": "get_data",
                "message0": "get device %1 %2, if status is %3",
                "args0": [
                    {
                        "type": "field_dropdown",
                        "name": "device",
                        "variableTypes": [""],
                        "options": this.get_devices_to_array()
                        
                    },
                    {
                        "type": "field_dropdown",
                        "name": "mode",
                        "variableTypes": [""],
                        "options": [
                            ["Relay", "relay"],
                            ["RFID reader", "rfid"],
                            ["Input", "input"],
                            ["OLED Display", "oled"],
                        ]
                    },
                    {
                        "type": "input_value",
                        "name": "status",
                        "check": ["String","boolean"]
                    }
                ],
                "message1": "Then, do %1",
                "args1": [
                    {
                        "type": "input_statement",
                        "name": "DO0"
                    },
                ],
                "previousStatement":true,
                "nextStatement": true,
                "inputsInline": true,
                
                
                "colour": '#0ddb69',
                "tooltip": "",
                "helpUrl": "",
                
            },
        ]);
        Blockly.defineBlocksWithJsonArray([
            {
                "type": "send_data",
                "message0": "set device %1, mode: %2, status: %3",
                "args0": [
                    {
                        "type": "field_dropdown",
                        "name": "device",
                        "variableTypes": [""],
                        "options": this.get_devices_to_array()
                        
                    },
                    {
                        "type": "field_dropdown",
                        "name": "mode",
                        "variableTypes": [""],
                        "options": [
                            ["Relay", "relay"],
                            ["RFID reader", "rfid"],
                            ["Input", "input"],
                            ["OLED Display", "oled"],
                        ]
                    },
                    {
                        "type": "input_value",
                        "name": "value",
                        "check": ["String"]
                    }
                ],
                "inputsInline": true,
                "previousStatement": true,
                "nextStatement": true,
                "colour": 160,
                "tooltip": "",
                "helpUrl": "",
                
            },
        ]);
        Blockly.defineBlocksWithJsonArray([
            {
                "type": "console_write",
                "message0": "Debug write %1",
                "args0": [
                    {
                        "type": "input_value",
                        "name": "value",
                        "check": ["String"]
                    }
                ],
                "inputsInline": true,
                "previousStatement": true,
                "nextStatement": true,
                "colour": 160,
                "tooltip": "",
                "helpUrl": "",
                
            },
        ]);
        Blockly.defineBlocksWithJsonArray([
            {
                "type": "send_finish",
                "message0": "send finish",
                "previousStatement": true,
                "colour": '#0ddb69',
                "tooltip": "",
                "helpUrl": "",
                
            },
        ]);//
        Blockly.defineBlocksWithJsonArray([
            {
                "type": "start_room",
                "message0": "Start Progress",
                "previousStatement": false,
                "nextStatement": true,
                "colour": '#0ddb69',
                "tooltip": "",
                "helpUrl": "https://github.com/karpad2/obudai_diplomamunka/wiki/Start-Process",
                
            },
        ]);
             
      Blockly.JavaScript["send_finish"] = function(block) {
          var code = `this.send_finish();\n`;
          return  code;
      };
       Blockly.JavaScript["send_data"] = function(block) {
        var device =block.getFieldValue('device');
        var mode = block.getFieldValue('mode');
        var value = Blockly.JavaScript.valueToCode(block, 'value',Blockly.JavaScript.ORDER_MEMBER) || '\'\'';
        var code = `this.set_data("${device}","${mode}",${value});\n`;
          return  code;
      };
       Blockly.JavaScript["console_write"] = function(block) {
           var value =Blockly.JavaScript.valueToCode(block, 'value',Blockly.JavaScript.ORDER_MEMBER) || '\'\'';
          var code = `console.log("${value}");\n`;
          return  code;
      };

      Blockly.JavaScript["get_data"] = function(block) {
        var device =block.getFieldValue('device');
        var mode = block.getFieldValue('mode');
        var status = Blockly.JavaScript.valueToCode(block, 'status',Blockly.JavaScript.ORDER_MEMBER) || '\'\'';
        var branch = Blockly.JavaScript.statementToCode(block, 'DO0');
        branch = Blockly.JavaScript.addLoopTrap(branch, block);
        var code = "";
        
        //let ref=`/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices/${device}/mode`;
        //set(ref,mode); 
        let m=null
        

        code = `
        let l="";
        
        l= this.get_status("${device}");

        
        if(l=="${status}"){${branch}}\n`;
        console.log(code);
        return code;
       
    };
    Blockly.JavaScript['start_room'] = function(block) {
    var device =Blockly.JavaScript.statementToCode(block, 'device');
   var code = `this.start_room();\n`;
    return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
    };
    Blockly.JavaScript["send_finish"] = function(block) {
    var code = `this.send_finish();\n`;
    return code;
    };
              
    },
       get_devices_to_array(){
     let b=[];
      onValue(ref(FireDb, `/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices`),(sn)=>{
       if(sn.exists()) 
       {
         sn.forEach((a)=>{
          b.push(
            [a.val().device_name,a.key]
          );
         });
         }
         
               
        });
      return b;

  }

        }
       
    }
</script>
<style lang="scss" scoped>
 .md-card
  {
  max-width: 400px;
  min-width: 200px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
    max-height: 600px;
    overflow-y: auto;
    overflow-x: auto;
    padding: 15px;
  }
#blocklyDiv
{
    display: none;
}
.stop
{
    background: brown;
}
.cameras{
    width: 300px;
    height: 300px;
}
#devices{
    width: 800px;
    height: 500px;
   
}
</style>