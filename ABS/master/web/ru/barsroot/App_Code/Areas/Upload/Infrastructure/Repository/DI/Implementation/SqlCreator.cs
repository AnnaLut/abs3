using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.Upload.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql DeleteImage(decimal clientRnk, string imgType)
        {
            return new BarsSql
            {
                SqlText = @"delete from customer_images where rnk = :p_rnk and type_img = :p_type",
                SqlParams = new object[]
                 {
                    new OracleParameter("p_rnk", OracleDbType.Int64) { Value = clientRnk },
                    new OracleParameter("p_type", OracleDbType.Varchar2) { Value = imgType }
                 }
            };
        }

        public static BarsSql InsertImage(string imgType, byte[] imgData, decimal clientRnk)
        {
            return new BarsSql
            {
                SqlText = @"insert into customer_images (rnk, type_img, date_img, image) values (:p_rnk, :p_type, sysdate, :p_image)",
                SqlParams = new object[]
                 {
                     new OracleParameter("p_rnk", OracleDbType.Int64) { Value = clientRnk },
                     new OracleParameter("p_type", OracleDbType.Varchar2) { Value = imgType },
                     new OracleParameter("p_image", OracleDbType.Blob, imgData, ParameterDirection.Input) { Value = imgData },
                 }
            };
        }

        public static BarsSql GetNd(decimal clientRnk)
        {
            return new BarsSql
            {
                SqlText = @"begin
                                bars.ow_utl.get_nd(:p_rnk);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_rnk", OracleDbType.Int64) { Value = clientRnk }
                }
            };
        }
    }
}
