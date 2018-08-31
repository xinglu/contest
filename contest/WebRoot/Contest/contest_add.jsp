<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/contest.css" />
<div id="contestAddDiv">
	<form id="contestAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">举办学校:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_schoolObj_schoolId" name="contest.schoolObj.schoolId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">比赛项目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_projectObj_projectId" name="contest.projectObj.projectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">比赛名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_contestName" name="contest.contestName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">比赛介绍:</span>
			<span class="inputControl">
				<script name="contest.contestDesc" id="contest_contestDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">比赛地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_contestPlace" name="contest.contestPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">人数限制:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_personNumber" name="contest.personNumber" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">报名时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_signUpTime" name="contest.signUpTime" />

			</span>

		</div>
		<div>
			<span class="label">截止时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_endTime" name="contest.endTime" />

			</span>

		</div>
		<div class="operation">
			<a id="contestAddButton" class="easyui-linkbutton">添加</a>
			<a id="contestClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Contest/js/contest_add.js"></script> 
