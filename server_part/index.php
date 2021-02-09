<?php
include "config.php";
//register("karpad2","asdfghjkl","asdfghjkl");
if(isset($_GET["ajax"]))
{
include "parts/ajax.php";
}
if(get_config_text("debug")=="1") include("parts/debug.html");
else {
    include("parts/header.php");
    if (isset($_GET["mod"])) switch ($_GET["mod"]) {
        case "login":
            include("parts/login.php");
            break;
        case "logout":
            include("parts/login.php");
            break;
        case "register":
            include("parts/login.php");
            break;
        case "programs":
            include("parts/programs.php");
            break;
        case "program":
            include("parts/program.php");
            break;
        case "devices":
            include("parts/devices.php");
            break;
        case "admin":
            include("parts/admin.php");
            break;
        case "programing_interface":
            include("parts/programing_ui.php");
            break;
            default:
            if($_SESSION["logged_in"])  include("parts/dashboard.php");
            else include("parts/welcome.php");
    } else {
        include("parts/welcome.php");
    }

    include("parts/footer.php");
}
?>
