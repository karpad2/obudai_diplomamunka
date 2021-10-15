<template>
<div class="center">
    <h2>Camera ~ {{camera.camera_name}}</h2>
    
    <md-field>
      <label>Camera name:</label>
      <md-input v-model="camera.camera_name"></md-input>
    </md-field>

    <md-field>
      <label>Camera url:</label>
      <md-input v-model="camera.camera_url"></md-input>
    </md-field>

    <img :src="camera.camera_url"  alt="Camera Live Image" id="camera_live_image"/>
<md-field>
      <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Camera</md-button>

</md-field>
<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this Camera?"
      md-content="Are you delete this camera?"
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="delete_camera()" />

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
            camera:{},
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
        const devId = this.$route.params.cid;
        const room_id=this.$route.params.rid;
        

        onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/cameras/${devId}`),(sn)=>{
       if(sn.exists()) 
       {this.camera=sn.val();
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
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/cameras/${this.$route.params.cid}/camera_url`);
                        set(_ref,this.camera.camera_url);
                       // _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/status`);
                       // set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/cameras/${this.$route.params.did}/camera_name`);
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
