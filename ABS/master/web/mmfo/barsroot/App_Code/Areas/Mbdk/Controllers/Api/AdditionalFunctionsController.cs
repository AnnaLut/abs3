using System;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Models;
using Dapper;
using System.Linq;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class AdditionalFunctionsController : ApiController
    {
        [HttpPost]
        [POST("/api/mbdk/AdditionalFunctions/CreateSwiftMessage")]
        public HttpResponseMessage CreateSwiftMessage([FromBody] decimal ND)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_mt", 320, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_dealRef", ND, DbType.Decimal, ParameterDirection.Input);

                    connection.Execute("SWIFT.Gen3xxMsg", p, commandType: CommandType.StoredProcedure);
                    return Request.CreateResponse(HttpStatusCode.OK, 1);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex);
            }
            finally
            {

            }
        }

        [HttpGet]
        public HttpResponseMessage GetSwifMessageRef(decimal ND)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var sql = @"select swo_ref from cc_add where nd=:ND";

                    var result = connection.Query<decimal>(sql, new { ND }).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, result);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex);
            }
            finally
            {

            }
        }
    }
}
