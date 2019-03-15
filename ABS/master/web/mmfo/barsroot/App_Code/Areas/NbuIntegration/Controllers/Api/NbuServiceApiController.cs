using BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Abstract;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Areas.NbuIntegration.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.NbuIntegration.Controllers.Api
{
    public class NbuServiceController : BarsApiController
    {
        readonly INbuServiceRepository _repo;
        public NbuServiceController(INbuServiceRepository repo) { _repo = repo; }

        [HttpGet]
        //[GET("/api/nbuintegration/nbuservice/GetDataFromNbu/{date}/{userName?}")]
        //public HttpResponseMessage GetDataFromNbu([FromUri]string date, [FromUri]string userName = "")
        public HttpResponseMessage GetDataFromNbu(string date, string userName = "")
        {
            try
            {
                using (OracleConnection con = OraConnector.Handler.UserConnection)
                {
                    if (!string.IsNullOrWhiteSpace(userName))
                        LoginUserIntSingleCon(con, userName);

                    ReqSaveRes res = _repo.GetAndProcessDataFromNbu(con, date);
                    return Request.CreateResponse(HttpStatusCode.OK, res);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
