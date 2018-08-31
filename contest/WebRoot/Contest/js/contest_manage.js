var contest_manage_tool = null; 
$(function () { 
	initContestManageTool(); //建立Contest管理对象
	contest_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#contest_manage").datagrid({
		url : 'Contest/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "contestId",
		sortOrder : "desc",
		toolbar : "#contest_manage_tool",
		columns : [[
			{
				field : "contestId",
				title : "比赛id",
				width : 70,
			},
			{
				field : "schoolObj",
				title : "举办学校",
				width : 140,
			},
			{
				field : "projectObj",
				title : "比赛项目",
				width : 140,
			},
			{
				field : "contestName",
				title : "比赛名称",
				width : 140,
			},
			{
				field : "contestPlace",
				title : "比赛地点",
				width : 140,
			},
			{
				field : "personNumber",
				title : "人数限制",
				width : 70,
			},
			{
				field : "signUpTime",
				title : "报名时间",
				width : 140,
			},
			{
				field : "endTime",
				title : "截止时间",
				width : 140,
			},
		]],
	});

	$("#contestEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#contestEditForm").form("validate")) {
					//验证表单 
					if(!$("#contestEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#contestEditForm").form({
						    url:"Contest/" + $("#contest_contestId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#contestEditDiv").dialog("close");
			                        contest_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#contestEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#contestEditDiv").dialog("close");
				$("#contestEditForm").form("reset"); 
			},
		}],
	});
});

function initContestManageTool() {
	contest_manage_tool = {
		init: function() {
			$.ajax({
				url : "School/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#schoolObj_schoolId_query").combobox({ 
					    valueField:"schoolId",
					    textField:"schoolName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{schoolId:0,schoolName:"不限制"});
					$("#schoolObj_schoolId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Project/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#projectObj_projectId_query").combobox({ 
					    valueField:"projectId",
					    textField:"projectName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{projectId:0,projectName:"不限制"});
					$("#projectObj_projectId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#contest_manage").datagrid("reload");
		},
		redo : function () {
			$("#contest_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#contest_manage").datagrid("options").queryParams;
			queryParams["schoolObj.schoolId"] = $("#schoolObj_schoolId_query").combobox("getValue");
			queryParams["projectObj.projectId"] = $("#projectObj_projectId_query").combobox("getValue");
			queryParams["contestName"] = $("#contestName").val();
			queryParams["signUpTime"] = $("#signUpTime").datebox("getValue"); 
			$("#contest_manage").datagrid("options").queryParams=queryParams; 
			$("#contest_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#contestQueryForm").form({
			    url:"Contest/OutToExcel",
			});
			//提交表单
			$("#contestQueryForm").submit();
		},
		remove : function () {
			var rows = $("#contest_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var contestIds = [];
						for (var i = 0; i < rows.length; i ++) {
							contestIds.push(rows[i].contestId);
						}
						$.ajax({
							type : "POST",
							url : "Contest/deletes",
							data : {
								contestIds : contestIds.join(","),
							},
							beforeSend : function () {
								$("#contest_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#contest_manage").datagrid("loaded");
									$("#contest_manage").datagrid("load");
									$("#contest_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#contest_manage").datagrid("loaded");
									$("#contest_manage").datagrid("load");
									$("#contest_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#contest_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Contest/" + rows[0].contestId +  "/update",
					type : "get",
					data : {
						//contestId : rows[0].contestId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (contest, response, status) {
						$.messager.progress("close");
						if (contest) { 
							$("#contestEditDiv").dialog("open");
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
							contest_contestDesc_editor.setContent(contest.contestDesc, false);
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
