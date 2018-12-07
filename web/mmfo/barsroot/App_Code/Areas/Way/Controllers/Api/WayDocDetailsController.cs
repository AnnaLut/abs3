using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Collections;
using iTextSharp.text;

namespace BarsWeb.Areas.Way.Controllers.Api
{
    public class WayDocDetailsController : ApiController
    {
        private readonly IWayRepository _repository;
        public WayDocDetailsController(IWayRepository repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal id)
        {
            try
            {
                var proccessedFiles = _repository.ProcessedFiles(id).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = proccessedFiles.ToDataSourceResult(request), Message = "Ok" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal id, string mode)
        {
            try
            {
                IList noProccessedFiles = null;
                switch (mode)
                {
                    case "ATRANSFERS":
                    case "FTRANSFERS":
                        noProccessedFiles = _repository.NoProccessedAFtransfers(id).ToList();
                        break;
                    case "DOCUMENTS":
                        noProccessedFiles = _repository.NoProccessedDocuments(id).ToList();
                        break;
                    case "STRANSFERS":
                        noProccessedFiles = _repository.NoProccessedStransfers(id).ToList();
                        break;
                    case "R_DOCUMENTS_REV":
                        // todo: add !!!!!
                        break;
                    case "INSTPLANDEL":
                        return Request.CreateResponse(HttpStatusCode.OK);
                    case "INSTPLAN":
                        return Request.CreateResponse(HttpStatusCode.OK);
                    case "DOCUMENTSDEL":
                        noProccessedFiles = _repository.DeletedDocuments(id).ToList();
                        break;
                    case "ATRANSFERSDEL":
                    case "FTRANSFERSDEL":
                        noProccessedFiles = _repository.DeletedAFtransfers(id).ToList();
                        break;
                    case "STRANSFERSDEL":
                        noProccessedFiles = _repository.DeletedStransfers(id).ToList();
                        break;
                }

                if (noProccessedFiles == null)
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, string.Format("Непідтримуваний тип файлу: id={0} mode={1}", id, mode));
                }

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = noProccessedFiles.ToDataSourceResult(request), Message = "Ok" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
    }
}