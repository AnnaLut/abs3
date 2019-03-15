using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System.Data;
using System.Collections.Generic;

namespace BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql SearchImports(string from, string to)
        {
            return new BarsSql()
            {
                SqlParams = FromToParams(from, to),
                SqlText = @"select 
                                ID as ""Id"",
                                CREATE_DATE as ""CreateDate"",
                                DATA as ""Data"",
                                STATE as ""State"",
                                COMM as ""Comment"",
                                USER_ID as ""UserId"",
                                DOC_COUNT as ""DocCount"",
                                USER_NAME as ""UserName"",
                                DOC_COUNT_PAYED as ""DocCountPayed""
                            from v_sago_requests 
                            where 
                                create_date between to_date(:p_from, 'DD.MM.YYYY HH24:MI:SS') and to_date(:p_to, 'DD.MM.YYYY HH24:MI:SS')
                            order by create_date desc"
            };
        }

        public static BarsSql SearchDocuments(string from, string to, decimal? requestId)
        {
            object[] _params = null;
            string sql = @"select
                                REF_OUR as ""Ref"",
                                REF_SAGO as ""RefSago"",
                                ACT as ""OperationCode"",
                                ACT_TYPE as ""OperationType"",
                                ACT_DATE as ""OperationDate"",
                                TOTAL_AMOUNT as ""TotalSum"",
                                REG_ID as ""RegionId"",
                                F_STATE as ""OperationState"",
                                N_DOC as ""PermissionNumber"",
                                D_DOC as ""PermissionDate"",
                                USER_ID as ""UserId"",
                                FIO_REG as ""PibReg"",
                                SIGN,
                                REQUEST_ID as ""RequestId"",
                                ID
                            from v_sago_documents
                            where ";
            if (null == requestId)
            {
                _params = FromToParams(from, to);
                sql += "ACT_DATE between to_date(:p_from, 'DD.MM.YYYY HH24:MI:SS') and to_date(:p_to, 'DD.MM.YYYY HH24:MI:SS')";
            }
            else
            {
                _params = new object[] { new OracleParameter("p_request_id", OracleDbType.Decimal, ParameterDirection.Input) { Value = requestId } };
                sql += "REQUEST_ID = :p_request_id";
            }

            return new BarsSql()
            {
                SqlParams = _params,
                SqlText = sql
            };
        }

        private static object[] FromToParams(string from, string to)
        {
            List<OracleParameter> oraParamsList = new List<OracleParameter>();
            oraParamsList.Add(new OracleParameter(":p_from", OracleDbType.Varchar2, from + " 00:00:00", ParameterDirection.Input));
            oraParamsList.Add(new OracleParameter(":p_to", OracleDbType.Varchar2, to + " 23:59:59", ParameterDirection.Input));

            return oraParamsList.ToArray();
        }

        public static BarsSql GetRequestStatuses()
        {
            return new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = @"select * from SAGO_REQUEST_STATE"
            };
        }

        public static BarsSql GetDocumentsStatuses()
        {
            return new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = @"select * from SAGO_DOCUMENT_STATE"
            };
        }
    }
}
