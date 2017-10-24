using System.Linq.Dynamic;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using System.Collections.Generic;
using BarsWeb.Areas.Admin.Models;
using System.Net.Http;
using System.Net;
using AttributeRouting.Web.Http;
using System;
using System.Reflection;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class OperController : ApiController
    {
        private readonly IOperRepository _repo;
        public OperController(IOperRepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string tt)
        {
            var data = _repo.OperItem(request, tt);
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
            return response;
        }

        [HttpPost]
        [POST("api/admin/oper/operitemupdate")]
        public HttpResponseMessage OperItemUpdate(TTS item)
        {
            try
            {
                _repo.UpdateOperItem(item);
                const  string message = "Створено нову операцію";
                return Request.CreateResponse(HttpStatusCode.OK, message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
/*
        #region CardHandbook

        [HttpGet]
        [GET("api/admin/oper/dkhandbook")]
        public HttpResponseMessage DkHandbook()
        {
            var data = _repo.DkHandbookData();
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
            return response;
        }
        [HttpGet]
        [GET("api/admin/oper/interbankhandbook")]
        public HttpResponseMessage InterbankHandbook()
        {
            var data = _repo.InterbankHandbookData();
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
            return response;
        }

        #endregion
*/
        #region Folders Commands
        [HttpPost]
        [POST("api/admin/oper/insertfolder")]
        public HttpResponseMessage InsertFolder(string id, decimal idfo)
        {
            try
            {
                _repo.InsertFolder(id, idfo);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        [HttpPost]
        [POST("api/admin/oper/deletefolder")]
        public HttpResponseMessage DeleteFolder(string id, decimal idfo)
        {
            try
            {
                _repo.DeleteFolder(id, idfo);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        #endregion

        #region Vobs Commands

        [HttpPost]
        [POST("api/admin/oper/insertvob")]
        public HttpResponseMessage InsertVob(string id, decimal vobId, decimal? vobOrd)
        {
            try
            {
                _repo.InsertVob(id, vobId, vobOrd);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        [HttpPost]
        [POST("api/admin/oper/deletevob")]
        public HttpResponseMessage DeleteVob(string id, decimal vobId)
        {
            try
            {
                _repo.DeleteVob(id, vobId);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        #endregion

        #region Groups Command

        [HttpPost]
        [POST("api/admin/oper/insertgroup")]
        public HttpResponseMessage InsertGroup(string id, decimal gId, decimal? charge, string respond, decimal priority, string sql)
        {
            try
            {
                _repo.InsertGroup(id, gId, priority, sql, charge, respond);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [POST("api/admin/oper/deletegroup")]
        public HttpResponseMessage DeleteGroup(string id, decimal gId)
        {
            try
            {
                _repo.DeleteGroup(id, gId);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        #endregion

        #region BalAccounts
        [HttpPost]
        [POST("api/admin/oper/insertacc")]
        public HttpResponseMessage InsertAcc(string id, string nbs, decimal dk, string ob)
        {
            try
            {
                _repo.InsertAccount(id,nbs,dk,ob);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [POST("api/admin/oper/deleteacc")]
        public HttpResponseMessage DeleteAcc(string id, string nbs, decimal dk, string ob)
        {
            try
            {
                _repo.DeleteAccount(id, nbs, dk, ob);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        #endregion

        #region Tranactions

        public HttpResponseMessage InsertTransaction(string id, string ttap, decimal dk)
        {
            try
            {
                _repo.InsertTransaction(id,ttap,dk);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        public HttpResponseMessage DeleteTransaction(string id, string ttap)
        {
            try
            {
                _repo.DeleteTransaction(id, ttap);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        #endregion

        #region Properties
        [HttpPost]
        [POST("api/admin/oper/updateprop")]
        public HttpResponseMessage UpdateProp(string id, string tag, string opt, decimal used, decimal? ord, string val)
        {
            try
            {
                _repo.UpdateProps(id, tag, opt, used, ord, val);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        #endregion
    }
}
