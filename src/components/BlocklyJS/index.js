import * as Blockly from 'blockly/core';
import * as En from "blockly/msg/en";

const send_data= require("./send_data");
const devices= require("./devices");
const init= require("./init");
const get_data= require("./get_data");
const send_finish= require("./send_finish");
import Blocks from "@/components/parts/Blocks";


export {
    send_data,
    devices,
    init,
    get_data,
    send_finish
}