<template>
   <div >
       <div class="section">
           <md-card >
               <md-card-header>
       <div class="md-title">Lobby</div>
       </md-card-header>
       <md-card-actions>
            <md-button class="md-raised md-primary" @click="showDialog = true" v-if="!started">Start</md-button>
            <md-button class="md-raised md-dense  stop" @click="stop()" v-if="started">Stop</md-button>
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
        <img class="cameras" :src="cameras[camera_id].camera_url" :alt="cameras[camera_id].camera_name"  />

      </md-card-content>

      <md-card-actions>
          <md-button class="md-raised md-dense" @click="prev_camera()" >Previous Camera</md-button>
          <md-button class="md-raised md-dense" @click="next_camera()" >Next Camera</md-button>
          
      </md-card-actions>
    </md-card>
    <md-card  >
      <md-card-header>
        <div class="md-title">Timer</div>
      </md-card-header>
    <md-card-content>
       
       

      </md-card-content>

      <md-card-actions>
          
          
      </md-card-actions>
    </md-card>
       
       <div id="blocklyDiv"></div>
        <Blocks :devices="devices" />
       <md-dialog-prompt
      :md-active.sync="showDialog"
      v-model="team_name"
      md-title="Enter team name:"
      md-input-maxlength="30"
      md-input-placeholder="Team name ..."
      md-confirm-text="Start"
      @md-confirm="start_runprocess"
      @md-cancel="cancel" />
   </div>
   
</template>

<script>
    import CryptoJS from "crypto-js";
    import * as Blockly from 'blockly/core';
    import * as En from "blockly/msg/en";
    import "blockly/javascript";
    import "@/components/BlocklyJS";
    import Blocks from "@/components/parts/Blocks";
    import 'blockly/blocks';
    import {FireDb,FirebaseAuth,userId} from "@/firebase";
    import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
    import {start_run,status_run,stop_run} from "@/mod_data/set_data";
    import {get_data_fromdb,get_data_fromroomdb} from "@/mod_data/get_data";
    import {add_program} from "@/mod_data/set_data";
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
                devices:[],
                a_xml:"",
                a_js:"",
                actual_camera:"",
                camera_id:0,
                Workspace:null,
                status:null,
                started:false,
                cameras:[]
            }
        },
        components:{
            Blocks
        },
        beforeMount()
        {
            this.status=status_run();
        },
        mounted()
        {
           this.get_data();
           console.log(this.room);
           Blockly.setLocale(En);
           const room_id=this.$route.params.rid;
            this.cameras=get_data_fromroomdb(room_id,"cameras");
            this.Workspace = Blockly.inject("blocklyDiv", {
                toolbox: document.getElementById("toolbox"),
                scrollbar: false});
           Blockly.JavaScript.INFINITE_LOOP_TRAP = null;
           this.a_xml=decoding(this.program.program_xml,get_encoding(this.$route.params.rid));
           console.log(this.a_xml);
           let workspace_default = Blockly.Xml.textToDom(this.a_xml);
           Blockly.Xml.appendDomToWorkspace(workspace_default,this.Workspace);
           this.a_js = Blockly.Javascript.workspaceToCode(this.Workspace);
                      
        },

        methods:
        {
            start_runprocess()
            {

            },
            start()
            {
                if(this.team_name=="") return;
                this.team_name="";
                this.started=true;
                //start_run(this.$route.params.rid,this.team_name);
            },
            cancel()
            {   
                console.warn("Cancelled start");
                this.team_name="";
            },
            stop()
            {
                stop_run();
            },
            next_camera()
            {
                this.camera_id++;
                if(this.camera_id>this.room.cameras.length-1) this.camera_id=0;
                this.actual_camera=this.cameras[this.camera_id].camera_url;
            },
            prev_camera()
            {
                this.camera_id--;
                if(this.camera_id<(0-this.room.cameras.length+1)) this.camera_id=0;
                this.actual_camera=this.cameras[this.camera_id].camera_url;

            },

            
            get_data() {  
                        const userId = FirebaseAuth.currentUser.uid; 
                        onValue(ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}`),(sn)=>{
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
                        
                       

                        onValue(ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices`),(sn)=>{
                            if(sn.exists()) 
                            {
                                sn.forEach((a)=>{
                                this.devices.push(
                                    {
                                    devID:a.key,
                                    data:a.val()
                                    });
                                });
                                }
                            });
                    },

        }
       
    }
</script>
<style lang="scss" scoped>
 .md-card
  {
  width: 300px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
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
</style>