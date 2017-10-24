using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using Areas.Swift.Models;
using System.Globalization;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class SwiftClaimsController: ApiController
    {
        const string DATE_FORMAT_DOC_KVIT = "dd/MM/yyyy";
        readonly Dictionary<decimal, string> swVisa900;
        readonly ISwiftRepository _repo;
        public SwiftClaimsController(ISwiftRepository repo)
        {
            _repo = repo;
            swVisa900 = new Dictionary<decimal, string>();
            swVisa900.Add(900, "SW_VISA900");
            swVisa900.Add(910, "SW_VISA910");
        }

        [HttpGet]
        [GET("/api/searchclaims")]
        public HttpResponseMessage SearchClaims([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string sFILTR, char strIoInd='O')
        {
            try
            {
                BarsSql sql = SqlCreator.SwiftClaims(sFILTR, strIoInd);
                var data = _repo.SearchGlobal<SwiftClaims>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/claimsrowdatacent")]
        public HttpResponseMessage СlaimsRowDataCent(СlaimsRowRequestData obj)
        {
            try
            {
                var data = _repo.ExecuteStoreQuery<ClaimsRowData>(SqlCreator.ClaimsRowData(obj.SWREF));
                var senderTitle = _repo.ExecuteStoreQuery<ClaimsRowTitle>(SqlCreator.ClaimsRowTitle(obj.SENDER));
                var receiverTitle = _repo.ExecuteStoreQuery<ClaimsRowTitle>(SqlCreator.ClaimsRowTitle(obj.RECEIVER));

                return Request.CreateResponse(HttpStatusCode.OK, new
                {
                    Data = data,
                    SenderTitle = senderTitle,
                    ReceiverTitle = receiverTitle
                });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/claimsrowdata")]
        public HttpResponseMessage СlaimsRowData(СlaimsRowRequestData obj)
        {
            try
            {
                IEnumerable<ClaimsRowData> data = _repo.ExecuteStoreQuery<ClaimsRowData>(SqlCreator.ClaimsRowData(obj.SWREF));
                IEnumerable<ClaimsRowTitle> senderTitle = _repo.ExecuteStoreQuery<ClaimsRowTitle>(SqlCreator.ClaimsRowTitle(obj.SENDER));
                IEnumerable<ClaimsRowTitle> receiverTitle = _repo.ExecuteStoreQuery<ClaimsRowTitle>(SqlCreator.ClaimsRowTitle(obj.RECEIVER));

                return Request.CreateResponse(HttpStatusCode.OK, new {
                    Data = new
                    {
                        SenderTitle = senderTitle.Single().name,
                        ReceiverTitle = receiverTitle.Single().name,
                        Result = data.Single().RESULT
                    }
                });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/impmsgmessagechangeuser")]
        public HttpResponseMessage ImpmsgMessageChangeuser(IList<ClaimsImpmsgMessageChangeuser> obj)
        {
            try
            {
                foreach (ClaimsImpmsgMessageChangeuser msg in obj)
                {
                    BarsSql sql = SqlCreator.ClaimsImpmsgMessageChangeuser(msg);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/listOperationsForProcessing")]
        public HttpResponseMessage ListOperationsForProcessing([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, byte sUserF, string strIoInd)
        {
            try
            {
                IEnumerable<OperationsForProcessingResult> data = _repo.ExecuteStoreQuery<OperationsForProcessingResult>(SqlCreator.ListOperationsForProcessing(new OperationsForProcessing { sUserF = sUserF , strIoInd = strIoInd}));
                //OperationsForProcessingResult[] data = { new OperationsForProcessingResult { TT = "D07", NAME = "D07" } };
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/docForKvit")]
        public HttpResponseMessage DocForKvit([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, bool isDocForKvit2, string Ccy, string strVDocMin, string strVDocMax, long? AccDb, long? AccKr, decimal? Amnt, long? Ref, string Tag20)
        {
            try
            {
                BarsSql sql = null;
                if (isDocForKvit2)
                {
                    if (Ref != null && Ref.HasValue)
                    {
                        sql = SqlCreator.DocForKvit(Ref.Value);
                    }
                    else{
                        sql = SqlCreator.DocForKvit(DateTime.ParseExact(strVDocMin, DATE_FORMAT_DOC_KVIT, 
                            CultureInfo.InvariantCulture), 
                            DateTime.ParseExact(strVDocMax, DATE_FORMAT_DOC_KVIT, CultureInfo.InvariantCulture));
                    }
                }
                else
                {
                    sql = SqlCreator.DocForKvit(Ccy, 
                        DateTime.ParseExact(strVDocMin, DATE_FORMAT_DOC_KVIT, 
                        CultureInfo.InvariantCulture), 
                        DateTime.ParseExact(strVDocMax, DATE_FORMAT_DOC_KVIT, CultureInfo.InvariantCulture), 
                        AccDb, AccKr, Amnt, Tag20);
                }
                
                IEnumerable<DocForKvit> data = _repo.SearchGlobal<DocForKvit>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, SqlCreator.DocForKvit(Ccy, strVDocMin, strVDocMax, AccDb, AccKr, Amnt, Tag20));

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = (request.Page * request.PageSize) + 1 });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/impmsgDocumentLink")]
        public HttpResponseMessage ImpmsgDocumentLink(ImpMsgDocumentLink obj)
        {
            try
            {
                BarsSql sql = SqlCreator.ImpmsgDocumentLink(obj);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }
        
        [HttpPost]
        [POST("/api/fullpaymentdata")]
        public HttpResponseMessage FullPaymentData(FullPaymentData obj)
        {
            try
            {
                IEnumerable<TransbackInfoResult> tbi = _repo.ExecuteStoreQuery<TransbackInfoResult>(SqlCreator.TransbackInfo(obj.SENDER));
                TransbackInfoResult TransbackInfo = tbi.FirstOrDefault();

                IEnumerable<BankNameResult> bn = _repo.ExecuteStoreQuery<BankNameResult>(SqlCreator.BankName(obj.SWREF));
                BankNameResult BankName = bn.FirstOrDefault();

                IEnumerable<CurrencyCodeResult> cc = _repo.ExecuteStoreQuery<CurrencyCodeResult>(SqlCreator.CurrencyCode(obj.SLCV));
                CurrencyCodeResult CurrencyCode = cc.FirstOrDefault();

                IEnumerable<PaymentData> pd = _repo.ExecuteStoreQuery<PaymentData>(SqlCreator.PaymentData(obj.TT));
                PaymentData Payment = pd.FirstOrDefault();

                DateTime bankdate = _repo.ExecuteStoreQuery<DateTime>(SqlCreator.Bankdate()).FirstOrDefault();

                string tt = null;
                if (obj.is_TransactionType)
                {
                    tt = _repo.ExecuteStoreQuery<string>(SqlCreator.TransactionType(obj.SWREF, obj.g_sUserF)).FirstOrDefault();
                }

                BarsSql sql;

                P_GET_RCVR data = new P_GET_RCVR();
                if (obj.IS_IMPMSGDOCGETPARAMS)
                {
                    sql = SqlCreator.PGetRcvr(obj.SWREF);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                    try { data.okpo_ = ((OracleParameter)sql.SqlParams[1]).Value.ToString(); }
                    catch (Exception e) { }
                    try { data.mfo_ = ((OracleParameter)sql.SqlParams[2]).Value.ToString(); }
                    catch (Exception e) { }
                    try { data.nls_ = ((OracleParameter)sql.SqlParams[3]).Value.ToString(); }
                    catch (Exception e) { }
                    try { data.kv_ = decimal.Parse(((OracleParameter)sql.SqlParams[4]).Value.ToString()); }
                    catch (Exception e) { }
                    try { data.nazv_ = ((OracleParameter)sql.SqlParams[5]).Value.ToString(); }
                    catch (Exception e) { }
                    try { data.sum_ = decimal.Parse(((OracleParameter)sql.SqlParams[6]).Value.ToString()); }
                    catch (Exception e) { }
                    try { data.datv_ = DateTime.Parse(((OracleParameter)sql.SqlParams[7]).Value.ToString()); }
                    catch (Exception e) { }
                    try { data.val_ = decimal.Parse(((OracleParameter)sql.SqlParams[8]).Value.ToString()); }
                    catch (Exception e) { }
                }

                ImpmsgDocumentParams dataIDP = new ImpmsgDocumentParams();                
                sql = SqlCreator.ImpmsgDocumentGetparams(obj.SWREF);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);                    
                    
                try { dataIDP.p_docMfoB = ((OracleParameter)sql.SqlParams[1]).Value.ToString(); }
                catch (Exception e) { }
                try { dataIDP.p_docCurCode = decimal.Parse(((OracleParameter)sql.SqlParams[2]).Value.ToString()); }
                catch (Exception e) { }
                try { dataIDP.p_docAccNum = ((OracleParameter)sql.SqlParams[3]).Value.ToString(); }
                catch (Exception e) { }
                try { dataIDP.p_docRcvrId = ((OracleParameter)sql.SqlParams[4]).Value.ToString(); }
                catch (Exception e) { }
                try { dataIDP.p_docRcvrName = ((OracleParameter)sql.SqlParams[5]).Value.ToString(); }
                catch (Exception e) { }
                try { dataIDP.p_docAmount = decimal.Parse(((OracleParameter)sql.SqlParams[6]).Value.ToString()); }
                catch (Exception e) { }
                try { dataIDP.p_docValueDate = DateTime.Parse(((OracleParameter)sql.SqlParams[7]).Value.ToString()); }
                catch (Exception e) { }

                ///operwData
                IEnumerable<OperwData> operwData = _repo.ExecuteStoreQuery<OperwData>(SqlCreator.ClaimsRowDataObject(obj.SWREF));
                List<OperwData> operwDataList = operwData.ToList();

                string NLS_53 = string.Empty;
                string NLS_54 = string.Empty;

                foreach (OperwData op in operwDataList)
                {
                    if (!string.IsNullOrEmpty(op.value))
                    {
                        if(op.tag == "50" || op.tag == "70")
                        {
                            op.swift2Str = _repo.ExecuteStoreQuery<string>(SqlCreator.SwiftToStr(string.Format("{0}\r\n", op.value), "RUR6")).FirstOrDefault();
                        }

                        if (op.tag == "53")
                        {
                            NLS_53 = _repo.ExecuteStoreQuery<string>(SqlCreator.NlsFromV_CORR_ACC(op.value, obj.SLCV)).FirstOrDefault();
                        }
                        if (op.tag == "54")
                        {
                            NLS_54 = _repo.ExecuteStoreQuery<string>(SqlCreator.NlsFromV_CORR_ACC(op.value, obj.SLCV)).FirstOrDefault();
                        }
                    }
                }
                
                string NLS_V_CORR_ACC = !string.IsNullOrEmpty(NLS_54) ? NLS_54 : NLS_53;

                return Request.CreateResponse(HttpStatusCode.OK, new {
                    NLS_V_CORR_ACC = NLS_V_CORR_ACC,
                    TT = tt,
                    Bankdate = bankdate,
                    OperwData = operwDataList,
                    TransbackInfo = TransbackInfo,
                    BankName = BankName,
                    CurrencyCode = CurrencyCode,
                    Payment = Payment,
                    PGetRcvr = data,
                    ImpDocParams = dataIDP      // empty for obj.IS_IMPMSGDOCGETPARAMS = false
                });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/loadglobaloption")]
        public HttpResponseMessage LoadGlobalOption(IList<string> data)
        {
            try
            {
                Dictionary<string, Params> result = new Dictionary<string, Params>();
                foreach (string id in data)
                {
                    Params p = _repo.GetParam(id);
                    result.Add(id, _repo.GetParam(id));
                } 
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/stmtdocumentlink")]
        public HttpResponseMessage StmtDocumentLink(StmtDocumentLink obj)
        {
            try
            {
                BarsSql sql = SqlCreator.StmtDocumentLink(obj);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/swiftusers")]
        public HttpResponseMessage SwiftUsers(SwiftUsers obj)
        {
            try
            {
                IEnumerable<SwiftUsersResult> data = _repo.ExecuteStoreQuery<SwiftUsersResult>(SqlCreator.SwiftUsers(obj.io));
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/impmsgmessagedelete")]
        public HttpResponseMessage ImpmsgMessageDelete(IList<decimal> data)
        {
            try
            {
                foreach (decimal swref in data)
                {
                    BarsSql sql = SqlCreator.ImpmsgMessageDelete(swref);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }        

        [HttpPost]
        [POST("/api/signmt900")]
        public HttpResponseMessage SignMT900(MT900Data obj)
        {
            try
            {
                BarsSql sql = SqlCreator.NextVisa(obj.nRef);
                NextVisaData nextVisa = _repo.ExecuteStoreQuery<NextVisaData>(sql).FirstOrDefault();

                Params nGrpParam = _repo.GetParam(swVisa900[obj.nMt]);
                short nTmp = 0;     // be careful

                int nGrp = Convert.ToInt32(nGrpParam.Value);
                string sVisaHex = nGrp.ToString("X");
                if (sVisaHex == nextVisa.sNextVisa && (nextVisa.sTt != "NOS" || obj.nMt == 900))
                {
                    sql = SqlCreator.TtsFlags(obj.nMt == 900 ? "NOS" : nextVisa.sTt);
                    string flags = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                    flags = flags.Substring(37, 1);
                    nTmp = Convert.ToInt16(flags);
                    nTmp++;

                    sql = SqlCreator.Pay(obj.nRef);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                    sql = SqlCreator.PutNos(obj.nRef, nGrp);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                }
                return Request.CreateResponse(HttpStatusCode.OK, new {
                    nRef = obj.nRef,
                    nGrp = nGrp,
                    nTmp = nTmp
                });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swiftgetsigninfo")]
        public HttpResponseMessage SwiftGetSignInfo()
        {
            try
            {
                BarsSql sql = SqlCreator.GetSignInfo();
                SwiftSignInfo signInfo = _repo.ExecuteStoreQuery<SwiftSignInfo>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = signInfo });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swiftgetgrp")]
        public HttpResponseMessage SwiftGetGrp(MT900Data obj)
        {
            try
            {
                int sos = 0;
                try
                {
                    sos = _repo.ExecuteStoreQuery<int>(SqlCreator.Sos(obj.nRef)).FirstOrDefault();
                }
                catch (Exception e) { }
                    
                Params nGrpParam = _repo.GetParam(swVisa900[obj.nMt]);
                int nGrp = Convert.ToInt32(nGrpParam.Value);
                return Request.CreateResponse(HttpStatusCode.OK, new { nGrp = nGrp, sos = sos });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/opervisa")]
        public HttpResponseMessage OperVisa(OperVisaData obj)
        {
            try
            {
                BarsSql sql = null;
                byte[] Sign = { };
                string strKeyId = string.Empty;
                if (obj.visaSign)
                {
                    sql = SqlCreator.GetIdOper();
                    strKeyId = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                    Sign = System.Text.Encoding.UTF8.GetBytes(obj.m_lsSign);
                }
                sql = SqlCreator.OperVisa(obj.nRef, obj.nGrp, obj.nTmp, Sign, obj.visaSign, strKeyId);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new { nRef = obj.nRef });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swiftsessiondata")]
        public HttpResponseMessage SwiftSetSessionData(SwiftSessionData obj)
        {
            try
            {
                if (!string.IsNullOrEmpty(obj.Value))
                {
                    HttpContext.Current.Session[obj.Key] = obj.Value;
                }
                else
                {
                    HttpContext.Current.Session.Remove(obj.Key);
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
