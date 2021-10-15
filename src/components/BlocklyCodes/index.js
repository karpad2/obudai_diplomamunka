import * as Blockly from 'blockly/core';
import * as En from "blockly/msg/en";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {stop_run} from "@/mod_data/set_data";

function send_finish()
{
    const roomID= localStorage.getItem("roomID");
    stop_run(roomID);
}
function set_data(device_id,mode,value)
{
    const roomID= localStorage.getItem("roomID");
    
    const userId = FirebaseAuth.currentUser.uid;
    
    let _ref= ref(FireDb, `/users/${userId}/rooms/${roomID}/devices/${device_id}/mode`);
    set(_ref,mode);
    _ref= ref(FireDb, `/users/${userId}/rooms/${roomID}/devices/${device_id}/status`);
    set(_ref,value);

}
function get_data(device_id,mode)
{
    const roomID= localStorage.getItem("roomID");
    const userId = FirebaseAuth.currentUser.uid;
    console.log(this.modelValue);
    let _ref= ref(FireDb, `/users/${userId}/rooms/${roomID}/devices/${device_id}/status`);
        onValue(_ref,(e)=>
            {
                if(e.exists())
                {
                    return e.val();
                }
                else return null;

            });

}
function start_room()
{
    const roomID= localStorage.getItem("roomID");
    

}

export{
    send_finish,
    start_room,
    get_data,
    set_data
    
}