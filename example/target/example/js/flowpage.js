var flowId;

//用户管理页面上点击删除按钮弹出删除框(userlist.jsp)
function deleteFlow(){
	$.ajax({
		type:"GET",
		url:"/deleteFlow",
		data:{"flowId":flowId},
		success:function(data){
			if(data == "true"){//删除成功：移除删除行
				cancelBtn();
                location.reload();
			}else if(data == "false"){//删除失败
				//alert("对不起，删除用户【"+obj.attr("username")+"】失败");
				changeDLGContent("对不起，删除流表项【"+flowId+"】失败");
			}else if(data == "notexist"){
				//alert("对不起，用户【"+obj.attr("username")+"】不存在");
				changeDLGContent("对不起，流表项【"+flowId+"】不存在");
			}
		},
		error:function(data){
			//alert("对不起，删除失败");
			changeDLGContent("对不起，删除失败");
		}
	});
}

function openYesOrNoDLG(){
	$('.zhezhao').css('display', 'block');
	$('#removeFlow').fadeIn();
}

function cancelBtn(){
	$('.zhezhao').css('display', 'none');
	$('#removeFlow').fadeOut();
}
function changeDLGContent(contentStr){
	var p = $(".removeMain").find("p");
	p.html(contentStr);
}

function f(fId) {
    flowId = fId;
    changeDLGContent("你确定要删除流表项【"+flowId+"】吗？");
    openYesOrNoDLG();
}