<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/project.css" /> 

<div id="project_manage"></div>
<div id="project_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="project_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="project_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="project_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="project_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="project_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="projectQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="projectEditDiv">
	<form id="projectEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">项目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="project_projectId_edit" name="project.projectId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">项目名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="project_projectName_edit" name="project.projectName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">项目介绍:</span>
			<span class="inputControl">
				<textarea id="project_projectDesc_edit" name="project.projectDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Project/js/project_manage.js"></script> 
