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
/*
echo '<script>
    var programmingWorkspace = Blockly.inject("blocklyDiv",
        {media: "media/",
         toolbox: document.getElementById("toolbox")});
    Blockly.Xml.domToWorkspace(document.getElementById("startBlocks"),programmingWorkspace);
  </script>';*/
echo '</div>';

echo '<div class="row">
<form method="post" action="#" id="f-submit">
<input type="hidden" name="program" id="program_block">
<input type="submit" class="btn btn-primary" value="Save">
</form>
<input type="button" id="stepButton" />
<script>
function a(l)
{
    return document.getElementById(l);
}
a("f-submit").onsubmit=(e)=>
{
    e.preventDefault();
}

var demoWorkspace = Blockly.inject("blocklyDiv",
        {media: "media/",
         toolbox: document.getElementById("toolbox")});
    Blockly.Xml.domToWorkspace(document.getElementById("startBlocks"),
        demoWorkspace);

    var outputArea = document.getElementById("output");
    var stepButton = document.getElementById("stepButton");
    var myInterpreter = null;

    function initApi(interpreter, globalObject) {
        // Add an API function for the alert() block, generated for "text_print" blocks.
        interpreter.setProperty(globalObject, "alert",
            interpreter.createNativeFunction(function(text) {
                text = arguments.length ? text : "";
                outputArea.value += "\n" + text;
            }));

        // Add an API function for the prompt() block.
        var wrapper = function(text) {
            return interpreter.createPrimitive(prompt(text));
        };
        interpreter.setProperty(globalObject, "prompt",
            interpreter.createNativeFunction(wrapper));

        // Add an API function for highlighting blocks.
        var wrapper = function(id) {
            id = String(id || "");
            return interpreter.createPrimitive(highlightBlock(id));
        };
        interpreter.setProperty(globalObject, "highlightBlock",
            interpreter.createNativeFunction(wrapper));
    }

    var highlightPause = false;
    var latestCode = "";

    function highlightBlock(id) {
        demoWorkspace.highlightBlock(id);
        highlightPause = true;
    }

    function resetStepUi(clearOutput) {
        demoWorkspace.highlightBlock(null);
        highlightPause = false;

        if (clearOutput) {
            outputArea.value = "Program output:\n=================";
        }
    }

    function generateCodeAndLoadIntoInterpreter() {
        // Generate JavaScript code and parse it.
        Blockly.JavaScript.STATEMENT_PREFIX = "highlightBlock(%1);\n";
        Blockly.JavaScript.addReservedWords("highlightBlock");
        latestCode = Blockly.JavaScript.workspaceToCode(demoWorkspace);
        resetStepUi(true);
    }

    function stepCode() {
        if (!myInterpreter) {
            // First statement of this code.
            // Clear the program output.
            resetStepUi(true);
            myInterpreter = new Interpreter(latestCode, initApi);

            // And then show generated code in an alert.
            // In a timeout to allow the outputArea.value to reset first.
            setTimeout(function() {
                alert("Ready to execute the following code\n" +
                    "===================================\n" + latestCode);
                highlightPause = true;
                stepCode();
            }, 1);
            return;
        }
        highlightPause = false;
        do {
            try {
                var hasMoreCode = myInterpreter.step();
            } finally {
                if (!hasMoreCode) {
                    // Program complete, no more code to execute.
                    outputArea.value += "\n\n<< Program complete >>";

                    myInterpreter = null;
                    resetStepUi(false);

                    // Cool down, to discourage accidentally restarting the program.
                    stepButton.disabled = "disabled";
                    setTimeout(function() {
                        stepButton.disabled = "";
                    }, 2000);

                    return;
                }
            }
            // Keep executing until a highlight statement is reached,
            // or the code completes or errors.
        } while (hasMoreCode && !highlightPause);
    }

    // Load the interpreter now, and upon future changes.
    generateCodeAndLoadIntoInterpreter();
    demoWorkspace.addChangeListener(function(event) {
        if (!event.isUiEvent) {
            // Something changed. Parser needs to be reloaded.
            generateCodeAndLoadIntoInterpreter();
        }
    });
 


</script>
</div>';

