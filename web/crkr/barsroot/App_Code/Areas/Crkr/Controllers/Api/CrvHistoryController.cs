using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using Dapper;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    public class CrvHistoryController : ApiController
    {
        [AuthorizeApi]
        public HttpResponseMessage Get(string dbcode)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select S, KV, ND, REF, TT, NSC from motio where dbcode = :dbcode").ToList());
            }
        }
    }
}
