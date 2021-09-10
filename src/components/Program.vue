<template>
<div class="center">
  <h2>Program ~ {{program.program_name}}</h2>


 <md-field>
      <label>Program name:</label>
      <md-input @change="namechange" v-model="program.program_name"></md-input>
    </md-field>
<div id="blocklyDiv"></div>
<Blocks :devices="devices" />

<md-button class="md-raised md-primary" @click="duplicateprogram()">Duplicate program</md-button>
      
<md-field>
<md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Program</md-button>
</md-field>
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
import  "blockly/javascript";
import 'blockly/blocks';
import Blocks from "@/components/parts/Blocks";
import {send_data,devices,init,get_data,send_finish} from "@/components/BlocklyJS";
//import {media} from "blockly/media";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {add_program} from "@/mod_data/set_data";
import {get_encoding} from "@/mod_data/get_data";
import {delete_program} from "@/mod_data/del_data";
import {encode,decoding} from "@/datas";

export default {
    name: 'Programs',
    data: () => ({
      program:{},
      showDialog: false,
	    a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
      camera:{},
      devices:[],
      showDeleteDialog:false,
      Workspace:null
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
      delete_pr()
      {   
                   delete_program(this.$route.params.rid,this.$route.params.pid);
      },
      onCancel () {
                        //this.value = 'Disagreed'
                    },
      achange()
      {
                        const userId = FirebaseAuth.currentUser.uid;
                        //console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_xml`);
                        this.program.program_xml=encode(this.a_program_xml,get_encoding(this.$route.params.rid,this.$route.params.pid));
                        set(_ref,this.program.program_xml);
                        this.$noty.success("Saved!");
       },
       namechange(){
                        const userId = FirebaseAuth.currentUser.uid;
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_name`);
                        set(_ref,this.program.program_name);
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
    this.auto_setup();
  },
   duplicateprogram()
  {
    add_program(this.$route.params.rid,this.program.program_name,this.program);
    this.$noty.success("Success!");
			
  }
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

       onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/devices`),(sn)=>{
       if(sn.exists()) 
       {
         sn.forEach((a)=>{
          this.devices.push(
            {
              devID:a.key,
              data:a.val()
            }
          );
         });
         }
         
         this.start();      
        });
  },
 
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
</style>