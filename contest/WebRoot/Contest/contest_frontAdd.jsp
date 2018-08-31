<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Project" %>
<%@ page import="com.shuangyulin.po.School" %>
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
<title>比赛添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Contest/frontlist">比赛列表</a></li>
			    	<li role="presentation" class="active"><a href="#contestAdd" aria-controls="contestAdd" role="tab" data-toggle="tab">添加比赛</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="contestList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="contestAdd"> 
				      	<form class="form-horizontal" name="contestAddForm" id="contestAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="contest_schoolObj_schoolId" class="col-md-2 text-right">举办学校:</label>
						  	 <div class="col-md-8">
							    <select id="contest_schoolObj_schoolId" name="contest.schoolObj.schoolId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_projectObj_projectId" class="col-md-2 text-right">比赛项目:</label>
						  	 <div class="col-md-8">
							    <select id="contest_projectObj_projectId" name="contest.projectObj.projectId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_contestName" class="col-md-2 text-right">比赛名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="contest_contestName" name="contest.contestName" class="form-control" placeholder="请输入比赛名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_contestDesc" class="col-md-2 text-right">比赛介绍:</label>
						  	 <div class="col-md-8">
							    <textarea name="contest.contestDesc" id="contest_contestDesc" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_contestPlace" class="col-md-2 text-right">比赛地点:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="contest_contestPlace" name="contest.contestPlace" class="form-control" placeholder="请输入比赛地点">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_personNumber" class="col-md-2 text-right">人数限制:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="contest_personNumber" name="contest.personNumber" class="form-control" placeholder="请输入人数限制">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_signUpTimeDiv" class="col-md-2 text-right">报名时间:</label>
						  	 <div class="col-md-8">
				                <div id="contest_signUpTimeDiv" class="input-group date contest_signUpTime col-md-12" data-link-field="contest_signUpTime">
				                    <input class="form-control" id="contest_signUpTime" name="contest.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="contest_endTimeDiv" class="col-md-2 text-right">截止时间:</label>
						  	 <div class="col-md-8">
				                <div id="contest_endTimeDiv" class="input-group date contest_endTime col-md-12" data-link-field="contest_endTime">
				                    <input class="form-control" id="contest_endTime" name="contest.endTime" size="16" type="text" value="" placeholder="请选择截止时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxContestAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#contestAddForm .form-group {margin:10px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var contest_contestDesc_editor = UE.getEditor('contest_contestDesc'); //比赛介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加比赛信息
	function ajaxContestAdd() { 
		//提交之前先验证表单
		$("#contestAddForm").data('bootstrapValidator').validate();
		if(!$("#contestAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(contest_contestDesc_editor.getContent() == "") {
			alert('比赛介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Contest/add",
			dataType : "json" , 
			data: new FormData($("#contestAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#contestAddForm").find("input").val("");
					$("#contestAddForm").find("textarea").val("");
					contest_contestDesc_editor.setContent("");
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
	//验证比赛添加表单字段
	$('#contestAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"contest.contestName": {
				validators: {
					notEmpty: {
						message: "比赛名称不能为空",
					}
				}
			},
			"contest.contestPlace": {
				validators: {
					notEmpty: {
						message: "比赛地点不能为空",
					}
				}
			},
			"contest.personNumber": {
				validators: {
					notEmpty: {
						message: "人数限制不能为空",
					},
					integer: {
						message: "人数限制不正确"
					}
				}
			},
			"contest.signUpTime": {
				validators: {
					notEmpty: {
						message: "报名时间不能为空",
					}
				}
			},
			"contest.endTime": {
				validators: {
					notEmpty: {
						message: "截止时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化举办学校下拉框值 
	$.ajax({
		url: basePath + "School/listAll",
		type: "get",
		success: function(schools,response,status) { 
			$("#contest_schoolObj_schoolId").empty();
			var html="";
    		$(schools).each(function(i,school){
    			html += "<option value='" + school.schoolId + "'>" + school.schoolName + "</option>";
    		});
    		$("#contest_schoolObj_schoolId").html(html);
    	}
	});
	//初始化比赛项目下拉框值 
	$.ajax({
		url: basePath + "Project/listAll",
		type: "get",
		success: function(projects,response,status) { 
			$("#contest_projectObj_projectId").empty();
			var html="";
    		$(projects).each(function(i,project){
    			html += "<option value='" + project.projectId + "'>" + project.projectName + "</option>";
    		});
    		$("#contest_projectObj_projectId").html(html);
    	}
	});
	//报名时间组件
	$('#contest_signUpTimeDiv').datetimepicker({
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
		$('#contestAddForm').data('bootstrapValidator').updateStatus('contest.signUpTime', 'NOT_VALIDATED',null).validateField('contest.signUpTime');
	});
	//截止时间组件
	$('#contest_endTimeDiv').datetimepicker({
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
		$('#contestAddForm').data('bootstrapValidator').updateStatus('contest.endTime', 'NOT_VALIDATED',null).validateField('contest.endTime');
	});
})
</script>
</body>
</html>
