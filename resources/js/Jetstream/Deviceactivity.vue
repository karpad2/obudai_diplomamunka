<template>
<span v-if="active" > Device is online </span>
<span v-else> Device was online {{time_string}}</span>
  <BIconCheck2  class="mr-2 h-5 w-5 text-green-400" v-if="active" />
   <BIconExclamationTriangle class="mr-2 h-5 w-5 text-red-400" v-else />
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

