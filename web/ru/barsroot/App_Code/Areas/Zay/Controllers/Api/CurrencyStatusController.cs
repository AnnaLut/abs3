using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using BarsWeb.Areas.ExternalServices.Services;
using CorpLight.Users.Models;
using System.Collections.Generic;
using System.Text;
using System.Net.Http.Headers;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class CurrencyStatusController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        private readonly IExternalServices externalServices;

        public CurrencyStatusController(ICurrencySightRepository repository, IExternalServices externalServices)
        {
            _repository = repository;
            this.externalServices = externalServices;
        }

        [HttpPost]
        [POST("api/zay/currencystatus")]
        public HttpResponseMessage Post(ZayCheckDataModel item)
        {
            try
            {
                _repository.ZayCheckData(item);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }
        }
        public HttpResponseMessage GetFilesTooltipContent(decimal? bidId)
        {
            var content = string.Empty;
            if (!bidId.HasValue) content = "<div class='load-file'>Відсутній ідентифікатор заявки.</div>";
            else
            {
                try
                {
                    var files = externalServices.CorpLightServices.FileLoaderService.GetSupportDocuments(bidId.Value);
                    //var files = new List<CorpLight.Users.Models.SupportDocument>();
                    //files.Add(new CorpLight.Users.Models.SupportDocument { Id = "111", FileName = "asdfgghjkj", Comment = "aaaaaaaaaa" });
                    //files.Add(new CorpLight.Users.Models.SupportDocument { Id = "222", FileName = "zxcvbn", Comment = "bbbbbbb" });

                    if (files.Count == 0) content = "<div class='load-file'>По заявці (ID: " + bidId + ") файлів не знайдено.</div>";
                    else content = CreateTooltipContent(files, bidId.Value);
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
                    //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
                }

            }
            var response = new HttpResponseMessage()
            {
                StatusCode = HttpStatusCode.OK,
                Content = new StringContent(content),
            };
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return response;
        }

        private string CreateTooltipContent(List<SupportDocument> filesList, decimal bidId)
        {
            var fileLinks = new StringBuilder();
            //var fileIds = new List<string>();
            foreach (var item in filesList)
            {
                fileLinks.AppendFormat("<a href='/barsroot/api/ExternalServices/ExternalServices/GetCorpLightFile?fileId={0}' class='load-file' ><table><tr><td>{1}</td><td>{2}</td></tr></table></a>", item.Id, item.FileName, item.Comment);
                //fileIds.Add(item.Id);
            }
            var content = new StringBuilder();
            //content.Append("<div style='width:270px; background: rgba(180, 250, 180, 0.8);'>");
            if (filesList.Count > 1)
            {
                content.AppendFormat("<a href='/barsroot/api/ExternalServices/ExternalServices/GetCorpLightAllFiles?bidId={0}", bidId);
                //foreach (var id in fileIds)
                //{
                //    content.AppendFormat("&fileIds%5B%5D={0}", id);
                //}
                content.Append("' class='load-file' ><table><tr><td colspan='2'>Завантажити всі</td></tr></table></a>");

            }
            //content.AppendFormat("{0}</div>", fileLinks.ToString());
            content.Append(fileLinks.ToString());

            return content.ToString();
        }
    }
}