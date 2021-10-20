<template>
<div >
    <h2>Previous Runs</h2>
    <div>
        You can see Previous runs which made by teams.
        <p> You can modify or even delete this run datas.</p>
    </div>
     <div class="section" >
  <md-table  md-card v-if="pruns.length>0">
      <md-table-toolbar>
        <h1 class="md-title">Previous runs  by rooms:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Room Name:</md-table-head>
        <md-table-head>Team name:</md-table-head>
        <md-table-head>Time:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in pruns" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.room_name}}</md-table-cell>
        <md-table-cell>{{row.data.team_name}}</md-table-cell>
        <md-table-cell><ElapsedTime :firstdate="row.data.starting_time" :lastdate="row.data.finishing_time" /></md-table-cell>
    </md-table-row>
      
     <md-button class="md-primary md-raised" @click="">Delete prrevious runs</md-button>
      </md-table>
      
      <md-empty-state v-else
			md-icon="history_toggle_off"
			md-label="You do not have previous run."
			md-description="You do not have previous run :/">
			
		</md-empty-state>
      </div>
      <md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this Run?"
      md-content="Are you delete the lists of run?"
      md-confirm-text="Agree"
      md-cancel-text="Disagree"
      @md-cancel="onCancel()"
      @md-confirm="delete_runs()" />
</div>
</template>
<script>
import ElapsedTime from "@/components/parts/ElapsedTime";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_from_allroomdb} from "@/mod_data/get_data";
export default
{
  data()
  {
    return{
     showDeleteDialog:false
    }
  },
  components:{
    ElapsedTime
  },
  mounted()
  {
    

  },
  methods:{
  delete_runs()
   {
    const k="past_runs";  
    let room_id="",room_name="";
   const userId = FirebaseAuth.currentUser.uid;
    let b=[];
onValue(ref(FireDb, `/users/${userId}/rooms`),(sn_out)=>{
      if(sn_out.exists()){
        sn_out.forEach((l)=>{
        room_id=l.key;
        room_name=l.val().room_name;
        //console.log(room_id);
       // console.log(`/users/${userId}/rooms/${room_id}/${k}`);
       onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sna)=>{
           if(sna.exists())
              {
              set(ref(`/users/${userId}/rooms/${room_id}/${k}`),null);
              }
            });
        });

      }
    });

    


   },
   onCancel()
    {
      console.log("Cancelled deletes");
    }
  },
  computed:
  {
    pruns()
    {
      return get_data_from_allroomdb("past_runs");
    }
  }
}
/*
<md-empty-state
			md-icon="devices_other"
			md-label="Create your first project"
			md-description="Create beautiful project with this template, you'll be able to create great things.">
			<md-button class="md-primary md-raised" to="/home">Ciao</md-button>
		</md-empty-state>
*/

</script>
