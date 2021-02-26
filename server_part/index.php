<?php
include "config.php";
if(isset($_GET["ajax"]))
{
include "parts/ajax.php";
}
if(get_config_text("debug")=="1") include("parts/debug.html");
else {
    include("parts/header.php");
    if (isset($_GET["mod"]))
        switch ($_GET["mod"]) {
        case "login":
        case "logout":
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
            case "teams":
                include("parts/teams.php");
                break;
        case "admin":
            include("parts/admin.php");
            break;
        case "run":
                include("parts/run.php");
                break;
        case "room":
                include("parts/rooms.php");
                break;
        case "programming_interface":
            include("parts/programming_interface.php");
            break;
            default:
            if($_SESSION["logged_in"]==true)  include("parts/dashboard.php");
            else include("parts/welcome.php");
    } else {
        if($_SESSION["logged_in"]==true)  include("parts/dashboard.php");
        else
        include("parts/welcome.php");
    }
    include("parts/footer.php");
}
?>
