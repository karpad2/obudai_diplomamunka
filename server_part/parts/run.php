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
            <h1 class=\"card-title pricing-card-title\"> 15 <small class=\"text-muted\">/ Program status</small></h1>";


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

function lobby()
{
    //echo "<div class=\"col-md-4\">";
    echo "<form action=\"index.php?mod=run&run_mod=run&room_id={$_GET["room_id"]}\" method=\"post\">";
    echo "<label for=\"teamname\">Team Name:</label><input id=\"teamname\" class=\"form-control\" name=\"team_name\" />
    <input class=\"w-100 btn btn-lg btn-outline-success\" type=\"submit\" value=\"Start!\"/>";
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
    echo "<a href=\"index.php?mod=run&run_mod=start&room_id={$_GET["room_id"]}\" class=\"w-100 btn btn-lg btn-outline-danger\">Start!</a>";
}
