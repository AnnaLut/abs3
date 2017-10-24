using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Services;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Areas.OpenCloseDay.Models;

namespace BarsWeb.Areas.OpenCloseDay.Controllers.Api
{
    [AuthorizeApi]
    public class DayOperController : ApiController
    {
        private readonly IFuncListOperation _func;

        public DayOperController(IFuncListOperation func)
        {
            _func = func;
        }

        [HttpGet]
        public HttpResponseMessage GetFuncList(string dateType)
        {
            try
            {
                var data = _func.GetList(dateType);
                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage ExecuteFunc(IList<FuncArray> funcList, string groupid)
        {
            try
            {
                _func.ExecuteFunc(funcList, groupid);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RunGroup(int groupLog)
        {
            try
            {
                _func.RunFailedGroup(groupLog);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage StopGroup(int groupLog)
        {
            try
            {
                _func.StopFailGroup(groupLog);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RestoreGroupList(int groupLog)
        {
            try
            {
                _func.RestoreGroup(groupLog);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /*[HttpGet]
        public HttpResponseMessage GetHistory(string date, string dateType)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _func.GetHistory(date, dateType));

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }*/
    }
}