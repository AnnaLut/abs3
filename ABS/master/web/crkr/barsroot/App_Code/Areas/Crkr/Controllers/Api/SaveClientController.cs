using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class SaveClientController : ApiController
    {
        private readonly ISaveClientRepository _save;
        public SaveClientController(ISaveClientRepository save)
        {
            _save = save;
        }

        [HttpPost]
        public HttpResponseMessage GetClientAccount(AccountInfo model)
        {
            var accounts = _save.ClientAccounts(model);
            return Request.CreateResponse(HttpStatusCode.OK, accounts);
        }

        [HttpPost]
        public HttpResponseMessage CreateClient(ClientProfile megamodel)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _save.CreateClient(megamodel));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }


        [HttpPost]
        public HttpResponseMessage SaveBenef(BenefProfile model)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _save.CreateBenef(model));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}
