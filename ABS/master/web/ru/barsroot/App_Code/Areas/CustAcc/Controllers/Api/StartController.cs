using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.CustAcc.Controllers.Api
{
    public class StartController : ApiController
    {
        private readonly IExecuteRepository _execute;
        public StartController(IExecuteRepository execute)
        {
            _execute = execute;
        }

        [HttpGet]
        public HttpResponseMessage RunNbsCheck(decimal acc, string nbs)
        {
            try
            {
                var res = _execute.NbsReservCheck(acc, nbs);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage BackOfficeCheck()
        {
            try
            {
                var res = _execute.IsUserBackOffice();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}