
	$(function(){
		
		//进行中的考试
		$.getJSON("ajax.do?action=currentExam", {t:rnd()}, function(data){
			$(data.datalist).each(function(i){
				var html = "";
				html += "<li>";
				html += "<b>考试名称</b>：" + "<a href=\"user/paper.do?action=list\">" + this.PAPER_NAME+ "</a>";
				html += "&nbsp; &nbsp; ";
				html += "<font style=\"font-size:16px;font-weight:bold\">" + this.PAPER_MINUTE + "</font>分钟 ";
				html += "<font style=\"font-size:16px;font-weight:bold\">" + this.TOTAL_SCORE + "</font>分";
				html += "&nbsp; &nbsp; <br/>";
				html += "<font style=\"color:#aaa\"><b>从</b>：" + this.STARTTIME;
				html += "&nbsp;";
				html += "<b>到</b>：" + this.ENDTIME;
				html += "</font>";
				html += "</li>";
				
				$("#ul_currentexam").append(html);
			});
		});
		
		
		//新闻列表
		$.getJSON("ajax.do?action=newsList", {t:rnd()}, function(data){
			$(data.datalist).each(function(i){
				var html = "";
				html += "<li>";
				html += "<a href=\"page.do?action=comm_news&act=readthread&id="+this.ID+"\">"+this.TITLE;
				html += "";
				html += "";
				html += "</a>";
				html += "&nbsp; <font style=\"color:#ccc\"><i>"+this.PDATE+"</i></font>";
				html += "</li>";
				$("#welcome_newslist").append(html);
			});
		});
		
		
		
	});