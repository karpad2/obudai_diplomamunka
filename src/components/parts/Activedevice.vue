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

import * as moment from 'moment'
    export default {
        props:['lastonline'],
        
        data(){
            return {
                time_string:"",
                active :false
            }},
        methods: {
            update_data()
            {

            let date=Date.now();//1970 utc óta elmúlt MS
            let last_online_date=Number(this.lastonline);
            let calculating=(date - last_online_date*1000); //UTC vel való összehasonlítás
            console.log(calculating);
            console.log(`Actual UTC time ${date}`);
            console.log(`Last online timestamp: ${this.lastonline}`);

            this.time_string=moment.utc(this.lastonline).startOf('minute').from(date);
            this.active= calculating < (120*1000); // 120 másodperce volt aktív UTC szerint beállítva

            }
        },

        created() {
            moment.locale(); 
            setInterval(()=>{
            this.update_data();      
            },1000);
        }
    }
</script>

