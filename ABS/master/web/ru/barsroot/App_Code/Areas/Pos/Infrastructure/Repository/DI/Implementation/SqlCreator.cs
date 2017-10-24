using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.Pos.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql PosTotalApply(decimal sum, decimal kv, string operation_type, string TerminaID)
        {
            decimal empty = 0;

            return new BarsSql()
            {
                SqlText = @"begin
                                BARS.pay_terminal_clearing(
                                    p_sum => :p_sum, 
                                    p_kv => :p_kv, 
                                    p_operation_type => :p_operation_type, 
                                    p_terminal_code => :p_terminal_code,
                                    p_ref => :p_ref
                                );
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swRef", OracleDbType.Decimal) { Value = sum },
                    new OracleParameter("p_srcUserID", OracleDbType.Decimal) { Value = kv },
                    new OracleParameter("p_tgtUserID", OracleDbType.Varchar2) { Value = operation_type },
                    new OracleParameter("p_terminal_code", OracleDbType.Varchar2) { Value = TerminaID },
                    new OracleParameter("p_ref", OracleDbType.Decimal, empty, ParameterDirection.Output),
                }
            };
        }
    }
}
