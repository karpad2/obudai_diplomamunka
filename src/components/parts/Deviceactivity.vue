<template>
<div>
<span v-if="active" > Device is online </span>
<span v-else> Device was online {{time_string}}</span>
  
</div>
</template>

<script>

import * as moment from 'moment'
    export default {
        props:['lastonline'],
        components: {
          
        },
        data(){
            return {
                time_string:"",
                active :false
            }},
        methods: {
            update_data()
            {
                let date=new Date();
            this.time_string=moment(this.lastonline).utc().startOf('minute').fromNow();
            this.active=date.getUTCSeconds()   - this.lastonline < 120; // 120 másodperce volt aktív
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

