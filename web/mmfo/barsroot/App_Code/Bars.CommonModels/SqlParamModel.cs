using Bars.CommonModels.SqlEnumes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.WebPages;

/// <summary>
/// Summary description for SqlParamModel
/// </summary>
namespace Bars.CommonModels
{
    public class SqlParamModel
    {
        public SqlParamModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        /// <summary>
        /// Тип параметра. Приходит с клиента
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// Имя поля таблицы. Приходит с клиента
        /// </summary>
        public string Name { get; set; }

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
                    case "N":
                    case "NUMBER":
                        return Decimal.Parse(Value);
                    default:
                        return Value;

                }
            }
        }

        public int ParamOrder { get; set; }




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