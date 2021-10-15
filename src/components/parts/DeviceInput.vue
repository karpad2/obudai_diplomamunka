<template>
   <div>
       <label for="input">{{mode}}</label>
       <md-field>
        <md-input id="input" v-model="status" @change="oChange"  v-if="mode=='oled'" ></md-input>
        <md-input id="input" v-model="status" @change="oChange"  v-else-if="mode=='rfid'" readonly></md-input>
        <md-switch id="input" v-model="status" @change="oChange"  v-else-if="mode=='relay'" >{{ status ? 'On' : 'Off' }}</md-switch>
        <md-switch id="input" v-model="status" @change="oChange"  v-else-if="mode=='input'" >{{ status ? 'On' : 'Off' }}</md-switch> 
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
           status:this.modelValue
        }
    },
    methods:{
        oChange()
        {
            const userId = FirebaseAuth.currentUser.uid;
            console.log(this.modelValue);
            let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/status`);
            set(_ref,this.status);
        }
    },
    mounted()
    {
        const userId = FirebaseAuth.currentUser.uid;
            console.log(this.modelValue);
            let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.did}/status`);
            onValue(_ref,(e)=>
            {
                if(e.exists())
                {
                    this.status=e.val();
                }

            });
    }
    
}
</script>