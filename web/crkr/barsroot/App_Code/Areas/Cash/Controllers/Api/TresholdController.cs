using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Cash.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    [AuthorizeApi]
    public class TresholdController : ApiController
    {
        private readonly ITresholdRepository _repository;

        public TresholdController(ITresholdRepository repository)
        {
            _repository = repository;
        }
         public DataSourceResult Get([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]
             DataSourceRequest request, 
             string date)
        {
            return _repository.GetCurrentTresholds(date).ToDataSourceResult(request);
        }

        public DataSourceResult Get([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]
            DataSourceRequest request,
            string date,
            string type)
        {
            return _repository.GetAllTresholds().Where(i => i.LimitType == type).ToDataSourceResult(request);
        }

        public HttpResponseMessage Get(int id)
        {
            var treshold = _repository.GetTreshold(id);
            return Request.CreateResponse(HttpStatusCode.OK, treshold);
        }

        public HttpResponseMessage Get([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]
            DataSourceRequest request,
            string date,
            string type,
            string mfo,
            decimal curFlag)
        {
            var tresholdList = _repository.GetTresholdHistory(type, mfo, curFlag);
            return Request.CreateResponse(HttpStatusCode.OK, tresholdList.ToDataSourceResult(request));
        }
        public HttpResponseMessage Post(Treshold treshold)
        {
            var resultId = "";
            if (!string.IsNullOrEmpty(treshold.Mfo))
            {
                var mfoList = treshold.Mfo.Split(',');
                foreach (var item in mfoList)
                {
                    treshold.Mfo = item;
                    if (!string.IsNullOrEmpty(resultId))
                    {
                        resultId += ", ";
                    }
                    var newTreshold = _repository.AddTreshold(treshold);
                    resultId += newTreshold.Id;
                }
            }
            else
            {
                var newTreshold = _repository.AddTreshold(treshold);
                resultId += newTreshold.Id;
            }
            return Request.CreateResponse(HttpStatusCode.OK, new { Id = resultId });
        }

        public HttpResponseMessage Put(Treshold treshold)
        {
            treshold = _repository.EditTreshold(treshold);
            return Request.CreateResponse(HttpStatusCode.OK, new { treshold.Id });
        }
        public HttpResponseMessage Delete(int id)
        {
            _repository.DeleteTreshold(id);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}