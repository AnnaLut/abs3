using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    public class GlobalClientIdentifierController : ApiController
    {
        public HttpResponseMessage PostGcif(GcifClients gsifClients)
        {
            return Request.CreateResponse(HttpStatusCode.OK, gsifClients);
        }

        public HttpResponseMessage DeleteMany(string[] gsif)
        {
            return Request.CreateResponse(HttpStatusCode.OK, gsif);
        }

        public HttpResponseMessage DeleteOne(string id)
        {
            return Request.CreateResponse(HttpStatusCode.OK, id);
        }

    }
}