	
	
	function addQc(qid, uid, did){
		$.ajax({
			type: "POST",
			url: "ajax.do?action=addQc",
			data: {qid:qid, uid:uid, did:did ,t:rnd()},
			success: function(msg){
				if("1"==msg || 1==msg){
					$.prompt("添加成功");
				}else{
					$.prompt("<font color='red'><b>添加失败</b>，已经收藏过。</font>");
				}
			}
		}); 
	}
	
	
	function deleteQc(id){
		$.ajax({
			type: "POST",
			url: "ajax.do?action=deleteQc",
			data: {id:id, t:rnd()},
			success: function(msg){
				if("1"==msg || 1==msg){
					$.prompt("删除成功");
				}else{
					$.prompt("删除失败");
				}
			}
		}); 
	}
	
	
	
	
	$(function(){
		
		$(".lnkdel").click(function(){
			var id = $(this).attr("id");
			var objp = $(this).parent().parent();
			$.ajax({
				type: "POST",
				url: "ajax.do?action=deleteQc",
				data: {id:id, t:rnd()},
				success: function(msg){
					if("1"==msg || 1==msg){
						alert("删除成功");
						location.reload();
					}else{
						alert("删除失败");
					}
				}
			}); 
		});
		
		
	});
	
	
	
	