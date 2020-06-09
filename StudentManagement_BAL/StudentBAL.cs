using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StudentManagement_DAL;
using StudentManagement_Model;

namespace StudentManagement_BAL
{
    public class StudentBAL
    {
        StudentDAL objStudentDAL = new StudentDAL();
        public List<CourseModel> CourseList()
        {
            return objStudentDAL.CourseList();
        }

        public int SaveStudent(StudentModel objStudentModel)
        {
            return objStudentDAL.SaveStudent(objStudentModel);
        }

        public List<StudentModel> GetStudentList()
        {
            return objStudentDAL.GetStudentList();
        }

        public StudentModel UpdateNotification(int studentId)
        {
            return objStudentDAL.UpdateNotification(studentId);
        }

        public int DeleteStudent(int studentId)
        {
            return objStudentDAL.DeleteStudent(studentId);
        }
    }
}
