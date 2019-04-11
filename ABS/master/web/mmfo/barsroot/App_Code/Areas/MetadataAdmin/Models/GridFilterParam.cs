using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.WebPages;
using BarsWeb.Areas.MetaDataAdmin.Infrastructure;

namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    /// <summary>
    /// �������� ���������� �� �������� �����
    /// </summary>
    public class GridFilter
    {
        /// <summary>
        /// ��� ���������. �������� � �������
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// ��� ���� �������. �������� � �������
        /// </summary>
        public string Field { get; set; }

        /// <summary>
        /// ��������. �������� � �������
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// ��� ��������� ����� ����� � ����������
        /// </summary>
        public string Comparison { get; set; }

        /// <summary>
        /// ��������� �������������� � �������� ���������
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
                    case "string":
                        {
                            Value = Value.Replace('*', '%');
                            if(!Value.Contains('%'))
                            Value += '%';
                            return Value;
                        }
                       
                }
                return Value;
            }
        }

        public int ParamOrder { get; set; }

        private string FormatFilter(string fieldName)
        {
            //string takeNull = (Type == "boolean" && Value.ToUpper() == "FALSE") ? "  OR " + fieldName + " IS NULL " : "";
            var paramExpressionBuilder = new SqlParamTextBuilder
            {
                FieldName = fieldName,
                ParamName = ParamName,
                CaseSensitive = CaseSensitive,
                Comparation = ComparisonSign,
                Type = ParamType
            };
            string result = " " + paramExpressionBuilder.GetExpression();
            //result += takeNull;
            return result;
        }

        /// <summary>
        /// ������� ���������� � ������ ������� ������� �������
        /// </summary>
        /// <param name="extColumnsMeta"></param>
        /// <returns></returns>
        public string ExtFilter(List<ColumnMetaInfo> extColumnsMeta)
        {
            var result = new StringBuilder();
            var extColumnInfo = extColumnsMeta.SingleOrDefault(ecm => ecm.COLNAME == Field);
            if (extColumnInfo == null)
            {
                // ������� ���������� SQL ��� ����� ������� �������� �������
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
                        // �� ������, ���� ��������� ��� ������������ ��� ���������
                        throw new InvalidOperationException();
                }
            }
        }
    }
}