using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Areas.CorpLight.Infrastructure.Services;
using BarsWeb.Areas.CorpLight.Models;
using BarsWeb.Core.Logger;
using CorpLight.Users.Models;
using Kendo.Mvc.Extensions;

using Kendo.Mvc.UI;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CorpLight.Controllers.Api
{
    /// <summary>
    /// Controller for managing Related customers
    /// </summary>
    [AuthorizeApi]
    public class RelatedCustomersController : ApiController
    {
        ICustomersRepository _custRepository;
        private IRelatedCustomersRepository _relaredCustRepository;
        private IRelatedCustomerValidator _relCustValidator;
        private IUserCertificateService _userCertificateService;
        private readonly IDbLogger _logger;

        public RelatedCustomersController(
            ICustomersRepository custRepository,
            IRelatedCustomersRepository relaredCustRepository,
            IRelatedCustomerValidator relCustValidator,
            IUserCertificateService userCertificateService,
            IDbLogger logger)
        {
            _relaredCustRepository = relaredCustRepository;
            _relCustValidator = relCustValidator;
            _custRepository = custRepository;
            _userCertificateService = userCertificateService;
            _logger = logger;
        }


        /// <summary>
        /// Get related customers by customer id
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/corpLight/GetCustomerRelatedCustomers/{custId}")]
        public HttpResponseMessage GetCustomerRelatedCustomers(decimal custId)
        {
            var result = _relaredCustRepository.GetCustomerRelatedCustomers(custId);
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        /// <summary>
        /// Get all customers
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/corpLight/customers/")]
        public DataSourceResult Customers(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var customers = _custRepository.GetAll();
            //return  customers.ToDataSource(request);
            return new DataSourceResult
            {
                Data = customers.ToDataSourceResult(request).Data,
                Total = (request.Page * request.PageSize) + 1,
                Errors = null
            };
        }

        /// <summary>
        /// Get customers list for visa
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/corpLight/customersForVisa/")]
        public DataSourceResult CustomersToVisa(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var customersToVisa = _relaredCustRepository.GetAllIdNotVisa(); 

            var customers = _custRepository.GetAll().Where(i=> customersToVisa.Contains(i.Id.Value));
            //return  customers.ToDataSource(request);
            return new DataSourceResult
            {
                Data = customers.ToDataSourceResult(request).Data,
                Total = (request.Page * request.PageSize) + 1,
                Errors = null
            };
        }

        /// <summary>
        /// Get related customers by customer id
        /// </summary>
        /// <param name="custId"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/corpLight/RelatedCustomers/{custId}/{clmode}")]
        public DataSourceResult Get(decimal custId, string clmode,
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var data = _relaredCustRepository.GetAll(custId);
            return clmode == "visa" ? data.Where(i => i.ApprovedType == "update" || i.ApprovedType == "delete" || i.ApprovedType == "add").ToDataSourceResult(request)
                : data.ToDataSourceResult(request);
        }

        [HttpGet]
        //[ODataQueryable]
        [GET("api/corpLight/RelatedCustomers/{custId}")]
        public DataSourceResult GetBase(decimal custId, 
    [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string clmode = "base")
        {
            var data = _relaredCustRepository.GetAll(custId);
            return clmode == "visa" ? data.Where(i => i.ApprovedType == "update" || i.ApprovedType == "delete" || i.ApprovedType == "add").ToDataSourceResult(request)
                : data.ToDataSourceResult(request);
        }
        /// <summary>
        /// Get related customer by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/corpLight/RelatedCustomers/getbyid/{id}")]
        public HttpResponseMessage GetById(decimal id)
        {
            var result = _relaredCustRepository.GetById(id);
            if (result == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        /// <summary>
        /// Get related customer by id
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/corpLight/RelatedCustomers/getbyid/{id}/{custId}")]
        public HttpResponseMessage GetById(decimal id, decimal custId)
        {
            var result = _relaredCustRepository.GetById(id, custId);
            if (result == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        /// <summary>
        /// Get related customer by tax code
        /// </summary>
        /// <param name="taxCode"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/corpLight/RelatedCustomers/getbytaxcode/{taxCode}/{custId}")]
        public HttpResponseMessage GetByTaxCode(string taxCode, decimal custId)
        {
            var result = _relaredCustRepository.GetByTaxCode(taxCode);
            if (result == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            return  Request.CreateResponse(HttpStatusCode.OK, result);
        }

        /// <summary>
        /// Create new related customer
        /// </summary>
        /// <param name="relatedCustomer"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/corpLight/RelatedCustomers")]
        public HttpResponseMessage Post(RelatedCustomer relatedCustomer)
        {
            if (_relCustValidator.IsExistByParameters(
                relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email))
            {
                return Request.CreateResponse(
                    HttpStatusCode.BadRequest, 
                    "Користувач з вказаними параметрами вже існує");
            }
            _relaredCustRepository.Add(relatedCustomer);
            _logger.Info(string.Format(
                "Створено нового користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, email:{3}",
                relatedCustomer.Id, relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email));


            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Updtae related customer
        /// </summary>
        /// <param name="id"></param>
        /// <param name="relatedCustomer"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/corpLight/RelatedCustomers/{id}")]
        public HttpResponseMessage Put(decimal id, RelatedCustomer relatedCustomer)
        {
 if (_relCustValidator.IsEmailEdited(relatedCustomer.Email, relatedCustomer.Id))
            {
                if (_relaredCustRepository.IsExistByEmail(relatedCustomer.Email))
                {
                    return Request.CreateResponse(
                   HttpStatusCode.BadRequest,
                   "Користувач з вказаним e-mail вже існує");
                }

            }
            if (_relCustValidator.IsPhoneEdited(relatedCustomer.CellPhone, relatedCustomer.Id))
            {
                if (_relaredCustRepository.IsExistByPhone(relatedCustomer.CellPhone))
                {
                    return Request.CreateResponse(
                   HttpStatusCode.BadRequest,
                   "Користувач з вказаним телефоном вже існує");
                }
            }
            _relaredCustRepository.Update(relatedCustomer);

            _logger.Info(string.Format(
                "Відредаговано дані користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, email:{3}",
                id, relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email));

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Map related customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <param name="signNumber"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/corpLight/RelatedCustomers/mapCustomer/{id}/{custId}/{signNumber}")]
        public HttpResponseMessage MapCustomer(decimal id, decimal custId, decimal signNumber)
        {
            if (_relCustValidator.CustomerIsMapped(id, custId))
            {
                return Request.CreateResponse(
                    HttpStatusCode.BadRequest,
                    "Користувач вже прикріплений до клієнта");
            }
            _relaredCustRepository.MapRelatedCustomerToUser(null,custId, id, signNumber);
            _logger.Info(string.Format(
                "Користувачу Id:{0} надано доступ до клієнта RNK:{1}, нонер підпису:{2}",
                id, custId, signNumber));

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Unmap related customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/corpLight/RelatedCustomers/unMapCustomer/{id}/{custId}")]
        public HttpResponseMessage UnMapCustomer(decimal id, decimal custId)
        {
            _relaredCustRepository.SetRelatedCustomerApproved(id, custId, false, "delete");

            _logger.Info(string.Format(
                "Підтверджено видалення користувача Id:{0}", id));

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Visa relate customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/corpLight/RelatedCustomers/visa/{id}/{custId}")]
        public HttpResponseMessage Visa(decimal id, decimal custId)
        {
            if (!_relCustValidator.CustomerIsMapped(id, custId))
            {
                return Request.CreateResponse(
                    HttpStatusCode.BadRequest,
                    "Користувач не прикріплений до клієнта");
            }

            var relCust = _relaredCustRepository.GetAll(custId).FirstOrDefault(i => i.Id == id);

            if (relCust == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Користувача з ID=" + id + " не знайдено!");
            }
            BankingUser existUser = null;
            if (relCust.ApprovedType == "add")
            {
                existUser = _relaredCustRepository.GetExistUser(relCust);
            }
            if (existUser != null)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new
                    {
                        Status = "ERROR",
                        Message = "Користувач з вказаними даними вже існує в системі ПІБ: " + existUser.DisplayName +
                                    " телефон: " + existUser.PhoneNumber + " email: " + existUser.Email,
                        Data = existUser
                    });
            }

            _relaredCustRepository.VisaMapedRelatedCustomerToUser(id, custId);

            _logger.Info(string.Format(
                "Бек офісом підтверджено картку клієнта Id:{0}, RNK:{1}", id, custId));

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Visa relate customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/corpLight/RelatedCustomers/visa/{id}/{custId}/{userId}")]
        public HttpResponseMessage Visa(decimal id, long custId, string userId)
        {
            if (!_relCustValidator.CustomerIsMapped(id, custId))
            {
                return Request.CreateResponse(
                    HttpStatusCode.BadRequest,
                    "Користувач не прикріплений до клієнта");
            }

            var relCust = _relaredCustRepository.GetAll(custId).FirstOrDefault(i => i.Id == id);
            if (relCust == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Користувача з ID=" + id + " не знайдено!");
            }

            _relaredCustRepository.VisaMapedRelatedCustomerToExistUser(id, custId, userId);

            _logger.Info(string.Format(
                "Бек офісом підтверджено картку клієнта Id:{0}, RNK:{1}, userId:{2}", id, custId, userId));

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Delete related customer
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete]
        [DELETE("api/corpLight/RelatedCustomers/{id}")]
        public HttpResponseMessage Delete(decimal id)
        {
            _relaredCustRepository.Delete(id);

            _logger.Info(string.Format(
                "Видалено користувача Id:{0}", id));
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        [POST("api/corpLight/RelatedCustomers/requestCertificate/{relCustId}")]
        public HttpResponseMessage RequestCertificate(decimal relCustId)
        {
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Set customer approoved 
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpDelete]
        [DELETE("api/corpLight/RelatedCustomers/deleteRequest/{relCustId}/{customerId}")]
        public HttpResponseMessage RequestCertificate(decimal relCustId, decimal customerId)
        {
            _relaredCustRepository.SetRelatedCustomerApproved(relCustId, customerId, false, "rejected");
            
            _logger.Info(string.Format(
                "Відхилено запит на підтвердження змін по користувачу Id:{0}", relCustId));
            return Request.CreateResponse(HttpStatusCode.OK);
        }


        /// <summary>
        /// Get the data of customer (For physical customers only !!!)
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/corpLight/customers/getfopdata/{customerId}")]
        public HttpResponseMessage GetFOPData(decimal customerId)
        {
            var res = _relaredCustRepository.GetFOPData(customerId);
            return Request.CreateResponse(HttpStatusCode.OK, res);
        }


    }
}
