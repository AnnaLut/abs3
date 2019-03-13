using Newtonsoft.Json;
using System;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for ConvertHelper
/// </summary>
namespace BarsWeb.Infrastructure.Helpers
{
    public class ConvertHelper
    {
        public ConvertHelper()
        {
            
        }

        // <summary>
        /// Преобразовать Json в объект
        /// </summary>
        /// <typeparam name="T">Результирующий тип</typeparam>
        /// <param name="json">Строка в формате Json</param>
        /// <returns>Объект</returns>
        public static T JsonToObject<T>(string json)
        {
            T resultObject = default(T);
            if (!string.IsNullOrEmpty(json))
            {
                resultObject = JsonConvert.DeserializeObject<T>(json);
            }
            return resultObject;
        }


        public static string ObjectToJsom(Object obj)
        {
            string jsonRes = string.Empty;
            if (obj != null)
            {
                jsonRes = JsonConvert.SerializeObject(obj);
            }
            return jsonRes;
        }

        /// <summary>
        /// Преобразовать Json в объект
        /// </summary>
        /// <typeparam name="T">Результирующий тип</typeparam>
        /// <param name="json">Строка в формате Json</param>
        /// <returns>Объект</returns>
        public static string ConvertFormBase64ToUTF8(string base64String)
        {
            string res = string.Empty;
            if (!string.IsNullOrEmpty(base64String))
            {
                base64String = base64String.Replace(" ", "+");
                int mod4 = base64String.Length % 4;
                if (mod4 > 0)
                {
                    base64String += new string('=', 4 - mod4);
                }
                var bytes = Convert.FromBase64String(base64String);
                if (bytes != null)
                    res = Encoding.UTF8.GetString(bytes);
            }
            return res;
        }

        public static string ConvertToUrlBase4UTF8(string param)
        {

            string res = string.Empty;
            if (!string.IsNullOrEmpty(param))
            {
                var bytes = Encoding.UTF8.GetBytes(param);
                if (bytes != null && bytes.Length > 0)
                    res = HttpServerUtility.UrlTokenEncode(bytes);
            }
            return res;
        }
        public static string StringToBase64(string plainText)
        {
            var plainTextBytes = Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static string ObjectToJsonInBase64(Object modelToConvert)
        {
            if (modelToConvert == null)
                return string.Empty;
            string jsonString = ObjectToJsom(modelToConvert);
            return StringToBase64(jsonString);
        }
        public static string ConvertFromUrlBase64UTF8(string param)
        {
            string res = string.Empty;
            if (!string.IsNullOrEmpty(param))
            {
                //int mod4 = param.Length % 4;
                //if (mod4 > 0)
                //{
                //    param += new string('=', 4 - mod4);
                //}

                var bytes = HttpServerUtility.UrlTokenDecode(param);
                if (bytes != null && bytes.Length > 0)
                    res = Encoding.UTF8.GetString(bytes);
            }
            return res;
        }
    }
}