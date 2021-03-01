<?php

include "../config.php";
if(empty($_SESSION["user"]["user_id"]) or empty($_GET["device_id"]) or empty($_GET["device_mode"]) or empty($_GET["status"])) die("err 403");
if($_GET["status"]>1) die("err 500");
$sql="update devices set device_mode='{$_GET["device_mode"]}', status='{$_GET["status"]}' ".
    "where device_id='{$_GET["device_id"]}' and user_id='{$_SESSION["user"]["user_id"]}'";
$res=e_sql($sql,GET_ROWS_NUMBER);
if($res>0)
{
    echo "ok";
}
else echo "fail";


