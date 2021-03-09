<?php
if(isset($_POST["current_program"])and isset($_GET["room_id"]))
{
    if($_POST["current_program"]=="new")
    {
        header("Location:index.php?mod=programming_interface&program_id=new&room_id={$_GET["room_id"]}");
    }
    $sql="update programs set active='0' where room_id='{$_GET["room_id"]}'";
    e_sql($sql);
    $sql="update programs set active='1' where room_id='{$_GET["room_id"]}' and program_id='{$_POST["current_program"]}'";
    e_sql($sql);
}

if(isset($_POST["add_new_device"])and isset($_GET["room_id"]))
{
    if($_POST["add_new_device"]=="new")
    {
        header("Location:index.php?mod=devices");
    }
    $sql="update devices set room_id='{$_GET["room_id"]}' where device_id='{$_POST["add_new_device"]}'";
}

if(isset($_POST["camera_name"]) and isset($_POST["camera_url"]) and isset($_GET["room_id"]))
{
    $sql="update cameras set camera_name='{$_POST["camera_name"]}',camera_url='{$_POST["camera_url"]}' where camera_id='{$_POST["camera_id"]}'";
    e_sql($sql);
}
if(isset($_GET["camera_id"]) and isset($_GET["delete"]))
{
    $sql=" delete from cameras where camera_id='{$_POST["camera_id"]}' and user_id='{$_SESSION["user"]["user_id"]}'";
    e_sql($sql);
}
if(isset($_POST["add-cam-name"]) and isset($_POST["add-cam-url"]) and isset($_GET["room_id"]))
{
    $sql="insert into cameras (camera_name,camera_url,room_id,user_id) values('{$_POST["camera_name"]}','{$_POST["camera_url"]}','{$_GET["room_id"]}','{$_SESSION["user"]["user_id"]}')";
    e_sql($sql);
}
if(isset($_POST["start-run"]))
{
    run();
}
/*
var_dump($_GET);
var_dump($_POST);*/


echo '<div class="row"><h3>Run</h3></div>';
if (isset($_GET["run_mod"]))
{
    echo "<div class=\"row\">";
    echo "<div class=\"col-lg w-auto\">";
    echo "<h5 class=\"my-0 font-weight-normal\">Room management</h5>";
    //var_dump($_GET);
    switch ($_GET["run_mod"])
    {
        case "start": start();
        break;
        case "lobby": lobby();
        break;
        case "run": run();break;
        case "edit" : edit();
        break;
        case "stop" : stop();
        break;

        default: defa();
    }
    echo"</div>";
    echo "<div class=\"col-md-4\">";
    echo "<h5 class=\"my-0 font-weight-normal\">Status:</h5>";
    echo "<div class=\"card-body\">";
    $sql="select count(device_id) as 'device_number',sum(active) as 'active_number' from active_devices where room_id='{$_GET["room_id"]}' group by room_id";
    $devis=e_sql($sql,GET_ASSOC)[0];
    if($devis["active_number"]==$devis["device_number"]) echo"<h5 class=\"card-title pricing-card-title\"><small class=\"text-muted\"><img class=\"mb-2\" src=\"media/Approve.svg\" alt=\"\" width=\"24\" height=\"24\"> All device online";
    else echo "<h5 class=\"card-title pricing-card-title\">{$devis["active_number"]} <small class=\"text-muted\"> / {$devis["device_number"]} active devices";
    echo " </small></h5>
            <h5 class=\"card-title pricing-card-title\"> 15 <small class=\"text-muted\">/ Program status</small></h5>
            <h5 class=\"card-title pricing-card-title\"> 15 <small class=\"text-muted\">/ Program status</small></h5>";


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
    echo"</div>";
}

function defa()
{

}
function start()
{
    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}\" class=\"w-100 btn btn-lg btn-outline-success\">Start!</a>";
    echo "<a href=\"index.php?mod=run&run_mod=edit&room_id={$_GET["room_id"]}\" class=\"w-100 btn btn-lg btn-outline-warning\">Edit!</a>";
}
function run()
{
    if(isset($_POST["team_name"])) $team_name=$_POST["team_name"];
    else $team_name="Default";
    $sql="select teams_id from teams where teams_name='$team_name'";
    $team=e_sql($sql,GET_ASSOC);
    if(count($team)==0)
    {
        $sql="insert into teams (teams_name) values('{$team_name}')";
        e_sql($sql);
        $sql="select * from teams where teams_name='$team_name'";
        $team=e_sql($sql,GET_ASSOC)[0];
    }
    else $team=e_sql($sql,GET_ASSOC)[0];
    //echo "array of elements".count($res);
    $sql="select program_id,program_javascript_block from programs where room_id='{$_GET["room_id"]}' and active='1'";
    $pr=e_sql($sql,GET_ASSOC)[0];

    $sql="insert into runs (program_id,team_id) values('{$pr["program_id"]}','{$team["team_id"]}')";
    $id=e_sql($sql,GET_INSERT_ID);

    $sql="select * from runs where run_id='$id'";
    $res=e_sql($sql,GET_ASSOC);
    echo "<form method=\"post\" action=\"#\"><input class=\"btn btn-outline-danger w-100\" type=\"submit\" name=\"run-stop\" value=\"Stop\"/><input type=\"hidden\" value=\"$id\"/></form>";
    echo "<h3 id=\"time-counter\"></h3>";
    echo '<script>
function a(id){return  document.getElementById(id);}
window.addEventListener("load",()=>{
    
    var starttimestamp=new Date("'.$res["starting_time"].'");
    var diff_time;
    var current_time=  new Date();
    setInterval(()=>{
        current_time=new Date();
        diff_time=current_time-starttimestamp;
        console.log(Date(diff_time));
        a("time-counter").innerText="";
    },1000);
    
    
});
    </script>';

}


function lobby()
{
    //echo "<div class=\"col-md-4\">";
    echo "<form action=\"index.php?mod=run&run_mod=run&room_id={$_GET["room_id"]}\" method=\"post\">";
    echo "<label for=\"teamname\">Team Name:</label><input id=\"teamname\" class=\"form-control\" name=\"team_name\" value=\"Default\"/>
    <input class=\"w-100 btn btn-lg btn-outline-success\" name=\"start-run\" type=\"submit\" value=\"Start!\"/>";
    echo"</form>";

    echo "<a href=\"index.php?mod=run&run_mod=edit&room_id={$_GET["room_id"]}\" class=\"w-100 btn btn-lg btn-outline-warning\">Edit!</a>";
    echo"<script></script>";

}
function edit()
{
echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}\" class=\"w-100 btn btn-lg btn-outline-success\">Start!</a>";
$sql="select * from programs where room_id='{$_GET["room_id"]}'";
$res=e_sql($sql,GET_ASSOC);
echo "<form method=\"post\" action='#'>";
echo"<label for=\"cur_program\">Choose program:</label>";
echo "<select id=\"cur_program\" class=\"form-control\" name=\"current_program\">";
foreach ($res as $re)
    echo "<option value=\"{$re["program_id"]}\">{$re["program_name"]}</option>";
    echo "<option value=\"new\">Add new program</option>";
echo"</select>
<input type=\"submit\" class=\"btn btn-outline-warning w-100\" value=\"Choose:\"/>
<a href=\"index.php?mod=run&\"></a>
 </form>";
    $sql="select * from devices where user_id='{$_SESSION["user"]["user_id"]}'";
    $res=e_sql($sql,GET_ASSOC);
    echo "<form method=\"post\" action='#'>";
    echo"<label for=\"add_new_devices\">Add new device:</label>";
    echo "<select id=\"add_new_devices\" class=\"form-control\" name=\"add_new_device\">";
    foreach ($res as $re)
        echo "<option value=\"{$re["device_id"]}\">{$re["device_name"]}</option>";
    echo "<option value=\"new\">Add new device:</option>";
    echo"</select>
<input type=\"submit\" class=\"btn btn-outline-warning w-100\" value=\"Add new device\"/>
 </form>";

    echo '<table class="table">
    <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Camera Name</th>
      <th scope="col">Camera url</th>
      <th scope="col"></th>
    </tr>
    </thead>
    <tbody>';
    $sql="select * from cameras where room_id='{$_GET["room_id"]}'";
    $res=e_sql($sql,GET_ASSOC);
    $i=0;
    foreach ($res as $re)
    {
        $i++;
    echo "<form method=\"post\" action=\"#\">
<tr><td>$i<input type=\"hidden\" name=\"camera_id\" value=\"{$re["camera_id"]}\"/></td>
<td><input name=\"camera_name\" class=\"form-control\" value=\"{$re["camera_name"]}\"/></td>
<td><input name=\"camera_url\" class=\"form-control\" value=\"{$re["camera_url"]}\"/></td>
<td><input value=\"Save\" class='btn w-100 btn-outline-success' type=\"submit\"/><a class=\"btn w-100 btn-outline-danger\" href=\"index.php?mod=run&run_mod=edit&delete&room_id={$_GET["room_id"]}&camera_id={$_GET["camera_id"]}\">Delete</a>
</td>
</tr>
</form>";
    }
    echo "</tbody><tfoot><form method=\"post\" action=\"#\"><tr><td></td>
<td><label for=\"add-cam-name\">Camera Name:</label><input id=\"add-cam-name\" class=\"form-control w-100\" name='add-camera-name'/></td>
<td><label for=\"add-cam-url\">Camera Url:</label><input id=\"add-cam-url\" class=\"form-control w-100\" name='add-camera-url'/></td>
<td><input id=\"add-cam-btn\" class=\"btn btn-outline-success\" type=\"submit\" value=\"Add camera\"/></td></tr></form></tfoot></table>";



}
function stop()
{
    $sql="select run_id from runs left join programs p on p.program_id = runs.program_id where runs.finishing_time  is null and p.room_id='{$_GET["room_id"]}'";
    $r_id=e_sql($sql)[0];
    $sql="update runs set finishing_time=CURRENT_TIME() where run_id='{$r_id["run_id"]}'";
    e_sql($sql);



}
