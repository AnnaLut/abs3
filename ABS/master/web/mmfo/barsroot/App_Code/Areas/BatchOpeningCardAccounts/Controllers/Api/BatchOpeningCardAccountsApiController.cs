using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.BatchOpeningCardAccounts.Infrastructure.DI.Abstract;
using BarsWeb.Areas.BatchOpeningCardAccounts.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.BatchOpeningCardAccounts.Models;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.BatchOpeningCardAccounts.Controllers.Api
{
    public class BatchOpeningCardAccountsController: ApiController
    {
        readonly IBatchOpeningCardAccountsRepository _repo;
        public BatchOpeningCardAccountsController(IBatchOpeningCardAccountsRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string dateStart, string dateEnd)
        {
            try
            {
                DateTime startDate = DateTime.ParseExact(dateStart, "dd.MM.yyyy", null);
                DateTime endDate = DateTime.ParseExact(dateEnd, "dd.MM.yyyy", null);
                BarsSql sql = SqlCreator.SearchMain(startDate, endDate);
                var data = _repo.SearchGlobal<BatchCardAccount>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, long Id)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchData(Id);
                var data = _repo.SearchGlobal<BatchOpenData>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage LoadFile()
        {
            byte[] p_filebody = null;
            try
            {
                HttpRequest r = HttpContext.Current.Request;

                var file = r.Files.Count > 0 ? r.Files[0] : null;
                if (file != null && file.ContentLength > 0)
                {
                    p_filebody = new byte[file.InputStream.Length];
                    long data = file.InputStream.Read(p_filebody, 0, (int)file.InputStream.Length);
                    file.InputStream.Close();

                    int p_filetype = int.Parse(r.Form.Get("filetype"));

                    string p_filename = Path.GetFileName(file.FileName);
                    BarsSql sql = SqlCreator.LoadFile(p_filename, p_filebody, p_filetype);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                    return new HttpResponseMessage() { StatusCode = HttpStatusCode.OK };
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, "Файл пустий");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            finally { p_filebody = null; }
        }

        [HttpGet]
        public HttpResponseMessage FileTypes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.FileTypes();
                IEnumerable<FileType> ft = _repo.ExecuteStoreQuery<FileType>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = ft });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage ProcessingFile(Deal o)
        {
            try
            {
                BarsSql sql = SqlCreator.CreateDeal(o.p_fileid, o.p_card_code, o.p_branch, o.p_isp, o.p_proect_id);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage FormTicket(int p_fileid)
        {
            string p_ticketdata = string.Empty;
            string p_ticketname = string.Empty;
            try
            {
                BarsSql sql = SqlCreator.FormTicket(p_fileid, p_ticketdata, p_ticketname);

                using (var connection = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    using (var cmd = connection.CreateCommand())
                    {
                        cmd.CommandText = "ow_batch_opening.form_ticket";
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        for (var i = 0; i < sql.SqlParams.Length; i++)
                        {
                            cmd.Parameters.Add((OracleParameter)sql.SqlParams[i]);
                        }
                        cmd.ExecuteNonQuery();

                        p_ticketname = ((OracleString)cmd.Parameters[1].Value).IsNull ? string.Empty : ((OracleString)cmd.Parameters[1].Value).Value;
                        p_ticketdata = ((OracleClob)cmd.Parameters[2].Value).IsNull ? string.Empty : ((OracleClob)cmd.Parameters[2].Value).Value;
                    }
                }

                //_repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                //p_ticketname = ((OracleParameter)sql.SqlParams[1]).Value.ToString();

                //OracleClob oc = (OracleClob)((OracleParameter)sql.SqlParams[2]).Value;
                //p_ticketdata = oc.IsNull ? string.Empty : oc.Value;
            }
            catch (Exception e)
            {
                throw new Exception("Не вдалось отримати файл. Помилка: " + (e.InnerException == null ? e.Message : e.InnerException.Message));
            }

            HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);

            result.Content = new StringContent(p_ticketdata, Encoding.GetEncoding(1251), "text/plain");
            result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
            {
                FileName = Uri.EscapeDataString(p_ticketname)
            };

            return result;
        }
    }
}
