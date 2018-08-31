<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/student.css" />
<div id="student_editDiv">
	<form id="studentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_user_name_edit" name="student.user_name" value="<%=request.getParameter("user_name") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_password_edit" name="student.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">报名比赛:</span>
			<span class="inputControl">
				<input class="textbox"  id="student_contest_contestId_edit" name="student.contest.contestId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_name_edit" name="student.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_gender_edit" name="student.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_birthDate_edit" name="student.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">用户照片:</span>
			<span class="inputControl">
				<img id="student_userPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="student_userPhoto" name="student.userPhoto"/>
				<input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_telephone_edit" name="student.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_address_edit" name="student.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">报名时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_signUpTime_edit" name="student.signUpTime" />

			</span>

		</div>
		<div class="operation">
			<a id="studentModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Student/js/student_modify.js"></script> 
