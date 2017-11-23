using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Abstract;
using BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System.Collections.Generic;
using System.Linq;
using Areas.RequestsProcessing.Models;

namespace BarsWeb.Areas.RequestsProcessing.Controllers.Api
{
    public class RequestsProcessingController : ApiController
    {
        readonly IRequestsProcessingRepository _repo;
        public RequestsProcessingController(IRequestsProcessingRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                IEnumerable<RequestsProcessingMain> data = _repo.SearchGlobal<RequestsProcessingMain>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

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
        public HttpResponseMessage DynamicRequest(DynamicRequestData obj)
        {
            try
            {                
                return Request.CreateResponse(HttpStatusCode.OK, _repo.GetDynamic(obj));
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, 
                    ex.InnerException != null ? ex.InnerException.Message : ex.Message);
                return response;
            }
        }

        [HttpPost]
        public HttpResponseMessage DynamicDictRequest(DynamicRequestData obj)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.GetDynamicDict(obj));
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        //*******
        // param = "field1;10.10.2016|field2;11.10.2016"
        [HttpGet]
        public HttpResponseMessage GetTextFile(string fName, char columnSeparator, int page, int pageSize, decimal kodz, string param, bool showHeaders)
        {
            try
            {
                DynamicRequestData drd = new DynamicRequestData { KODZ = kodz, PARAMS = new List<DynamicRequestParams>() };
                if (!string.IsNullOrEmpty(param))
                {
                    string[] allParams = param.Split('|');
                    foreach (string p in allParams)
                    {
                        string[] idValue = p.Split(';');
                        drd.PARAMS.Add(new DynamicRequestParams { ID = idValue[0], VALUE = idValue[1] });
                    }
                }

                List<Dictionary<string, object>> data = _repo.GetDynamic(drd);

                Dictionary<string, int> headerLen = new Dictionary<string, int>();
                System.Text.StringBuilder sb = new System.Text.StringBuilder();

                int start = (page - 1)* pageSize;

                pageSize = Math.Min((data.Count - start), pageSize);
                data = data.GetRange(start, pageSize);

                foreach (Dictionary<string, object> rowData in data)
                {
                    foreach (KeyValuePair<string, object> r in rowData)
                    {
                        if (!headerLen.ContainsKey(r.Key)) { headerLen.Add(r.Key, r.Key.Length); }
                        headerLen[r.Key] = Math.Max(headerLen[r.Key], r.Value.ToString().Length);
                    }
                }

                string[] A7Dates = { "DATF", "MDATE", "SDATE", "WDATE" };
                foreach (Dictionary<string, object> rowData in data)
                {
                    System.Text.StringBuilder sbRow = new System.Text.StringBuilder();
                    foreach (KeyValuePair<string, object> r in rowData)
                    {
                        string v = r.Value.ToString();

                        //hack for A7 report
                        if (A7Dates.Contains(r.Key) && !string.IsNullOrEmpty(v))
                        {
                            v = ((DateTime)r.Value).ToString("ddMMyyyy");
                        }

                        sbRow.Append(v.PadRight(headerLen[r.Key]));
                        sbRow.Append(columnSeparator);
                    }
                    sbRow.Remove(sbRow.Length - 1, 1);  // remove last 'columnSeparator' symbol
                    sbRow.AppendLine();

                    sb.Append(sbRow);
                }

                if (showHeaders)
                {
                    // add file header
                    System.Text.StringBuilder sbHeaders = new System.Text.StringBuilder();
                    foreach (KeyValuePair<string, int> h in headerLen)
                    {
                        sbHeaders.Append(h.Key.PadRight(h.Value));
                        sbHeaders.Append(columnSeparator);
                    }
                    sbHeaders.Remove(sbHeaders.Length - 1, 1);  // remove last 'columnSeparator' symbol
                    sbHeaders.AppendLine();
                    sb.Insert(0, sbHeaders);
                }

                HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);

                result.Content = new StringContent(sb.ToString(), System.Text.Encoding.UTF8, "text/plain");
                result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
                {
                    FileName = Uri.EscapeDataString(string.Format("{0}", fName))
                };

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
