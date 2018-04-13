using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Async.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Async.Controllers.Api
{
    /// <summary>
    /// Async Schedulers API
    /// </summary>
    [AuthorizeApi]
    public class SchedulersController : ApiController
    {
        private readonly ISchedulersRepository _schedulerRepository;
        public SchedulersController(ISchedulersRepository schedulersRepository)
        {
            _schedulerRepository = schedulersRepository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var schedulers = _schedulerRepository.GetAll();
            return schedulers.ToDataSourceResult(request);
        }
        public HttpResponseMessage Get(int id)
        {
            var scheduler = _schedulerRepository.Get(id);
            if (scheduler == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = "Не знайдено задання асинхронного запуску Id: " + id
                    });
            }
            return Request.CreateResponse(HttpStatusCode.OK, scheduler);
        }
        public HttpResponseMessage Get(string code)
        {
            var scheduler = _schedulerRepository.GetByCode(code);
            if (scheduler == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = "Не знайдено задання асинхронного запуску Code: " + code
                    });
            }
            return Request.CreateResponse(HttpStatusCode.OK, scheduler);
        }
        public HttpResponseMessage Post(Scheduler scheduler)
        {
            scheduler = _schedulerRepository.Add(scheduler);
            return Request.CreateResponse(HttpStatusCode.OK, scheduler );
        }
        public HttpResponseMessage Put(Scheduler scheduler)
        {
            var baseScheduler = _schedulerRepository.Get(scheduler.Id);
            if (baseScheduler == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = "Не знайдено задання асинхронного запуску Id: " + scheduler.Id
                    });
            }
            scheduler = _schedulerRepository.Update(scheduler);
            return Request.CreateResponse(HttpStatusCode.OK, scheduler );
        }
        public HttpResponseMessage Delete(int id)
        {
            _schedulerRepository.Delete(id);
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }
        public HttpResponseMessage Delete(string code)
        {
            _schedulerRepository.DeleteByCode(code);
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }
    }
}