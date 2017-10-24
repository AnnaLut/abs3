using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
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
using Areas.DynamicLayoutLegalEntities.Models;
using System.Collections.Generic;
using Bars.Classes;
using Dapper;
using System.Linq;
using System.Net.Http.Headers;
using BarsWeb.Areas.DynamicLayoutLegalEntities.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DynamicLayoutLegalEntities.Infrastructure.DI.Implementation;

namespace BarsWeb.Areas.DynamicLayoutLegalEntities.Controllers.Api
{
    public class DynamicLayoutLegalEntitiesController : ApiController
    {
        readonly IDynamicLayoutLegalEntitiesRepository _repo;
        public DynamicLayoutLegalEntitiesController(IDynamicLayoutLegalEntitiesRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                var data = _repo.SearchGlobal<VStaticLayout>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchMainJuridicalOnly([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMainFiltered();
                var data = _repo.SearchGlobal<VStaticLayout>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchStaticLayoutData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchStaticLayoutData();
                var data = _repo.SearchGlobal<SLDetailA>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchTmpDynamicLayout([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchTmpDynamicLayout();
                var data = _repo.SearchGlobal<VTmpDynamicLayout>(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage KvAC()
        {
            try
            {
                BarsSql sql = SqlCreator.KvAutoComplete();
                var data = _repo.SearchGlobal<KvAutoComplete>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage GetStaticLayout(CreateLayoutModel model)
        {
            try
            {
                _repo.ClearDynamicLayout();
                _repo.CreateDynamicLayout(model.pMode, model.pDk, model.pNls, model.pBs, model.pOb, model.pGrp, model.Flag);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseDL());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.ErrorResponse(ex));
            }
        }

        [HttpPost]
        public HttpResponseMessage UpdateAndCalculateDynamicLayout(UpdateDynamicLayoutDataModel model)
        {
            try
            {
                _repo.UpdateDynamicLayout(model);
                _repo.CalculateDynamicLayout(null, model.flag);
                _repo.CalculateStaticLayout();

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseDL());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.ErrorResponse(ex));
            }
        }

        [HttpGet]
        public HttpResponseMessage PayStaticLayout(decimal pMak)
        {
            try
            {
                _repo.PayStaticLayout(pMak);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseDL());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.ErrorResponse(ex));
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteStaticLayout(DeleteStaticLayoutDataModel model)
        {
            try
            {
                _repo.DeleteStaticLayout(model.pGrp, model.pId);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseDL());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.ErrorResponse(ex));
            }
        }

        [HttpPost]
        public HttpResponseMessage SaveDetails(SaveDetailsDataModel model)
        {
            try
            {
                _repo.UpdateDynamicLayout(model.UdlModel);
                _repo.AddStaticLayout(model.AslModel);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseDL());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.ErrorResponse(ex));
            }
        }

        [HttpPost]
        public HttpResponseMessage PaySelected(SLDetailA model)
        {
            try
            {
                _repo.PaySelectedStaticLayout(model);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseDL());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.ErrorResponse(ex));
            }
        }

        // POST api/savefile
        public HttpResponseMessage KendoSaveFile([FromBody]FileData file)
        {
            var data = Convert.FromBase64String(file.Base64);

            var result = new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StreamContent(new MemoryStream(data))
            };

            result.Content.Headers.ContentType = new MediaTypeHeaderValue(file.ContentType);

            result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
            {
                FileName = file.FileName
            };

            return result;
        }
    }
    public class FileData
    {
        public string ContentType { get; set; }
        public string Base64 { get; set; }
        public string FileName { get; set; }
    }
}
