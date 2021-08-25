<template>
    <app-layout>
        <template>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Run
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg col-span-full md:col-span-4">

                    <h3>Status:{{status}}/{{room_max}}</h3>
                    <h3>Timer:<ElapsedTime :firstdate="run[0].start_time" :lastdate="_NOW" /></h3>
                    <div>
                    <LinkButton :href="'/run-stop/'+room[0].id+'/stop'">Stop</LinkButton>
                    </div>
                    <div>
                    <intertia-link></intertia-link>
                    </div>
                    <div class="bg-indigo-300 ...">
                    <img class="object-contain h-48 w-full" src="alma.png">
                    </div>

                        <div class="bg-green-300 ...">
                     <div class="object-contain h-48 w-full" :v-for="log in console_log">
                        <p>{{log}}</p>
                     </div>
                    <input type="text" v-model="console_in"/>
                     <jet-button class="ml-4" v-on:click="add_to_console">
                    Send
                    </jet-button>
                        </div>

                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    //import Welcome from '@/Jetstream/Welcome'
    import Blockly, { isNumber } from 'blockly';
    import LinkButton from '@/Jetstream/LinkButton'
    import ElapsedTime from '@/Jetstream/ElapsedTime'
    import JetButton from '@/Jetstream/Button'
    import axios from 'axios';
    import {Interpreter} from 'js-interpreter-npm'

    import * as En from 'blockly/msg/en';
    import 'blockly/javascript';


    export default {
        data()
        {
        return {
        console_log:["Starting app",""],
        log:"",
        elapsed_time:"",
        room_max:100,
        status:0
        }
        },
        components: {
            AppLayout,
            Blockly,
            JetButton,
            LinkButton,
            ElapsedTime
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
            program:{
                type:Array,
                required: true
            },
            cameras:{
                type:Array,
                required: true
            },
             room:{
                type:Array,
                required: true
            },
        },
           methods: {
               syntaxerror()
               {
                this.console_log.push("syntax_error");
               },
               add_to_console_text(text)
               {
                this.console_log.push(Date.now()+" "+text);
               },
            add_to_console() {
            let text=this.console_in;
            console.log(text);
            
            //device_id,mode,status
            //1,relay,ON
            if(text=="?")
            {
                this.add_to_console_text("device_id,mode,status");
                this.add_to_console_text("example:1,relay,ON");
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
    //let code = Blockly.JavaScript.workspaceToCode(workspace);
    let code = this.program[0].javascript_block;
    
    let myInterpreter = new Interpreter(code, initFunc);
    let stepsAllowed = 10000;  //max lépés
    while (myInterpreter.step() && stepsAllowed) {
      stepsAllowed--;
      this.status++;
    }
    if (!stepsAllowed) {
      throw EvalError('Infinite loop.');
    }
    let initFunc = function(interpreter, scope) {
      let alertWrapper = function(text) {
        text = text ? text.toString() : '';
        return interpreter.createPrimitive(alert(text));
      };

        let send_console = function(text) {
            text = text ? text.toString() : '';
            return interpreter.createPrimitive(this.send_console(text));
        };

      interpreter.setProperty(scope, 'alert',
          interpreter.createNativeFunction(alertWrapper));
      interpreter.setProperty(scope, 'send_console',
            interpreter.createNativeFunction(send_console));
      let promptWrapper = function(text) {
        text = text ? text.toString() : '';
        return interpreter.createPrimitive(prompt(text));
      };
      interpreter.setProperty(scope, 'prompt',
          interpreter.createNativeFunction(promptWrapper));
    };
  }


},
        mounted()
        {
            //this.executeBlockCode();
        },
        

    }




</script>
