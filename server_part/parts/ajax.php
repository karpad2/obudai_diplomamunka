<?php
include_once "config.php";
if(isset($_GET["esp32_welcome"]))
{
$sql="insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','".get_ipaddress()."')";
$res=e_sql($sql,GET_INSERT_ID);
$dev_pass=md5(SALT.$res.SALT);

}
else if(isset($_GET["esp32_status"]) and isset($_GET["device_pass"]))
{
    $assoc=array("esp32id"=>"0","esp32name"=>"Name","Status"=>false);
    $sql="insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','".get_ipaddress()."')";
    $res=e_sql($sql);
    echo json_encode($assoc);
}
else {}

