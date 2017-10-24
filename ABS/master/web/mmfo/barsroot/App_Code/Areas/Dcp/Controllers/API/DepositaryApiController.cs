using Bars.Doc;
using BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dcp.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
  
namespace BarsWeb.Areas.Dcp.Controllers.Api
{
    public class DepositaryApiController : ApiController
    {

        private readonly IDepositaryRepository _repository;

        public DepositaryApiController(IDepositaryRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// Отримує дані для таблиці
        /// </summary>
        /// <param name="request"></param>
        /// <param name="nPar"></param>
        /// <param name="fn"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal nPar, string fn)
        {
            try
            {
                List<PFileGridData> list = new List<PFileGridData>();
                list = _repository.GetGridData(nPar, fn);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch(Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
            
        }

        /// <summary>
        /// Отримує види документів
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetVob()
        {
            try
            {
                List<Vob> list = new List<Vob>();
                Vob model = new Vob();
                model = _repository.GetVob("ЦП1");
                list.Add(model);
                model = _repository.GetVob("ЦП2");
                list.Add(model);
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }

        }

        /// <summary>
        /// Отримує дані архіву
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetArchGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                List<PFileGridData> list = new List<PFileGridData>();
                list = _repository.GetArchGridData();
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /// <summary>
        /// Приймає файл
        /// </summary>
        /// <param name="update"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage AcceptFile(bool update)
        {
            try
            {
                object model = new object();
                model = _repository.AcceptFile(update);
                return Request.CreateResponse(HttpStatusCode.OK, model);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /// <summary>
        /// Оплачує файл
        /// </summary>
        /// <param name="grid"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage Pay([FromBody] dynamic grid)
        {
            try
            {
                List<PFileGridData> gridList = grid.ToObject<List<PFileGridData>>();
                _repository.Pay(gridList);
                return Request.CreateResponse(HttpStatusCode.OK, "Файли успішно оплачено");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /// <summary>
        /// Перевіряє чи був файл вже прийнятий
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage CheckFile()
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repository.CheckFile());
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /// <summary>
        /// Видаляє стрічку з бази
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage DeleteRow(decimal? id)
        {
            try
            {
                _repository.DeleteRow(id);
                return Request.CreateResponse(HttpStatusCode.OK, "Стрічка успішно видалена.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /// <summary>
        /// Перевіряє чи був файл вже оплачено
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage CheckStorno()
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repository.CheckStorno());
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDataByNLS(string nls, decimal id, string okpo)
        {
            try
            {
                NlsModel model = _repository.GetDataByNLS(nls, id, okpo);
                return Request.CreateResponse(HttpStatusCode.OK, model);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBPReasons([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                List<BP_REASON> list = _repository.GetBPReasons();
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage Storno(int reasonid, string fn)
        {
            try
            {
                var model = _repository.Storno(reasonid, fn);
                return Request.CreateResponse(HttpStatusCode.OK, model);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}