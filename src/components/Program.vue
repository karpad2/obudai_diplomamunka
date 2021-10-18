<template>
<div>
   <div class="section">
     <md-card >
       <md-card-header>
          <div class="md-title">Program ~ {{program.program_name}}</div>
       </md-card-header>
       <md-card-content>
         <md-field>
      <label>Program name:</label>
      <md-input @change="namechange" v-model="program.program_name"></md-input>
    </md-field>

  <md-field>
      <label>Solving time (minutes):</label>
      <md-input @change="minutechange" v-model="program.solving_time"></md-input>
    </md-field>
    </md-card-content>
       <md-card-actions>
           </md-card-actions>
            </md-card>
</div>

 
   <md-card >
              
       <md-card-content>
         <div id="blocklyDiv"></div>
        <Blocks :devices="devices" />
    </md-card-content>
       <md-card-actions>
          <md-button class="md-raised md-primary" @click="duplicateprogram()">Duplicate program</md-button>
          <md-button class="md-raised md-secondary" @click="get_config()">Download Program</md-button>
          <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Program</md-button>
        </md-card-actions>
    </md-card>




<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this program?"
      md-content="Your program will be deleted."
      md-confirm-text="Continue"
      md-cancel-text="Cancel"
      @md-cancel="onCancel()"
      @md-confirm="delete_pr()" />


</div>

</template>
<script>
import * as Blockly from 'blockly/core';
import * as En from "blockly/msg/en";
import BlocklyJS from "blockly/javascript";

import 'blockly/blocks';
import Blocks from "@/components/parts/Blocks";

//import {media} from "blockly/media";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {add_program} from "@/mod_data/set_data";
import {get_encoding} from "@/mod_data/get_data";
import {delete_program} from "@/mod_data/del_data";
import {encode,decoding} from "@/datas";
import {saveTextAsFile} from "@/file";

export default {
    name: 'Programs',
    data: () => ({
      program:{},
      showDialog: false,
	    a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
      camera:{},
      showDeleteDialog:false,
      Workspace:null,
      prev:"",
      js_code:""
    }),
    comments:{
      Blockly,
    },
    components:
      {
        Blocks
      },
     methods: {
    myUpdateFunction(event) {},
    save() {
      if (this.program.program_javascript != "") {
        const userId = FirebaseAuth.currentUser.uid;
        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_xml`);
        set(_ref,this.program.program_xml);
         
      }
        console.log("WELP");
      },
      init_block()
      {
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
       
        "previousStatement": true,
        "nextStatement": true,
        "colour": '#0ddb69',
        "tooltip": "",
        "helpUrl": "https://github.com/karpad2/obudai_diplomamunka/wiki/Start-Process",
        
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
                "saved":false
                
            },
        ]);
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

  },
      delete_pr()
      {   
                   delete_program(this.$route.params.rid,this.$route.params.pid);
      },
      onCancel () {
                        //this.value = 'Disagreed'
                    },
      achange()
      {                 if(this.prev==this.a_program_xml) return;
                        const userId = FirebaseAuth.currentUser.uid;
                        //console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_xml`);
                        this.program.program_xml=encode(this.a_program_xml,get_encoding(this.$route.params.rid,this.$route.params.pid));
                        set(_ref,this.program.program_xml);
                        this.prev=this.a_program_xml;
                        this.saved=true;
                        
       },
       namechange(){
                        const userId = FirebaseAuth.currentUser.uid;
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_name`);
                        set(_ref,this.program.program_name);
                    },
       minutechange(){
                        const userId = FirebaseAuth.currentUser.uid;
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/solving_time`);
                        set(_ref,this.program.solving_time);
                    },               
                    
    
    auto_compile() {
      console.log("im here");
      //this.program.program_javascript = Blockly.Javascript.workspaceToCode(this.Workspace);
      let xml = Blockly.Xml.workspaceToDom(this.Workspace);
      console.log(xml);
      if (xml != "") {
        this.a_program_xml = Blockly.Xml.domToText(xml);
        console.log(this.a_program_xml);
        this.achange();
        
      }
    },
    auto_setup() {
     
     
    },
     
    start()
    {
    
    //let blocklyDefault = document.getElementById("blocklyDefault");
   
    //media: "/media/",
    if(this.program.program_xml==undefined||this.program.program_xml==null) return;
    console.log(get_encoding(this.$route.params.rid,this.$route.params.pid));
    this.a_program_xml=decoding(this.program.program_xml,get_encoding(this.$route.params.rid,this.$route.params.pid));
    //console.log(this.a_program_xml);
    let workspace_default = Blockly.Xml.textToDom(this.a_program_xml);
    Blockly.Xml.appendDomToWorkspace(workspace_default,this.Workspace);
    //this.js_code=BJavascript.workspaceToCode(this.Workspace);
    //console.log(this.js_code);
    this.auto_setup();
  },
   duplicateprogram()
  {
    add_program(this.$route.params.rid,this.program.program_name,this.program);
    
    
			
  },
  
   get_config(){
                      let filename="program.json";
                      let l={data:this.program};
                      saveTextAsFile(JSON.stringify(l),filename);}
  },
  mounted() {
    Blockly.setLocale(En);
      this.Workspace = Blockly.inject("blocklyDiv", {
      toolbox: document.getElementById("toolbox"),
      scrollbar: false,
    });
  
     this.Workspace.addChangeListener(() => {
      this.auto_compile(this.Workspace);
    });
    setTimeout(()=>{
                        if(this.saved) this.$noty.success("Saved!");
                        this.saved=false;
                      },5000);
    console.log(this.$route.params);
        //localStorage.setItem('device',JSON.stringify(null));
        const userId = FirebaseAuth.currentUser.uid;
        const devId = this.$route.params.pid;
        const room_id=this.$route.params.rid;
        

       onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/programs/${devId}`),(sn)=>{
       if(sn.exists()) 
       {
         this.program=sn.val();
        //this.select=this.device.mode;
       }
        });

       this.init_block();
        this.start();
  },
  computed:{
    devices()
    {
      const userId = FirebaseAuth.currentUser.uid;
      let b=[];
      onValue(ref(FireDb, `/users/${FirebaseAuth.currentUser.uid}/rooms/${this.$route.params.rid}/devices`),(sn)=>{
       if(sn.exists()) 
       {
         sn.forEach((a)=>{
          b.push(
            {
              devID:a.key,
              data:a.val()
            }
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
#blocklyDiv
{
  width: 800px;
  height: 480px;
}
#text_programjavascript
{

}
#text_programxml
{
  display: none;
}
.center{
  padding:50px;
}
</style>