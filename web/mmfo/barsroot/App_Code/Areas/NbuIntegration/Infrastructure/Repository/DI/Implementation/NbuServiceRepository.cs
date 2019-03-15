using Areas.NbuIntegration;
using Areas.NbuIntegration.Models;
using Bars.Classes;
using BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Abstract;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;

namespace BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Implementation
{
    public class NbuServiceRepository : INbuServiceRepository
    {
        public NbuServiceRepository()
        {
        }

        public ReqSaveRes GetAndProcessDataFromNbu(OracleConnection con, string date)
        {
            if (string.IsNullOrWhiteSpace(date)) throw new ArgumentException("parameter can not be empty, parameter name 'date'");
            ReqSaveRes res = new ReqSaveRes();
            string mfo = "";

            mfo = GetMfo(con);

            SagoConfig cfg = new SagoConfig(con);

            try
            {
                NbuServiceResponse tmpData = GetDataFromNbu(cfg.ServerUrl, cfg.FullUrl + date, cfg[SagoParams.UserName], cfg[SagoParams.Password], cfg[SagoParams.Domain]);
                CheckSign(tmpData);

                NbuServiceResponse filteredData = FilterData(tmpData, GetRegionIdByMfo(con, mfo), date, mfo);

                res = SaveRequest(con, filteredData);
                if (string.IsNullOrWhiteSpace(res.ErrMsg))
                {
                    SaveDocumentsResult saveRes = new SaveDocumentsResult();
                    saveRes = SaveDocuments(con, filteredData.Data.Operations.Rows, res.Id);

                    res.CountDocsInserted = saveRes.CountSaved;
                    res.TotalSum = Convert.ToDecimal(saveRes.Sum);

                    string msg = "";
                    RequestState _state = RequestState.DocumentsCreated;
                    if (res.CountDocsInserted == 0)
                    {
                        msg = string.Format("Документи за дату {0} було створено раніше.", DateStr(date));
                        _state = RequestState.CreateDocumentsError;
                    }
                    else if (res.CountDocs != res.CountDocsInserted)
                        msg = string.Format("Документи створено частково ({0} з {1})", res.CountDocsInserted, res.CountDocs);

                    UpdateRequestState(con, res.Id, _state, msg);

                    if (res.CountDocsInserted > 0)
                        CreatePayments(con, res.Id);
                }
                else
                    throw new Exception(res.ErrMsg);

                return res;
            }
            catch (SagoException ex)
            {
                SaveRequest(con, new VRequestsRow()
                {
                    Data = ex.RequestData,
                    Comment = ex.Message,
                    UserId = GetUserId(con),
                    State = ex.Code,
                    Id = res.Id
                });
                throw;
            }
            catch (Exception ex)
            {
                SaveRequest(con, new VRequestsRow()
                {
                    Data = ex.Message + Environment.NewLine + ex.StackTrace,
                    Comment = ex.Message,
                    UserId = GetUserId(con),
                    State = (int)RequestState.RequestError,
                    Id = res.Id
                });
                throw;
            }
        }

        private void CheckSign(NbuServiceResponse data)
        {
            bool res = true;
            // here do something to check sign
            if (string.IsNullOrWhiteSpace(data.Sign)) res = false;

            if (!res) throw new SagoException("Відбулась помилка при перевірці підпису", RequestState.SignCheckError, data.ToString());
        }

        #region save request
        private ReqSaveRes SaveRequest(OracleConnection con, NbuServiceResponse data)
        {
            return SaveRequest(con, new VRequestsRow()
            {
                UserId = GetUserId(con),
                Data = JsonConvert.SerializeObject(data),
                DocCount = data.Data.Operations.Rows.Count,
                State = (int)RequestState.SignChecked
            }, data.Data.Operations.TotalSum);
        }

        private ReqSaveRes SaveRequest(OracleConnection con, VRequestsRow req, long totalSum = 0)
        {
            if (RequestExists(con, req.Id))
            {
                UpdateRequestState(con, req.Id, (RequestState)req.State, req.Comment);
                return null;
            }
            ReqSaveRes res = new ReqSaveRes() { CountDocs = req.DocCount, TotalSum = totalSum };

            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pReqId = new OracleParameter("p_req_id", OracleDbType.Decimal, ParameterDirection.Output),
                                  pErrMsg = new OracleParameter("p_err_mess", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sago_utl.ins_request";
                cmd.BindByName = true;

                cmd.Parameters.Add(new OracleParameter("p_create_date", OracleDbType.Date, req.CreateDate, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_data", OracleDbType.Clob, req.Data, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_state", OracleDbType.Decimal, req.State, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_comm", OracleDbType.Varchar2, 1000, req.Comment, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_user_id", OracleDbType.Decimal, req.UserId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_doc_count", OracleDbType.Decimal, req.DocCount, ParameterDirection.Input));
                cmd.Parameters.Add(pReqId);
                cmd.Parameters.Add(pErrMsg);

                cmd.ExecuteNonQuery();

                OracleDecimal _pId = (OracleDecimal)pReqId.Value;
                if (!_pId.IsNull)
                    res.Id = _pId.Value;

                OracleString _pErrMsg = (OracleString)pErrMsg.Value;
                if (!_pErrMsg.IsNull)
                    res.ErrMsg = _pErrMsg.Value;
            }
            return res;
        }

        private bool RequestExists(OracleConnection con, decimal? requestId)
        {
            if (null == requestId) return false;

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select count(*) from sago_requests where id = :p_id";
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, requestId, ParameterDirection.Input);

                var cnt = cmd.ExecuteScalar();
                if (null == cnt || Convert.ToInt32(cnt) == 0) return false;
                else if (Convert.ToInt32(cnt) > 0) return true;
                return false;
            }
        }
        #endregion

        #region save documents
        private SaveDocumentsResult SaveDocuments(OracleConnection con, List<OperationRow> docs, decimal? requestId)
        {
            SaveDocumentsResult result = new SaveDocumentsResult();
            try
            {
                foreach (OperationRow document in docs)
                {
                    SaveDocumentsResult tmpRes = SaveDocument(con, document, requestId);
                    result.CountSaved += tmpRes.CountSaved;
                    result.Sum += tmpRes.Sum;
                }
                UpdateRequestState(con, requestId, RequestState.DocumentsCreated);
            }
            catch (Exception ex)
            {
                UpdateRequestState(con, requestId, RequestState.CreateDocumentsError, ex.Message);
            }
            return result;
        }
        private SaveDocumentsResult SaveDocument(OracleConnection con, OperationRow doc, decimal? requestId)
        {
            SaveDocumentsResult result = new SaveDocumentsResult();
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter errMsg = new OracleParameter("P_ERR_MESS", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                                    isIns = new OracleParameter("P_IS_INS", OracleDbType.Decimal, ParameterDirection.Output))
            {
                cmd.CommandText = "sago_utl.ins_document";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("p_ref_sago", OracleDbType.Decimal, doc.RefSago, ParameterDirection.Input);
                cmd.Parameters.Add("p_act", OracleDbType.Varchar2, doc.OperationCode, ParameterDirection.Input);
                cmd.Parameters.Add("p_act_type", OracleDbType.Decimal, doc.OperationType, ParameterDirection.Input);
                cmd.Parameters.Add("p_act_date", OracleDbType.Date, doc.OperationDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_total_amount", OracleDbType.Decimal, doc.TotalSum, ParameterDirection.Input);
                cmd.Parameters.Add("p_reg_id", OracleDbType.Decimal, doc.RegionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_f_state", OracleDbType.Decimal, doc.OperationState, ParameterDirection.Input);
                cmd.Parameters.Add("p_n_doc", OracleDbType.Varchar2, doc.PermissionNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_d_doc", OracleDbType.Date, doc.PermissionDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, doc.UserId, ParameterDirection.Input);
                cmd.Parameters.Add("p_fio_reg", OracleDbType.Varchar2, doc.PibReg, ParameterDirection.Input);
                cmd.Parameters.Add("p_sign", OracleDbType.Varchar2, Guid.NewGuid(), ParameterDirection.Input);
                cmd.Parameters.Add("p_request_id", OracleDbType.Decimal, requestId, ParameterDirection.Input);
                cmd.Parameters.Add(isIns);
                cmd.Parameters.Add(errMsg);

                cmd.ExecuteNonQuery();

                string errorMessage = "";
                OracleString _err = (OracleString)errMsg.Value;
                if (!_err.IsNull)
                    errorMessage = _err.Value;

                OracleDecimal res = (OracleDecimal)isIns.Value;
                result.CountSaved = res.IsNull ? 0 : Convert.ToInt32(res.Value);
                result.Sum = result.CountSaved > 0 ? doc.TotalSum : 0;
            }
            return result;
        }
        #endregion

        #region create payments
        private void CreatePayments(OracleConnection con, decimal? requestId)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "sago_utl.create_payment";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_req_id", OracleDbType.Decimal, ParameterDirection.Input) { Value = requestId });

                cmd.ExecuteNonQuery();
            }
        }
        #endregion
        private void UpdateRequestState(OracleConnection con, decimal? requestId, RequestState state, string comment = "")
        {
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter _state = new OracleParameter("p_state", OracleDbType.Decimal, (int)state, ParameterDirection.Input),
                               _requestId = new OracleParameter("p_req_id", OracleDbType.Decimal, requestId, ParameterDirection.Input),
                                    _comm = new OracleParameter("p_comm", OracleDbType.Varchar2, comment, ParameterDirection.Input))
            {
                cmd.CommandText = "sago_utl.set_request_state";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(_requestId);
                cmd.Parameters.Add(_state);
                cmd.Parameters.Add(_comm);

                cmd.ExecuteNonQuery();
            }
        }
        private NbuServiceResponse GetDataFromNbu(string serverUrl, string requestUrl, string user, string password, string domain)
        {
            ///// NbuServiceResponse 
            //string fileData = System.IO.File.ReadAllText(@"D:\20180906.json");
            //NbuServiceResponse res = JsonConvert.DeserializeObject<NbuServiceResponse>(fileData);
            //return res;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(requestUrl);
            CredentialCache credentialCache = new CredentialCache();
            credentialCache.Add(new Uri(serverUrl), "NTLM", new NetworkCredential(user, password, domain));

            request.Method = "GET";
            request.ContentType = "application/json; charset=utf-8";
            request.Credentials = credentialCache;

            ServicePointManager.ServerCertificateValidationCallback = ((sender, certificate, chain, sslPolicyErrors) => true);
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Ssl3 | (SecurityProtocolType)3072 | (SecurityProtocolType)768;

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (Stream responseStream = response.GetResponseStream())
            using (StreamReader sr = new StreamReader(responseStream, Encoding.UTF8))
            {
                string responseString = sr.ReadToEnd();

                if (response.StatusCode != HttpStatusCode.OK)
                    throw new SagoException(string.Format("{0} : {1}" + Environment.NewLine + "{2}", (int)response.StatusCode, response.StatusDescription), RequestState.RequestError, responseString);

                NbuServiceResponse res = JsonConvert.DeserializeObject<NbuServiceResponse>(responseString);
                if (res.ErrorCode != 0)
                    throw new SagoException(string.Format("Error. Code : {0}, Message : {1}", res.ErrorCode, res.ErrorMessage), RequestState.RequestError, responseString);

                return res;
            }
        }

        #region private methods
        private NbuServiceResponse FilterData(NbuServiceResponse totalData, short regionId, string date, string mfo)
        {
            if (totalData.Data.Operations == null) throw new SagoException(string.Format("За дату {0} даних не знайдено", DateStr(date)), RequestState.RequestError, totalData.ToString());
            totalData.Data.Operations.Rows = totalData.Data.Operations.Rows.Where(x => x.RegionId == regionId).ToList();

            if (totalData.Data.Operations.Rows.Count <= 0) throw new SagoException(string.Format("По МФО={0}, за дату {1} даних не знайдено", mfo, DateStr(date)), RequestState.RequestError, totalData.ToString());

            return totalData;
        }
        private string DateStr(string date)
        {
            string y = date.Substring(0, 4);
            string m = date.Substring(4, 2);
            string d = date.Substring(6, 2);

            return string.Format("{0}.{1}.{2}", d, m, y);
        }
        private string GetMfo(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                //cmd.CommandText = "select f_ourmfo() from dual";
                cmd.CommandText = "select bc.current_branch_code from dual";
                object res = cmd.ExecuteScalar();
                //if (res.IsNullOrEmpty()) throw new Exception(@"Використання даного функціоналу не можливе на бранчі = '/'");
                if (res.IsNullOrEmpty()) throw new Exception(@"Не виконано логін!!!");

                string strRes = Convert.ToString(res);
                if (strRes.Length != 15) throw new Exception("Для того щоб імпортувати документи, перейдіть на другий рівень.");

                return strRes.Substring(1, 6);
            }
        }
        private decimal GetUserId(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select sys_context('bars_global', 'user_id') from dual";
                object tmpRes = cmd.ExecuteScalar();
                if (tmpRes.IsNullOrEmpty()) throw new Exception("Unexpected error! user_id not found!");
                return Convert.ToDecimal(tmpRes);
            }
        }
        private short GetRegionIdByMfo(OracleConnection con, string mfo)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select reg_id from SAGO_REGION where kf = :p_mfo";
                cmd.Parameters.Add(new OracleParameter("p_mfo", OracleDbType.Varchar2, ParameterDirection.Input) { Value = mfo });

                var res = cmd.ExecuteScalar();
                if (res.IsNullOrEmpty()) throw new Exception("Не знайдено налаштування регіону для МФО=" + mfo);

                return Convert.ToInt16(res);
            }
        }

        #endregion
    }

    public static class SagoExts
    {
        public static bool IsNullOrEmpty(this object o)
        {
            if (null == o) return true;
            return string.IsNullOrWhiteSpace(o.ToString());
        }
    }
}
