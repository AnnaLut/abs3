
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class ActualController : ApiController
    {
        private readonly IKendoRequestTransformer _requestTransformer;
        private readonly IUserRepository _users;
        public ActualController(IKendoRequestTransformer requestTransformer, IUserRepository users)
        {
            _requestTransformer = requestTransformer;
            _users = users;
        }
        [HttpPost]
        public HttpResponseMessage GetUsers([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, ActualUser model)
        {
            try
            {
                var requestTrans = _requestTransformer.MultiplyFilterValue(request, new[] { "s" });
                var profiles = _users.GetProfiles(model, requestTrans);
                if (profiles == null)
                    return Request.CreateResponse(HttpStatusCode.OK);
                var result = profiles.ToDataSourceResult(request);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (HttpException ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}
