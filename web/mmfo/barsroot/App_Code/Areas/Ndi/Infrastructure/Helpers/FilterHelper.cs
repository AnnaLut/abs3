using System.Linq;

namespace barsroot.Areas.Ndi.Infrastructure.Helpers
{
    /// <summary>
    /// Summary description for FilterHelper
    /// </summary>
    public class FilterHelper
    {
        public FilterHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static string BuildValueForLike(string value)
        {
            if (string.IsNullOrEmpty(value))
                return  "%";
            value = value.Replace('*', '%');
            if (!value.Contains('%'))
                value += '%';
            return value;
        }

   
    }
}