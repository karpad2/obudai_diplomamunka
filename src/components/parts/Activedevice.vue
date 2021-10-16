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
            this.time_string=moment(this.lastonline).startOf('minute').fromNow();
            this.active=  ~~(Date.now()/1000)-this.lastonline < 120; // 120 másodperce volt aktív UTC szerint beállítva
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

