
var myDate = new Date();
var month = myDate.getMonth() + 1;
var smonth = ""+month;
if(month<10) smonth = "0" + month;

var sdate = "" + myDate.getFullYear() + "/" + smonth + "/" + myDate.getDate() + " 12:00";


$(function(){
	
	//计算考试时间
	var qs = new queryStr();
	if(qs.action=="addrand"){
		$("#starttime").val(sdate);
		$("#endtime").val(sdate);
		$(this).mousemove(function(){
			count_paper_minute();
		});
	}
	
	
	
	
	
	
	
});


//新增章节行
add_row = function(obj){
	var tr = $(obj).parent().parent().clone();
	tr.insertAfter($(obj).parent().parent());
}

//移除章节行
del_row = function(obj){
	if($(obj).parent().parent().parent().children("tr").length<4){
		alert("最少保留一行");
	}else{
		$(obj).parent().parent().remove();
	}
}


//计算考试时间
count_paper_minute = function(){
	var startDate= new Date($("#starttime").val()); 
	var endDate= new Date($("#endtime").val()); 
	var df=(endDate.getTime()-startDate.getTime());

	var int_hours = Math.floor(df/60000);
	$("#paper_minute").val(int_hours);
	
}




