$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('contest_contestDesc');
	var contest_contestDesc_editor = UE.getEditor('contest_contestDesc'); //比赛介绍编辑框
	$("#contest_schoolObj_schoolId").combobox({
	    url:'School/listAll',
	    valueField: "schoolId",
	    textField: "schoolName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#contest_schoolObj_schoolId").combobox("getData"); 
            if (data.length > 0) {
                $("#contest_schoolObj_schoolId").combobox("select", data[0].schoolId);
            }
        }
	});
	$("#contest_projectObj_projectId").combobox({
	    url:'Project/listAll',
	    valueField: "projectId",
	    textField: "projectName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#contest_projectObj_projectId").combobox("getData"); 
            if (data.length > 0) {
                $("#contest_projectObj_projectId").combobox("select", data[0].projectId);
            }
        }
	});
	$("#contest_contestName").validatebox({
		required : true, 
		missingMessage : '请输入比赛名称',
	});

	$("#contest_contestPlace").validatebox({
		required : true, 
		missingMessage : '请输入比赛地点',
	});

	$("#contest_personNumber").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入人数限制',
		invalidMessage : '人数限制输入不对',
	});

	$("#contest_signUpTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#contest_endTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#contestAddButton").click(function () {
		if(contest_contestDesc_editor.getContent() == "") {
			alert("请输入比赛介绍");
			return;
		}
		//验证表单 
		if(!$("#contestAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#contestAddForm").form({
			    url:"Contest/add",
			    onSubmit: function(){
					if($("#contestAddForm").form("validate"))  { 
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
                        $("#contestAddForm").form("clear");
                        contest_contestDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#contestAddForm").submit();
		}
	});

	//单击清空按钮
	$("#contestClearButton").click(function () { 
		$("#contestAddForm").form("clear"); 
	});
});
