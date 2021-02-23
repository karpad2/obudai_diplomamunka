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
if(isset($_GET["start"]))
{
    echo '<form method="POST" action="#">';


    echo '</form>';
}
function defa()
{

}
function start()
{
    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-primary\">Start!</a>";

}
function edit()
{
echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-primary btn-success\">Start!</a>";


}
function stop()
{
    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-primary btn-danger\">Start!</a>";

}
