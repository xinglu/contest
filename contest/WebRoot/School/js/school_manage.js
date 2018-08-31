var school_manage_tool = null; 
$(function () { 
	initSchoolManageTool(); //建立School管理对象
	school_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#school_manage").datagrid({
		url : 'School/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "schoolId",
		sortOrder : "desc",
		toolbar : "#school_manage_tool",
		columns : [[
			{
				field : "schoolId",
				title : "学校id",
				width : 70,
			},
			{
				field : "schoolName",
				title : "学校名称",
				width : 140,
			},
		]],
	});

	$("#schoolEditDiv").dialog({
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
				if ($("#schoolEditForm").form("validate")) {
					//验证表单 
					if(!$("#schoolEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#schoolEditForm").form({
						    url:"School/" + $("#school_schoolId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#schoolEditDiv").dialog("close");
			                        school_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#schoolEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#schoolEditDiv").dialog("close");
				$("#schoolEditForm").form("reset"); 
			},
		}],
	});
});

function initSchoolManageTool() {
	school_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#school_manage").datagrid("reload");
		},
		redo : function () {
			$("#school_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#school_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#schoolQueryForm").form({
			    url:"School/OutToExcel",
			});
			//提交表单
			$("#schoolQueryForm").submit();
		},
		remove : function () {
			var rows = $("#school_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var schoolIds = [];
						for (var i = 0; i < rows.length; i ++) {
							schoolIds.push(rows[i].schoolId);
						}
						$.ajax({
							type : "POST",
							url : "School/deletes",
							data : {
								schoolIds : schoolIds.join(","),
							},
							beforeSend : function () {
								$("#school_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#school_manage").datagrid("loaded");
									$("#school_manage").datagrid("load");
									$("#school_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#school_manage").datagrid("loaded");
									$("#school_manage").datagrid("load");
									$("#school_manage").datagrid("unselectAll");
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
			var rows = $("#school_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "School/" + rows[0].schoolId +  "/update",
					type : "get",
					data : {
						//schoolId : rows[0].schoolId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (school, response, status) {
						$.messager.progress("close");
						if (school) { 
							$("#schoolEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
