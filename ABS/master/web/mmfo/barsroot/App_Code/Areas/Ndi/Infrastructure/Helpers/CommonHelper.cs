using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CommonHelper
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{
    public class CommonHelper
    {
        public CommonHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static byte[] ConcatArrays(byte[] array1, byte[] array2)
        {
            var resultArray = new byte[array1.Length + array2.Length];
            array1.CopyTo(resultArray, 0);
            array2.CopyTo(resultArray, array1.Length);
            return resultArray;
        }
    }
}