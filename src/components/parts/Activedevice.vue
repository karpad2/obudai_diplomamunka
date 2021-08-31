<template>
<div>
    <span v-if="active">Device is online</span>
    <span v-else> Device was online {{time_string}}</span>
    <BIconCheck2  class="" v-if="active" />
    <BIconExclamationTriangle class="" v-else />
</div>
</template>

<script>
import {BIconCheck2,BIconExclamationTriangle} from 'bootstrap-icons-vue'
import * as moment from 'moment'
    export default {
        props:['lastonline'],
        components: {
          BIconCheck2,
          BIconExclamationTriangle
        },
        data(){
            return {
                time_string:"",
                active :false
            }},
        methods: {
            update_data()
            {
            this.time_string=moment(this.lastonline).startOf('minute').fromNow();
            this.active=  Date.now()-this.lastonline < 120; // 120 másodperce volt aktív
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

