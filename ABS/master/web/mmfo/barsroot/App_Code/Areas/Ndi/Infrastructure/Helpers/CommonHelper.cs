using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CommonHelper
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{
    public static class CommonHelper
    {
        public static byte[] ConcatArrays(byte[] array1, byte[] array2)
        {
            var resultArray = new byte[array1.Length + array2.Length];
            array1.CopyTo(resultArray, 0);
            array2.CopyTo(resultArray, array1.Length);
            return resultArray;
        }

        public static void CopyValuesTo<T>( this T source, T target)
        {
            Type t = typeof(T);

            var properties = t.GetProperties().Where(prop => prop.CanRead && prop.CanWrite);

            foreach (var prop in properties)
            {
                var value = prop.GetValue(source, null);
                if (value != null && !string.IsNullOrEmpty(value.ToString()))
                    prop.SetValue(target, value, null);
            }
        }
    }
}