<?php
include "config.php";
if(isset($_GET["ajax"]))
{
include "parts/ajax.php";
}

if(get_config_text("debug")=="1") include("parts/debug.html");
else if(isset($_GET["window"]))
{
w_head();
sa();
w_footer();
}
else {
    include("parts/header.php");
    if (isset($_GET["mod"]))
        sa();
     else {
        if($_SESSION["logged_in"]==true)  include("parts/dashboard.php");
        else
        include("parts/welcome.php");
    }
    include("parts/footer.php");
}

function sa()
{
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
             }
}
function w_head()
{
    echo'<!doctype html><html lang="en"><head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>'.get_title_name().'</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="favicon.png">
    <script src="js/bootstrap.bundle.min.js"></script>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="'.get_config_text("author").'">
</head><body>';
}
function w_footer()
{
    echo'</body></html>';
}

?>
