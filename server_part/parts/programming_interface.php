<?php //TODO 1 more cell to xml dom, and save that too, xml for visual javascript for running
include ("blocks.php");

if(empty($_SESSION["user"]["user_id"])) die("err 403");
if(isset($_GET["program_id"])) {
    if($_GET["program_id"]!="new") {

        $sql = "select * from programs where program_id='{$_GET["room_id"]}'";
        $devs = e_sql($sql, GET_ASSOC);
    }
    else
    {
        if(isset($_POST["program_name"]) and isset($_POST["program_xml_block"]) and isset($_POST["program_javascript_block"]))
        {
            $sql="insert into programs (program_name,user_id,room_id,active,program_xml_block,program_javascript_block)".
            "values('{$_POST["program_name"]}','{$_SESSION["user"]["user_id"]}','{$_GET["room_id"]}','1','{$_POST["program_xml_block"]}','{$_POST["program_javascript_block"]}')";
        }

    }
}

if(isset($_GET["room_id"])) {
    $sql = "select * from devices where room_id='{$_GET["room_id"]}'";
    $devs = e_sql($sql, GET_ASSOC);
}

echo '<script src="js/blockly_compressed.js"></script>';
echo '<script src="js/blocks_compressed.js"></script>';
echo '<script src="js/javascript_compressed.js"></script>';
echo '<script src="js/en.js"></script>';
echo '<form method="post" action="#" id="f-submit">';
echo '<div class="row">';

echo '<label for="program_name">Program name:</label> <input type="text" name="program_name" class="form-control" id="program_name"/>';
echo ' <div id="blocklyDiv" style="height: 480px;" class="col-lg"></div>';
//echo '<input name="program_id" type="hidden" value=".."/>';
//A grafikus felületet blockly segítsével oldottam meg

echo '<xml xmlns="https://developers.google.com/blockly/xml" id="toolbox" style="display: block">';
$sql="select * from blocks";
$res=e_sql($sql,GET_ASSOC);

echo "<category name=\"Logic & Arithmetic\" colour=\"%{BKY_LOGIC_HUE}\">";
foreach ($res as $re) 
{
if(empty($re["bl_pr_text"])) echo "<block type='{$re["bl_pr_id"]}'></block>";
else  
echo "<block type='{$re["bl_pr_id"]}'>{$re["bl_pr_text"]}</block>";
}
echo "</category>";
$sql="select * from devices where user_id='{$_SESSION["user"]["user_id"]}'";
$res=e_sql($sql,GET_ASSOC);
echo "<category name=\"Device tags\" colour=\"%{BKY_MATH_HUE}\">";
foreach ($res as $re) 
{
echo "<block type=\"text\">{$re["device_name"]}</block>";
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
    if(isset($devs["program_xml_block"])) echo $devs["program_xml_block"];
echo '</xml>';
/*
echo '<script>
    var programmingWorkspace = Blockly.inject("blocklyDiv",
        {media: "media/",
         toolbox: document.getElementById("toolbox")});
    Blockly.Xml.domToWorkspace(document.getElementById("startBlocks"),programmingWorkspace);
  </script>';*/
//echo '</div>';

echo '<div class="row">

<input type="hidden" name="program_js_block" id="program_js_block">
<input type="hidden" name="program_xml_block" id="program_xml_block">
<input type="submit" class="btn btn-primary" value="Save">
';
//<input type="button" id="generate" value="generate" />';
echo '
<script>
function a(l)
{
    return document.getElementById(l);
}
a("f-submit").onsubmit=(e)=>
{
    var code = Blockly.JavaScript.workspaceToCode(Workspace);
    a("program_js_block").value=code;
    var xmldowm = Blockly.Xml.workspaceToDom(Workspace);
    var xmltext = Blockly.Xml.domToPrettyText(xmldowm);
    a("program_xml_block").value=xmltext;
    alert(xmltext);
    e.preventDefault();
}

var Workspace = Blockly.inject("blocklyDiv",
        {media: "media/",
         toolbox: document.getElementById("toolbox")});
    Blockly.Xml.domToWorkspace(a("startBlocks"),Workspace);
    Blockly.JavaScript.addReservedWords("code");
     
    var code = Blockly.JavaScript.workspaceToCode(Workspace);
   /* a("generate").onclick=()=>
    {
       var code = Blockly.JavaScript.workspaceToCode(Workspace);
     
    }*/
</script>
</div> </form>';


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

