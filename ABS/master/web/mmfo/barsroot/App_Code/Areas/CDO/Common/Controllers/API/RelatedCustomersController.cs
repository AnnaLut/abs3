using AttributeRouting.Web.Http;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using Kendo.Mvc.Extensions;
using BarsWeb.Areas.CDO.Common.Repository;
using System.Net.Http;
using System.Net;
using BarsWeb.Areas.CDO.Common.Models;

/// <summary>
/// Summary description for RelatedCustomersController
/// </summary>
namespace BarsWeb.Areas.CDO.Common.Controllers.Api
{
    [AuthorizeApi]
    public class RelatedCustomersController : ApiController
    {
        private ICustomersRepository _custRepository;
        private IRelatedCustomersRepository _relaredCustRepository;
        public RelatedCustomersController(
            ICustomersRepository custRepository,
            IRelatedCustomersRepository relaredCustRepository
            )
        {
            _relaredCustRepository = relaredCustRepository;
            _custRepository = custRepository;
        }
        
        /// <summary>
        /// Get all customers
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/cdo/common/customers/")]
        public HttpResponseMessage Customers(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var customers = _custRepository.GetAll();
                //return new DataSourceResult
                //{
                //    Data = customers.ToDataSourceResult(request).Data,
                //    Total = (request.Page * request.PageSize) + 1,
                //    Errors = null
                //};
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = customers.ToDataSourceResult(request).Data, Total = (request.Page * request.PageSize) + 1 });
            }
            catch (Exception ex)
            {
                //return new DataSourceResult
                //{
                //    Data = null,
                //    Total = (request.Page * request.PageSize) + 1,
                //    Errors = "Виникла помилка під час запросу до CorpLight. Зверніться до адміністратора. " + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace
                //};

                return Request.CreateResponse(HttpStatusCode.InternalServerError, 
                    "Виникла помилка під час запросу до CorpLight. Зверніться до адміністратора. " + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        /// <summary>
        /// Get related customers by customer id
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/common/GetCustomerRelatedCustomers/{custId}")]
        public HttpResponseMessage GetCustomerRelatedCustomers(decimal custId)
        {
            try
            {
                var result = _relaredCustRepository.GetCustomerRelatedCustomers(custId);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        /// <summary>
        /// Get customers list for visa related customers
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/cdo/common/customersForVisa/")]
        public HttpResponseMessage CustomersToVisa(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var customersToVisa = _relaredCustRepository.GetAllIdNotVisa();//select from mbm and corp2
                var customers = _custRepository.GetAll().Where(i => customersToVisa.Contains(i.Id.Value));
                //return  customers.ToDataSource(request);
                //return new DataSourceResult
                //{
                //    Data = customers.ToDataSourceResult(request).Data,
                //    Total = (request.Page * request.PageSize) + 1,
                //    Errors = null
                //};
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = customers.ToDataSourceResult(request).Data, Total = (request.Page * request.PageSize) + 1 });
            }
            catch (Exception ex)
            {
                //return new DataSourceResult
                //{
                //    Data = null,
                //    Total = (request.Page * request.PageSize) + 1,
                //    Errors = ex.Message + Environment.NewLine + ex.StackTrace
                //};
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        /// <summary>
        /// Get the data of customer (For physical customers only !!!)
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/common/customers/getfopdata/{customerId}")]
        public HttpResponseMessage GetFOPData(decimal customerId)
        {
            try
            {
                var res = _relaredCustRepository.GetFOPData(customerId);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Get related customers (by customer id) for visa
        /// </summary>
        /// <param name="custId"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/cdo/common/RelatedCustomers/{custId}")]
        public HttpResponseMessage GetC2AndCLUsers(decimal custId,
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                IEnumerable<RelatedCustomer> data = _relaredCustRepository.GetAllForConfirm(custId);//select from mbm and corp2
                                                                                                   //return data.ToDataSourceResult(request);
                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }

        }
        [HttpGet]
        [GET("api/cdo/common/customers/getdocs")]
        public HttpResponseMessage GetDocsData()
        {
            try
            {
                var res = _relaredCustRepository.GetDocsData();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }
        [HttpGet]
        [GET("api/cdo/common/customers/getTypeOfCustomer/{customerId}")]
        public HttpResponseMessage GetTypeOfCustomer(decimal customerId)
        {
            try
            {
                var res = _relaredCustRepository.GetTypeOfCustomer(customerId);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
    }
}