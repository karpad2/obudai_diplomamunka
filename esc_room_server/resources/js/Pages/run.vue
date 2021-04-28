<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Run
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg col-span-full md:col-span-4">
                   
                    <h3>Status:{{status}}/{{room_max}}</h3>
                     <h3>Timer:{{elapsed_time}}</h3>
                    <div>
                    <intertia-link>Stop</intertia-link>
                    </div>
                    <div>
                    <intertia-link></intertia-link>
                    </div>
                    <div class="bg-indigo-300 ...">
                     <img class="object-contain h-48 w-full" :src="getImgUrl(pic)" v-bind:alt="pic">
                    </div>
                     

                     <div :v-for="log in console_log">
                        <p>{{log}}</p>
                     </div>
                    <input type="text" v-model="console_in"/>
                     <jet-button class="ml-4"  @click="add_to_console">
                    Send
                    </jet-button>


                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    //import Welcome from '@/Jetstream/Welcome'
    import Blockly, { isNumber } from 'blockly';
    import 'blockly/javascript';
import axios from 'axios';
 
    import * as En from 'blockly/msg/en';
    import 'blockly/javascript';
    

    export default {
        data:
        {
        console_log:[],
        log:""
        },
        components: {
            AppLayout,
            Blockly
        },
        props: {
            run:{ 
                type:Array,
                required: true
            },
            cameras:{
                type:Array,
                required: true
            },
            run:{
                type:Array,
                required: true
            },
            cameras:{
                type:Array,
                required: true
            },
        },
           methods: {
               syntaxerror()
               {
                console_log.push("syntax_error");
               },
            add_to_console(text) {
            console_log.push(console_in);
            //device_id,mode,status
            //1,relay,ON
            if(text=="?")
            {
                console_log.push("device_id,mode,status");
                console_log.push("example:1,relay,ON");
            }
            let texts=text.split(",");
            let device_id=texts[0];
            if(!isNumber(device_id)) { this.syntaxerror(); return 0;}
            if(texts[2]=="ON" || texts[2]=="OFF")
            {
                send_data(device_id,texts[1],texts[2]=="ON"?"1":"0")
            }
            },
            send_data(id,mode,status)
            {
            axios.get('/api/device/js-api/'+id+'/'+mode+'/'+status);
            },
   executeBlockCode() {
    var code = Blockly.JavaScript.workspaceToCode(workspace);
    var initFunc = function(interpreter, scope) {
      var alertWrapper = function(text) {
        text = text ? text.toString() : '';
        return interpreter.createPrimitive(alert(text));
      };
      interpreter.setProperty(scope, 'alert',
          interpreter.createNativeFunction(alertWrapper));
      var promptWrapper = function(text) {
        text = text ? text.toString() : '';
        return interpreter.createPrimitive(prompt(text));
      };
      interpreter.setProperty(scope, 'prompt',
          interpreter.createNativeFunction(promptWrapper));
    };
    var myInterpreter = new Interpreter(code, initFunc);
    var stepsAllowed = 10000;
    while (myInterpreter.step() && stepsAllowed) {
      stepsAllowed--;
    }
    if (!stepsAllowed) {
      throw EvalError('Infinite loop.');
    }
  }
        },
        mounted()
        {
            executeBlockCode();


        }
        
    }
    if (!stepsAllowed) {
      throw EvalError('Infinite loop.');
    }
  }
},
mounted()
{
executeBlockCode();
}        
}

    
</script>