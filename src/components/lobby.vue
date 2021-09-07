<template>
   <div class="center">
       <h2>Lobby</h2>
       <div class="section">
            <md-button class="md-raised md-primary" @click="showDialog = true">Start</md-button>
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
      @md-confirm="start_run"
      @md-cancel="stop" />
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
                Workspace:null
            }
        },
        components:{
            Blocks
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
           
           console.log(this.program.program_xml);
           let workspace_default = Blockly.Xml.textToDom(this.program.program_xml);
           Blockly.Xml.appendDomToWorkspace(workspace_default,this.Workspace);
           this.program.program_javascript = Blockly.Javascript.workspaceToCode(this.Workspace);
           
           
        },

        methods:
        {
            start_run()
            {

            },
            start()
            {
                if(this.team_name=="") return;
                this.team_name="";
                
            },
            stop()
            {   
                console.warn("Cancelled start");
                this.team_name="";
            },
            decoding() {
                    console.log( this.program);
                      const encodedWord = CryptoJS.enc.Base64.parse(this.program.program_xml);
                      console.log(encodedWord); // encodedWord via Base64.parse()
                      this.program.program_xml = CryptoJS.enc.Utf8.stringify(encodedWord);
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
                        this.decoding();

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
</style>