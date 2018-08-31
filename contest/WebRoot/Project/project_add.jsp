<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/project.css" />
<div id="projectAddDiv">
	<form id="projectAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">项目名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="project_projectName" name="project.projectName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">项目介绍:</span>
			<span class="inputControl">
				<textarea id="project_projectDesc" name="project.projectDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="projectAddButton" class="easyui-linkbutton">添加</a>
			<a id="projectClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Project/js/project_add.js"></script> 
