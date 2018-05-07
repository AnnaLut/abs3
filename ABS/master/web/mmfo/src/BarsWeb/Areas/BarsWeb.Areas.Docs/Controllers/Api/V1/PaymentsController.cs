using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Docs.Infrastructure;
using BarsWeb.Areas.Docs.Infrastructure.Repository;
using BarsWeb.Areas.Docs.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Docs.Controllers.Api.V1
{
    [Authorize]
    public class PaymentsController : ApiController
    {

        private readonly IPaymentsRepository _paymentsRepo;
        public PaymentsController(IPaymentsRepository paymentsRepo)
        {
            _paymentsRepo = paymentsRepo;
        }

        [GET("api/docs/payments/model")]
        public HttpResponseMessage GetModel()
        {
            var model = new AttributesHelper().AttributesToKendoGridOptions(typeof(Payment));
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [GET("api/docs/payments/userin")]
        public DataSourceResult GetUserIn(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllUserIn(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

        [GET("api/docs/payments/userout")]
        public DataSourceResult GetUserOut(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllUserOut(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

        [GET("api/docs/payments/branchin")]
        public DataSourceResult GetBranchIn(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllBranchIn(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

        [GET("api/docs/payments/branchout")]
        public DataSourceResult GetBranchOut(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllBranchOut(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }


        //архівна схема
        [GET("api/docs/payments/arcsuserin")]
        public DataSourceResult GetArcsUserIn(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllArcsUserIn(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

        [GET("api/docs/payments/arcsuserout")]
        public DataSourceResult GetArcsUserOut(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllArcsUserOut(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

        [GET("api/docs/payments/arcsbranchin")]
        public DataSourceResult GetArcsBranchIn(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllArcsBranchIn(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

        [GET("api/docs/payments/arcsbranchout")]
        public DataSourceResult GetArcsBranchOut(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            DateTime dateStart,
            DateTime dateEnd)
        {
            var payments = _paymentsRepo.GetAllArcsBranchOut(dateStart, dateEnd.AddDays(1));
            return payments.ToDataSourceResult(request);
        }

    }
}