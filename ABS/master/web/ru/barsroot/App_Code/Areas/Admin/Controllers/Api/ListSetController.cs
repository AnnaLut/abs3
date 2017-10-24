using System;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Net;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class ListSetController : ApiController
    {
        private readonly IListSetRepository _repo;
        public ListSetController(IListSetRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        [POST("api/admin/listset/createset")]
        public HttpResponseMessage CreateSet(string name, string comment)
        {
            try
            {
                _repo.CreateSet(name, comment);
                const string message = "Створено новий набір функцій";
                return Request.CreateResponse(HttpStatusCode.OK, message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/admin/listset/dropset")]
        public HttpResponseMessage DropSet(decimal id)
        {
            try
            {
                _repo.DropSet(id);
                const string message = "Набір функцій видалено";
                return Request.CreateResponse(HttpStatusCode.OK, message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/admin/listset/savesetchanges")]
        public HttpResponseMessage SaveSetChanges(decimal id, string name, string comm)
        {
            try
            {
                _repo.UpdateSet(id, name, comm);
                const string message = "Зміни до набору функцій збережено";
                return Request.CreateResponse(HttpStatusCode.OK, message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/admin/listset/addtoinuse")]
        public HttpResponseMessage AddToInUse(decimal id, decimal funcId)
        {
            try
            {
                //_repo.UpdateSet(id, name, comm);
                //const string message = "Зміни до набору функцій збережено";
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotModified, ex.Message);
            }
        }
        /*[HttpPost]
        [POST("/api/admin/listset/movefromeinuse")]
        public HttpResponseMessage MoveFromInUse(decimal id, decimal funcId)
        {
            try
            {
                //_repo.UpdateSet(id, name, comm);
                //const string message = "Зміни до набору функцій збережено";
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotModified, ex.Message);
            }
        }*/
    }

}