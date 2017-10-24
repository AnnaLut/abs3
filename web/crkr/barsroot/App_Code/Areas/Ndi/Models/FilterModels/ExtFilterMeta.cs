using System.Web.Script.Serialization;
using BarsWeb.Areas.Ndi.Infrastructure;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Метаданные дополнительных фильтров справочника (не по колонкам грида, задаются в отдельной форме, описываются в META_BROWSETBL)
    /// </summary>
    public class ExtFilterMeta
    {
        public string HostColName { get; set; }
        
        public string AddTabName { get; set; }
        
        public string AddColName { get; set; }
        
        public string VarColName { get; set; }
        
        public string VarColType { get; set; }
        
        public string Caption { get; set; }
        
        /// <summary>
        /// Выполнять чувствительное к регистру сравнение
        /// </summary>
        [ScriptIgnore]
        public bool CaseSensitive { get; set; }

        /// <summary>
        /// Тип сравнения между полем и параметром
        /// </summary>
        [ScriptIgnore]
        public string Comparison { get; set; }
        [ScriptIgnore]
        public string FullVarColName
        {
            get { return AddTabName + "." + VarColName; }
        }
        [ScriptIgnore]
        public string FullAddColName
        {
            get { return AddTabName + "." + AddColName; }
        }
        
        [ScriptIgnore]
        public string ParamName
        {
            get
            {
                string compType = Comparison ?? "";
                return VarColName.ToLower().Replace(".", "_") + "_" + compType;
            }
        }
        public string Filter()
        {
            var paramExpressionBuilder = new SqlParamTextBuilder
            {
                FieldName = FullVarColName,
                ParamName = ParamName,
                CaseSensitive = CaseSensitive,
                Comparation = ComparisonSign,
                Type = ParamType
            };
            return " and " + paramExpressionBuilder.GetExpression();
        }

        [ScriptIgnore]
        private Sign ComparisonSign
        {
            get
            {
                switch (Comparison)
                {
                    case "lt":
                        return Sign.Less | Sign.Equal;
                    case "gt":
                        return Sign.More | Sign.Equal;
                    default:
                        return Sign.Equal;
                }
            }
        }

        private ParamType ParamType
        {
            get
            {
                switch (VarColType)
                {
                    case "N":
                    case "E":
                    case "B":
                        return ParamType.Numeric;
                    case "D":
                        return ParamType.Date;
                    default:
                        return ParamType.String;
                }
            }
        }
    }
}

