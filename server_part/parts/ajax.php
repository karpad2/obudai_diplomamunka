<?php
include_once "config.php";
if(isset($_GET["esp32_welcome"]))
{
$sql="insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','".get_ipaddress()."')";
$res=e_sql($sql);
}
else if(isset($_GET["esp32_status"]))
{
    $sql="insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','".get_ipaddress()."')";
    $res=e_sql($sql);
}
