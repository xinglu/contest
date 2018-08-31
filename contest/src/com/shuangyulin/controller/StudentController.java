package com.shuangyulin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.shuangyulin.utils.ExportExcelUtil;
import com.shuangyulin.utils.UserException;
import com.shuangyulin.service.StudentService;
import com.shuangyulin.po.Student;
import com.shuangyulin.service.ContestService;
import com.shuangyulin.po.Contest;

//Student管理控制层
@Controller
@RequestMapping("/Student")
public class StudentController extends BaseController {

    /*业务层对象*/
    @Resource StudentService studentService;

    @Resource ContestService contestService;
	@InitBinder("contest")
	public void initBindercontest(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("contest.");
	}
	@InitBinder("student")
	public void initBinderStudent(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("student.");
	}
	/*跳转到添加Student视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Student());
		/*查询所有的Contest信息*/
		List<Contest> contestList = contestService.queryAllContest();
		request.setAttribute("contestList", contestList);
		return "Student_add";
	}

	/*客户端ajax方式提交添加报名学生信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Student student, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(studentService.getStudent(student.getUser_name()) != null) {
			message = "用户名已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			student.setUserPhoto(this.handlePhotoUpload(request, "userPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        studentService.addStudent(student);
        message = "报名学生添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询报名学生信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String user_name,@ModelAttribute("contest") Contest contest,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (user_name == null) user_name = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)studentService.setRows(rows);
		List<Student> studentList = studentService.queryStudent(user_name, contest, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    studentService.queryTotalPageAndRecordNumber(user_name, contest, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = studentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Student student:studentList) {
			JSONObject jsonStudent = student.getJsonObject();
			jsonArray.put(jsonStudent);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询报名学生信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Student> studentList = studentService.queryAllStudent();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Student student:studentList) {
			JSONObject jsonStudent = new JSONObject();
			jsonStudent.accumulate("user_name", student.getUser_name());
			jsonStudent.accumulate("name", student.getName());
			jsonArray.put(jsonStudent);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询报名学生信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String user_name,@ModelAttribute("contest") Contest contest,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (user_name == null) user_name = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<Student> studentList = studentService.queryStudent(user_name, contest, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    studentService.queryTotalPageAndRecordNumber(user_name, contest, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = studentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentService.getRecordNumber();
	    request.setAttribute("studentList",  studentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("user_name", user_name);
	    request.setAttribute("contest", contest);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
	    List<Contest> contestList = contestService.queryAllContest();
	    request.setAttribute("contestList", contestList);
		return "Student/student_frontquery_result"; 
	}

     /*前台查询Student信息*/
	@RequestMapping(value="/{user_name}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String user_name,Model model,HttpServletRequest request) throws Exception {
		/*根据主键user_name获取Student对象*/
        Student student = studentService.getStudent(user_name);

        List<Contest> contestList = contestService.queryAllContest();
        request.setAttribute("contestList", contestList);
        request.setAttribute("student",  student);
        return "Student/student_frontshow";
	}

	/*ajax方式显示报名学生修改jsp视图页*/
	@RequestMapping(value="/{user_name}/update",method=RequestMethod.GET)
	public void update(@PathVariable String user_name,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键user_name获取Student对象*/
        Student student = studentService.getStudent(user_name);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonStudent = student.getJsonObject();
		out.println(jsonStudent.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新报名学生信息*/
	@RequestMapping(value = "/{user_name}/update", method = RequestMethod.POST)
	public void update(@Validated Student student, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String userPhotoFileName = this.handlePhotoUpload(request, "userPhotoFile");
		if(!userPhotoFileName.equals("upload/NoImage.jpg"))student.setUserPhoto(userPhotoFileName); 


		try {
			studentService.updateStudent(student);
			message = "报名学生更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "报名学生更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除报名学生信息*/
	@RequestMapping(value="/{user_name}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String user_name,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  studentService.deleteStudent(user_name);
	            request.setAttribute("message", "报名学生删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "报名学生删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条报名学生记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String user_names,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = studentService.deleteStudents(user_names);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出报名学生信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String user_name,@ModelAttribute("contest") Contest contest,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(user_name == null) user_name = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<Student> studentList = studentService.queryStudent(user_name,contest,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Student信息记录"; 
        String[] headers = { "用户名","报名比赛","姓名","性别","出生日期","用户照片","联系电话","报名时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<studentList.size();i++) {
        	Student student = studentList.get(i); 
        	dataset.add(new String[]{student.getUser_name(),student.getContest().getContestName(),student.getName(),student.getGender(),student.getBirthDate(),student.getUserPhoto(),student.getTelephone(),student.getSignUpTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Student.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
