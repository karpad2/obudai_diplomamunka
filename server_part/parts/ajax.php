<?php
include_once "config.php";
if(isset($_GET["esp32_welcome"]))
{
   if($_GET["esp32_welcome"]=="reg") {
       $esp32 = array("pass" => "");
       $sql = "insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','" . get_ipaddress() . "')";
       $res = e_sql($sql, GET_INSERT_ID);
       $dev_pass = md5(SALT.$res.SALT);
       $esp32["pass"] = $dev_pass;
       $sql = "update devices set device_password='$dev_pass' where device_id='$res';";
       $res=e_sql($sql);
       echo json_encode($esp32);
   }
   else
   {

   }

}
else if(isset($_GET["esp32_status"]) and isset($_GET["device_pass"]))
{
    $assoc=array("esp32id"=>"0","esp32name"=>"Name","Status"=>false);
    $sql="insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','".get_ipaddress()."')";
    $res=e_sql($sql);
    echo json_encode($assoc);
}
else if(isset($_GET["esp32_status"]))
{
    $sql="select * from devices where device_password='{$_GET["esp32_status"]}'";
    $res=e_sql($sql);
    $result=mysqli_fetch_all($res,MYSQLI_ASSOC);
    if($result["device_mode"]=="relay")
    {
        $stat= $result["status"]=="1";
        $assoc=array("status"=>$stat);
        echo json_encode($assoc);
    }
    else
    {
    if(isset($_GET["esp32_card"]))
    {
        $sql="select * from devices join program_tasks pt on devices.device_id = pt.device_id where device_password='{$_GET["esp32_status"]}' and rfid_code='{$_GET["esp32_card"]}' ";
        $res=e_sql($sql);
        $result=mysqli_fetch_all($res);
        $sql="update runs set progress={$result["order_number"]} where program_id={$result["program_id"]} and isnull(finishing_time)";
    }

    }

    $sql="insert into devices (device_name,device_mode,ip_address) values('ESP32','relay','".get_ipaddress()."')";
    $res=e_sql($sql);
    echo json_encode($assoc);
}

else {}

