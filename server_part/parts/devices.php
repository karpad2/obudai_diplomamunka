<h3>Devices:</h3>

<?php
echo '<table class="table">
    <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Device Name</th>
      <th scope="col">Device Active</th>
      <th scope="col">Escape Room</th>
    </tr>
    </thead>
    <tbody>';
//include "../config.php";
$sql = "select * from devices where user_id='{$_SESSION["user"]["user_id"]}'";
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

?>

