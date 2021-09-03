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

export {
    devicemodes
}