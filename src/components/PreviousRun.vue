<template>
<div class="center">
    <h2>Previous Run ~ {{prun.team_name}}</h2>
    
    

    <md-field>
      <label for="time">Time:</label>
      <md-input id="time" disabled v-model="prun.time_length"></md-input>
    </md-field>
    <md-field>
      <label for="program">Program:</label>
      <md-input id="program" disabled v-model="prun.time_length"></md-input>
    </md-field>

<md-field>
      <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Run</md-button>
</md-field>
<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this Run?"
      md-content="Are you delete run?"
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="delete_run()" />

</div>
</template>
<script>
import Input from "@/components/parts/Input";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
export default
{
    data()
    {
        return{
            prun:{},
            showDeleteDialog:false
        }
    },
    components:
    {
        
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
        const previousRunId = this.$route.params.prid;
        const room_id=this.$route.params.rid;
        

        onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/previousrun/${previousRunId}`),(sn)=>{
       if(sn.exists()) 
       {this.prun=sn.val();
        //this.select=this.device.mode;
       }
        });
    },
    methods:
    {
        delete_camera()
                {
                console.log("Delete process");
                    const userId = FirebaseAuth.currentUser.uid;
                    let b=[];
                    let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/cameras/${this.$route.params.cid}`);
                    set(_ref,null);
                    this.$route.router.go(-1); 
                },
                onCancel () {
                        //this.value = 'Disagreed'
                    },
                achange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/camera_url`);
                        set(_ref,this.camera.camera_url);
                       // _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/status`);
                       // set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/camera/${this.$route.params.did}/camera_name`);
                        set(_ref,this.device.camera_name);
                    }
                    },
}

</script>
<style lang="scss" scoped>
#camera_live_image
{
    border: 1px black solid;
    height: 400px;
    width: 640px;
}
</style>
