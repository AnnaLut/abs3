using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.Upload.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SaveImage(string imgType, byte[] imgData, decimal clientRnk)
        {
            return new BarsSql
            {
                SqlText = @"begin
                                kl.set_cutomer_image(:p_rnk, :p_imgage_type, :p_image);
                            end;",
                SqlParams = new object[]
                {
                     new OracleParameter("p_rnk", OracleDbType.Int64) { Value = clientRnk },
                     new OracleParameter("p_imgage_type", OracleDbType.Varchar2) { Value = imgType },
                     new OracleParameter("p_image", OracleDbType.Blob, imgData, ParameterDirection.Input) { Value = imgData },
                }
            };
        }
    }
}
