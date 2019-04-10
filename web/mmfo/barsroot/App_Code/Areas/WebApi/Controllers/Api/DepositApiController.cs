using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http;
using BarsWeb.Areas.WebApi.Deposit.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.WebApi.Deposit
{
    public class DepositController : ApiController
    {
        private readonly IDepositRepository _repo;

        public DepositController(IDepositRepository repo)
        {
            _repo = repo;
        }


        [HttpGet]
        public HttpResponseMessage GetReport(string tmpFileName)
        {
            long fileSize;

            var localFilePath = _repo.GetFileFromFileName(tmpFileName, out fileSize);

            byte[] buffer = File.ReadAllBytes(localFilePath);
            TryRemome(localFilePath);
            TryRemome(localFilePath.Replace(".pdf", ".tmp"));

            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            response.Content = new ByteArrayContent(buffer);
            response.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment");
            response.Content.Headers.ContentDisposition.FileName = tmpFileName;
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/pdf");

            return response;
        }

        private static void TryRemome(string localFilePath)
        {
            try
            {
                File.Delete(localFilePath);
            }
            catch (Exception)
            {
                // ignored
            }
        }
    }
}