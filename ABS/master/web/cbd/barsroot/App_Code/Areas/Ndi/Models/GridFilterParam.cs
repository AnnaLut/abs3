using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.WebPages;
using BarsWeb.Areas.Ndi.Infrastructure;

namespace BarsWeb.Areas.Ndi.Models
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