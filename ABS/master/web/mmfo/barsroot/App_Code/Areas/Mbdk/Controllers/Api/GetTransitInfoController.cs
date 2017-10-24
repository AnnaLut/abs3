using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using Dapper;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class GetTransitInfoController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetMultiScore(decimal KV)
        {
            const string sql = @"SELECT a.nls, a.ostc/power(10,2) NUMB
                                 FROM accounts a
                                 WHERE a.nls =(select val from params where par = 'MBD_NLS_1819') and KV = :KV";
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    object result = connection.Query(sql, new { KV }).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, result);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }

        }
    }
}