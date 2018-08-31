<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Contest" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>报名学生添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Student/frontlist">报名学生管理</a></li>
  			<li class="active">添加报名学生</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="studentAddForm" id="studentAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="student_user_name" class="col-md-2 text-right">用户名:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="student_user_name" name="student.user_name" class="form-control" placeholder="请输入用户名">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="student_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_password" name="student.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_contest_contestId" class="col-md-2 text-right">报名比赛:</label>
				  	 <div class="col-md-8">
					    <select id="student_contest_contestId" name="student.contest.contestId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_name" name="student.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_gender" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_gender" name="student.gender" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_birthDateDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="student_birthDateDiv" class="input-group date student_birthDate col-md-12" data-link-field="student_birthDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="student_birthDate" name="student.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_userPhoto" class="col-md-2 text-right">用户照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="student_userPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="student_userPhoto" name="student.userPhoto"/>
					    <input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_telephone" name="student.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_address" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_address" name="student.address" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_signUpTimeDiv" class="col-md-2 text-right">报名时间:</label>
				  	 <div class="col-md-8">
		                <div id="student_signUpTimeDiv" class="input-group date student_signUpTime col-md-12" data-link-field="student_signUpTime">
		                    <input class="form-control" id="student_signUpTime" name="student.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxStudentAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#studentAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加报名学生信息
	function ajaxStudentAdd() { 
		//提交之前先验证表单
		$("#studentAddForm").data('bootstrapValidator').validate();
		if(!$("#studentAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Student/add",
			dataType : "json" , 
			data: new FormData($("#studentAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#studentAddForm").find("input").val("");
					$("#studentAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证报名学生添加表单字段
	$('#studentAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"student.user_name": {
				validators: {
					notEmpty: {
						message: "用户名不能为空",
					}
				}
			},
			"student.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"student.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"student.gender": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"student.birthDate": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"student.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"student.signUpTime": {
				validators: {
					notEmpty: {
						message: "报名时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化报名比赛下拉框值 
	$.ajax({
		url: basePath + "Contest/listAll",
		type: "get",
		success: function(contests,response,status) { 
			$("#student_contest_contestId").empty();
			var html="";
    		$(contests).each(function(i,contest){
    			html += "<option value='" + contest.contestId + "'>" + contest.contestName + "</option>";
    		});
    		$("#student_contest_contestId").html(html);
    	}
	});
	//出生日期组件
	$('#student_birthDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#studentAddForm').data('bootstrapValidator').updateStatus('student.birthDate', 'NOT_VALIDATED',null).validateField('student.birthDate');
	});
	//报名时间组件
	$('#student_signUpTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#studentAddForm').data('bootstrapValidator').updateStatus('student.signUpTime', 'NOT_VALIDATED',null).validateField('student.signUpTime');
	});
})
</script>
</body>
</html>
