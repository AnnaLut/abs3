using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    public class PfuRequestController : ApiController
    {
        private readonly IPfuRequestRepository _pfuRequestRepository;

        public PfuRequestController(IPfuRequestRepository pfuRequestRepository)
        {
            _pfuRequestRepository = pfuRequestRepository;
        }

        [HttpPost]
        [POST("/api/pfu/pfurequest/sendpackage")]
        public HttpResponseMessage SendPackage([FromUri] PackageParameter parameters)
        {
            var contentBytes = Request.Content.ReadAsByteArrayAsync().Result;
            //File.WriteAllBytes(@"G:\Data\Pens\process_data\ru_data.zip", contentBytes);
            var requestData = _pfuRequestRepository.InsertPackage(parameters.PackageId, parameters.PackageName,
                 parameters.PackageMfo, contentBytes);
            return Request.CreateResponse(HttpStatusCode.OK, requestData);
        }

        [HttpPost]
        [POST("/api/pfu/pfurequest/checkpackage")]
        public HttpResponseMessage CheckPackage([FromUri] PackageParameter parameters)
        {
            var contentBytes = Request.Content.ReadAsByteArrayAsync().Result;
            var requestData = _pfuRequestRepository.CheckPackage(parameters.PackageId);
            return Request.CreateResponse(HttpStatusCode.OK, requestData);
        }

        [HttpPost]
        [POST("/api/pfu/pfurequest/receiptpackage")]
        public HttpResponseMessage ReceiptPackage([FromUri] PackageParameter parameters)
        {
            var contentBytes = Request.Content.ReadAsByteArrayAsync().Result;
            var requestData = _pfuRequestRepository.ReceiptPackage(parameters.PackageId);
            return Request.CreateResponse(HttpStatusCode.OK, requestData);
        }

        public class PackageParameter
        {
            public decimal PackageId { get; set; }
            public string PackageName { get; set; }
            public string PackageMfo { get; set; }
        }
    }
}