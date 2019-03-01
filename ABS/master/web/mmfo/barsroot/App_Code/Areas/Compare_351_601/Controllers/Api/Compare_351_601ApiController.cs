using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Compare_351_601.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Compare_351_601.Infrastructure.DI.Implementation;
using System;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.Compare_351_601.Models;

namespace BarsWeb.Areas.Compare_351_601.Controllers.Api
{
    [AuthorizeApi]
    public class Compare_351_601Controller: ApiController
    {
        readonly ICompare_351_601Repository _repo;
        public Compare_351_601Controller(ICompare_351_601Repository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                var data = _repo.SearchGlobal<Compare_601>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage consl()
        {
            try
            {
                _repo.execute_consolidate();

                return Request.CreateResponse(HttpStatusCode.OK, new { Message = "Ok" });

            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = e.Message });
            }
        }
    }
}
