<template>
<div >
    <div class="section">
    <h2>Events</h2>
    </div>
    <div class="section">
         <md-card id="mdsmall">
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
           <b-select v-model="contact.room">
                <b-select-option disabled selected>Choose Room:</b-select-option>
                <b-select-option v-for="row in rooms" :key="row.devID">{{row.data.room_name}}</b-select-option>
            </b-select>
            <DatePicker mode='dateTime' :v-model="contact.contact_date" :min-date='new Date()'  :open-date="openDate" />
            </md-card-content>
            <md-card-actions>
                <md-button class="md-raised" @click="addevent()">Add Event</md-button>
            </md-card-actions>
        </md-card>
   
    
      <md-card  >
          <md-card-header>
          <div class="md-title">Events</div>
        </md-card-header>
         <md-card-content>
  <md-table v-if="events.length>0">
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
        <md-table-cell>{{get_timestamp(row.data.contact_date)}}</md-table-cell>
        <md-table-cell><router-link :to="{ path: `/room/${row.room_id}/event/${row.dev_id}`}">Edit</router-link></md-table-cell>
    </md-table-row>
      
      </md-table>

      <md-empty-state v-else
			md-icon="event"
			md-label="You do not have events"
			md-description="You do not have events. You can create events here.">
			
		</md-empty-state>
     </md-card-content>
      </md-card>
</div>
 </div>
</template>
<script>
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {get_data_from_allroomdb,get_rooms} from "@/mod_data/get_data";
import {add_event} from "@/mod_data/set_data";
import {DatePicker } from 'v-calendar';
import moment from "moment";

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
          contact_date:new Date()
      },
      disabledDates: {
          to: new Date(Date.now() - 8640000)
        },
        openDate: new Date()

    }
  },
  components:{
      DatePicker
  },
  mounted()
  {
    this.rooms=get_rooms();
    console.log(this.rooms);
    this.events=get_data_from_allroomdb("events");
     
  },
  methods:{
      addevent()
      {
        if (this.contact.contact_name==null && this.contact.contact_phone==null) return;
        if (this.contact.room=="")
        {
          this.$noty.error("Room hasnt been choosed.");
          return ;
        } 
        
          add_event(this.contact.room,{
              contact_name:this.contact.contact_name,
              contact_phone:this.contact.contact_phone,
              contact_date:this.contact.contact_date
          });
        this.contact={
          room:"",
          contact_name:"",
          contact_phone:"",
          contact_date:Date()
      };
      },
      get_timestamp(string)
      {
        return moment(string).format('MMMM Do YYYY, HH:mm ');
      }
  },
  computed:{
  
  }
}

</script>
<style lang="scss" scoped>
.center{
    padding: 50px;
    margin: auto;
}
#mdsmall {
    width: 420px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
  }
  .md-card
  {
  width: 900px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
  }
</style>
