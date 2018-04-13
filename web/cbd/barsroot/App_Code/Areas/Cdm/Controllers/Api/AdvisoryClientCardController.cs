using System;
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
    public class AdvisoryClientCardController : ApiController
    {
        private readonly ICdmRepository _repo;

        public AdvisoryClientCardController(ICdmRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage PutAdvisoryCardChanges(AdvisoryCards request)
        {
            //для тестов сохраняем запрос во временную таблицу
            SaveXmlinTmpTable(request);

            AdvisoryCardResponse resp = new AdvisoryCardResponse();
            resp.SetStatus(ResponseStatus.OK);
            
            if (ModelState.IsValid)
            {
                resp.Status = "OK";
            }
            else
            {
                resp.Status = "ERROR";
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

        private void SaveXmlinTmpTable(AdvisoryCards request)
        {
            HttpContext.Current.Request.InputStream.Seek(0, SeekOrigin.Begin);
            var p = new StreamReader(HttpContext.Current.Request.InputStream).ReadToEnd();
            var current = DateTime.Now;
            string name = "EBK_" + current.Day + current.Month + "_";
            if (request != null && !string.IsNullOrEmpty(request.BatchId))
            {
                name = name + request.BatchId;
            }
            else
                name = name + "NULL";

            name = name.Substring(0, 12);
            
            _repo.SaveRequestToTempTable(name, p);
        }
    }
}