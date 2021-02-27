<?php
include ("blocks.php");
if(isset($_GET["room_id"])) {
    $sql = "select * from devices where room_id='{$_GET["room_id"]}'";
    $devs = e_sql($sql, GET_ASSOC);
}

echo '<script src="js/blockly_compressed.js"></script>';
echo '<script src="js/blocks_compressed.js"></script>';
echo '<script src="js/javascript_compressed.js"></script>';
echo '<script src="js/en.js"></script>';
echo '<div class="row">';
echo ' <div id="blocklyDiv" style="height: 480px;" class="col-lg"></div>';

//A grafikus felületet blockly segítsével oldottam meg

echo '<xml xmlns="https://developers.google.com/blockly/xml" id="toolbox" style="display: block">';
$sql="select * from blocks";
$res=e_sql($sql,GET_ASSOC);
/*
echo '
<category name="Logic" colour="%{BKY_LOGIC_HUE}">
      <block type="controls_if"></block>
      <block type="logic_compare"></block>
      <block type="logic_operation"></block>
      <block type="logic_negate"></block>
      <block type="logic_boolean"></block>
    </category>
    <category name="Loops" colour="%{BKY_LOOPS_HUE}">
      <block type="controls_repeat_ext">
        <value name="TIMES">
          <block type="math_number">
            <field name="NUM">10</field>
          </block>
        </value>
      </block>
      <block type="controls_whileUntil"></block>
    </category>
    <category name="Math" colour="%{BKY_MATH_HUE}">
      <block type="math_number">
        <field name="NUM">123</field>
      </block>
      <block type="math_arithmetic"></block>
      <block type="math_single"></block>
    </category>
    <category name="Text" colour="%{BKY_TEXTS_HUE}">
      <block type="text"></block>
      <block type="text_length"></block>
      <block type="text_print"></block>
    </category>
  </xml>

';*/
echo "<category name=\"Logic & Arithmetic\" colour=\"%{BKY_LOGIC_HUE}\">";
foreach ($res as $re) 
{
if(empty($re["bl_pr_text"])) echo "<block type='{$re["bl_pr_id"]}'></block>";
else  
echo "<block type='{$re["bl_pr_id"]}'>{$re["bl_pr_text"]}</block>";
}
echo "</category>";
$sql="select * from rfid_cards where user_id='{$_SESSION["user"]["user_id"]}'";
$res=e_sql($sql,GET_ASSOC);
echo "<category name=\"Device tags\" colour=\"%{BKY_MATH_HUE}\">";
foreach ($res as $re) 
{
echo "<block type=\"text\">{$re["rfid-code"]}</block>";
}
echo "</category>";

$sql = "select * from rfid_cards where room_id='{$_GET["room_id"]}'";
$res=e_sql($sql,GET_ASSOC);
echo "<category name=\"RFID tags\" colour=\"%{BKY_TEXTS_HUE}\">";
foreach ($res as $re) 
{
echo "<block type=\"text\">{$re["rfid-code"]}</block>";
}
echo "</category>";
echo "<category name=\"Variables\" custom=\"VARIABLE\" colour=\"%{BKY_VARIABLES_HUE}\">";

echo "</category>";
echo "<category name=\"Functions\" custom=\"PROCEDURE\" colour=\"%{BKY_PROCEDURES_HUE}\">";

echo "</category>";
echo '</xml>';
echo  '<xml xmlns="https://developers.google.com/blockly/xml" id="startBlocks" style="display: none">';
echo '</xml>';

echo '<script>
    var programmingWorkspace = Blockly.inject("blocklyDiv",
        {media: "media/",
         toolbox: document.getElementById("toolbox")});
    Blockly.Xml.domToWorkspace(document.getElementById("startBlocks"),programmingWorkspace);
  </script>';
echo '</div>';

echo '<div class="row">
<form method="post" action="#" id="f-submit">
<input type="hidden" name="program" id="program_block">
<input type="submit" class="btn btn-primary" >
</form>
<script>
function a(l)
{
    return document.getElementById(l);
}

</script>
</div>';

