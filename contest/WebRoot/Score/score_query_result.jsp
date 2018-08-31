<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/score.css" /> 

<div id="score_manage"></div>
<div id="score_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="score_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="score_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="score_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="score_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="score_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="scoreQueryForm" method="post">
			比赛名称：<input class="textbox" type="text" id="contestObj_contestId_query" name="contestObj.contestId" style="width: auto"/>
			学生：<input class="textbox" type="text" id="studentObj_user_name_query" name="studentObj.user_name" style="width: auto"/>
			比赛轮次：<input type="text" class="textbox" id="contentRound" name="contentRound" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="score_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="scoreEditDiv">
	<form id="scoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_scoreId_edit" name="score.scoreId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Score/js/score_manage.js"></script> 
