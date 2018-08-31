<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/contest.css" /> 

<div id="contest_manage"></div>
<div id="contest_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="contest_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="contest_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="contest_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="contest_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="contest_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="contestQueryForm" method="post">
			举办学校：<input class="textbox" type="text" id="schoolObj_schoolId_query" name="schoolObj.schoolId" style="width: auto"/>
			比赛项目：<input class="textbox" type="text" id="projectObj_projectId_query" name="projectObj.projectId" style="width: auto"/>
			比赛名称：<input type="text" class="textbox" id="contestName" name="contestName" style="width:110px" />
			报名时间：<input type="text" id="signUpTime" name="signUpTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="contest_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="contestEditDiv">
	<form id="contestEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">比赛id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="contest_contestId_edit" name="contest.contestId" style="width:200px" />
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
				<script name="contest.contestDesc" id="contest_contestDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

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
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var contest_contestDesc_editor = UE.getEditor('contest_contestDesc_edit'); //比赛介绍编辑器
</script>
<script type="text/javascript" src="Contest/js/contest_manage.js"></script> 
