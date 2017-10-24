using System;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorStmt950
    {       
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT SW_STMT_CUSTOMER_LIST.rnk , 
                                        SW_STMT_CUSTOMER_LIST.nmk, 
                                        SW_STMT_CUSTOMER_LIST.bic, 
                                        SW_STMT_CUSTOMER_LIST.stmt, 
                                        s.name
                            FROM SW_STMT_CUSTOMER_LIST, STMT s
                            WHERE SW_STMT_CUSTOMER_LIST.stmt = s.stmt
                            ORDER BY SW_STMT_CUSTOMER_LIST.nmk",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql CreateCustomerStatementMessage(string bic, long rnk, DateTime dat1, DateTime dat2, int stmt)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                SWIFT.CreateCustomerStatementMessage(:bic, :rnk, :dat1, :dat2, :stmt);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("bic", OracleDbType.Varchar2) { Value = bic },
                    new OracleParameter("rnk", OracleDbType.Int64) { Value = rnk },
                    new OracleParameter("dat1", OracleDbType.Date) { Value = dat1 },
                    new OracleParameter("dat2", OracleDbType.Date) { Value = dat2 },
                    new OracleParameter("stmt", OracleDbType.Int64) { Value = stmt }
                }
            };
        }
    }
}
