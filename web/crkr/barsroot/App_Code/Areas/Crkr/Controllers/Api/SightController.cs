using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Services;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using Dapper;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class SightController : ApiController
    {
        private readonly ISightRepository _sight;
        public SightController(ISightRepository sight)
        {
            _sight = sight;
        }

        [HttpGet]
        public HttpResponseMessage Depo(TabIndex tabIndex, UserType userType)
        {
            return Request.CreateResponse(HttpStatusCode.OK, _sight.Deposit(tabIndex, userType));
        }

        [HttpGet]
        public HttpResponseMessage DocInfo(decimal id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var infoList = connection.Query("select * from v_compen_choper_depend where compen_bound = :id", new {id});
                return Request.CreateResponse(HttpStatusCode.OK, infoList);
            }
        }

        [HttpGet]
        public HttpResponseMessage Count(UserType userType)
        {
           
            return Request.CreateResponse(HttpStatusCode.OK,_sight.Count(userType));
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage Visa(PaymentsList item)
        {
            try
            {
                _sight.VisaDbProc(item);
                return Request.CreateResponse(HttpStatusCode.OK, _sight.Deposit(item.TabIndex, item.UserType));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage Storno(PaymentsList item)
        {
            try
            {
                _sight.StornoDbProc(item);
                return Request.CreateResponse(HttpStatusCode.OK, _sight.Deposit(item.TabIndex, item.UserType));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage StornoAll(PaymentsList item)
        {
            try
            {
                _sight.StornoAllDbProc(item);
                return Request.CreateResponse(HttpStatusCode.OK, _sight.Deposit(item.TabIndex, item.UserType));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage Error(PaymentsList item)
        {
            try
            {
                _sight.ErrorDbProc(item);
                return Request.CreateResponse(HttpStatusCode.OK, _sight.Deposit(item.TabIndex, item.UserType));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }


    }
}