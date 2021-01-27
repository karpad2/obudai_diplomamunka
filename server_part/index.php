<?php
include "config.php";
if(isset($_GET["ajax"]))
{
include "parts/ajax.php";
}
else {
    include("parts/header.php");
    if (isset($_GET["mod"])) {
        switch ($_GET["mod"]) {
            case "login":
                include("parts/login.php");
                break;
            case "logout":
                include("parts/login.php");
                break;
            case "register":
                include("parts/login.php");
                break;
                default:
                include("parts/welcome.php");
        }
    } else {
        include("parts/welcome.php");
    }

    include("parts/footer.php");
}
?>
