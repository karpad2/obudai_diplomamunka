<template>
   <div>
       <label>{{mode}}</label>
       <md-field>
        <md-input v-model="modelValue" @change="oChange" @input="$emit('update:modelValue', $event.target.value)" v-if="mode=='oled'" ></md-input>
        <md-input v-model="modelValue" @change="oChange" @input="$emit('update:modelValue', $event.target.value)" v-else-if="mode=='rfid'" readonly></md-input>
        <md-switch v-model="modelValue" @change="oChange" @input="$emit('update:modelValue', $event.target.value)"  v-else-if="mode=='relay'" >{{ modelValue ? 'On' : 'Off' }}</md-switch>
        <md-switch v-model="modelValue" @change="oChange" @input="$emit('update:modelValue', $event.target.value)" v-else-if="mode=='input'" >{{ modelValue ? 'On' : 'Off' }}</md-switch> 
        <span v-else>Unknown mode</span> 
       </md-field>
    </div> 
</template>
<script>
import {devicemodes} from "@/datas";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
export default {
    
    props:['modelValue','mode'],
   // emits: ['update:modelValue'], bruh lets do direct render instead
    data()
    {
        return{
            astatus:this.status
        }
    },
    methods:{
        oChange()
        {
            const userId = FirebaseAuth.currentUser.uid;
            console.log(this.modelValue);
            let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/status`);
            set(_ref,this.modelValue);
        }
    }
    
}
</script>