using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;

namespace BarsWeb.Areas.AccountRestore.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql GetCurrencies()
        {
            return new BarsSql
            {
                SqlText = @"select kv, name from TABVAL$GLOBAL",
                SqlParams = new Object[] { }
            };
        }

        public static BarsSql Restore(Decimal acc)
        {
            return new BarsSql
            {
                SqlText = @"begin ACCREG.p_acc_restore(:p_acc); end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_acc",OracleDbType.Decimal){ Value = acc}
                }
            };
        }
    }
}
