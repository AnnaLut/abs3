using System;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Построитель sql-выражения сравнения поля и параметра
    /// </summary>
    public class SqlParamTextBuilder
    {
        /// <summary>
        /// Имя поля. Обязательный параметр
        /// </summary>
        public string FieldName { get; set; }

        /// <summary>
        /// Имя параметра. Обязательный параметр
        /// </summary>
        public string ParamName { get; set; }

        /// <summary>
        /// Тип поля и параметра. Обязательный параметр
        /// </summary>
        public ParamType Type { get; set; }

        /// <summary>
        /// Чувствительное к регистру сравнение (имеет смысл для строк и дат)
        /// </summary>
        public bool CaseSensitive { get; set; }

        /// <summary>
        /// Знак сравнения (имеет смысл для чисел и дат)
        /// </summary>
        public Sign Comparation { get; set; }

        /// <summary>
        /// Получить sql-выражение сравнения поля и параметра
        /// </summary>
        /// <returns></returns>
        public string GetExpression()
        {
            string sqlTextTemplate = GetSqlTemplate();
            string comparationStr = GetComparation();
            return string.Format(sqlTextTemplate, FieldName, ParamName, comparationStr);
        }

        private string GetSqlTemplate()
        {
            string sqlTextTemplate;
            switch (Type)
            {
                case (ParamType.Numeric):
                    sqlTextTemplate = "{0} {2} :{1}";
                    break;
                case (ParamType.Date):
                    sqlTextTemplate = "{0} {2} :{1}";
                    break;
                case (ParamType.String):
                    sqlTextTemplate = CaseSensitive
                        ? "{0} like '%' || :{1} || '%'"
                        : "UPPER({0}) like UPPER('%' || :{1} || '%')";
                    break;
                default:
                    // на случай, если добавится тип перечесления без обработки
                    throw new InvalidOperationException();
            }
            return sqlTextTemplate;
        }

        private string GetComparation()
        {
            switch (Comparation)
            {
                case Sign.Less:
                    return "<";
                case Sign.More:
                    return ">";
                case Sign.Equal:
                    return "=";
                case Sign.Less | Sign.Equal:
                    return "<=";
                case Sign.More | Sign.Equal:
                    return ">=";
                default:
                    // на случай, если добавится тип перечесления без обработки
                    throw new InvalidOperationException();
            }
        }
    }

    public enum ParamType
    {
        Numeric,
        String,
        Date
    }

    [Flags]
    public enum Sign
    {
        More = 1,
        Less = 2,
        Equal = 4
    }
}