using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Reference.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    [AuthorizeApi]
    public class HandBookMetadataController : ApiController
    {
        private readonly IHandBookMetadataRepository _repository;

        public HandBookMetadataController(IHandBookMetadataRepository repository)
        {
            _repository = repository;
        }

        public DataSourceResult GetHandBooks([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            var data = _repository.GetHandBookList();
            return data.ToDataSourceResult(request);
        }
        public HttpResponseMessage GetHandBook(string id)
        {
            var data = _repository.GetHandBookByName(id);
            return Request.CreateResponse(HttpStatusCode.OK,data);
        }
        public HttpResponseMessage Delete(int id)
        {
            var data = _repository.GetHandBook(id);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }

    }
}