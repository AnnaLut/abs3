using System;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Diagnostics;
using ibank.core;
using System.Web;
using BarsWeb.Areas.Ndi.Models;
using System.Globalization;
using System.Runtime.Serialization;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Класс для форматирования различных типов данных, дат, цветов и т.д.
    /// </summary>
    public static class FormatConverter
    {
        private const string CenturaColorDbPrefix = "COLOR_";

        /// <summary>
        /// Преобразовать центуровый код цвета в web-код цвета 
        /// </summary>
        /// <param name="centuraColor"></param>
        /// <returns></returns>
        public static string CenturaColorToWebColor(string centuraColor)
        {
            if (centuraColor.Length > CenturaColorDbPrefix.Length &&
                centuraColor.Substring(0, CenturaColorDbPrefix.Length).Equals(CenturaColorDbPrefix, StringComparison.OrdinalIgnoreCase))
            {
                centuraColor = centuraColor.Substring(CenturaColorDbPrefix.Length);
            }
            centuraColor = centuraColor.ToLower();
            switch (centuraColor)
            {
                case "black":
                    return "#000000";
                case "blue":
                    return "#0000FF";
                case "burgundy":
                    return "#900020";
                case "charcoal":
                    return "#36454F";
                case "chartreuse":
                    return "#7FFF00";
                case "cyan":
                    return "#00FFFF";
                case "darkaqua":
                    return "#1799B5";
                case "darkblue":
                    return "#00008B";
                case "darkgray":
                    return "#A9A9A9	";
                case "darkgreen":
                    return "#013220";
                case "darkred":
                    return "#8B0000";
                case "gray":
                    return "#808080";
                case "green":
                    return "#008000";
                case "jade":
                    return "#00A86B";
                case "lightaqua":
                    return "#B3FFFF";
                case "lightgray":
                    return "#D3D3D3";
                case "lightgreen":
                    return "#90EE90";
                case "lightperiwinkle":
                    return "#D0D9E1";
                case "magenta":
                    return "#FF00FF";
                case "maize":
                    return "#FBEC5D";
                case "marigold":
                    return "#B57D29";
                case "midnightblue":
                    return "#191970";
                case "orchid":
                    return "#DA70D6";
                case "periwinkle":
                    return "#CCCCFF";
                case "purple":
                    return "#BF00FF";
                case "red":
                    return "#FF0000";
                case "royalblue":
                    return "#4169E1";
                case "salmon":
                    return "#FA8072";
                case "sky":
                    return "#87CEEB";
                case "teal":
                    return "#008080";
                case "white":
                    return "#FFFFFF";
                default:
                    return centuraColor;
            }
        }
        /// <summary>
        /// Преобразовать центуровый код цвета в excel-код цвета 
        /// </summary>
        /// <param name="centuraColor"></param>
        /// <returns></returns>
        public static Color CenturaColorToExcelColor(string centuraColor)
        {
            string hex = CenturaColorToWebColor(centuraColor);
            Color color;
            if (hex.ToUpper().Contains("RGB"))
            {
                string rgbstr = hex.Substring(hex.IndexOf('(') + 1, hex.IndexOf(')') - hex.IndexOf('(') - 1);
                string[] strArray = rgbstr.Split(',');
                color = Color.FromArgb(Convert.ToInt32(strArray[0]), Convert.ToInt32(strArray[1]), Convert.ToInt32(strArray[2]));

            }
            else
                color = ColorTranslator.FromHtml(hex);
            return color;
        }

        /// <summary>
        /// Преобразовать формат даты .NET в формат даты используемый в extjs (Там используется Unix/PHP формат даты)
        /// </summary>
        /// <param name="netDateFormat">.NET формат даты</param>
        /// <returns></returns>
        public static string ConvertToExtJsDateFormat(string netDateFormat)
        {
            if (string.IsNullOrEmpty(netDateFormat))
                return string.Empty;
            var final = new StringBuilder(128);

            switch (netDateFormat.Trim())
            {
                case "d":
                    netDateFormat = System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.ShortDatePattern;
                    break;
                case "D":
                    netDateFormat = System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.LongDatePattern;
                    break;
                case "t":
                    netDateFormat = System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.ShortTimePattern;
                    break;
                case "T":
                    netDateFormat = System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.LongTimePattern;
                    break;
            }

            Match m = Regex.Match(netDateFormat, @"(\\)?(dd?d?d?|MM?M?M?|yy?y?y?|hh?h?h?|HH?|mm?|ss?|tt?|S)|.", RegexOptions.IgnoreCase);

            while (m.Success)
            {
                string temp = m.Value;
                switch (temp)
                {
                    case "dd":
                        final.Append("d");
                        break;
                    case "ddd":
                        final.Append("D");
                        break;
                    case "d":
                        final.Append("j");
                        break;
                    case "dddd":
                        final.Append("l");
                        break;
                    case "MMMM":
                        final.Append("F");
                        break;
                    case "MM":
                        final.Append("m");
                        break;
                    case "MMM":
                        final.Append("M");
                        break;
                    case "M":
                        final.Append("n");
                        break;
                    case "yyyy":
                        final.Append("Y");
                        break;
                    case "yy":
                        final.Append("y");
                        break;
                    case "tt":
                        final.Append("a");
                        break;
                    case "h":
                        final.Append("g");
                        break;
                    case "H":
                        final.Append("G");
                        break;
                    case "hh":
                        final.Append("h");
                        break;
                    case "hhhh":
                        final.Append("H");
                        break;
                    case "HH":
                        final.Append("H");
                        break;
                    case "mm":
                        final.Append("i");
                        break;
                    case "ss":
                        final.Append("s");
                        break;
                    default:
                        final.Append(temp);
                        break;
                }
                m = m.NextMatch();
            }

            return final.ToString();
        }

        /// <summary>
        /// Конвертация формата отображения чисел из метаданных в понятный для extjs формат
        /// Для extjs нужен примерно такой формат '#,##0.00' для форматирования чисел
        /// в метаданных    примерно такой формат '# ##0.00' или '# ##0,00'
        /// заменим ',' на '.' для десятичного разделителя
        /// заменим ' ' на ',' для тысячного разделителя
        /// и установим в extjs Ext.util.Format.thousandSeparator = ' '; Ext.util.Format.decimalSeparator = '.';
        /// при этом числа будут форматироваться правильно при тысячном разделителе ' ' и десятичном разделителе '.' 
        /// </summary>
        /// <param name="decimalFormat">META_COLUMNS.SHOWFORMAT для decimal полей</param>
        /// <returns>Понятный для extjs формат десятичных чисел</returns>
        public static string ConvertToExtJsDecimalFormat(string decimalFormat)
        {
            if (string.IsNullOrEmpty(decimalFormat))
                return string.Empty;
            return decimalFormat
                .Replace(',', '.')
                .Replace(' ', ',');
        }

        /// <summary>
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
                if(bytes != null)
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
                if(bytes != null && bytes.Length > 0)
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

        public static string ConvertFieldValueFromJsToSharpFormat(FieldProperties field)
        {
            if (string.IsNullOrEmpty(field.Value))
                return "";
            var res = Convert.ChangeType(field.Value, SqlStatementParamsParser.GetCsTypeCode(field.Type));
            if (res == null)
                return "";
            if (field.Type == "D")
            {
                DateTime resule = (DateTime)res;
                return resule.ToString("d",CultureInfo.CreateSpecificCulture("de-DE"));
                
            }
            else
                return res.ToString();
        }
    }
}