<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Student" %>
<%@ page import="com.shuangyulin.po.Contest" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    //获取所有的contest信息
    List<Contest> contestList = (List<Contest>)request.getAttribute("contestList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String user_name = (String)request.getAttribute("user_name"); //用户名查询关键字
    Contest contest = (Contest)request.getAttribute("contest");
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>报名学生查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Student/frontlist">报名学生信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Student/student_frontAdd.jsp" style="display:none;">添加报名学生</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<studentList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Student student = studentList.get(i); //获取到报名学生对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Student/<%=student.getUser_name() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=student.getUserPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		用户名:<%=student.getUser_name() %>
			     	</div>
			     	<div class="field">
	            		报名比赛:<%=student.getContest().getContestName() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=student.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=student.getGender() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=student.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=student.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		报名时间:<%=student.getSignUpTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Student/<%=student.getUser_name() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="studentEdit('<%=student.getUser_name() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="studentDelete('<%=student.getUser_name() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>报名学生查询</h1>
		</div>
		<form name="studentQueryForm" id="studentQueryForm" action="<%=basePath %>Student/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="user_name">用户名:</label>
				<input type="text" id="user_name" name="user_name" value="<%=user_name %>" class="form-control" placeholder="请输入用户名">
			</div>
            <div class="form-group">
            	<label for="contest_contestId">报名比赛：</label>
                <select id="contest_contestId" name="contest.contestId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Contest contestTemp:contestList) {
	 					String selected = "";
 					if(contest!=null && contest.getContestId()!=null && contest.getContestId().intValue()==contestTemp.getContestId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=contestTemp.getContestId() %>" <%=selected %>><%=contestTemp.getContestName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="studentEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;报名学生信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="studentEditForm" id="studentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="student_user_name_edit" class="col-md-3 text-right">用户名:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="student_user_name_edit" name="student.user_name" class="form-control" placeholder="请输入用户名" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="student_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_password_edit" name="student.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_contest_contestId_edit" class="col-md-3 text-right">报名比赛:</label>
		  	 <div class="col-md-9">
			    <select id="student_contest_contestId_edit" name="student.contest.contestId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_name_edit" name="student.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_gender_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_gender_edit" name="student.gender" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date student_birthDate_edit col-md-12" data-link-field="student_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="student_birthDate_edit" name="student.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_userPhoto_edit" class="col-md-3 text-right">用户照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="student_userPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="student_userPhoto" name="student.userPhoto"/>
			    <input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_telephone_edit" name="student.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_address_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_address_edit" name="student.address" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_signUpTime_edit" class="col-md-3 text-right">报名时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date student_signUpTime_edit col-md-12" data-link-field="student_signUpTime_edit">
                    <input class="form-control" id="student_signUpTime_edit" name="student.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#studentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxStudentModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.studentQueryForm.currentPage.value = currentPage;
    document.studentQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.studentQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.studentQueryForm.currentPage.value = pageValue;
    documentstudentQueryForm.submit();
}

/*弹出修改报名学生界面并初始化数据*/
function studentEdit(user_name) {
	$.ajax({
		url :  basePath + "Student/" + user_name + "/update",
		type : "get",
		dataType: "json",
		success : function (student, response, status) {
			if (student) {
				$("#student_user_name_edit").val(student.user_name);
				$("#student_password_edit").val(student.password);
				$.ajax({
					url: basePath + "Contest/listAll",
					type: "get",
					success: function(contests,response,status) { 
						$("#student_contest_contestId_edit").empty();
						var html="";
		        		$(contests).each(function(i,contest){
		        			html += "<option value='" + contest.contestId + "'>" + contest.contestName + "</option>";
		        		});
		        		$("#student_contest_contestId_edit").html(html);
		        		$("#student_contest_contestId_edit").val(student.contestPri);
					}
				});
				$("#student_name_edit").val(student.name);
				$("#student_gender_edit").val(student.gender);
				$("#student_birthDate_edit").val(student.birthDate);
				$("#student_userPhoto").val(student.userPhoto);
				$("#student_userPhotoImg").attr("src", basePath +　student.userPhoto);
				$("#student_telephone_edit").val(student.telephone);
				$("#student_address_edit").val(student.address);
				$("#student_signUpTime_edit").val(student.signUpTime);
				$('#studentEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除报名学生信息*/
function studentDelete(user_name) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Student/deletes",
			data : {
				user_names : user_name,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#studentQueryForm").submit();
					//location.href= basePath + "Student/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交报名学生信息表单给服务器端修改*/
function ajaxStudentModify() {
	$.ajax({
		url :  basePath + "Student/" + $("#student_user_name_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#studentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#studentQueryForm").submit();
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

    /*出生日期组件*/
    $('.student_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*报名时间组件*/
    $('.student_signUpTime_edit').datetimepicker({
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
})
</script>
</body>
</html>
