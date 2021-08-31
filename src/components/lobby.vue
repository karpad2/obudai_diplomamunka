<template>
   <div class="center">
       <h2>Lobby</h2>
       <div class="section">
            <md-button class="md-raised md-primary" @click="showDialog = true">Start</md-button>
       </div>
       <md-dialog-prompt
      :md-active.sync="showDialog"
      v-model="team_name"
      md-title="Starting Run"
      md-input-maxlength="30"
      md-input-placeholder="Team name ..."
      md-confirm-text="Start"
      :md-confirm="start()"
      :md-cancel="cancel()" />
   </div>
   
</template>

<script>
   

    export default {
        data()
        {
            return{
                showDialog:false,
                team_name:""
            }
        },
        mounted()
        {
           

        },
        methods:
        {
            start()
            {
                if(this.team_name=="") return;
                this.team_name="";
            },
            stop()
            {   
                console.warn("Cancelled start");
                this.team_name="";
            }
        }
       
    }
</script>