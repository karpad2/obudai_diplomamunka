<template>
<div class="center">
  <h2>Program ~ {{program.program_name}}</h2>


 <md-field>
      <label>Program name:</label>
      <md-input @change="namechange" v-model="program.program_name"></md-input>
    </md-field>
<div id="blocklyDiv"></div>
<Blocks :devices="devices" />
<md-field>
  <md-textarea id="text_programjavascript"  v-model="program.program_javascript" name="program_javascript"  md-autogrow ></md-textarea>
</md-field>
<md-field>
  <md-textarea id="text_programxml" v-model="program.program_xml"  name="program_xml"></md-textarea>
</md-field>
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
      @md-confirm="delete_program()" />

</div>
</template>
<script>
import * as Blockly from 'blockly/core';
import * as En from "blockly/msg/en";
import BlocklyJavascript from "blockly/javascript";
import 'blockly/blocks';
import Blocks from "@/components/parts/Blocks";
import {BlocklyJS} from "@/components/BlocklyJS";
import CryptoJS from "crypto-js";  
//import {media} from "blockly/media";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";

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
      delete_program()
                {
                console.log("Delete process");
                    const userId = FirebaseAuth.currentUser.uid;
                    let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}`);
                    set(_ref,null);
                    this.$route.router.go(-1); 

                },
         onCancel () {
                        //this.value = 'Disagreed'
                    },
         achange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        //console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_xml`);
                        let encoding=CryptoJS.enc.Utf8.parse(this.program.program_xml);
                        let encoded = CryptoJS.enc.Base64.stringify(encoding);
                        set(_ref,encoded);

                      /*  _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_javascript`);
                        set(_ref,this.program.javascript);*/
                       // _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/status`);
                       // set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        //console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}/program_name`);
                        set(_ref,this.program.program_name);
                    },

                    decoding()
                    {
                      const encodedWord = CryptoJS.enc.Base64.parse(this.program.program_xml); // encodedWord via Base64.parse()
                      this.program.program_xml = CryptoJS.enc.Utf8.stringify(encodedWord);
                    },
    
    auto_compile() {
      console.log("im here");
      this.program.program_javascript = BlocklyJavascript.workspaceToCode(this.Workspace);
      let xml = Blockly.Xml.workspaceToDom(this.Workspace);
      console.log(xml);
      if (this.program.program_javascript != "") {
        this.program.program_xml = Blockly.Xml.domToText(xml);
        console.log(this.program.program_xml);
        this.achange();
      }
    },
    auto_setup() {
      BlocklyJS();
    },
    start()
    {
    
    //let blocklyDefault = document.getElementById("blocklyDefault");
   
    //media: "/media/",
    if(this.program.program_xml===undefined) return;
    this.decoding();
    let workspace_default = Blockly.Xml.textToDom(this.program.program_xml);
    Blockly.Xml.appendDomToWorkspace(workspace_default,this.Workspace);
      this.auto_setup();
  }
  },
  mounted() {
    Blockly.setLocale(En);
    BlocklyJS();

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
        //this.select=this.device.mode;
       
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