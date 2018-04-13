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
    public class ClientsDuplicatesReportController : ApiController
    {
        private readonly ICdmRepository _repo;

        public ClientsDuplicatesReportController(ICdmRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage PostDuplicates(Duplicates dupes)
        {
            //для тестов сохраняем запрос во временную таблицу
            SaveXmlinTmpTable(dupes);

            Response resp = new Response();
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

        private void SaveXmlinTmpTable(Duplicates dupes)
        {
            HttpContext.Current.Request.InputStream.Seek(0, SeekOrigin.Begin);
            var p = new StreamReader(HttpContext.Current.Request.InputStream).ReadToEnd();
            var current = DateTime.Now;
            string name = "EBK_D_" + current.Day + current.Month + "_";
            if (dupes != null && !string.IsNullOrEmpty(dupes.Request.BatchId))
            {
                name = name + dupes.Request.BatchId;
            }
            else
                name = name + "NULL";

            name = name.Substring(0, 12);

            _repo.SaveRequestToTempTable(name, p);
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