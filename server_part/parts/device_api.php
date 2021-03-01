<?php
if(empty($_SESSION["user"]["user_id"])) die();
include "../config.php";
$sql="update devices set device_mode='{$_GET["device_mode"]}' and status={$_GET["device_status"]} where device_id='{$_GET["device_id"]}'";
$res=e_sql($sql,GET_ROWS_NUMBER);
if($res>0)
{
    echo "ok";
}
else echo "fail";


