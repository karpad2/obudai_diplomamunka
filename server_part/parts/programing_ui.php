
<script src="https://cdnjs.cloudflare.com/ajax/libs/blockly/4.20201217.0/blockly.min.js"></script>

<?php
echo ' <div id="blocklyDiv" style="height: 480px; width: 600px;"></div>';

//A grafikus felületet blockly segítsével oldottam meg

echo '<xml xmlns="https://developers.google.com/blockly/xml" id="toolbox" style="display: none">';

  /*  <block type="controls_if"></block>
    <block type="logic_compare"></block>
    <block type="controls_repeat_ext"></block>
    <block type="math_number">
      <field name="NUM">123</field>
    </block>
    <block type="math_arithmetic"></block>
    <block type="text"></block>
    <block type="text_print"></block>*/
 echo '</xml>';

echo '<script>
    var programmingWorkspace = Blockly.inject("blocklyDiv",
        {media: "parts/media/",
         toolbox: document.getElementById("toolbox")});
  </script>';

?>
//Blockly documentation https://developers.google.com/blockly/guides/create-custom-blocks/define-blocks#json
/*
Blockly.Blocks['string_length'] = {
init: function() {
this.appendValueInput('VALUE')
.setCheck('String')
.appendField('length of');
this.setOutput(true, 'Number');
this.setColour(160);
this.setTooltip('Returns number of letters in the provided text.');
this.setHelpUrl('http://www.w3schools.com/jsref/jsref_length_string.asp');
}
};
*/