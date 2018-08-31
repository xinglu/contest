<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Contest" %>
<%@ page import="com.shuangyulin.po.Student" %>
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
<title>比赛成绩添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Score/frontlist">比赛成绩列表</a></li>
			    	<li role="presentation" class="active"><a href="#scoreAdd" aria-controls="scoreAdd" role="tab" data-toggle="tab">添加比赛成绩</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="scoreList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="scoreAdd"> 
				      	<form class="form-horizontal" name="scoreAddForm" id="scoreAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="score_contestObj_contestId" class="col-md-2 text-right">比赛名称:</label>
						  	 <div class="col-md-8">
							    <select id="score_contestObj_contestId" name="score.contestObj.contestId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_studentObj_user_name" class="col-md-2 text-right">学生:</label>
						  	 <div class="col-md-8">
							    <select id="score_studentObj_user_name" name="score.studentObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_contentRound" class="col-md-2 text-right">比赛轮次:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="score_contentRound" name="score.contentRound" class="form-control" placeholder="请输入比赛轮次">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_scoreValue" class="col-md-2 text-right">比赛积分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="score_scoreValue" name="score.scoreValue" class="form-control" placeholder="请输入比赛积分">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxScoreAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#scoreAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加比赛成绩信息
	function ajaxScoreAdd() { 
		//提交之前先验证表单
		$("#scoreAddForm").data('bootstrapValidator').validate();
		if(!$("#scoreAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Score/add",
			dataType : "json" , 
			data: new FormData($("#scoreAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#scoreAddForm").find("input").val("");
					$("#scoreAddForm").find("textarea").val("");
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
	//验证比赛成绩添加表单字段
	$('#scoreAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"score.contentRound": {
				validators: {
					notEmpty: {
						message: "比赛轮次不能为空",
					}
				}
			},
			"score.scoreValue": {
				validators: {
					notEmpty: {
						message: "比赛积分不能为空",
					},
					numeric: {
						message: "比赛积分不正确"
					}
				}
			},
		}
	}); 
	//初始化比赛名称下拉框值 
	$.ajax({
		url: basePath + "Contest/listAll",
		type: "get",
		success: function(contests,response,status) { 
			$("#score_contestObj_contestId").empty();
			var html="";
    		$(contests).each(function(i,contest){
    			html += "<option value='" + contest.contestId + "'>" + contest.contestName + "</option>";
    		});
    		$("#score_contestObj_contestId").html(html);
    	}
	});
	//初始化学生下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#score_studentObj_user_name").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.user_name + "'>" + student.name + "</option>";
    		});
    		$("#score_studentObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
