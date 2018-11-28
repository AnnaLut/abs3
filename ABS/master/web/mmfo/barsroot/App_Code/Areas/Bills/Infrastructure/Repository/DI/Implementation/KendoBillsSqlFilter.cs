using BarsWeb.Areas.Bills.Model;
using Kendo.Mvc;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for KendoBillsSqlFilter
    /// </summary>
    public class KendoBillsSqlFilter: IKendoBillsSqlFilter
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
        private List<OracleParameter> _newSqlParams;

        private bool isFirstEnter = false;

        private bool isFirstEnterLogicOr = false;

        public KendoBillsSqlFilter()
        {
            _newSqlParams = new List<OracleParameter>();
        }

        private void AddNewFilterToSql(StringBuilder sql, FilterDescriptor filter, string[] dateFieldsNames)
        {
            string paramName = "p_" + filter.Member + "_flt_" + (_newSqlParams.Count + 1);
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
            var tmpParamsList = new List<OracleParameter> { new OracleParameter(paramName, paramType) { Value = filtervalue } };

            _newSqlParams = _newSqlParams.Concat(tmpParamsList).ToList();
        }

        private void ParseTransformSql(StringBuilder filterStr, CompositeFilterDescriptor filter, string[] dateFieldsNames)
        {

            foreach (var flt in filter.FilterDescriptors)
            {
                if (flt is FilterDescriptor)
                {

                    if (filter.LogicalOperator == FilterCompositionLogicalOperator.And)
                    {

                        if (filterStr.Length > 0)
                        {
                            filterStr.Append(" and ( ");
                            AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                            filterStr.Append(" ) ");
                        }
                        else
                        {
                            filterStr.Append(" ( ");
                            AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                            filterStr.Append(" ) ");
                        }
                    }
                    else
                    {
                        if (isFirstEnter)
                        {
                            filterStr.Append(" or ");
                            AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                            filterStr.Append(" ) ");
                            isFirstEnter = false;
                        }
                        else
                        {
                            if (filterStr.Length > 0)
                            {
                                if (isFirstEnterLogicOr)
                                {
                                    filterStr.Append(" or ");
                                    AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                                    filterStr.Append(" ) ");
                                    isFirstEnterLogicOr = false;
                                    continue;
                                }

                                filterStr.Append(" and ( ");
                                AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                                isFirstEnterLogicOr = true;

                            }
                            else
                            {
                                filterStr.Append(" ( ");
                                AddNewFilterToSql(filterStr, flt as FilterDescriptor, dateFieldsNames);
                                isFirstEnter = true;
                            }


                        }


                    }

                }
                else if (flt is CompositeFilterDescriptor)
                {
                    //рекурсивный вызов!
                    ParseTransformSql(filterStr, flt as CompositeFilterDescriptor, dateFieldsNames);
                }
            }
        }

        public BillsSql TransformSql(BillsSql sql, DataSourceRequest request, string[] dateFieldsNames, string extraConditions = "")
        {

            if (request != null && request.Filters != null && request.Filters.Any())
            {
                _newSqlParams = new List<OracleParameter>();
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
                extraConditions = string.IsNullOrEmpty(extraConditions) ? "" : " AND (" + extraConditions + ")";
                return new BillsSql
                {
                    SqlText = string.Format("SELECT * FROM ({0}) ", sql.SqlText) + " where " + filterStr + extraConditions,
                    Parameters = sql.Parameters == null ? _newSqlParams : sql.Parameters.Concat(_newSqlParams).ToList()
                };
            }
            return sql;
        }
    }
}