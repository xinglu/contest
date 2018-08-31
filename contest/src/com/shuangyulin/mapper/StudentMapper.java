package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.Student;

public interface StudentMapper {
	/*添加报名学生信息*/
	public void addStudent(Student student) throws Exception;

	/*按照查询条件分页查询报名学生记录*/
	public ArrayList<Student> queryStudent(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有报名学生记录*/
	public ArrayList<Student> queryStudentList(@Param("where") String where) throws Exception;

	/*按照查询条件的报名学生记录数*/
	public int queryStudentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条报名学生记录*/
	public Student getStudent(String user_name) throws Exception;

	/*更新报名学生记录*/
	public void updateStudent(Student student) throws Exception;

	/*删除报名学生记录*/
	public void deleteStudent(String user_name) throws Exception;

}
