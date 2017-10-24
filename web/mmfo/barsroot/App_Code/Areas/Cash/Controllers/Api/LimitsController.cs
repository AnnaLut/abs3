using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models.ViewModels;

namespace BarsWeb.Areas.Cash.Controllers.Api
{
    /// <summary>
    /// API для получения данных об остатках наличности из регионов
    /// </summary>
    [AuthorizeApi]
    public class LimitsController : ApiController
    {
        private ILimitRepository _limitRepository;
        public LimitsController(ILimitRepository limitRepository)
        {
            _limitRepository = limitRepository;
        }
        [GET("api/cash/Limits/get")]
        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string date)
        {
            var schedulers = _limitRepository.GetLimitsOnDate(date);
            return schedulers.ToDataSourceResult(request);
        }
        [GET("api/cash/Limits/get")]
        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string kf, 
            decimal? kv)
        {
            var schedulers = _limitRepository.GetMfoLimitPlan(kf, kv);
            return schedulers.ToDataSourceResult(request);
        }
        public HttpResponseMessage Put(LimitsDistributionMfoViewModel limitDistr)
        {
            _limitRepository.SetMfoLimit(limitDistr, FormatedDate(limitDistr.Date));
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }
        public HttpResponseMessage Post(LimitsDistributionMfoViewModel limitDistr)
        {
            _limitRepository.SetMfoLimit(limitDistr, FormatedDate(limitDistr.Date));
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }

        public HttpResponseMessage Delete(string mfo, decimal? kv, string date, string limitType)
        {
            _limitRepository.DeleteMfoLimit(mfo, kv, FormatedDate(date), limitType);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        private string FormatedDate(string date)
        {
            return date.Split(' ')[0].Replace(".", "/");
        }
    }
}