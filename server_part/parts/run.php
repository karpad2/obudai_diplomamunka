<?php
echo '<div class="row"><h3>Run</h3></div>';
if (isset($_GET["run_mod"]))
{
    //var_dump($_GET);
    switch ($_GET["run_mod"])
    {
        case "start": start();
        break;
        case "edit" : edit();
        break;
        case "stop" : stop();
        break;

        default: defa();
    }
}

function defa()
{

}
function start()
{

    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-danger\">Start!</a>";
    echo "<a href=\"index.php?mod=run&run_mod=edit&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-warning\">Edit!</a>";

}
function edit()
{
echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-success\">Start!</a>";


}
function stop()
{
    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-danger\">Start!</a>";

}
