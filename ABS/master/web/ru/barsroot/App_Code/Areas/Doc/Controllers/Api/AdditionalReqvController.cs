using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Doc.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.Doc.Controllers.Api
{
    /// <summary>
    /// Summary description for AdditionalReqv
    /// </summary>
    [AuthorizeApi]
    public class AdditionalReqvController : ApiController
    {
        private readonly IAddDocsInfo _dInf;
        public AdditionalReqvController(IAddDocsInfo DocInfo)
        {
            _dInf = DocInfo;
        }

        [HttpPost]
        [POST("api/doc/additionalreqv/getcodesinfo")]
        public HttpResponseMessage GetCodesInfo()
        {
            try
            {
                var data = _dInf.GetUniqKodf();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        [POST("api/doc/additionalreqv/getmaingridinfo")]
        public HttpResponseMessage GetMainGridInfo(string KODF, string DATEF)
        {
            try
            {
                var data = _dInf.GetAllReqInfo(KODF, DATEF);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpPost]
        [POST("api/doc/additionalreqv/getchildgridinfo")]
        public HttpResponseMessage GetChildGridInfo(decimal Ref)
        {
            try
            {
                var data = _dInf.GetReqDependInfo(Ref);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

    }
}