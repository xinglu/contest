$(function () {
	$.ajax({
		url : "Project/" + $("#project_projectId_edit").val() + "/update",
		type : "get",
		data : {
			//projectId : $("#project_projectId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (project, response, status) {
			$.messager.progress("close");
			if (project) { 
				$("#project_projectId_edit").val(project.projectId);
				$("#project_projectId_edit").validatebox({
					required : true,
					missingMessage : "请输入项目id",
					editable: false
				});
				$("#project_projectName_edit").val(project.projectName);
				$("#project_projectName_edit").validatebox({
					required : true,
					missingMessage : "请输入项目名称",
				});
				$("#project_projectDesc_edit").val(project.projectDesc);
				$("#project_projectDesc_edit").validatebox({
					required : true,
					missingMessage : "请输入项目介绍",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#projectModifyButton").click(function(){ 
		if ($("#projectEditForm").form("validate")) {
			$("#projectEditForm").form({
			    url:"Project/" +  $("#project_projectId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#projectEditForm").form("validate"))  {
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
			$("#projectEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
