<?php
session_start();
if(!isset($_SESSION["logged_in"])) $_SESSION["logged_in"]=false;
const SALT=123456789;
const GET_RESULT=0;
const GET_INSERT_ID=1;

define("website_name","ESP32-project");
$conn = new mysqli("localhost","root","","esp32project");

if ($conn -> connect_errno) {
    echo "Failed to connect to MySQL: " . $conn -> connect_error;
    exit();
}


function get_ipaddress()
{
    return $_SERVER['REMOTE_ADDR'];
}

function get_title_name()
{
   echo "".website_name;
}
function login_in($username,$password)
{
    $user=array("user_id"=>0,"username"=>"John Doe","admin");
    $sql="select * from users where username='$username' and password=md5('".SALT.$password.SALT."');";
    $res=e_sql($sql);
    //var_dump(mysqli_fetch_all($res,MYSQLI_ASSOC));

    if($res&& $res->num_rows>0){
        $res_acc=mysqli_fetch_all($res,MYSQLI_ASSOC);
        $_SESSION["user"]=$res_acc[0];
        $_SESSION["logged_in"]=true;
        $_SESSION["user"]["admin"]= $_SESSION["user"]["admin_mod"]=="1";
       // var_dump($_SESSION);
        if($_SESSION["user"]["user_id"]=="1") $_SESSION["admin"]=true;
        $sql="update users set ip_address='".get_ipaddress()."' where user_id='".$_SESSION["user"]["user_id"]."';";
        $res=e_sql($sql);
        header("Location: index.php?mod=dashboard");
      //  die("alma");
    }
    else session_destroy();
}

function register($username,$password,$password2)
{
    if ($password == $password2) {
        $conn = new mysqli("localhost", "root", "", "esp32project");
        $sql = "Select username from users where username='$username';";
        $res = e_sql($sql);

        if ($res->num_rows == 0) {
            $_SESSION["logged_in"]=true;
            $sql = "insert into users (username,password) values ('$username',md5('".SALT.$password.SALT."'))";
            $res = e_sql($sql);
            $res_acc = mysqli_fetch_all($res, MYSQLI_ASSOC);
            $_SESSION["user"] = $res_acc;
            $sql = 'update users set ip_address='.get_ipaddress().' where user_id='.$_SESSION["user"]["user_id"].' ;';
            $res = e_sql($sql);
            if (mysqli_affected_rows($conn) > 0) {
            }

        } else {
            return "3";
        }
    }
    else
    {

    }
}

function logout()
{
    session_destroy();
    header("Location: index.php");
}

function e_sql($sql,$mod=GET_RESULT)
{
    $conn = new mysqli("localhost","root","","esp32project");
    $uid=0;
    if(isset($_SESSION["user"]["user_id"])) $uid=$_SESSION["user"]["user_id"];

    else $uid=1;

    if (!str_contains($sql,"config"))
        {
            $sql2="insert into log (user_id,logtext) values ('$uid','".mysqli_escape_string($conn,$sql)."')";
            $_res=mysqli_query($conn,$sql2);
        }
    //echo "im here:".$sql;
    $var= mysqli_query($conn,$sql)  or die(mysqli_error($conn));
    if($mod==GET_INSERT_ID)  $var= mysqli_insert_id($conn);
   // var_dump($var);
    //die("");
    $conn->close();
    return $var;
}
function get_config_text($name)
{
    $sql="select config_text from config where config_name='$name'";
    $res=e_sql($sql);
    $resi = mysqli_fetch_assoc($res);
    //var_dump($resi);
    return $resi["config_text"];
}


