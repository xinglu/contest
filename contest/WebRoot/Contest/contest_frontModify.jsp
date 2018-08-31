<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Contest" %>
<%@ page import="com.shuangyulin.po.Project" %>
<%@ page import="com.shuangyulin.po.School" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的projectObj信息
    List<Project> projectList = (List<Project>)request.getAttribute("projectList");
    //获取所有的schoolObj信息
    List<School> schoolList = (List<School>)request.getAttribute("schoolList");
    Contest contest = (Contest)request.getAttribute("contest");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改比赛信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">比赛信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="contestEditForm" id="contestEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="contest_contestId_edit" class="col-md-3 text-right">比赛id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="contest_contestId_edit" name="contest.contestId" class="form-control" placeholder="请输入比赛id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="contest_schoolObj_schoolId_edit" class="col-md-3 text-right">举办学校:</label>
		  	 <div class="col-md-9">
			    <select id="contest_schoolObj_schoolId_edit" name="contest.schoolObj.schoolId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_projectObj_projectId_edit" class="col-md-3 text-right">比赛项目:</label>
		  	 <div class="col-md-9">
			    <select id="contest_projectObj_projectId_edit" name="contest.projectObj.projectId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_contestName_edit" class="col-md-3 text-right">比赛名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="contest_contestName_edit" name="contest.contestName" class="form-control" placeholder="请输入比赛名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_contestDesc_edit" class="col-md-3 text-right">比赛介绍:</label>
		  	 <div class="col-md-9">
			    <script name="contest.contestDesc" id="contest_contestDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_contestPlace_edit" class="col-md-3 text-right">比赛地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="contest_contestPlace_edit" name="contest.contestPlace" class="form-control" placeholder="请输入比赛地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_personNumber_edit" class="col-md-3 text-right">人数限制:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="contest_personNumber_edit" name="contest.personNumber" class="form-control" placeholder="请输入人数限制">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_signUpTime_edit" class="col-md-3 text-right">报名时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date contest_signUpTime_edit col-md-12" data-link-field="contest_signUpTime_edit">
                    <input class="form-control" id="contest_signUpTime_edit" name="contest.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_endTime_edit" class="col-md-3 text-right">截止时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date contest_endTime_edit col-md-12" data-link-field="contest_endTime_edit">
                    <input class="form-control" id="contest_endTime_edit" name="contest.endTime" size="16" type="text" value="" placeholder="请选择截止时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxContestModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#contestEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var contest_contestDesc_editor = UE.getEditor('contest_contestDesc_edit'); //比赛介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改比赛界面并初始化数据*/
function contestEdit(contestId) {
  contest_contestDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(contestId);
  });
}
 function ajaxModifyQuery(contestId) {
	$.ajax({
		url :  basePath + "Contest/" + contestId + "/update",
		type : "get",
		dataType: "json",
		success : function (contest, response, status) {
			if (contest) {
				$("#contest_contestId_edit").val(contest.contestId);
				$.ajax({
					url: basePath + "School/listAll",
					type: "get",
					success: function(schools,response,status) { 
						$("#contest_schoolObj_schoolId_edit").empty();
						var html="";
		        		$(schools).each(function(i,school){
		        			html += "<option value='" + school.schoolId + "'>" + school.schoolName + "</option>";
		        		});
		        		$("#contest_schoolObj_schoolId_edit").html(html);
		        		$("#contest_schoolObj_schoolId_edit").val(contest.schoolObjPri);
					}
				});
				$.ajax({
					url: basePath + "Project/listAll",
					type: "get",
					success: function(projects,response,status) { 
						$("#contest_projectObj_projectId_edit").empty();
						var html="";
		        		$(projects).each(function(i,project){
		        			html += "<option value='" + project.projectId + "'>" + project.projectName + "</option>";
		        		});
		        		$("#contest_projectObj_projectId_edit").html(html);
		        		$("#contest_projectObj_projectId_edit").val(contest.projectObjPri);
					}
				});
				$("#contest_contestName_edit").val(contest.contestName);
				contest_contestDesc_editor.setContent(contest.contestDesc, false);
				$("#contest_contestPlace_edit").val(contest.contestPlace);
				$("#contest_personNumber_edit").val(contest.personNumber);
				$("#contest_signUpTime_edit").val(contest.signUpTime);
				$("#contest_endTime_edit").val(contest.endTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交比赛信息表单给服务器端修改*/
function ajaxContestModify() {
	$.ajax({
		url :  basePath + "Contest/" + $("#contest_contestId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#contestEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#contestQueryForm").submit();
            }else{
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
    /*报名时间组件*/
    $('.contest_signUpTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*截止时间组件*/
    $('.contest_endTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    contestEdit("<%=request.getParameter("contestId")%>");
 })
 </script> 
</body>
</html>

