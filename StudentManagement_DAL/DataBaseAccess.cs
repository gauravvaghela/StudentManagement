using System.Configuration;
namespace StudentManagement_DAL
{
    public class DataBaseAccess
    {
        public string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["MainConnectionString"].ConnectionString.ToString();
            }
        }

        public T ObjectValue<T>(System.Data.IDataReader objReader, string columnValue)
        {
            int index = objReader.GetOrdinal(columnValue);
            if (!objReader.IsDBNull(index))
            {
                return (T)objReader.GetValue(index);
            }
            else
            {
                return default(T);
            }
        }
    }
}
