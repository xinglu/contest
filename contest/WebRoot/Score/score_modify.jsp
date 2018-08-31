<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/score.css" />
<div id="score_editDiv">
	<form id="scoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_scoreId_edit" name="score.scoreId" value="<%=request.getParameter("scoreId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">比赛名称:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_contestObj_contestId_edit" name="score.contestObj.contestId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_studentObj_user_name_edit" name="score.studentObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">比赛轮次:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_contentRound_edit" name="score.contentRound" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">比赛积分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_scoreValue_edit" name="score.scoreValue" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="scoreModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Score/js/score_modify.js"></script> 
