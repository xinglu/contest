<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/score.css" />
<div id="scoreAddDiv">
	<form id="scoreAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">比赛名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_contestObj_contestId" name="score.contestObj.contestId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_studentObj_user_name" name="score.studentObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">比赛轮次:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_contentRound" name="score.contentRound" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">比赛积分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_scoreValue" name="score.scoreValue" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="scoreAddButton" class="easyui-linkbutton">添加</a>
			<a id="scoreClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Score/js/score_add.js"></script> 
