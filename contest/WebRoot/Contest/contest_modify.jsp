<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/contest.css" />
<div id="contest_editDiv">
	<form id="contestEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">比赛id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_contestId_edit" name="contest.contestId" value="<%=request.getParameter("contestId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">举办学校:</span>
			<span class="inputControl">
				<input class="textbox"  id="contest_schoolObj_schoolId_edit" name="contest.schoolObj.schoolId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">比赛项目:</span>
			<span class="inputControl">
				<input class="textbox"  id="contest_projectObj_projectId_edit" name="contest.projectObj.projectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">比赛名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_contestName_edit" name="contest.contestName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">比赛介绍:</span>
			<span class="inputControl">
				<script id="contest_contestDesc_edit" name="contest.contestDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">比赛地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_contestPlace_edit" name="contest.contestPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">人数限制:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_personNumber_edit" name="contest.personNumber" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">报名时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_signUpTime_edit" name="contest.signUpTime" />

			</span>

		</div>
		<div>
			<span class="label">截止时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_endTime_edit" name="contest.endTime" />

			</span>

		</div>
		<div class="operation">
			<a id="contestModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Contest/js/contest_modify.js"></script> 
