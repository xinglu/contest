$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('contest_contestDesc_edit');
	var contest_contestDesc_edit = UE.getEditor('contest_contestDesc_edit'); //比赛介绍编辑器
	contest_contestDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Contest/" + $("#contest_contestId_edit").val() + "/update",
		type : "get",
		data : {
			//contestId : $("#contest_contestId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (contest, response, status) {
			$.messager.progress("close");
			if (contest) { 
				$("#contest_contestId_edit").val(contest.contestId);
				$("#contest_contestId_edit").validatebox({
					required : true,
					missingMessage : "请输入比赛id",
					editable: false
				});
				$("#contest_schoolObj_schoolId_edit").combobox({
					url:"School/listAll",
					valueField:"schoolId",
					textField:"schoolName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#contest_schoolObj_schoolId_edit").combobox("select", contest.schoolObjPri);
						//var data = $("#contest_schoolObj_schoolId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#contest_schoolObj_schoolId_edit").combobox("select", data[0].schoolId);
						//}
					}
				});
				$("#contest_projectObj_projectId_edit").combobox({
					url:"Project/listAll",
					valueField:"projectId",
					textField:"projectName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#contest_projectObj_projectId_edit").combobox("select", contest.projectObjPri);
						//var data = $("#contest_projectObj_projectId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#contest_projectObj_projectId_edit").combobox("select", data[0].projectId);
						//}
					}
				});
				$("#contest_contestName_edit").val(contest.contestName);
				$("#contest_contestName_edit").validatebox({
					required : true,
					missingMessage : "请输入比赛名称",
				});
				contest_contestDesc_edit.setContent(contest.contestDesc);
				$("#contest_contestPlace_edit").val(contest.contestPlace);
				$("#contest_contestPlace_edit").validatebox({
					required : true,
					missingMessage : "请输入比赛地点",
				});
				$("#contest_personNumber_edit").val(contest.personNumber);
				$("#contest_personNumber_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入人数限制",
					invalidMessage : "人数限制输入不对",
				});
				$("#contest_signUpTime_edit").datetimebox({
					value: contest.signUpTime,
					required: true,
					showSeconds: true,
				});
				$("#contest_endTime_edit").datetimebox({
					value: contest.endTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#contestModifyButton").click(function(){ 
		if ($("#contestEditForm").form("validate")) {
			$("#contestEditForm").form({
			    url:"Contest/" +  $("#contest_contestId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#contestEditForm").form("validate"))  {
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
			$("#contestEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
