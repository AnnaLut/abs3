using System.Collections.Generic;
using System.Data;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.SalaryBagSrv.Models;
using Dapper;
using System.Linq;
using System.Text;
using System;
using System.IO;
using Ionic.Zlib;

namespace Bars.SalaryBagSrv
{
    public static class ZPSrvWorker
    {
        public static Result SendCentrallToAll(string mfo, string nls, string central, string sessionId)
        {
            Result res = new Result();
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = con.CreateCommand())
            {
                List<UrlModel> urls = new List<UrlModel>();

                urls = con.Query<UrlModel>(string.Format("select * from zp_central_recipients where mfo <> '{0}'", mfo)).ToList();
                if (urls.Count <= 0)
                    throw new System.Exception("Відсутні налаштування URL для розсилки.");

                foreach (UrlModel url in urls)
                {
                    SendCentralDeal.Result result = new SendCentralDeal.Result();
                    using (SendCentralDeal.ReceiveCentralDeal rcd = new SendCentralDeal.ReceiveCentralDeal())
                    {
                        rcd.Url = url.url + "webservices/SalaryBagServices/ReceiveCentralDeal.asmx";
                        result = rcd.SetCentral(mfo, nls, central, sessionId);
                        if (result.status.ToUpper() != "OK")
                        {
                            res.status = "ERROR";
                            res.message += url.mfo + " " + result.message;
                        }
                    }
                }
            }

            return res;
        }

        #region Corp2Intrg
        public static CorpAddIfoResult GetCorp2ClientInfo(string rnk, decimal? sum, string mfo)
        {
            CorpAddIfoResult res = new CorpAddIfoResult();

            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pDebt = new OracleParameter("p_debt", OracleDbType.Decimal, null, ParameterDirection.Output),
                           pTarifpercent = new OracleParameter("p_commiss", OracleDbType.Decimal, null, ParameterDirection.Output),
                                pPremium = new OracleParameter("p_premium", OracleDbType.Decimal, null, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "zp_corp2_intg.get_zp_deal_par";

                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal).Value = rnk;
                cmd.Parameters.Add("p_amount", OracleDbType.Decimal).Value = sum;
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2).Value = mfo;
                cmd.Parameters.Add(pDebt);
                cmd.Parameters.Add(pTarifpercent);
                cmd.Parameters.Add(pPremium);

                cmd.ExecuteNonQuery();

                OracleDecimal _pDebt = (OracleDecimal)pDebt.Value;
                if (!_pDebt.IsNull)
                    res.data.Debt = _pDebt.Value;

                OracleDecimal _pTarifpercent = (OracleDecimal)pTarifpercent.Value;
                if (!_pTarifpercent.IsNull)
                    res.data.CommissionSum = _pTarifpercent.Value;

                OracleDecimal _pPremium = (OracleDecimal)pPremium.Value;
                if (!_pPremium.IsNull)
                    res.data.Premial = _pPremium.Value;
            }

            return res;
        }

        public static OpenCardsResult OpenCardsFromCorp2(byte[] inBlob, string mfo)
        {
            OpenCardsResult res = new OpenCardsResult()
            {
                OutBlob = null
            };
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pResponse = new OracleParameter("p_response", OracleDbType.Blob, null, ParameterDirection.Output),
                                     pErrMsg = new OracleParameter("p_errmsg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "zp_corp2_intg.imp_salary_cards_order";

                cmd.Parameters.Add("p_blob_data", OracleDbType.Blob).Value = inBlob;
                cmd.Parameters.Add(pResponse);
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2).Value = mfo;
                cmd.Parameters.Add(pErrMsg);

                cmd.ExecuteNonQuery();

                using (OracleBlob ob = (OracleBlob)pResponse.Value)
                {
                    if (!ob.IsNull)
                        res.OutBlob = ob.Value;
                }

                OracleString os = (OracleString)pErrMsg.Value;
                if (!os.IsNull)
                    res.message = os.Value;
            }

            return res;
        }

        public static Result ProcessPayrollFromCorp2(string data)
        {
            data = FromUtf8(data);
            Result res = new Result();

            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter result = new OracleParameter("p_clob_out", OracleDbType.Clob, null, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "zp_corp2_intg.set_payrolls";

                cmd.Parameters.Add("p_clob_data", OracleDbType.Clob).Value = data;
                cmd.Parameters.Add(result);
                cmd.ExecuteNonQuery();

                using (OracleClob _res = (OracleClob)result.Value)
                {
                    if (!_res.IsNull)
                        res.message = _res.Value;
                }
            }
            return res;
        }
        #endregion

        #region Encoding
        public static string ToUtf8(string b64Str)
        {
            return ConvertB64String(b64Str, Encoding.UTF8, GetDbEncoding());
        }
        public static string FromUtf8(string b64Str)
        {
            return ConvertB64String(b64Str, GetDbEncoding(), Encoding.UTF8);
        }
        private static string ConvertB64String(string b64Str, Encoding destEncoding, Encoding srcEncoding)
        {
            byte[] _tmpOld = Convert.FromBase64String(b64Str);
            byte[] _tmpNew = Encoding.Convert(srcEncoding, destEncoding, _tmpOld);

            return Convert.ToBase64String(_tmpNew);
        }

        private static Encoding GetDbEncoding()
        {
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = con.CreateCommand())
            {
                Encoding result = Encoding.GetEncoding(1251);
                try
                {
                    cmd.CommandText = "select value from nls_database_parameters where parameter = 'NLS_CHARACTERSET'";
                    var res = cmd.ExecuteScalar();
                    return null == res ? Encoding.GetEncoding(1251) : OraEncodingToSharp(res.ToString());
                }
                catch { }

                return result;
            }
        }

        private static Encoding OraEncodingToSharp(string oraCodePage)
        {
            Dictionary<string, Encoding> encodings = new Dictionary<string, Encoding>()
            {
                { "CL8MSWIN1251", Encoding.GetEncoding(1251)},
                { "AL32UTF8", Encoding.UTF8}
            };
            Encoding e = encodings.Where(x => x.Key == oraCodePage.ToUpper()).FirstOrDefault().Value;
            return null == e ? Encoding.GetEncoding(1251) : e;
        }
        #endregion
    }
}