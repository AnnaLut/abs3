using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Bars.Classes;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Dapper;
using System.Data;
using Oracle.DataAccess.Client;
using System.Web.Services;
using Oracle.DataAccess.Types;
using Kendo.Mvc.Extensions;
using System.Text.RegularExpressions;

namespace BarsWeb.Areas.Sep.Controllers
{
    //[CheckAccessPage]
    [AuthorizeUser]
    public class SepLockDocsController : ApplicationController
    {
        private readonly ISepLockDocsRepository _repo;
        private IParamsRepository _kernelParams;
        private readonly IKendoRequestTransformer _requestTransformer;
        public SepLockDocsController(ISepLockDocsRepository repo, IParamsRepository kernelParams, IKendoRequestTransformer requestTransformer)
        {
            _requestTransformer = requestTransformer;
            _kernelParams = kernelParams;
            _repo = repo;
            
        }

        public ActionResult Index()
        {
            ViewBag.MFO = _kernelParams.GetParam("MFO").Value;
            ViewBag.IsValidDate = _repo.isValidUserBankDate();
            ViewBag.IsAutoStp = _repo.isSepAuto();
            return View();
        }

        public ActionResult LockDocsRO()
        {
            ViewBag.MFO = _kernelParams.GetParam("MFO").Value;
            ViewBag.IsValidDate = _repo.isValidUserBankDate();
            return View();
        }

        public ActionResult Detail()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var detailList = connection.Query<Detail>("select * from v_blk_doc_summary").ToList();
                return Json(new { Data = detailList, Total = 0 }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult UnlockByCode(decimal code, decimal val, string summa)
        {
            using(var connection = OraConnector.Handler.UserConnection)
            {
                decimal sum = 0;
                if (!string.IsNullOrEmpty(summa))
                {
                    string s1="";
                    var ss = summa.ToCharArray();
                    foreach(var item in ss)
                    {
                        if(item != 160)
                            s1 += item.ToString();
                       
                    }
                    sum = decimal.Parse(s1.Replace(".",","));
                }


                var p = new DynamicParameters();
                p.Add("p_sum", sum * 100, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_kv", val, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_blk", code, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_msg", null, DbType.String, ParameterDirection.Output, 4000);
                connection.Execute("SEP_UTL.unlock_by_sum_blk", p, commandType: System.Data.CommandType.StoredProcedure);

                var msg = p.Get<string>("p_msg");
                //connection.Execute("SEP_UTL.UNLOCK_BY_CODE", p, commandType: System.Data.CommandType.StoredProcedure);
                return Json(new { Result = "OK", Msg = msg }, JsonRequestBehavior.AllowGet); 
                }
        }

        [HttpPost]
        [WebMethod]
        public ActionResult UnlockBySumm(Unlock model)
        {
            var connection = OraConnector.Handler.UserConnection;
            string message = "";
            try
            {
                var command = new OracleCommand("sep_utl.unlock_by_sum", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                var approveListParam = new OracleParameter("p_reclist", OracleDbType.Array, model.id.Length, model.id, ParameterDirection.Input);
                approveListParam.UdtTypeName = "NUMBER_LIST";
                command.Parameters.Add("p_sum", OracleDbType.Decimal, model.summa, ParameterDirection.Input);
                command.Parameters.Add(approveListParam);
                command.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.ExecuteNonQuery();
                message = ((OracleString)command.Parameters["p_msg"].Value).IsNull ? string.Empty : ((OracleString)command.Parameters["p_msg"].Value).Value;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Json(new { Result = "OK", Msg = message }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetSepLockDoc([DataSourceRequest] DataSourceRequest request, int? DefCode, string parameters, string fixedBlk = null, string swt = null)
        {
            int def = DefCode == null ? 0 : DefCode.Value;
            //var _request = _requestTransformer.MultiplyFilterValue(request, new string[] { "s" });
            var res = _repo.GetSepLockDoc(def, 0, request, parameters, fixedBlk, swt).ToList();
            var total = _repo.GetSepLockDocCount(def, 0, request, parameters, fixedBlk, swt);
            return Json(new { Data = res, Total = total }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GeSepLockDocsByCodeCount(int? DefCode, int Code, string parameters, [DataSourceRequest] DataSourceRequest request)
        {
            int def = DefCode == null ? 0 : DefCode.Value;
            var _request = _requestTransformer.MultiplyFilterValue(request, new string[] { "s" });
            var count = _repo.GetSepLockDocCount(def, Code, _request, parameters);
            return Json(new { Count = count, status = JsonResponseStatus.Ok}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSepLockDocResource([DataSourceRequest] DataSourceRequest request)
        {
            var resource = _repo.GetSepLockDocResource(request);
            return Json(new { Resource = resource }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSepLockDocs(string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteSepLockDocs(listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSepLockDocsByCode(int? DefCode, int Code, string parameters, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.DeleteSepLockDocsByCode(def, Code, parameters, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        public ActionResult ReturnSepLockDocs(string Reason, string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
               _repo.ReturnSepLockDocs(Reason, listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ReturnSepLockDocsByCode(string Reason, int? DefCode, int Code, string parameters, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.ReturnSepLockDocsByCode(Reason, def, Code, parameters, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UnLockSepLockDocs(string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repo.UnlockSepLockDocs(listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UnLockSepLockDocsByCode(int? DefCode, int Code, string parameters, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.UnLockSepLockDocsByCode(def, Code, parameters, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AcceptSepLockDocs(string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repo.UnlockSepDocsTo902(listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AcceptSepLockDocsByCode(int? DefCode, int Code, string parameters, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.UnlockSepDocsTo902ByCode(def, Code, parameters, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult BlockedDocumentsToExcelFile(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
        }


        [HttpGet]
        public ActionResult GetBIS(decimal rec)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var account = _repo.GetBIS(rec);
                return Json(account, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;

                return Json(e.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetCodes()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var codes = connection.Query<Int32>(@"SELECT distinct BLK rule
                                                      FROM V_RECQUE_ARCRRP_DATA, bp_rrp, s_er
                                                      WHERE V_RECQUE_ARCRRP_DATA.blk = bp_rrp.rule(+)
                                                      AND V_RECQUE_ARCRRP_DATA.blk = S_ER.K_ER(+)
                                                      GROUP BY BLK
                                                      ORDER BY blk").ToList();
                return Json(new { Data = codes }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult UnlockByCodeAndSum(decimal code, string summa)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                decimal sum;
                decimal.TryParse(summa, out sum);

                var p = new DynamicParameters();
                p.Add("p_func", 1, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_sum", sum * 100, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_blk", code, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_msg", null, DbType.String, ParameterDirection.Output, 4000);
                try
                {
                    connection.Execute("SEP_UTL.unlock_by_func", p, commandType: System.Data.CommandType.StoredProcedure);
                }
                catch (Exception e)
                {
                    return Json(new { Result = "Error", Msg = e.Message }, JsonRequestBehavior.AllowGet);
                }

                var msg = p.Get<string>("p_msg");
                return Json(new { Result = "OK", Msg = msg }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult UnlockBudget(decimal code)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_func", 2, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_blk", code, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_msg", null, DbType.String, ParameterDirection.Output, 4000);
                try
                {
                    connection.Execute("SEP_UTL.unlock_by_func", p, commandType: System.Data.CommandType.StoredProcedure);
                }
                catch (Exception e)
                {
                    return Json(new { Result = "Error", Msg = e.Message }, JsonRequestBehavior.AllowGet);
                }

                var msg = p.Get<string>("p_msg");
                return Json(new { Result = "OK", Msg = msg }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult UnlockByMfo(decimal code, string mfo)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_func", 3, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_blk", code, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_mfob", mfo, DbType.String, ParameterDirection.Input);
                p.Add("p_msg", null, DbType.String, ParameterDirection.Output, 4000);
                try
                {
                    connection.Execute("SEP_UTL.unlock_by_func", p, commandType: System.Data.CommandType.StoredProcedure);
                }
                catch (Exception e)
                {
                    return Json(new { Result = "Error", Msg = e.Message }, JsonRequestBehavior.AllowGet);
                }

                var msg = p.Get<string>("p_msg");
                return Json(new { Result = "OK", Msg = msg }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult UnlockAllByCode(decimal code)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_func", 4, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_blk", code, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_msg", null, DbType.String, ParameterDirection.Output, 4000);
                try
                {
                    connection.Execute("SEP_UTL.unlock_by_func", p, commandType: System.Data.CommandType.StoredProcedure);
                }
                catch (Exception e)
                {
                    return Json(new { Result = "Error", Msg = e.Message }, JsonRequestBehavior.AllowGet);
                }

                var msg = p.Get<string>("p_msg");
                return Json(new { Result = "OK", Msg = msg }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult SetFlagStp(int isFlagged)
        {
            using( var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_value", isFlagged, DbType.Decimal, ParameterDirection.Input);
                try
                {
                    connection.Execute("SEP_UTL.set_STP_AUTO", p, commandType: System.Data.CommandType.StoredProcedure);
                }
                catch (Exception e)
                {
                    return Json(new { Result = "Error", Msg = e.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            return Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetFlagStp()
        {
            bool isSepAuto = _repo.isSepAuto();
            return Json(new { Data = isSepAuto }, JsonRequestBehavior.AllowGet);
        }
    }
}