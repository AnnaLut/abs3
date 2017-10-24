using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    public class ExtendedClientCardController : ApiController
    {
        public HttpResponseMessage GetExtendedClientParams()
        {
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}