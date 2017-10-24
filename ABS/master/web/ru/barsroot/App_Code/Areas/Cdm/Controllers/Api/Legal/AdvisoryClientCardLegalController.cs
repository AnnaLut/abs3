using System;
using System.Activities.Statements;
using System.IO;
using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;


namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    public class AdvisoryClientCardLegalController : ApiController
    {
        private readonly ICdmLegalRepository _repo;

        public AdvisoryClientCardLegalController(ICdmLegalRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage PutAdvisoryCardChanges(AdvisoryCards request)
        {

            AdvisoryCardResponse resp = new AdvisoryCardResponse();
            resp.SetStatus(ResponseStatus.ERROR);
            if (ModelState.IsValid)
            {
                try
                {
                    _repo.SaveCardsAdvisoryFast(request);
                    resp.SetStatus(ResponseStatus.OK);
                }
                catch (Exception e)
                {
                    resp.Msg = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            else
            {
                resp.Msg = GetModelErrors();
            }
            return Request.CreateResponse(HttpStatusCode.OK, resp);
        }

        private string GetModelErrors()
        {
            var result = new StringBuilder();
            foreach (var modelState in ModelState.Values)
            {
                foreach (var error in modelState.Errors)
                {
                    result.Append((string.IsNullOrEmpty(error.ErrorMessage) ? error.Exception.Message : error.ErrorMessage) + Environment.NewLine);
                }
            }
            return result.ToString();
        }
  
    }
}