<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Score" %>
<%@ page import="com.shuangyulin.po.Contest" %>
<%@ page import="com.shuangyulin.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的contestObj信息
    List<Contest> contestList = (List<Contest>)request.getAttribute("contestList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    Score score = (Score)request.getAttribute("score");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改比赛成绩信息</TITLE>
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
  		<li class="active">比赛成绩信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="scoreEditForm" id="scoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="score_scoreId_edit" class="col-md-3 text-right">成绩id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="score_scoreId_edit" name="score.scoreId" class="form-control" placeholder="请输入成绩id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="score_contestObj_contestId_edit" class="col-md-3 text-right">比赛名称:</label>
		  	 <div class="col-md-9">
			    <select id="score_contestObj_contestId_edit" name="score.contestObj.contestId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_studentObj_user_name_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="score_studentObj_user_name_edit" name="score.studentObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_contentRound_edit" class="col-md-3 text-right">比赛轮次:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="score_contentRound_edit" name="score.contentRound" class="form-control" placeholder="请输入比赛轮次">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_scoreValue_edit" class="col-md-3 text-right">比赛积分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="score_scoreValue_edit" name="score.scoreValue" class="form-control" placeholder="请输入比赛积分">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxScoreModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#scoreEditForm .form-group {margin-bottom:5px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
/*弹出修改比赛成绩界面并初始化数据*/
function scoreEdit(scoreId) {
	$.ajax({
		url :  basePath + "Score/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (score, response, status) {
			if (score) {
				$("#score_scoreId_edit").val(score.scoreId);
				$.ajax({
					url: basePath + "Contest/listAll",
					type: "get",
					success: function(contests,response,status) { 
						$("#score_contestObj_contestId_edit").empty();
						var html="";
		        		$(contests).each(function(i,contest){
		        			html += "<option value='" + contest.contestId + "'>" + contest.contestName + "</option>";
		        		});
		        		$("#score_contestObj_contestId_edit").html(html);
		        		$("#score_contestObj_contestId_edit").val(score.contestObjPri);
					}
				});
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#score_studentObj_user_name_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.user_name + "'>" + student.name + "</option>";
		        		});
		        		$("#score_studentObj_user_name_edit").html(html);
		        		$("#score_studentObj_user_name_edit").val(score.studentObjPri);
					}
				});
				$("#score_contentRound_edit").val(score.contentRound);
				$("#score_scoreValue_edit").val(score.scoreValue);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交比赛成绩信息表单给服务器端修改*/
function ajaxScoreModify() {
	$.ajax({
		url :  basePath + "Score/" + $("#score_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#scoreQueryForm").submit();
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
    scoreEdit("<%=request.getParameter("scoreId")%>");
 })
 </script> 
</body>
</html>

