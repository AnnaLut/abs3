using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.WebPages;
using BarsWeb.Areas.Ndi.Infrastructure;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Параметр фильтрации по колонкам грида
    /// </summary>
    public class GridFilter
    {
        /// <summary>
        /// Тип параметра. Приходит с клиента
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// Имя поля таблицы. Приходит с клиента
        /// </summary>
        public string Field { get; set; }

        /// <summary>
        /// Значение. Приходит с клиента
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// Тип сравнения между полем и параметром
        /// </summary>
        public string Comparison { get; set; }

        /// <summary>
        /// Выполнять чувствительное к регистру сравнение
        /// </summary>
        public bool CaseSensitive { get; set; }

        public string ParamName
        {
            get
            {
                string compType = Comparison ?? "";
                return "P" + ParamOrder + "_" + compType;
            }
        }
        
        public Object ParamValue
        {
            get
            {
                switch (Type)
                {
                    case "date":
                        return Value.AsDateTime();
                    case "boolean":
                        return Value == "True" ? 1 : 0;
                }
                return Value;
            }
        }

        public int ParamOrder { get; set; }

        private string FormatFilter(string fieldName)
        {
            var paramExpressionBuilder = new SqlParamTextBuilder
            {
                FieldName = fieldName,
                ParamName = ParamName,
                CaseSensitive = CaseSensitive,
                Comparation = ComparisonSign,
                Type = ParamType
            };
            return " " + paramExpressionBuilder.GetExpression();
        }

        /// <summary>
        /// Условие фильтрации с учетом наличия внешних колонок
        /// </summary>
        /// <param name="extColumnsMeta"></param>
        /// <returns></returns>
        public string ExtFilter(List<ColumnMetaInfo> extColumnsMeta)
        {
            var result = new StringBuilder();
            var extColumnInfo = extColumnsMeta.SingleOrDefault(ecm => ecm.COLNAME == Field);
            if (extColumnInfo == null)
            {
                // условие фильтрации SQL без учета наличия внешнией колонки
                result.Append(FormatFilter(Field));
            }
            else
            {
                result.Append(FormatFilter(extColumnInfo.ResultColFullName));
            }
            return result.ToString();
        }

        private Sign ComparisonSign
        {
            get
            {
                switch (Comparison)
                {
                    case "lt":
                        return Sign.Less;
                    case "gt":
                        return Sign.More;
                    default:
                        return Sign.Equal;
                }
            }
        }

        private ParamType ParamType
        {
            get
            {
                switch (Type)
                {
                    case "string":
                        return ParamType.String;
                    case "numeric":
                    case "boolean":
                        return ParamType.Numeric;
                    case "date":
                        return ParamType.Date;
                    default:
                        // на случай, если добавится тип перечесления без обработки
                        throw new InvalidOperationException();
                }
            }
        }
    }
}