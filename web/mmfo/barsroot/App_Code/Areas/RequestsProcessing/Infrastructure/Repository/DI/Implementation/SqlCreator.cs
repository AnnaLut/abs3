using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT KODZ,
                                   KODR,
                                   NAME,
                                   NAMEF,
                                   BINDVARS,
                                   CREATE_STMT,
                                   RPT_TEMPLATE,
                                   DEFAULT_VARS,
                                   LAST_UPDATED,
                                   BIND_SQL
                            FROM ZAPROS 
                            where KODZ in (select ZU.KODZ from ZAPROS_USERS zu where zu.USER_ID in (-1, user_id()))
                            ORDER BY KODZ",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchMainByKodz(decimal KODZ)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT  TXT, 
                                    BIND_SQL, 
                                    DEFAULT_VARS, 
                                    FORM_PROC
                            FROM ZAPROS 
                            WHERE KODZ = :P_KODZ",
                SqlParams = new object[] {
                    new OracleParameter("P_KODZ", OracleDbType.Int32) { Value = KODZ }
                }
            };
        }        

        public static BarsSql TableSemanticSql(string tabname)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT semantic, tabid FROM meta_tables WHERE tabname = :sReferenceName",
                SqlParams = new object[] {
                    new OracleParameter("sReferenceName", OracleDbType.Varchar2) { Value = tabname }
                }
            };
        }

        public static BarsSql TableColumnsSql(int tabid)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT colname,semantic,showwidth 
                            FROM meta_columns 
                            WHERE tabid = :nTabId 
                            ORDER BY showpos",
                SqlParams = new object[] {
                    new OracleParameter("nTabId", OracleDbType.Int32) { Value = tabid }
                }
            };
        }
    }
}
