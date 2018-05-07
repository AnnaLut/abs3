using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kendo.Mvc;
using Kendo.Mvc.UI;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Models.Kernel;

namespace BarsWeb.Core.Infrastructure.Kernel.DI.Implementation
{
    public class KendoSqlFilter : IKendoSqlFilter
    {
        private string KendoFilterOperatorToString(FilterOperator op)
        {
            switch (op)
            {
                case FilterOperator.IsLessThan:
                    return "<";
                case FilterOperator.IsEqualTo:
                    return "=";
                case FilterOperator.IsNotEqualTo:
                    return "!=";
                case FilterOperator.IsGreaterThanOrEqualTo:
                    return ">=";
                case FilterOperator.IsLessThanOrEqualTo:
                    return "<=";
                case FilterOperator.IsGreaterThan:
                    return ">";
                case FilterOperator.StartsWith:
                case FilterOperator.EndsWith:
                case FilterOperator.Contains:
                    return " like ";
                case FilterOperator.DoesNotContain:
                    return " not like ";
                default:
                    return "";
            }
        }

        private object[] _newSqlParams;
        public KendoSqlFilter()
        {
            _newSqlParams = new object[] { };
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
                filtervalue = (bool)filter.ConvertedValue ? 1 : 0;
            }
            sql.Append(fieldName + KendoFilterOperatorToString(filter.Operator) + ":" + paramName);
            var tmpParamsList = new List<object> { new OracleParameter(paramName, paramType) { Value = filtervalue } };

            _newSqlParams = _newSqlParams.Concat(tmpParamsList).ToArray();
        }

        private void ParseTransformSql(StringBuilder filterStr, CompositeFilterDescriptor filter, string[] dateFieldsNames)
        {
            var nextClauseFromSameComposite = false;

            if (filterStr.Length > 0)
            {
                filterStr.Append(" and (");
            }
            filterStr.Append(" (");

            foreach (var flt in filter.FilterDescriptors)
            {
                if (flt is FilterDescriptor)
                {
                    if (filterStr.Length > 0)
                    {
                        if (nextClauseFromSameComposite)
                        {
                            filterStr.Append(filter.LogicalOperator == FilterCompositionLogicalOperator.Or ? " or " : " and ");
                        }
                    }
                    AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                    nextClauseFromSameComposite = true;
                }
                else if (flt is CompositeFilterDescriptor)
                {
                    //рекурсивный вызов!
                    ParseTransformSql(filterStr, flt as CompositeFilterDescriptor, dateFieldsNames);
                }
            }
            filterStr.Append(" )");
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
                        ParseTransformSql(filterStr, filter as CompositeFilterDescriptor, dateFieldsNames);
                    }
                }

                return new BarsSql
                {
                    SqlText = string.Format("SELECT * FROM ({0}) ", sql.SqlText) + " where " + filterStr,
                    SqlParams = sql.SqlParams == null ? _newSqlParams : sql.SqlParams.Concat(_newSqlParams).ToArray()
                };
            }
            return sql;
        }
    }
}