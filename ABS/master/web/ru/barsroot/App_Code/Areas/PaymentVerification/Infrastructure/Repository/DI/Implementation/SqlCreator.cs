using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Collections.Generic;

namespace BarsWeb.Areas.PaymentVerification.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql GetPhone(CellPhone obj)
        {
            return new BarsSql()
            {
                //SqlText = @"select value from customerw where rnk = :p_rnk and tag = 'MPNO'",
                SqlText = @"SELECT w.nmk AS NMK, (SELECT c.VALUE FROM customerw c
                             WHERE c.rnk = :p_rnk AND c.tag = 'MPNO') AS PHONE FROM customer w WHERE w.rnk = :p_rnk",
                SqlParams = new object[]
                {
                    new OracleParameter("p_rnk", OracleDbType.Varchar2) { Value = obj.rnk }
                }
            };
        }

        public static BarsSql Sms(CellPhone obj)
        {
            string p_msg = "";
            decimal p_result = 0;

            List<object> sqlParamsList = new List<object>();
            sqlParamsList.Add(new OracleParameter("p_rnk", OracleDbType.Varchar2) { Value = obj.rnk });
            sqlParamsList.Add(new OracleParameter("p_phone", OracleDbType.Varchar2) { Value = obj.phone });
            if (!obj.skipcode)
            {
                sqlParamsList.Add(new OracleParameter("p_code", OracleDbType.Decimal) { Value = obj.code });
            }
            sqlParamsList.Add(new OracleParameter("p_result", OracleDbType.Decimal, p_result, ParameterDirection.InputOutput));
            sqlParamsList.Add(new OracleParameter("p_msg", OracleDbType.Varchar2, 4000, p_msg, ParameterDirection.InputOutput));

            return new BarsSql()
            {
                SqlText = string.Format(
                            @"begin 
                                KL_SMSCODE(:p_rnk,:p_phone, {0}, :p_result, :p_msg); 
                            end;", obj.skipcode ? "null" : ":p_code"),
                SqlParams = sqlParamsList.ToArray()
            };
        }
    }
}
