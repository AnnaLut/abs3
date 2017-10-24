using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"select * from V_NBUR_REF_XSD",
                SqlParams = new object[] { }
            };

        }
    }
}
