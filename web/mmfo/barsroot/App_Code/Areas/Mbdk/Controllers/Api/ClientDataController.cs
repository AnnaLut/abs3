using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Models;
using Dapper;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class ClientDataController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage GetClient(RightBank item)
        {
            if (item == null)
            {
                item = new RightBank { bParKR = 0 };
            }
            try
            {
                #region SQL
                var sql = @"select c.rnk, c.NMK, b.mfo, c.codcagent, c.nd, b.bic, c.okpo,  b.kod_b
                            from CUSTOMER c
                            join CUSTBANK b
                            on ( c.rnk = b.rnk )
                            where c.DATE_OFF is null 
                            and (c.rnk = :rnk or :rnk is null)
                            and (b.mfo = :mfo or :mfo is null)                      
                            and c.custtype=1 
                            and (   ( c.codcagent = 9 and b.mfo <> '300465' ) 
                                 or
                                  ( ( c.codcagent = 1 and b.mfo <> '300465' ) 
                                   or
                                    ( c.codcagent = 2 and b.bic is not null ) 
                                  )
                                )
                            and ( ( :bParKR = 1 and c.codcagent = 9 ) 
                                 or
                                  ( :bParKR = 0 and c.codcagent in (1,2)))";
                #endregion
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql, new { item.rnk, item.mfo, item.bParKR }).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);

                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetPayRoad(string BIC)
        {
            if (BIC == "getBic")
                BIC = null;
            try
            {
                var sql = @"select * from SW_BANKS where (BIC = :BIC or :BIC is null)";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql, new { BIC }).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetComments(string BIC)
        {
            if (BIC == "getBic")
                BIC = null;
            try
            {
                var sql = @"select * from SW_BANKS where (BIC = :BIC or :BIC is null)";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql, new { BIC }).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }


}