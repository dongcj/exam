
	$(function(){
		$(".qks").each(function(){
			var _qid = $(this).attr("qid");
			var _did = $(this).attr("did");
			$(this).append('<br/><a href="javascript:;" style="color:#aaa" onclick="javascript:addQc('+_qid+','+uid+','+_did+')">收藏该题</a>');
		});
			
	});
	