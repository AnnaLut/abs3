using System;
using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.F601.Infrastructure.DI
{
    /// <summary>
    /// Summary description for SqlCreator
    /// </summary>
    public class SqlCreator
    {
        public static BarsSql GetNBUReports()
        {
            return new BarsSql()
            {
                SqlText = @"select * from nbu_gateway.v_nbu_report_instance t order by t.id desc",
                SqlParams = new object[] { }
            };
        }
        public static BarsSql GetNBUSessionHistory(Decimal? id)
        {
            return new BarsSql()
            {
                SqlText = @"select * from nbu_gateway.V_NBU_SESSION_HISTORY t where report_id = :p_id", 
                SqlParams = new object[] {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = id }
                }
            };
        }
        public static BarsSql GetNBUSessionData(Decimal? reportId, Decimal? sessionId, Decimal? typeId, string kf)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT * FROM   TABLE(nbu_gateway.f_get_tab_compare_json(:p_sessionId,:p_reportId, :p_type_id ,:p_kf )) ",// --t.object_id , t.report_id , t.object_type_id ,t.object_kf 
                SqlParams = new object[] {
                    new OracleParameter("p_sessionId", OracleDbType.Decimal) { Value = sessionId },
                    new OracleParameter("p_reportId", OracleDbType.Decimal) { Value = reportId },
                    new OracleParameter("p_type_id", OracleDbType.Decimal) { Value = typeId },
                    new OracleParameter("p_kf", OracleDbType.Decimal) { Value = kf }
                }
            };
        }
    }
}