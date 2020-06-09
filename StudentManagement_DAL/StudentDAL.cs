using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using StudentManagement_Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace StudentManagement_DAL
{
    public class StudentDAL : DataBaseAccess
    {
        SqlDatabase objDB;
        public List<CourseModel> CourseList()
        {
            List<CourseModel> objCourseModelList = new List<CourseModel>();
            objDB = new SqlDatabase(ConnectionString);
            using (System.Data.Common.DbCommand objCMD = objDB.GetStoredProcCommand("usp_GetCourseList"))
            {
                using (IDataReader objDataReader = objDB.ExecuteReader(objCMD))
                {
                    while (objDataReader.Read())
                    {
                        CourseModel objCourseModel = new CourseModel();
                        objCourseModel = FilterMasterDopdownObject(objDataReader);
                        objCourseModelList.Add(objCourseModel);
                    }
                    objDataReader.Close();
                }
                objCMD.Connection.Close();
            }
            return objCourseModelList;
        }

        private CourseModel FilterMasterDopdownObject(IDataReader objDataReader)
        {
            CourseModel objMasterDopdownDTO = new CourseModel();
            objMasterDopdownDTO.CourseId = ObjectValue<int>(objDataReader, "CourseId");
            objMasterDopdownDTO.Course = ObjectValue<string>(objDataReader, "Course");
            return objMasterDopdownDTO;
        }

        public int SaveStudent(StudentModel objStudentModel)
        {
            int result = 0;
            objDB = new SqlDatabase(ConnectionString);

            using (System.Data.Common.DbCommand objCMD = objDB.GetStoredProcCommand("usp_InsertUpdateStudent"))
            {
                objDB.AddInParameter(objCMD, "@StudentId", SqlDbType.Int, objStudentModel.StudentId);
                objDB.AddInParameter(objCMD, "@Name", SqlDbType.VarChar, objStudentModel.Name);
                objDB.AddInParameter(objCMD, "@DateOfBirth", SqlDbType.VarChar, objStudentModel.DateOfBirth);
                objDB.AddInParameter(objCMD, "@Gender", SqlDbType.VarChar, objStudentModel.Gender);
                objDB.AddInParameter(objCMD, "@CourseIDS", SqlDbType.VarChar, objStudentModel.CourseIDS);
                result = Convert.ToInt32(objDB.ExecuteScalar(objCMD));
            }
            return result;
        }

        public List<StudentModel> GetStudentList()
        {
            List<StudentModel> objStudentModelList = new List<StudentModel>();
            objDB = new SqlDatabase(ConnectionString);
            using (DbCommand objCMD = objDB.GetStoredProcCommand("usp_GetStudentList"))
            {
                using (IDataReader objDataReader = objDB.ExecuteReader(objCMD))
                {
                    while (objDataReader.Read())
                    {
                        StudentModel objStudentModel = new StudentModel();
                        objStudentModel = FilterStudentListObject(objDataReader);
                        objStudentModelList.Add(objStudentModel);
                    }
                    objDataReader.Close();
                }
                objCMD.Connection.Close();
            }
            return objStudentModelList;
        }

        private StudentModel FilterStudentListObject(IDataReader objDataReader)
        {
            StudentModel objStudentModel = new StudentModel();
            objStudentModel.StudentId = ObjectValue<int>(objDataReader, "StudentId");
            objStudentModel.Name = ObjectValue<string>(objDataReader, "Name");
            objStudentModel.DateOfBirth = ObjectValue<string>(objDataReader, "DateOfBirth");
            objStudentModel.Age = ObjectValue<int>(objDataReader, "Age");
            objStudentModel.Gender = ObjectValue<string>(objDataReader, "Gender");
            return objStudentModel;
        }

        public StudentModel UpdateNotification(int StudentId)
        {
            StudentModel objStudentModel = new StudentModel();
            objDB = new SqlDatabase(ConnectionString);
            using (DbCommand objCMD = objDB.GetStoredProcCommand("usp_GetStudentById"))
            {
                objDB.AddInParameter(objCMD, "@StudentId", SqlDbType.Int, StudentId);
                using (IDataReader objDataReader = objDB.ExecuteReader(objCMD))
                {
                    while (objDataReader.Read())
                    {
                        objStudentModel.StudentId = ObjectValue<int>(objDataReader, "StudentId");
                        objStudentModel.Name = ObjectValue<string>(objDataReader, "Name");
                        objStudentModel.DateOfBirth = ObjectValue<string>(objDataReader, "DateOfBirth");
                        objStudentModel.Gender = ObjectValue<string>(objDataReader, "Gender");
                        objStudentModel.CourseIDS = ObjectValue<string>(objDataReader, "CourseIDS");
                    }
                    objDataReader.Close();
                }
                objCMD.Connection.Close();
            }
            return objStudentModel;
        }

        public int DeleteStudent(int studentId)
        {
            int result = 0;
            objDB = new SqlDatabase(ConnectionString);

            using (DbCommand objCMD = objDB.GetStoredProcCommand("usp_DeleteStudent"))
            {
                objDB.AddInParameter(objCMD, "@StudentId", SqlDbType.Int, studentId);
                result = Convert.ToInt32(objDB.ExecuteScalar(objCMD));
            }
            return result;
        }
    }
}
