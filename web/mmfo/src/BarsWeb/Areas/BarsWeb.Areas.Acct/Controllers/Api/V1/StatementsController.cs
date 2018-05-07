using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Acct.Infrastructure.Repository;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Areas.Acct.Resources;
using BarsWeb.Areas.Security.Attributes;
//
using BarsWeb.Core.Models;
using Kendo.Mvc.Extensions;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.Acct.Controllers.Api.V1
{
    [AuthorizeApi]
    public class StatementsController : ApiController
    {
        private readonly IStatemantRepository _statRepository;
        public StatementsController(IStatemantRepository statRepository)
        {
            _statRepository = statRepository;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="acctId">account id</param>
        /// <param name="dateStart">date start in format yyyy-MM-dd</param>
        /// <param name="dateEnd">date end in format yyyy-MM-dd</param>
        /// <returns></returns>
        public HttpResponseMessage Get(
            decimal acctId, 
            [ModelBinder(typeof(DateModelBinder))] DateTime? dateStart, 
            [ModelBinder(typeof(DateModelBinder))] DateTime? dateEnd,
            string type)
        {          
            var tmpDateStart = dateStart ?? DateTime.Today;
            var tmpDateEnd = dateEnd ?? tmpDateStart;

            var statement = type == "saldo" ? _statRepository.GetStatement(acctId, tmpDateStart, tmpDateEnd.AddDays(1), type) : _statRepository.GetStatement(acctId, tmpDateStart, tmpDateEnd.AddDays(1));
            if (statement == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new {Message = AcctResource.AcctNotFound});
            }
            return Request.CreateResponse(HttpStatusCode.OK, statement);
        }

        [HttpGet]
        [GET("api/v1/acct/Statements/Payments")]
        public HttpResponseMessage Payments(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal acctId, 
            [ModelBinder(typeof (DateModelBinder))] DateTime? dateStart,
            [ModelBinder(typeof (DateModelBinder))] DateTime? dateEnd)
        {
            var tmpDateStart = dateStart ?? DateTime.Today;
            var tmpDateEnd = dateEnd ?? tmpDateStart;

            var payments = _statRepository.GetStatementPayments(acctId, tmpDateStart, tmpDateEnd.AddDays(1));
            if (payments == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = AcctResource.AcctNotFound });
            }
            return Request.CreateResponse(HttpStatusCode.OK, payments.ToDataSourceResult(request));
        }
        /*[HttpGet]
        public HttpResponseMessage GetStatement(decimal acctId, 
            [ModelBinder(typeof(DateModelBinder))] DateTime? dateStart,
            [ModelBinder(typeof(DateModelBinder))] DateTime? dateEnd)
        {
            var tmpDateStart = dateStart ?? DateTime.Today;
            var tmpDateEnd = dateEnd ?? tmpDateStart;

            var statement = _statRepository.GetStatement(acctId, tmpDateStart, tmpDateEnd.AddDays(1));
            if (statement == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = AcctResource.AcctNotFound });
            }
            return Request.CreateResponse(HttpStatusCode.OK, statement);
        }*/
    }
}