<template>
<div >
    <div class="section">
    <h2>Events</h2>
    </div>
    <div class="section">
         <md-card class=" md-small-size-100">
             <md-card-header>
          <div class="md-title">Add event</div>
        </md-card-header>
        <md-card-content>
             <md-field>
                 <label for="contact-name">Contact Name:</label>
                 <md-input name="contact-name" id="contact-name" autocomplete="given-name" v-model="contact.contact_name"/>
             </md-field>
             <md-field>
                 <label for="contact-Phone">Contact Phone:</label>
                 <md-input name="contact-Phone" id="contact-Phone" autocomplete="given-name" v-model="contact.contact_phone"/>
             </md-field>
           <b-select @change="changeprogram" v-model="contact.room">
                <b-select-option disabled selected>Choose Room</b-select-option>
                <b-select-option v-for="row in rooms" :key="row.devID" :value="row.devID">{{row.data.room_name}}</b-select-option>
            </b-select>
            <DatePicker mode='dateTime' v-model="contact.date" />
            </md-card-content>
            <md-card-actions>
                <md-button class="md-raised" @click="addevent()">Add Event</md-button>
            </md-card-actions>
        </md-card>
   </div>
    <div class="section">
  <md-table  md-card v-if="events.length>0">
      <md-table-toolbar>
        <h1 class="md-title">Events of all room:</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Contact</md-table-head>
        <md-table-head>Room</md-table-head>
        <md-table-head>Date</md-table-head>
        <md-table-head>Options</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in events" :key="index">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell><p>{{row.data.contact_name}}</p><p>{{row.data.contact_phone}}</p></md-table-cell>
        <md-table-cell>{{row.room_name}}</md-table-cell>
        <md-table-cell><img :src="row.data.date" class="" /></md-table-cell>
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/event/${row.dev_id}`}">Edit</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>

      <md-empty-state v-else
			md-icon="event"
			md-label="You do not have events"
			md-description="You do not have events. You can create events here.">
			
		</md-empty-state>
      
</div>
 </div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_from_allroomdb,get_rooms} from "@/mod_data/get_data";
import {add_event} from "@/mod_data/set_data";
import {DatePicker } from 'v-calendar';

export default
{
  data()
  {
    return{
      events:[],
      rooms:[],
      contact:{
          room:"",
          contact_name:"",
          contact_phone:"",
          date:Date()
      }
      

    }
  },
  components:{
      DatePicker
  },
  beforeMount()
  {
    this.events=get_data_from_allroomdb("events");
    this.rooms=get_rooms(); 
  },
  methods:{
      addevent()
      {
          add_event(this.contact.room,{
              contact_name:this.contact.contact_name,
              contact_phone:this.contact.contact_phone,
              date:this.contact.date
          });
        this.contact={
          room:"",
          contact_name:"",
          contact_phone:"",
          date:Date()
      };
      }
  }
}

</script>
<style lang="scss" scoped>
.center{
    padding: 50px;
    margin: auto;
}
</style>
