using System;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

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
            Color color = ColorTranslator.FromHtml(hex);
            return color;
        }

        /// <summary>
        /// Преобразовать формат даты .NET в формат даты используемый в extjs (Там используется Unix/PHP формат даты)
        /// </summary>
        /// <param name="netDateFormat">.NET формат даты</param>
        /// <returns></returns>
        public static string ConvertToExtJsDateFormat(string netDateFormat)
        {
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
    }
}