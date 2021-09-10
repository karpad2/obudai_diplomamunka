<template>
   <div class="center">
       <div class="section">
       <h2>Lobby</h2>
       
            <md-button class="md-raised md-primary" @click="showDialog = true" v-if="!started">Start</md-button>
            <md-button class="md-raised md-dense  stop" @click="stop()" v-if="started">Stop</md-button>
    </div>
    <div class="section">
    <md-card md-with-hover v-if="!started">
      <md-card-header>
        <div class="md-title">Cameras</div>
      </md-card-header>
        <b-carousel-slide img-src="https://picsum.photos/1024/480/?image=54">
        <h1>Hello world!</h1>
      </b-carousel-slide>

      <md-card-content>
        

      </md-card-content>

      <md-card-actions>
        
      </md-card-actions>
    </md-card>
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
                Workspace:null,
                status:null,
                started:false
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
#blocklyDiv
{
    display: none;
}
.stop
{
    background: brown;
}
</style>