$(function () {
	$("#score_contestObj_contestId").combobox({
	    url:'Contest/listAll',
	    valueField: "contestId",
	    textField: "contestName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#score_contestObj_contestId").combobox("getData"); 
            if (data.length > 0) {
                $("#score_contestObj_contestId").combobox("select", data[0].contestId);
            }
        }
	});
	$("#score_studentObj_user_name").combobox({
	    url:'Student/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#score_studentObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#score_studentObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#score_contentRound").validatebox({
		required : true, 
		missingMessage : '请输入比赛轮次',
	});

	$("#score_scoreValue").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入比赛积分',
		invalidMessage : '比赛积分输入不对',
	});

	//单击添加按钮
	$("#scoreAddButton").click(function () {
		//验证表单 
		if(!$("#scoreAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#scoreAddForm").form({
			    url:"Score/add",
			    onSubmit: function(){
					if($("#scoreAddForm").form("validate"))  { 
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
                        $("#scoreAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#scoreAddForm").submit();
		}
	});

	//单击清空按钮
	$("#scoreClearButton").click(function () { 
		$("#scoreAddForm").form("clear"); 
	});
});
