using Areas.EDeclarations.Models;
using BarsWeb.Areas.EDeclarations.Infrastructure.DI.Abstract;
using BarsWeb.Areas.EDeclarations.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.EDeclarations.Controllers.Api
{
    [AuthorizeApi]
    public class EDeclarationsController : ApiController
    {
        readonly IEDeclarationsRepository _repo;
        public EDeclarationsController(IEDeclarationsRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]
            DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                //var data = _repo.SearchGlobal<EDECL>(request, sql);
                var data = _repo.SearchGlobal<EDeclarationModel>(request, sql);
                //if (data)
                //    data = new List<EDeclarationModel>();
                decimal dataCount = _repo.CountGlobal(request, sql);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage PersonDocTypes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.GetPersonDocTypes();
                var data = _repo.ExecuteStoreQuery<PersonDocType>(sql);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage CreateDeclaration()
        {
            String req = Request.Content.ReadAsStringAsync().Result;
            EDeclViewModel model = JsonConvert.DeserializeObject<EDeclViewModel>(req);

            try
            {
                BarsSql sql = SqlCreator.GetCreateRequest(model);
                Int32? result = _repo.CreateRequest(sql);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch(Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message);
            }

        }

        [HttpPost]
        public HttpResponseMessage RenewDeclaration(Int32 id)
        {
            try
            {
                Int32? result = _repo.CreateRequest(SqlCreator.RenewDeclaration(id));
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message);
            }

        }

        [HttpPost]
        public String CreateSearch(String id)
        {
            if (String.IsNullOrEmpty(id))
                return "Введіть данні для пошуку";
            BarsSql sql = SqlCreator.IsEDeclarationExists(id);
            Int32 result = _repo.SearchDeclaration(sql);
            String response = String.Empty;
            switch (result)
            {
                case 0:
                    response = String.Format("Декларацію (№ {0}) додано до списку",id);
                    break;
                case 1:
                    response = String.Format("Декларація (№ {0}) вже існує",id);
                    break;
                case 2:
                    response = String.Format("Виникла помилка при пошуку");
                    break;
                case 3:
                    response = String.Format("Декларації № {0} не знайдено", id);
                    break;
            }
            return response;
        }

        
    }
}