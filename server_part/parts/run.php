<?php
echo '<div class="row"><h3>Run</h3></div>';
if (isset($_GET["run_mod"]))
{
    echo "<div class=\"row\">";
    echo "<div class=\"col-md-4\">";
    echo "<h5 class=\"my-0 font-weight-normal\">Room management</h5>";
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
    echo"</div>";
    echo "<div class=\"col-md-4\">";
    echo "<h5 class=\"my-0 font-weight-normal\">Status:</h5>";
    echo "<div class=\"card-body\">
            <h1 class=\"card-title pricing-card-title\"> 15 <small class=\"text-muted\">/ Devices</small></h1>
            <h1 class=\"card-title pricing-card-title\"> 15 <small class=\"text-muted\">/ Program status</small></h1>
        </div>";
        /*    <ul class="list-unstyled mt-3 mb-4">
              <li>20 users included</li>
              <li>10 GB of storage</li>
              <li>Priority email support</li>
              <li>Help center access</li>
            </ul>
            <button type="button" class="btn btn-lg btn-block btn-primary">Get started</button>
          */

    echo"</div>";
    echo"</div>";
}

function defa()
{

}
function start()
{
    //echo "<div class=\"col-md-4\">";
    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}}\" class=\"w-100 btn btn-lg btn-outline-success\">Start!</a>";
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
