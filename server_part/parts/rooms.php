<h3>Escape rooms:</h3>

<?php
echo '<table class="table">
    <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Escape Room Name</th>
      <th scope="col">Device Numbers</th>
      <th scope="col">Program number</th>
    </tr>
    </thead>
    <tbody>';
//include "../config.php";
$sql = "select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id='{$_SESSION["user"]["user_id"]}'";
$result=e_sql($sql);
if($result->num_rows>0)
{
    $res=mysqli_fetch_all($result,0);
    foreach ($res as $re)
    {
        echo "<tr></tr>
        {$re["room_name"]}
    <span class=\"badge bg-primary rounded-pill\">14</span> <i class=\"bi bi-pencil-square\"></i> </li>";
    }
}
else
{
    echo "<tr scope=\"row\"><td colspan=\"3\">You havent registered any device.</td></tr>";
}
echo '
</tbody>
<tfoot><form method="post" action="index.php?ajax=register_devices"><td>Add device code:</td><td><input type="text"  class="form-control" name="esp32pass"></td>
<td><input type="submit"></td></form></tfoot>
</table>';




$sql = "select * from escape_rooms where user_id='{$_SESSION["user"]["user_id"]}'";
    $result=e_sql($sql);
    if($result->num_rows>0)
    {
        $res=mysqli_fetch_all($result,0);
        foreach ($res as $re)
        {
            echo "<li class=\"list-group-item d-flex justify-content-between align-items-center\">
        {$re["room_name"]}
    <span class=\"badge bg-primary rounded-pill\">14</span></li>";
        }
    }
    else
    {
        echo "<a href=\"#\" class=\"list-group-item list-group-item-action\">You don't have any program yet.</a>";
    }
    echo '   <a href="index.php?mod=escape_rooms&new" class="list-group-item list-group-item-action active">Click here to add a Rooms.</a>
</table>';
