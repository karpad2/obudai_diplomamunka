<template>
<div>
    <div v-if="time_string!='Invalid date'">
    <span v-if="active">Device is online</span>
    <span v-else> Device was online {{time_string}}</span>
   
    </div>
<div v-else>
    <span style="color:red">Invalid data, probably device never was online?</span>
</div>
</div>
</template>

<script>

import * as moment from 'moment';
import axios from "axios";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";

    export default {
        props:['device_id','room_id'],
        
        data(){
            return {
                time_string:"",
                lastonline:"",
                active :false
            }},
        methods: {
            update_data()
            {

            let date=Date.now(); //1970 utc óta elmúlt MS

            axios.get(this.build_link(this.room_id,this.device_id))
            .then((re)=>{
                this.lastonline=re.data.lastonline;
                //console.log(re.data);
            })
            let last_online_date=Number(this.lastonline)*1000;
            let last=Date(last_online_date);
            let calculating=(date - last_online_date)/1000; //UTC vel való összehasonlítás
            //console.log(calculating);
            //console.log(`Actual UTC time ${date}`);
            //console.log(`Last online timestamp: ${this.lastonline}`);

            this.time_string=moment(last).utc().startOf('minute').from(date);
            //this.active= calculating < 120; // 60 másodperce volt aktív UTC szerint beállítva

            },
            build_link(room_id="",device_id="")
              {
                  return `https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/${FirebaseAuth.currentUser.uid}/rooms/${room_id}/devices/${device_id}.json`;
              },
        },

        mounted() {
            moment.locale(); 
            setInterval(()=>{
            this.update_data();      
            },3000);
        }
    }
</script>

