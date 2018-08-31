<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/project.css" />
<div id="project_editDiv">
	<form id="projectEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">项目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="project_projectId_edit" name="project.projectId" value="<%=request.getParameter("projectId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="projectModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Project/js/project_modify.js"></script> 
