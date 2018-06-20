using System;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorMT
    {       
        public static BarsSql GetSWREFValue(string uetr)
        {
            return new BarsSql()
            {
                SqlText = @"Select swref from sw_journal where uetr=:p_uetr and MT='103'",
                SqlParams = new object[]
                {
                    new OracleParameter("p_uetr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = uetr}
                }
            };
        }

        public static BarsSql GenerateReject(string uetr)
        {
            return new BarsSql()
            {
                SqlText = @"begin bars_swift_msg.generate_reject (:p_uetr); end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_uetr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = uetr}
                }
            };
        }

        public static BarsSql GenerateACSC(string uetr)
        {
            return new BarsSql()
            {
                SqlText = @"begin bars_swift_msg.generate_acsc (:p_uetr); end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_uetr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = uetr}
                }
            };
        }
    }
}
