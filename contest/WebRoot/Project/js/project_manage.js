var project_manage_tool = null; 
$(function () { 
	initProjectManageTool(); //建立Project管理对象
	project_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#project_manage").datagrid({
		url : 'Project/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "projectId",
		sortOrder : "desc",
		toolbar : "#project_manage_tool",
		columns : [[
			{
				field : "projectId",
				title : "项目id",
				width : 70,
			},
			{
				field : "projectName",
				title : "项目名称",
				width : 140,
			},
			{
				field : "projectDesc",
				title : "项目介绍",
				width : 140,
			},
		]],
	});

	$("#projectEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#projectEditForm").form("validate")) {
					//验证表单 
					if(!$("#projectEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#projectEditForm").form({
						    url:"Project/" + $("#project_projectId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#projectEditDiv").dialog("close");
			                        project_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#projectEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#projectEditDiv").dialog("close");
				$("#projectEditForm").form("reset"); 
			},
		}],
	});
});

function initProjectManageTool() {
	project_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#project_manage").datagrid("reload");
		},
		redo : function () {
			$("#project_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#project_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#projectQueryForm").form({
			    url:"Project/OutToExcel",
			});
			//提交表单
			$("#projectQueryForm").submit();
		},
		remove : function () {
			var rows = $("#project_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var projectIds = [];
						for (var i = 0; i < rows.length; i ++) {
							projectIds.push(rows[i].projectId);
						}
						$.ajax({
							type : "POST",
							url : "Project/deletes",
							data : {
								projectIds : projectIds.join(","),
							},
							beforeSend : function () {
								$("#project_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#project_manage").datagrid("loaded");
									$("#project_manage").datagrid("load");
									$("#project_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#project_manage").datagrid("loaded");
									$("#project_manage").datagrid("load");
									$("#project_manage").datagrid("unselectAll");
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
			var rows = $("#project_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Project/" + rows[0].projectId +  "/update",
					type : "get",
					data : {
						//projectId : rows[0].projectId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (project, response, status) {
						$.messager.progress("close");
						if (project) { 
							$("#projectEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
