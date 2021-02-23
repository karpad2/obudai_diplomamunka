<?php
echo '<div class="row"><h3>Run</h3></div>';

if (isset($_GET["run_mod"]))
{
    switch ($_GET["run_mod"])
    {
        case "start":start();
        break;
        case "edit" :edit();
        break;
        case "stop" :stop();
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

}
function edit()
{



}
function stop()
{

}


