using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace BarsWeb.Areas.Subvention.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql GetAccountsForReport()
        {
            return new BarsSql
            {
                SqlParams = new object[] { },
                //SqlText = "select nls AccountNumber, nms AccountName, iban Iban from accounts where tip = 'SBD'"
                SqlText = "select nls AccountNumber, nms AccountName, '' Iban from accounts where tip = 'SBD'"
            };
        }
        public static BarsSql GetPackages(string from, string to, int? status)
        {
            List<OracleParameter> _params = new List<OracleParameter>();
            _params.AddRange(FromToParams(from, to));

            string statusPredicate = "";
            if (null != status)
            {
                statusPredicate = "and p.STATE_ID = :p_status ";
                _params.Add(new OracleParameter("p_status", OracleDbType.Decimal, status, ParameterDirection.Input));
            }

            string sql = string.Format(@"select p.ID,
                                                p.UNIT_TYPE_ID     UnitTypeId,
                                                p.EXTERNAL_FILE_ID ExternalFileId,
                                                p.RECEIVER_URL     ReceiverUrl,
                                                p.STATE_ID         StateId,
                                                p.FAILURES_COUNT   FailureCount,
                                                p.KF,
                                                p.sys_time         SysTime
                                           from v_subsidy_ebk_packages p 
                                           where 
                                                p.sys_time between to_date(:p_from, 'DD.MM.YYYY HH24:MI:SS') and to_date(:p_to, 'DD.MM.YYYY HH24:MI:SS')        
                                                {0}
                                           order by p.EXTERNAL_FILE_ID desc", statusPredicate);

            return new BarsSql()
            {
                SqlParams = _params.ToArray(),
                SqlText = sql
            };
        }

        public static BarsSql GetDocuments(string from, string to, decimal? packageId)
        {
            string sql = @"select d.extreqid,
                                  d.receiveraccnum,
                                  d.receivername,
                                  d.receiveridentcode,
                                  d.receiverbankcode,
                                  d.amount,
                                  d.purpose,
                                  d.signature,
                                  d.extrowid,
                                  d.ref,
                                  d.err,
                                  d.feerate,
                                  d.receiverrnk,
                                  d.payeraccnum,
                                  d.payerbankcode,
                                  d.paytype,
                                  d.sys_time SysTyme
                             from v_subsidy_data d where ";
            object[] _params = null;

            if (null == packageId)
            {
                _params = FromToParams(from, to).ToArray();
                sql += " d.sys_time between to_date(:p_from, 'DD.MM.YYYY HH24:MI:SS') and to_date(:p_to, 'DD.MM.YYYY HH24:MI:SS')";
            }
            else
            {
                _params = new object[] { new OracleParameter("p_package_id", OracleDbType.Decimal, packageId, ParameterDirection.Input) };
                sql += " d.extreqid = :p_package_id";
            }

            return new BarsSql()
            {
                SqlParams = _params,
                SqlText = sql
            };
        }

        private static List<OracleParameter> FromToParams(string from, string to)
        {
            List<OracleParameter> oraParamsList = new List<OracleParameter>();
            oraParamsList.Add(new OracleParameter(":p_from", OracleDbType.Varchar2, from, ParameterDirection.Input));
            oraParamsList.Add(new OracleParameter(":p_to", OracleDbType.Varchar2, to, ParameterDirection.Input));

            return oraParamsList;
        }
    }
}
