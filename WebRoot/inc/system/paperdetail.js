	
	//创建分页类
	var pager = new Pagination("listnav");
	var qs = new queryStr();
	
	
	//查询参数
	var s_dbid = '';
	var s_qtype = '';
	var s_keywords = '';
	
	
	//调整浮动框
	$(this).scroll(function(){ 
	    $("#div_question_list").css("top",$(this).scrollTop()+100); 
	});
	
	
	//页面加载
	$(function(){
		
		//调整控件大小
		$("#s_dbid").attr("style","width:100px");
		$("#s_qtype").attr("style","width:100px");
		$("#s_keywords").attr("style","width:80px");
		
		//章节缩放
		var htm = '<span style="float:right;font-family:Webdings">0</span> ';
		$(".section_th").append(htm);
		$(".section_th").attr("style","cursor:hand");
		$(".section_th").attr("title","点击缩放");
		$(".section_th").click(function(){
			$(this).parent().parent().children("tr").not(":first").toggle('fast');
			$(this).children("span").eq(1).html("0"==$(this).children("span").eq(1).html()?"1":"0");
		});
		
		
		//展示第一页
		list(1);
		
		//移除试题详情
		$(".body").children().not("#div_question_list").mousemove(function(){
			$("#question_detail").hide();
		});
		
		$(".body").children().not("#question_detail_left").mousemove(function(){
			$("#question_detail_left").hide();
		});
		
	});
	
	
	
	
	//设置查询参数
	function setParams(){
		s_dbid = $("#s_dbid").val();
		s_qtype = $("#s_qtype").val();
		s_keywords = $("#s_keywords").val();
//		alert(s_dbid + "," + s_qtype + "," + s_keywords);
	}
	
	
	
	
	//分页显示数据
	function list(page){
		$("#questionlist").html(" ");
		$.getJSON("ajax.do?action=getQuestions", {pagesize:"10",epage:page,s_dbid:s_dbid,s_qtype:s_qtype,s_keywords:s_keywords,t:rnd()}, function(data){
			$("#questionlist").empty();
			$("#questionlist").append('<tr><th width="30">编号</th><th width="30">类型</th><th>题干</th><th>操作</th></tr>');
			$(data.datalist).each(function(i){
				var content = this.CONTENT;
				if(content!=null && content.length>25) content = content.substring(0,20) + "..";
				
				var html = "";
				html += '<tr class="tr_of_question">';
				html += '<td>'+this.ID+'</td>';
				html += '<td>'+qTypeName(this.QTYPE)+'</td>';
				html += '<td>'+content+'</td>';
				html += '<td>';
				html += '<a href="javascript:;" onclick="addQuestion('+this.ID+',this,'+this.QTYPE+')" title="添加到试卷"><img src="skins/images/ico_add.png" border="0" align="absmiddle" /></a> ';
				html += '</td>';
				html += '</tr>';
				
				$("#questionlist").append(html);
			});
			
			var totalrows = parseInt(data.info[0].totalrows);
			var perpage = parseInt(data.info[0].perpage);
			var current_page = parseInt(data.info[0].nowpage);
			var total_pages = parseInt(data.info[0].totalpages);
				
			pager.setStep(1);
			pager.setTotalNum(totalrows);
			pager.setMaxNum(perpage);
			pager.setIndexPage(current_page);
			pager.initPage("pager");
			
			
			//绑定试题详情事件
			$(".tr_of_question").mouseover(function(ev){
				var qid = $(this).children("td:first-child").html();
				$(this).attr("style","background:#eee");
				var offset = $(this).offset();
				var the_top = offset.top + 28;
				$("#question_detail").attr("style","left:600px");
				$("#question_detail").attr("style","top:"+the_top+"px");
				$("#question_detail").fadeIn("fast");
				viewQuestion("question_detail", qid);
			});
			
			$(".tr_of_question").mouseout(function(){
				$(this).attr("style","background:#ffffff");
			});
			
		});
	}
	
	
	function pagination_data() {
		list(pager.getIndexPage());
	}
	
	
	//添加试题
	function addQuestion(qid,obj,qtype){
		var objcon = obj.parentNode.previousSibling;
		questioncontent = objcon.innerHTML;
		$.prompt(addQuestionConfirm(qid,qtype),{callback:addQuestionCallback,buttons: { ok: 'true', cancel: 'false' }});
	}
	
	
	//添加试题-确认
	function addQuestionConfirm(qid,qtype){
		
		if(null==SECTION_LIST.length || SECTION_LIST.length<1){
			return("请选创建章节。");
		}
		
		var html = '';
		var sections = '<select name="sectionid" id="sectionid">';
		$(SECTION_LIST).each(function(){
			sections += '<option value="'+this.ID+'">'+this.SECTION_NAME+'</option>';
		});
		sections += "</select>";
		
		html += '请选择需要添加到的章节？<br/>';
		html += '目标章节：' + sections + '<br/>';
		html += '本题分值：<input type="text" class="txtfree" name="cqscore" id="cqscore" value="0" size="5" style="margin-top:5px" /> 分<br/>';
		
		html += '<input type="hidden" name="cqid" id="cqid" value="'+qid+'" />';
	
		return html;
	}	
	
	
	//添加试卷回调方法
	function addQuestionCallback(v,m,f){
		
		var qid = f.cqid;
		var sid = f.sectionid;
		var score = f.cqscore;
		
		if(true==v || "true"==v){
			if(document.getElementById("QUESTION_"+qid)){
				alert("试卷中已存在试题");
				return;
				
			}else{
				var html = '';
				
				html += '<tr id="QUESTION_'+qid+'">';
				html += ' <td>';
				html += ' 编号：['+qid+'] &nbsp; ';
				html += ' 分值：<input type="text" class="validate[required,custom[onlyNumber]] txtfree" size="2" value="'+score+'" name="qscore" />&nbsp;';
				html += ' <a href="javascript:;" onclick="removeQuestion(\''+qid+'\');"><u>移除</u></a> |';
				html += ' <a href="javascript:;" onclick="moveQuestion(\''+qid+'\',\'up\');"><u>上移</u></a> |';
				html += ' <a href="javascript:;" onclick="moveQuestion(\''+qid+'\',\'down\');"><u>下移</u></a> |';
				html += ' <a href="javascript:;" onmouseover="viewQuestionLeft('+qid+',this)" onclick="viewQuestionLeft('+qid+',this)"><u>详情</u></a>';
				html += ' <br/>';
				html += '' + questioncontent;
				html += ' <input type="hidden" value="'+sid+'" name="sid" />';
				html += ' <input type="hidden" value="'+qid+'" name="qid" />';
				html += '';
				html += ' </td>';
				html += '</tr>';
				
				$("#SECTION_"+sid).append(html);
			}
		}
	}
	
	
	//删除当前试题
	function removeQuestion(qid){
		if(window.confirm('确定要删除吗?')){
			$('#QUESTION_'+qid).remove()
		}
	}
	
	
	//移动问题
	function moveQuestion(qid,to){
		if("up"==to){
			var now_tr = $("#QUESTION_"+qid);
			var up_tr = now_tr.prev();
			
			var tr_th = up_tr.children("th");
			if(tr_th.html()!=null){//上一行是th，不能移上去
				return;	
			}
			if(up_tr.html()==null){
				return;	
			}
			now_tr.insertBefore(up_tr);
			
		}else if("down"==to){
			var now_tr = $("#QUESTION_"+qid);
			var down_tr = now_tr.next();
			if(down_tr.html()==null){
				return;	
			}
			now_tr.insertAfter(down_tr);
			
		}
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
					//html += '[BlankArea' + this.ID + ']：' + this.VAL + '<br/>';
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
	
	
	
	//左侧试卷查看试题详情
	function viewQuestionLeft(qid,obj){
		var offset = $(obj).parent().offset();
		var the_top = offset.top;
		
		$("#question_detail_left").attr("style","top:" + the_top + "px");
		$("#question_detail_left").show();
		$("#question_detail_left").html("...........");
		viewQuestion("question_detail_left",qid);
	}
	
	
	
	
	
	
