$(function () {
	$("#student_user_name").validatebox({
		required : true, 
		missingMessage : '请输入用户名',
	});

	$("#student_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#student_contest_contestId").combobox({
	    url:'Contest/listAll',
	    valueField: "contestId",
	    textField: "contestName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#student_contest_contestId").combobox("getData"); 
            if (data.length > 0) {
                $("#student_contest_contestId").combobox("select", data[0].contestId);
            }
        }
	});
	$("#student_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#student_gender").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#student_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#student_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#student_signUpTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#studentAddButton").click(function () {
		//验证表单 
		if(!$("#studentAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#studentAddForm").form({
			    url:"Student/add",
			    onSubmit: function(){
					if($("#studentAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#studentAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#studentAddForm").submit();
		}
	});

	//单击清空按钮
	$("#studentClearButton").click(function () { 
		$("#studentAddForm").form("clear"); 
	});
});
