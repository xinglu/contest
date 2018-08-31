<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/school.css" />
<div id="schoolAddDiv">
	<form id="schoolAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学校名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="school_schoolName" name="school.schoolName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="schoolAddButton" class="easyui-linkbutton">添加</a>
			<a id="schoolClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/School/js/school_add.js"></script> 
