using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.Teller.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"select * from teller_tt_history",
                SqlParams = new object[] { }
            };

        }
    }
}
