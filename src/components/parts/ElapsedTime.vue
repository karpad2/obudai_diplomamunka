<template>
<span>{{time_string}}</span>
</template>

<script>

import * as moment from 'moment'
import 'moment-duration-format'
    export default {
        props:['firstdate','lastdate'],
        components: {
          
        },
        data(){
            return {
                
            }},
        methods: {
            update_data()
            {
                
            
            
            }
        },
        computed:
        {
            time_string()
            {
                let ldate;
                let sdate=moment(this.firstdate).utc();
                
            if(this.lastdate=="_NOW")
            {
                ldate=moment(Date.now()).utc();
            }
            else{
                ldate=moment(this.lastdate).utc();
            }
                let duration = moment.duration(ldate.diff(sdate));
                return duration.format('hh:mm:ss');
            }
        },

        mounted() {
            moment.locale(); 
            setInterval(()=>{
            this.update_data();      
            },1000);
        }
    }
</script>

