$(function () {
	$.ajax({
		url : "Score/" + $("#score_scoreId_edit").val() + "/update",
		type : "get",
		data : {
			//scoreId : $("#score_scoreId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (score, response, status) {
			$.messager.progress("close");
			if (score) { 
				$("#score_scoreId_edit").val(score.scoreId);
				$("#score_scoreId_edit").validatebox({
					required : true,
					missingMessage : "请输入成绩id",
					editable: false
				});
				$("#score_contestObj_contestId_edit").combobox({
					url:"Contest/listAll",
					valueField:"contestId",
					textField:"contestName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#score_contestObj_contestId_edit").combobox("select", score.contestObjPri);
						//var data = $("#score_contestObj_contestId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#score_contestObj_contestId_edit").combobox("select", data[0].contestId);
						//}
					}
				});
				$("#score_studentObj_user_name_edit").combobox({
					url:"Student/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#score_studentObj_user_name_edit").combobox("select", score.studentObjPri);
						//var data = $("#score_studentObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#score_studentObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#score_contentRound_edit").val(score.contentRound);
				$("#score_contentRound_edit").validatebox({
					required : true,
					missingMessage : "请输入比赛轮次",
				});
				$("#score_scoreValue_edit").val(score.scoreValue);
				$("#score_scoreValue_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入比赛积分",
					invalidMessage : "比赛积分输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#scoreModifyButton").click(function(){ 
		if ($("#scoreEditForm").form("validate")) {
			$("#scoreEditForm").form({
			    url:"Score/" +  $("#score_scoreId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#scoreEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#scoreEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
