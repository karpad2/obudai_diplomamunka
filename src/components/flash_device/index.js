const filters = [
    { usbVendorId: 0x2341, usbProductId: 0x0043 },
    { usbVendorId: 0x2341, usbProductId: 0x0001 }
  ];

function check_serial_supported()
{
    if ("serial" in navigator) {
        return true;
      }
}
function list_coms()
{
    
}




export{
 check_serial_supported,
 list_coms

}