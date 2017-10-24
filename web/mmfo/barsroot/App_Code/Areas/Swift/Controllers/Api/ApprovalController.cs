using Areas.Swift.Models;
using AttributeRouting.Web.Http;
using Bars.DocPrint;
using Bars.Oracle;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class ApprovalController : ApiController
    {
        readonly ISwiftRepository _repo;
        public ApprovalController(ISwiftRepository repo) { _repo = repo; }

        [HttpGet]
        [GET("/api/listApprovals")]
        public HttpResponseMessage ListApprovals([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                IEnumerable<Approvals> data = _repo.ExecuteStoreQuery<Approvals>(SqlCreatorApprovals.ListApprovals());
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/searchApprovals")]
        public HttpResponseMessage SearchApprovals([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string g_grpid)
        {
            try
            {
                BarsSql sql = SqlCreatorApprovals.SearchApprovals(g_grpid);
                var data = _repo.SearchGlobal<ApprovalsResult>(request, sql);
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

        [HttpGet]
        [GET("/api/vvisalist")]
        public HttpResponseMessage VvisaList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? g_cDocRef)
        {
            try
            {
                decimal dataCount = 0;
                IEnumerable<VvisaList> data = new List<VvisaList>();
                if (g_cDocRef.HasValue)
                {
                    BarsSql sql = SqlCreatorApprovals.VvisaList(g_cDocRef.Value);
                    dataCount = _repo.CountGlobal(request, sql);
                    data = _repo.SearchGlobal<VvisaList>(request, sql);                    
                }                
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
        [POST("/api/approve")]
        public HttpResponseMessage Approve(List<Approve> obj)
        {
            try
            {
                List<string> errorsStr = new List<string>();
                List<Approve> errors = new List<Approve>();
                foreach (Approve doc in obj)
                {
                    try
                    {
                        BarsSql sql = SqlCreatorApprovals.Approve(doc.cDocRef, doc.cSwRef, doc.nChkGrpId);
                        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                    }
                    catch (Exception e)
                    {
                        errors.Add(doc);
                        errorsStr.Add(e.Message);
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { Errors = errors, ErrorsStr = errorsStr });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/canselapprove")]
        public HttpResponseMessage CanselApprove(List<Approve> obj)
        {
            try
            {
                foreach (Approve doc in obj)
                {
                    BarsSql sql = SqlCreatorApprovals.CanselApprove(doc.cDocRef, doc.cSwRef, doc.nChkGrpId, doc.nBackReasonId);
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
        [GET("/api/canselreasons")]
        public HttpResponseMessage CanselReasons([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                IEnumerable<CanselReasons> data = _repo.ExecuteStoreQuery<CanselReasons>(SqlCreatorApprovals.CanselReasons());
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/genfullmessage")]
        public HttpResponseMessage GenFullMessage(Approve obj)
        {
            try
            {
                BarsSql sql = SqlCreatorApprovals.GenFullMessage(obj.cSwRef, obj.mt);
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
        [POST("/api/approvalgetfileforprint")]
        public string GetFileForPrint(FilePrintData id)
        {
            var conn = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection con = conn.GetUserConnection(System.Web.HttpContext.Current);
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                var outTicket = new cDocPrint(con, id.Refs[0], System.Web.Hosting.HostingEnvironment.MapPath("/TEMPLATE.RPT/"), id.IsPrintModel);
                if (id.Refs.Count > 1)
                {
                    var sw = new StreamWriter(outTicket.GetTicketFileName(), true);

                    for (int i = 1; i < id.Refs.Count; i++)
                    {
                        var ticCon = conn.GetUserConnection(System.Web.HttpContext.Current);
                        try
                        {
                            var ourTick = new cDocPrint(ticCon, id.Refs[i], System.Web.Hosting.HostingEnvironment.MapPath("/TEMPLATE.RPT/"), id.IsPrintModel);
                            string text = File.ReadAllText(ourTick.GetTicketFileName(), Encoding.ASCII);
                            sw.WriteLine(text);

                            ourTick.DeleteTempFiles();
                        }
                        catch (Exception e)
                        {
                            var t = e;
                        }
                        finally
                        {
                            if (System.Data.ConnectionState.Open == ticCon.State) ticCon.Close();
                            ticCon.Dispose();
                        }
                    }
                    sw.Close();
                }
                return outTicket.GetTicketFileName();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }
    }    
}
