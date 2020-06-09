using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement_Model
{
    public class CourseModel
    {
        public int CourseId { get; set; }
        public string Course { get; set; }
    }
    public class MasterDropdownList
    {
        public List<CourseModel> CourseList { get; set; }
    }
}
