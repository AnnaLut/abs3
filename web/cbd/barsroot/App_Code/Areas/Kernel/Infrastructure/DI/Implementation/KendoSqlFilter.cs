using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class KendoSqlFilter : IKendoSqlFilter
    {
        private string KendoFilterOperatorToString(FilterOperator op)
        {
            switch (op)
            {
                case FilterOperator.IsLessThan:
                    return "<";
                    break;
                case FilterOperator.IsEqualTo:
                    return "=";
                    break;
                case FilterOperator.IsNotEqualTo:
                    return "!=";
                    break;
                case FilterOperator.IsGreaterThanOrEqualTo:
                    return ">=";
                    break;
                case FilterOperator.IsLessThanOrEqualTo:
                    return "<=";
                    break;
                case FilterOperator.IsGreaterThan:
                    return ">";
                    break;
                case FilterOperator.StartsWith: 
                case FilterOperator.EndsWith:
                case FilterOperator.Contains:
                    return " like ";
                    break;
                case FilterOperator.DoesNotContain:
                    return " not like ";
                    break;
                default:
                    return "";
            }
        }

        private object[] _newSqlParams;
        public KendoSqlFilter()
        {
            _newSqlParams = new object[] {};
        }

        private void AddNewFilterToSql(StringBuilder sql, FilterDescriptor filter, string[] dateFieldsNames)
        {
            string paramName = "p_" + filter.Member + "_flt_" + (_newSqlParams.Length + 1);
            string fieldName = filter.Member;
            object filtervalue = filter.Value;

            OracleDbType paramType = OracleDbType.Decimal;

            if (filter.ConvertedValue is DateTime)
            {
                paramType = OracleDbType.Date;
                if (dateFieldsNames != null && dateFieldsNames.Contains(fieldName))
                    fieldName = string.Format(" {0} ", fieldName);   
                else
                    fieldName = string.Format(" trunc({0}) ", fieldName);
            }
            else if (filter.ConvertedValue is String)
            {
                paramType = OracleDbType.Varchar2;
                if (filter.Operator == FilterOperator.StartsWith)
                {
                    filtervalue = filtervalue + "%";
                }
                else if (filter.Operator == FilterOperator.EndsWith)
                {
                    filtervalue = "%" + filtervalue;
                }
                else if (filter.Operator == FilterOperator.Contains || filter.Operator == FilterOperator.DoesNotContain)
                {
                    filtervalue = "%" + filtervalue + "%";
                }
            }
            else if (filter.ConvertedValue is Boolean)
            {
                paramType = OracleDbType.Int16;
                filtervalue = (bool)filter.ConvertedValue ? 1 : 0  ;
            }
            sql.Append(fieldName + KendoFilterOperatorToString(filter.Operator) + ":" + paramName);
            var tmpParamsList = new List<object> { new OracleParameter(paramName, paramType) { Value = filtervalue } };

            _newSqlParams = _newSqlParams.Concat(tmpParamsList).ToArray();
        }

        private void parseTransformSql(StringBuilder filterStr, CompositeFilterDescriptor filter, string[] dateFieldsNames)
        {
            foreach (var flt in filter.FilterDescriptors)
            {
                if (flt is FilterDescriptor)
                {
                    if (filterStr.Length > 0)
                    {
                        filterStr.Append(" and ");
                    }
                    AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                }
                else if (flt is CompositeFilterDescriptor)
                {
                    //рекурсивный вызов!
                    parseTransformSql(filterStr, flt as CompositeFilterDescriptor, dateFieldsNames);
                }
            }
        }

        public BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames)
        {

            if (request != null && request.Filters != null && request.Filters.Any())
            {
                _newSqlParams = new object[] { };
                StringBuilder filterStr = new StringBuilder();
                
                foreach (var filter in request.Filters)
                {
                    if (filter is FilterDescriptor)
                    {
                        AddNewFilterToSql(filterStr, (filter as FilterDescriptor), dateFieldsNames);
                    }
                    else if (filter is CompositeFilterDescriptor)
                    {
                        parseTransformSql(filterStr, filter as CompositeFilterDescriptor, dateFieldsNames);
                    }
                }

                string whereConcatenator = " where ";
                if (sql.SqlText.ToLower().Contains("where"))
                {
                    whereConcatenator = " and ";
                }
                
                return new BarsSql
                {
                    SqlText = string.Format("SELECT * FROM ({0}) ",sql.SqlText) + whereConcatenator + filterStr,
                    SqlParams = sql.SqlParams == null ? _newSqlParams : sql.SqlParams.Concat(_newSqlParams).ToArray()
                };
            }
            return sql;
        }
    }
}