using System;
using System.Activities.Statements;
using System.IO;
using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    public class ChangeClientCardController : ApiController
    {
        private readonly ICdmRepository _repo;

        public ChangeClientCardController(ICdmRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage PostChanges(SimpleCard request)
        {
            AdvisoryCardResponse resp = new AdvisoryCardResponse();
            resp.SetStatus(ResponseStatus.ERROR);
            if (ModelState.IsValid)
            {
                try
                {
                    _repo.SaveCardChangesOnline(request);
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