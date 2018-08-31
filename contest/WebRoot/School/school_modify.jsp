<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/school.css" />
<div id="school_editDiv">
	<form id="schoolEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学校id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="school_schoolId_edit" name="school.schoolId" value="<%=request.getParameter("schoolId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学校名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="school_schoolName_edit" name="school.schoolName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="schoolModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/School/js/school_modify.js"></script> 
