<?php
if(isset($_GET["delete"]) and isset($_GET["program_id"]))
{
    $sql="delete from program where program_id='{$_GET["program_id"]}' and user_id='{$_SESSION["user"]["user_id"]}'";
    e_sql($sql);
}
?>


<h3>Programs:</h3>

<?php

echo '<table class="table">
    <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Program Names</th>
      <th scope="col">Room Name</th>
      <th scope="col">Edit/Delete</th>
    </tr>
    </thead>
    <tbody>';
$sql = "select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where user_id='{$_SESSION["user"]["user_id"]}'";
$result=e_sql($sql);
if($result->num_rows>0)
{
    $i=0;
    $res=mysqli_fetch_all($result,0);
    foreach ($res as $re)
    {
        $i++;
    echo "<tr><td>$i</td><td>{$re["program_name"]}</td><td>{$re["room_name"]}</td>".
        "<td>".
        "<a class=\"btn w-50 btn-outline-warning\" href=\"index.php?programming_interface&program_id={$re["program_id"]}\">Edit</a>".
        "<a class=\"btn w-50 btn-outline-danger\" href=\"index.php?programs&delete&program_id={$re["program_id"]}\">Delete</a>".
        "</td></tr>";
    }
}
else
{
    echo "<tr><td colspan='4'>You don't have any program yet.</td></tr>";
    echo "</tbody>
<tfoot>
<tr>
<td colspan='4'><a href=\"index.php?mod=program&pr_mod=new\">Add program</a></td>
</tr>
        </tfoot>";
}
echo "</table>";
?>


