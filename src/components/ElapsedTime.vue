<template>
<span>{{time_string}}</span>
</template>

<script>
import {BIconCheck2,BIconExclamationTriangle} from 'bootstrap-icons-vue';
import * as moment from 'moment'
import 'moment-duration-format'
    export default {
        props:['firstdate','lastdate'],
        components: {
          
        },
        data(){
            return {
                time_string:""
            }},
        methods: {
            update_data()
            {
                let ldate;
                let sdate=moment(this.firstdate);
            if(this.lastdate=="_NOW")
            {
                ldate=moment(new Date());
            }
            else{
                ldate=moment(this.lastdate);
            }
            let duration = moment.duration(ldate.diff(sdate));
            this.time_string=duration.format('hh:mm:ss');
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

