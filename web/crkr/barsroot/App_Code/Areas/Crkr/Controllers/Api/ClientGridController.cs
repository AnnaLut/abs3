using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Dapper;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class ClientGridController : ApiController
    {
        private readonly IKendoRequestTransformer _requestTransformer;
        private readonly ICrkrProfileRepository _crkrProfileRepository;
        public ClientGridController(IKendoRequestTransformer requestTransformer, ICrkrProfileRepository crkrProfileRepository)
        {
            _requestTransformer = requestTransformer;
            _crkrProfileRepository = crkrProfileRepository;
        }

        public HttpResponseMessage GetCrkrBag()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select *  from v_customer_crkr"));
            }
        }

        public HttpResponseMessage SearchClients(ClientSearch client)
        {
            return Request.CreateResponse(HttpStatusCode.OK, _crkrProfileRepository.GetClients(client));
        }

        public HttpResponseMessage GetBenef(decimal rnk, string code)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var res = connection.Query("select * from v_cust_compens_benef where RNK = :rnk and code = :code", new { rnk, code }).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
        }

        public HttpResponseMessage GetCompen(decimal rnk)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var res = connection.Query("select * from v_customer_compens where rnk = :rnk", new { rnk }).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetHistory(string dbcode)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var res = connection.Query("select * from V_COMPEN_USSR2_CLIENT_HIST c where c.asvo_dbcode = :dbcode", new { dbcode }).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
        }

        [HttpGet]
        public HttpResponseMessage DepoHistory(string dbcode)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var res = connection.Query("select * from V_COMPEN_USSR2_DEPOSIT_HIST c where  c.asvo_dbcode = :dbcode", new { dbcode }).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
        }

        [HttpGet]
        public HttpResponseMessage PayHistory(string dbcode)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var res = connection.Query("select * from V_COMPEN_USSR2_PAY_HIST c where  c.asvo_dbcode = :dbcode", new { dbcode }).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
        }
        [HttpGet]
        public HttpResponseMessage DepoOnFuneral(string rnk)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var res = connection.Query("select * from V_CUSTOMER_COMPENS_BUR where rnk = :rnk", new { rnk }).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
        }
    }
}
