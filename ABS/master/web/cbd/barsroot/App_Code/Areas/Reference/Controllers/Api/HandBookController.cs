using System.Web.Http;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using System.Data;
using System.Linq;

namespace BarsWeb.Areas.Reference.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    [AuthorizeApi]
    public class HandBookController : ApiController
    {
        private readonly IHandBookRepository _repository;
        public HandBookController(IHandBookRepository repository)
        {
            _repository = repository;
        }

       /* public DataSourceResult GetData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request,string id,string clause="")
        {
            var data = _repository.GetBookData(id,clause);
            return data.ToDataSourceResult(request);
        }*/

        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string id, string clause="")
        {
            var result = new DataSourceResult();
            var data = _repository.GetHandBookData(id, clause, request).Tables[0].AsEnumerable().FirstOrDefault();
            if (data != null)
            {
                var convetrRequest = new DataSourceRequest
                {
                    Page = 1,
                    PageSize = request.PageSize
                };
                result = data.Table.ToDataSourceResult(convetrRequest);
                if (data.Table.Rows.Count + 1 >= request.PageSize)
                {
                    result.Total = (request.Page*request.PageSize) + 1;
                    //_repository.GetHandBookDataCount(id, clause, request);
                }
                else
                {
                    result.Total = (request.Page*request.PageSize);
                }
            }
            else
            {
                result.Data = new string[] {};
                result.Total = request.Page*request.PageSize;
            }
            
            return result;
        }
    }
}