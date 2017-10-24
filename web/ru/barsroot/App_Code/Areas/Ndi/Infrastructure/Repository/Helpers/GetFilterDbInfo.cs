using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

/// <summary>
/// Summary description for GetFilterDbInfo
/// </summary>
public class GetFilterDbInfo
{
    public static string PushRowsFilterList(List<FilterRowInfo> filterRowList, int tableId, string filterName,int saveFilter,string whereClause )
    {
        //var functionInfoList = new FilterInfoList();
        //functionInfoList.FilterInfoArray = filterRowList.ToArray();

        using (var context = new DbAccess())
        {
            try
            {
                var parameters = new OracleParameter[5];
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
}