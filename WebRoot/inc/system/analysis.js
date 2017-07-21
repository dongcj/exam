
addrow = function(){
	var html = '';
	html += '<tr>';
	html += '  <td>';
	html += '  从(≥) <input type="text" class="validate[required,custom[onlyNumber]] txtfree" name="tfrom" size="5" /> 分 &nbsp;';
	html += '  到(<) <input type="text" class="validate[required,custom[onlyNumber]] txtfree" name="tto" size="5" /> 分';
	html += '  <a href="javascript:;" onclick="delrow(this)"><img src="skins/images/ico_del.png" align="absmiddle" border="0" /></a>';
	html += ' </td>';
	html += '</tr>';
	html += '';
	$("#table_condition").append(html);
}


delrow = function(obj){
	$(obj).parent().parent().remove();
}


$(function(){
	var qs = new queryStr();
	if(qs.action=="kaoshi_detail"){
		
		$(".qoptions").hide();
		
		
	}
});


