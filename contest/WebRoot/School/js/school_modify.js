$(function () {
	$.ajax({
		url : "School/" + $("#school_schoolId_edit").val() + "/update",
		type : "get",
		data : {
			//schoolId : $("#school_schoolId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (school, response, status) {
			$.messager.progress("close");
			if (school) { 
				$("#school_schoolId_edit").val(school.schoolId);
				$("#school_schoolId_edit").validatebox({
					required : true,
					missingMessage : "请输入学校id",
					editable: false
				});
				$("#school_schoolName_edit").val(school.schoolName);
				$("#school_schoolName_edit").validatebox({
					required : true,
					missingMessage : "请输入学校名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#schoolModifyButton").click(function(){ 
		if ($("#schoolEditForm").form("validate")) {
			$("#schoolEditForm").form({
			    url:"School/" +  $("#school_schoolId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#schoolEditForm").form("validate"))  {
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
			$("#schoolEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
