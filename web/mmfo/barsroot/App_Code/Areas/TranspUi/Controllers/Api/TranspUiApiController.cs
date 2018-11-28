using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.TranspUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.TranspUi.Infrastructure.DI.Implementation;
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
using Areas.TranspUi.Models;
using System.Linq;

namespace BarsWeb.Areas.TranspUi.Controllers.Api
{
    [AuthorizeApi]
    public class TranspUiController: ApiController
    {
        readonly ITranspUiRepository _repo;
        public TranspUiController(ITranspUiRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMainOutReqs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMainOutReqs();
                var data = _repo.SearchGlobal<OutMainReqModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchMainInReqs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMainInReqs();
                var data = _repo.SearchGlobal<InMainReqModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchReqs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchOutReqs(guid);
                var data = _repo.SearchGlobal<OutReqsModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchQueue([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchOutQueue(guid);
                var data = _repo.SearchGlobal<QueueModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInputQueue([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchInQueue(guid);
                var data = _repo.SearchGlobal<QueueModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchTypes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchOutTypes();
                var data = _repo.SearchGlobal<TypesModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInputTypes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchInTypes();
                var data = _repo.SearchGlobal<TypesModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchLog([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchOutputLog(guid);
                var data = _repo.SearchGlobal<LogModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInputLog([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchInputLog(guid);
                var data = _repo.SearchGlobal<LogModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchParams([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchParams();
                var data = _repo.SearchGlobal<ParamsModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInputResponseParams([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchInRespParams(guid);
                var data = _repo.SearchGlobal<ParametersModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInputRequestParams([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchInReqParams(guid);
                var data = _repo.SearchGlobal<ParametersModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInputResponses([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchInputResponses(guid);
                var data = _repo.SearchGlobal<InputResponseModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetMainOutClob(string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.GetMainOutClob(guid);
                var clob = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, clob);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetMainInClob(string guid)
        {
            try
            {
                BarsSql sql = SqlCreator.GetMainInClob(guid);
                var clob = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, clob);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetReqClob(string id)
        {
            try
            {
                BarsSql sql = SqlCreator.GetReqClob(id);
                var clob = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, clob);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetRespClob(string id)
        {
            try
            {
                BarsSql sql = SqlCreator.GetRespClob(id);
                var clob = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, clob);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetLogClob(int id)
        {
            try
            {
                BarsSql sql = SqlCreator.GetLogClob(id);
                var clob = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, clob);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetInputLogClob(int id)
        {
            try
            {
                BarsSql sql = SqlCreator.GetInputLogClob(id);
                var clob = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, clob);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
