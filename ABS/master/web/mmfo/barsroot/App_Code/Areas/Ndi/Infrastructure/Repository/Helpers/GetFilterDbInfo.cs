using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using BarsWeb.Areas.Ndi.Models;

/// <summary>
/// Summary description for GetFilterDbInfo
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers
{
    public class GetFilterDbInfo
    {
        public static string PushRowsFilterList(List<FilterRowInfo> filterRowList, string filterStructure, int tableId, string filterName, int saveFilter, string whereClause)
        {
            //var functionInfoList = new FilterInfoList();
            //functionInfoList.FilterInfoArray = filterRowList.ToArray();

            using (var context = new DbAccess())
            {
                try
                {
                    var parameters = new OracleParameter[6];
                    //parameters[0] = DbAccess.CreateCustomTypeArrayInputParameter("P_DYN_FILTER_COND_LIST", "BARS.T_DYN_FILTER_COND_LINE", filterRowList.ToArray());
                    parameters[0] = new OracleParameter("P_TABLE_ID", OracleDbType.Int32, tableId, ParameterDirection.Input);


                    parameters[1] = new OracleParameter("P_FILTER_NAME", OracleDbType.Varchar2, filterName, ParameterDirection.Input);
                    parameters[2] = new OracleParameter("p_dyn_filter_cond_list", OracleDbType.Array)
                    {
                        UdtTypeName = "BARS.T_DYN_FILTER_COND_LIST",
                        Value = filterRowList.ToArray()
                    };
                    parameters[3] = new OracleParameter("p_save_filter", OracleDbType.Int32, saveFilter, ParameterDirection.Input);
                    parameters[4] = new OracleParameter("p_where_clause", OracleDbType.Varchar2, 4000, whereClause, ParameterDirection.InputOutput);
                    parameters[5] = new OracleParameter("p_condition_list", OracleDbType.Clob, filterStructure, ParameterDirection.Input);
                    var result = context.CreateCommand("BARS.BARS_METABASE.CREATE_DYN_FILTER", CommandType.StoredProcedure, parameters);
                    result.ExecuteNonQuery();

                    string clause = Convert.ToString(result.Parameters["p_where_clause"].Value);
                    return clause;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public static string UpdateFilter(EditFilterModel editFilterModel)
        {

            using (var context = new DbAccess())
            {
                try
                {
                    var parameters = new OracleParameter[6];
                    //parameters[0] = DbAccess.CreateCustomTypeArrayInputParameter("P_DYN_FILTER_COND_LIST", "BARS.T_DYN_FILTER_COND_LINE", filterRowList.ToArray());
                    parameters[0] = new OracleParameter("P_TABLE_ID", OracleDbType.Int32, editFilterModel.TableId, ParameterDirection.Input);

                    parameters[1] = new OracleParameter("P_FILTER_ID", OracleDbType.Int32, editFilterModel.FilterId, ParameterDirection.Input);
                    parameters[2] = new OracleParameter("P_FILTER_NAME", OracleDbType.Varchar2, editFilterModel.FilterName, ParameterDirection.Input);
                    parameters[3] = new OracleParameter("p_dyn_filter_cond_list", OracleDbType.Array)
                    {
                        UdtTypeName = "BARS.T_DYN_FILTER_COND_LIST",
                        Value = editFilterModel.FilterRows.ToArray()
                    };
                    parameters[4] = new OracleParameter("p_where_clause", OracleDbType.Varchar2, 4000, "", ParameterDirection.InputOutput);
                    parameters[5] = new OracleParameter("p_condition_list", OracleDbType.Clob, editFilterModel.JosnStructure, ParameterDirection.Input);
                    var result = context.CreateCommand("BARS.BARS_METABASE.update_dyn_filter", CommandType.StoredProcedure, parameters);
                    result.ExecuteNonQuery();

                    string clause = Convert.ToString(result.Parameters["p_where_clause"].Value);
                    return clause;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}