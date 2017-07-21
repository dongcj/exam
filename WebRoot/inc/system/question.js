
//填空题，空格计数器
var TOTAL_BLANKS = 0;

$(function(){
	
	var qs = new queryStr();
	if(qs.action=="load"){
		rebuild_key_setting($("#qtype1").val());
		$("#qtype1").attr("disabled","disabled");
	}else if(qs.action=="add"){
		xuan_init(1);
	}else if(qs.action=="list"){
		$(".qestr").mouseover(function(ev){
			$(this).attr("style","background:#F9F9F9");
			var offset = $(this).children("td:eq(3)").offset();
			var the_top = offset.top + 28;
			var the_left = offset.left;
			var qid = $(this).children("td:eq(0)").html();
			$("#question_detail").attr("style","top:"+the_top+"px;left:"+the_left+"px");
			$("#question_detail").show();
			viewQuestion("question_detail", qid);
		});
		
		$(".qestr").mouseout(function(){
			$(this).attr("style","background:#ffffff");
		});
		
		$(".qestr").parent().mouseout(function(){
			$("#question_detail").hide();
		});
	}
	
	
	//捕获题型选择事件
	if(document.getElementById("qtype")){
		$("#qtype").change(function(){
		
			var qtype = $(this).val();
			//清空当前的选项
			$("#key_setting").empty();
			$("#btn_xuan_addrow").hide();
			
			TOTAL_BLANKS = 0;
			
			//选择题
			if(1==qtype || 2==qtype){
				xuan_init(qtype);
			}else if(3==qtype){
				panduan();
			}else if(4==qtype){
				tiankong();
			}else if(5==qtype){
				wenda();
			}
			
		});
	}
	
	
	
	
	
});


//选择题初始化4个选项
xuan_init = function(qtype){
	$("#btn_xuan_addrow").show();
	var options = ['A','B','C','D'];
	$("#key_setting").append('<table class="stable" width="455" align="left" id="key_setting_table">');
	$(options).each(function(i){
		var html = '<tr>';
		html += '<td>选项' + this + '</td>';
		if(1==qtype){
			html += '<td><input type="radio" class="validate[required]" name="skey" value="'+this+'" /></td>';
		}else if(2==qtype){
			html += '<td><input type="checkbox" class="validate[required,minCheckbox[4]]" name="skey" value="'+this+'" /></td>';
		}
		
		var aremove = '<a href="javascript:;" onclick="$(this).parent().parent().remove()">移除</a>';
		html += '<td><textarea rows="2" cols="40" name="soption" class="validate[required]" id="toption_' + this + '"></textarea> '+aremove+'</td>';
		html += '</tr>';
		
		$("#key_setting_table").append(html);
	}); 
	$("#key_setting").append('</table>');
}


//修改时_选择题初始化选项
xuan_init_load = function(qtype){
	$("#btn_xuan_addrow").hide();
	$("#key_setting").append('<table class="stable" width="455" align="left" id="key_setting_table">');
	$(OPTION_LIST).each(function(i){
		var html = '<tr>';
		html += '<td>选项' + this.SALISA + '</td>';
		if(1==qtype){
			html += '<td><input type="radio" class="validate[required]" name="skey" value="'+this.SALISA+'" /></td>';
		}else if(2==qtype){
			html += '<td><input type="checkbox" class="validate[required,minCheckbox[4]]" name="skey" value="'+this.SALISA+'" /></td>';
		}
		
		var aremove = '<a href="javascript:;" onclick="$(this).parent().parent().remove()">移除</a>';
		html += '<td><textarea rows="2" cols="40" name="soption" class="validate[required]" id="toption_' + this.SALISA + '">'+this.SOPTION+'</textarea> '+aremove+'</td>';
		html += '</tr>';
		
		$("#key_setting_table").append(html);
	}); 
	$("#key_setting").append('</table>');
}


//选择题增加选项
xuan_addrow = function(qtype){
	$("#btn_xuan_addrow").show();
	var options = ['A','B','C','D','E','F','G','H'];
	for(var i=0;i<options.length;i=i+1){
		var this_value = options[i];
		if(!document.getElementById("toption_"+this_value)){
			var html = '<tr>';
			html += '<td>选项' + this_value + '</td>';
			if(1==qtype){
				html += '<td><input type="radio" class="validate[required]" name="skey" value="'+this_value+'" /></td>';
			}else if(2==qtype){
				html += '<td><input type="checkbox" class="validate[required,minCheckbox[4]]" name="skey" value="'+this_value+'" /></td>';
			}
			var aremove = '<a href="javascript:;" onclick="$(this).parent().parent().remove()">移除</a>';
			html += '<td><textarea rows="2" cols="40" name="soption" class="validate[required]" id="toption_' + this_value + '"></textarea> '+aremove+'</td>';
			html += '</tr>';
			$("#key_setting_table").append(html);
			break;
		}
	};
}


//判断题
panduan = function(){
	var html = '<table class="stable" width="455" align="left">';
	html += '<tr>';
	html += '<td><b>正确</b> <input type="radio" class="validate[required]" name="skey" value="YES" /> &nbsp;  &nbsp; ';
	html += '<b>错误</b> <input type="radio" class="validate[required]" name="skey" value="NO" /></td>';
	html += '<td>&nbsp;</td><td>&nbsp;</td>';
	html += '</tr></table>';
	$("#key_setting").html(html);
}


//填空题
tiankong = function(){
	var html = '<table class="stable" width="455" align="left">';
	html += '<tr>';
	html += '<td id="TD_BLANKS"></td>';
	html += '</tr>';
	
	html += '<tr>';
	html += '<td><input type="button" class="btn" value="增加填空" onclick="add_Blank();" /> <input type="checkbox" value="yes" name="qcomplex" />混杂模式批改</td>';
	html += '</tr>';
	html += '</table>';
	$("#key_setting").html(html);
}


//问答题
wenda = function(){
	var html = '';
	html += '<textarea name="skey" rows="5" cols="55" style="width:450px"></textarea>';
	$("#key_setting").append(html);
}




//重建答案设置区域
rebuild_key_setting = function(qtype){
	//清空当前的选项
	$("#key_setting").empty();
	$("#btn_xuan_addrow").hide();
	
	var _skey_ = $("#_skey_").val();
	
	//选择题
	if(1==qtype || 2==qtype){
		xuan_init_load(qtype);
		$("input[name=skey]").val(_skey_.split(''));
		
	//判断题
	}else if(3==qtype){
		panduan();
		$("input[name=skey]").val([""+_skey_+""]);
	
	//填空题
	}else if(4==qtype){
		tiankong();
		load_Blank();
		
	//问答题
	}else if(5==qtype){
		wenda();
		$("textarea[name=skey]").val(unescape(_skey_));
	}
	
	
}







/********** 工具函数 ***********/

add_Blank = function(){
	if(TOTAL_BLANKS>7) {
		alert("填空数不能大于8个");
		return;
	}
	
	TOTAL_BLANKS++;
	var ClientID = "content";
	var content = "" + FCKeditorAPI.GetInstance(ClientID).GetXHTML(true);
	
	//判断是否存在即将要插入的BLANK
	var index_of_new_blank = content.indexOf("[BlankArea"+TOTAL_BLANKS+"]");
	while(index_of_new_blank>-1){
		TOTAL_BLANKS++;
		index_of_new_blank = content.indexOf("[BlankArea"+TOTAL_BLANKS+"]");
	}
	
	$("#TD_BLANKS").append('<span>'+TOTAL_BLANKS+'：<input name="skey'+TOTAL_BLANKS+'" type="input" maxlength="30" class="txt" /><a href="javascript:;" mid="'+TOTAL_BLANKS+'">r</a></span>');
	FCKeditorAPI.GetInstance(ClientID).InsertHtml("[BlankArea"+TOTAL_BLANKS+"]");
	
	$("#TD_BLANKS span a").click(function(){
		content = "" + FCKeditorAPI.GetInstance(ClientID).GetXHTML(true);
		$(this).parent().remove();
		var mid = $(this).attr("mid");
		content = content.replace("[BlankArea"+mid+"]","");
		FCKeditorAPI.GetInstance(ClientID).SetHTML(content);
	});
	
}


//加载空格
load_Blank = function(){
	var ClientID = "content";
	
	$(BLANKS).each(function(i){
		if(this.ID != null && this.ID != ""){
			$("#TD_BLANKS").append('<span>'+this.ID+'：<input name="skey'+this.ID+'" value="'+this.VAL+'" type="input" maxlength="30" class="txt" /><a href="javascript:;" mid="'+this.ID+'">r</a></span>');
		}else if(this.QCOMPLEX != null && this.QCOMPLEX == "YES"){
			$("input[name='qcomplex']").attr("checked","checked");
		}
	});
	
	$("#TD_BLANKS span a").click(function(){
		$(this).parent().remove();
		var mid = $(this).attr("mid");
		var content = "" + FCKeditorAPI.GetInstance(ClientID).GetXHTML(true);
		content = content.replace("[BlankArea"+mid+"]","");
		FCKeditorAPI.GetInstance(ClientID).SetHTML(content);
	});
		
}






//查看试题详情
function viewQuestion(obj,qid){
	if(obj==null | ""==obj){
		obj = "question_detail";
	}
	$("#"+obj).html("Loading...."+qid);
	$.getJSON("ajax.do?action=getQuestionInfoById", {id:qid}, function(data){
		var qtype = data.datalist.QTYPE;
		var html = '';
		html += '<div><b>题干：</b>' + data.datalist.CONTENT + '</div>';
		if(qtype=="1" || qtype=="2"){//选择
			html += '<div><b>选项：</b></div>';
			$(data.datalist.OPTIONS).each(function(){
				html += this.SALISA + '：' + this.SOPTION + '<br/>';
			});
			html += '<div><b>答案：</b>' + data.datalist.SKEY + '</div>';
		
		}else if(qtype=="3"){//判断
			html += '<div><b>答案：</b>' + ((data.datalist.SKEY=="YES")?"正确":"错误") + '</div>';
		
		}else if(qtype=="4"){//填空 
			html += '<div><b>答案：</b></div>';
			$(eval(data.datalist.SKEY)).each(function(){
				if(this.ID != null && this.ID != ""){
					html += '[BlankArea' + this.ID + ']：' + this.VAL + '<br/>';
				}else if(this.QCOMPLEX != null && this.QCOMPLEX == "YES"){
					//nothing
				}
				
			});
			
		}else if(qtype=="5"){//问答
			html += '<div><b>答案：</b>' + data.datalist.SKEY + '</div>';
			
		}
		
		html += '';
		$("#"+obj).html(html);
		
	});
	
}







