using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement_Model
{
   public class StudentModel
    {
        public int StudentId { get; set; }
        public string Name { get; set; }
        public string DateOfBirth { get; set; }
        public int Age { get; set; }
        public string Gender { get; set; }
        public string CourseIDS { get; set; }
    }
}
