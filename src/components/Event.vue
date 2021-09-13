<template>
<div class="center">
    <h2>Event reservation ~ {{event.contact_name}}</h2>
    
    <md-field>
      <label>Contact name:</label>
      <md-input v-model="event.contact_name"></md-input>
    </md-field>

    <md-field>
      <label>Contact Phone:</label>
      <md-input v-model="event.contact_phone"></md-input>
    </md-field>

    <md-field>
      
      {{get_timestamp(event.contact_date)}}
    </md-field>
    
<md-field>
      <md-button class="md-raised md-secondary" @click="showDeleteDialog = true">Delete Event</md-button>

</md-field>
<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this Event?"
      md-content="Are you delete this event?"
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="delete_event()" />

</div>
</template>
<script>
import Input from "@/components/parts/Input";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import moment from "moment";
export default
{
    data()
    {
        return{
            event:{},
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
        const eventID = this.$route.params.eid;
        const room_id=this.$route.params.rid;
        

        onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/events/${eventID}`),(sn)=>{
       if(sn.exists()) 
       {
        this.event=sn.val();
       // this.event.contact_date=Date(sn.val().contact_date);
        //this.select=this.device.mode;
       }
        });
    },
    methods:
    {
        delete_event()
                {
                console.log("Delete event");
                    const userId = FirebaseAuth.currentUser.uid;
                    let b=[];
                    let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/events/${this.$route.params.eid}`);
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
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/events/${this.$route.params.eid}/contact_phone`);
                        set(_ref,this.event.contact_phone);
                       // _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/status`);
                       // set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/events/${this.$route.params.eid}/camera_name`);
                        set(_ref,this.event.contact_name);
                    },
                    get_timestamp(string)
                      {
                       return moment(string).format('MMMM Do YYYY, HH:mm ');
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
