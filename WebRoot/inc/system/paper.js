
var myDate = new Date();
var month = myDate.getMonth() + 1;
var smonth = ""+month;
if(month<10) smonth = "0" + month;

var sdate = "" + myDate.getFullYear() + "/" + smonth + "/" + myDate.getDate() + " 12:00";


$(function(){
	
	var qs = new queryStr();
	if(qs.action=="load"){
		
		//绘制表单
		$("select[name=status]").val(_status);
		$("input[name=starttime]").val(_starttime);
		$("input[name=endtime]").val(_endtime);
		$("input[name=paper_minute]").val(_paper_minute);
		$("input[name=show_score]").val(_show_score);
		$("input[name=qorder]").val(_qorder.split(""));
		$("input[name=groupids]").val(_usergroupids.split("#"));
		
		$(this).mousemove(function(){
			//count_paper_minute();
		});
		
	}else if(qs.action=="add" || qs.action=="addrand"){//加载_与随机试卷设置
		
		$("#starttime").val(sdate);
		$("#endtime").val(sdate);
		
		$(this).mousemove(function(){
			//count_paper_minute();
		});

	}
	
});





//计算考试时间
count_paper_minute = function(){
	var startDate= new Date($("#starttime").val()); 
	var endDate= new Date($("#endtime").val()); 
	var df=(endDate.getTime()-startDate.getTime());

	var int_hours = Math.floor(df/60000);
	$("#paper_minute").val(int_hours);
	
}










