using System;
using System.Web.Mvc;
using StudentManagement_Model;
using StudentManagement_BAL;
using System.Collections.Generic;

namespace StudentManagement_Web.Controllers
{
    public class StudentController : Controller
    {
        StudentBAL objStudentBAL = new StudentBAL();
        public ActionResult StudentDetails()
        {
            return View();
        }

        public JsonResult BindStudentCourseList()
        {
            MasterDropdownList objMasterDropdownList = new MasterDropdownList();
            try
            {
                objMasterDropdownList.CourseList = objStudentBAL.CourseList();
            }
            catch (Exception ex)
            {
                //CustomLog.Error(Convert.ToString(ex.InnerException), ex);
                return Json("-1", JsonRequestBehavior.AllowGet);
            }
            return Json(objMasterDropdownList, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveStudent(StudentModel objStudentModel)
        {
            int result = 0;
            try
            {
                result = objStudentBAL.SaveStudent(objStudentModel);
            }
            catch (Exception ex)
            {
                //CustomLog.Error(Convert.ToString(ex.InnerException), ex);
                return Json("-1", JsonRequestBehavior.AllowGet);
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetStudentList()
        {
            List<StudentModel> objStudentModelList = new List<StudentModel>();
            try
            {
                objStudentModelList = objStudentBAL.GetStudentList();
            }
            catch (Exception ex)
            {                
                return Json("-1", JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = objStudentModelList }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateStudent(int StudentId)
        {
            StudentModel objStudentModel = new StudentModel();
            try
            {
                objStudentModel = objStudentBAL.UpdateNotification(StudentId);
            }
            catch (Exception ex)
            {                
                return Json("-1", JsonRequestBehavior.AllowGet);
            }
            return Json(objStudentModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteStudent(int StudentId)
        {
            int result = 0;
            try
            {                
                result = objStudentBAL.DeleteStudent(StudentId);
            }
            catch (Exception ex)
            {                
                return Json("-1", JsonRequestBehavior.AllowGet);
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

    }
}