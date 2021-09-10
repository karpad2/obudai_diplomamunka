import CryptoJS from "crypto-js"; 
const devicemodes=
[
    {
    type:"relay",
    name:"Relay",
    direction:"out",
    control:"checkbox",
    readonly:false
    },
    {
        type:"rfid",
        name:"RFID reader",
        direction:"in",
        control:"text",
        readonly:true
    },
    {
        type:"input",
        name:"Input from device",
        direction:"in",
        control:"checkbox",
        readonly:true
    },

    {
        type:"oled",
        name:"Oled writer",
        direction:"out",
        control:"text",
        readonly:false
    },
    
];

function encode(a_program_xml,format="base64")
                    {
                    if(format=="base64")
                    {
                      let encoding=CryptoJS.enc.Utf8.parse(a_program_xml);
                      return CryptoJS.enc.Base64.stringify(encoding);
                    }
                    else return"";   // 
                    }
function  decoding(program_xml,format="base64")
                    {
                    if(format=="base64")
                    {
                      let encodedWord = CryptoJS.enc.Base64.parse(program_xml); // encodedWord via Base64.parse()
                      return CryptoJS.enc.Utf8.stringify(encodedWord);
                    }
                    else return "";   // 
                    }


export {
    devicemodes,
    encode,
    decoding
}