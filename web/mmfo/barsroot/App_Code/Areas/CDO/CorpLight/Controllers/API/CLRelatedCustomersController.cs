using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Core.Logger;
using CorpLight.Users.Models;
using Kendo.Mvc.Extensions;

using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Models;
using System.Text;
using System.Web;

using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Services;
using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.CorpLight.Repository;
using BarsWeb.Areas.CDO.CorpLight.Services;
using BarsWeb.Areas.CDO.Corp2.Repository;
using BarsWeb.Areas.CDO.Corp2.Services;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CDO.CorpLight.Controllers.Api
{
    /// <summary>
    /// Controller for managing Related customers
    /// </summary>
    [AuthorizeApi]
    public class CLRelatedCustomersController : ApiController
    {
        private ICustomersRepository _custRepository;
        private IRelatedCustomersRepository _commonrelaredCustRepository;
        private ICLRelatedCustomersRepository _relaredCustRepository;
        private readonly ICorp2RelatedCustomersRepository _corp2RelatedCustomers;
        private readonly ICLAcskRepository _acskRepository;
        private ICLRelatedCustomerValidator _relCustValidator;
        private IUserCertificateService _userCertificateService;
        private readonly IDbLogger _logger;

        public CLRelatedCustomersController(
            ICustomersRepository custRepository,
            IRelatedCustomersRepository commonRelatedCustomerRepository,
            ICLRelatedCustomersRepository relaredCustRepository,
            ICLRelatedCustomerValidator relCustValidator,
            IUserCertificateService userCertificateService
            , ICorp2RelatedCustomersRepository corp2RelatedCustomers
            , ICLAcskRepository acskRepository
            , IDbLogger logger)
        {
            _commonrelaredCustRepository = commonRelatedCustomerRepository;
            _relaredCustRepository = relaredCustRepository;
            _corp2RelatedCustomers = corp2RelatedCustomers;
            _acskRepository = acskRepository;
            _relCustValidator = relCustValidator;
            _custRepository = custRepository;
            _userCertificateService = userCertificateService;
            _logger = logger;
        }

        //HACK: Moved to Common
        /// <summary>
        /// Get related customers by customer id
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        //[HttpGet]
        //[GET("api/cdo/corplight/GetCustomerRelatedCustomers/{custId}")]
        //public HttpResponseMessage GetCustomerRelatedCustomers(decimal custId)
        //{
        //    var result = _relaredCustRepository.GetCustomerRelatedCustomers(custId);
        //    return Request.CreateResponse(HttpStatusCode.OK, result);
        //}

        /// <summary>
        /// Get related customers by customer id
        /// </summary>
        /// <param name="custId"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/cdo/corplight/RelatedCustomers/{custId}/{clmode}")]
        public HttpResponseMessage Get(decimal custId, string clmode,
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                IEnumerable<RelatedCustomer> data;
                //HACK: Removed to Common. The clmode parameter and _commonrelaredCustRepository are now unnecessary.
                //if (clmode == "visa")
                //{
                //    data = _commonrelaredCustRepository.GetAllForConfirm(custId);//select from mbm and corp2
                //}
                //else
                {
                    data = _relaredCustRepository.GetAll(custId);
                }
                //return data.ToDataSourceResult(request);
                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        [HttpGet]
        //[ODataQueryable]
        [GET("api/cdo/corplight/RelatedCustomers/{custId}")]
        public HttpResponseMessage GetBase(decimal custId,
    [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string clmode = "base")
        {
            try
            {
                var data = _relaredCustRepository.GetAll(custId);
                var dataSourceResult = clmode == "visa" ? data.Where(i => i.ApprovedType == "update" || i.ApprovedType == "delete" || i.ApprovedType == "add").ToDataSourceResult(request)
                    : data.ToDataSourceResult(request);
                return Request.CreateResponse(HttpStatusCode.OK, dataSourceResult);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Get related customer by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/RelatedCustomers/getbyid/{id}")]
        public HttpResponseMessage GetById(decimal id)
        {
            try
            {
                var result = _relaredCustRepository.GetById(id);
                if (result == null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Get related customer by id
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/RelatedCustomers/getbyid/{id}/{custId}")]
        public HttpResponseMessage GetById(decimal id, decimal custId)
        {
            try
            {
                var result = _relaredCustRepository.GetById(id, custId);
                if (result == null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        // TODO check fix
        /// <summary>
        /// Get related customer by tax code
        /// </summary>
        /// <param name="taxCode"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/RelatedCustomers/getbytaxcode/{custId}/{taxCode}/{docSeries}/{docNumber}")]
        public HttpResponseMessage GetByTaxCode(decimal custId, string taxCode, string docSeries, string docNumber)
        {
            try
            {
                //Шукаємо користувача в базі ABS CorpLight
                var users = _relaredCustRepository.GetByTaxCode(taxCode).ToList();
                RelatedCustomer data = users.FirstOrDefault(i => i.CustId == custId);
                if (data != null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest,
                        string.Format("Користувач з ІПН: {0} вже існує у клієнта id: {1}", taxCode, custId));
                }
                data = users.FirstOrDefault(i => i.CustId != custId);
                if (data != null)
                {
                    data.Sdo = "CorpLight";
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }
                //Якщо не знаходимо, то шукаємо в ABS Corp2
                data = _corp2RelatedCustomers.GetByTaxCodeFrom_REL_CUSTOMERS(taxCode).FirstOrDefault();
                if (data != null)
                {
                    data.Id = null;
                    data.UserId = null;
					data.NoInn = 0;
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }
                //В базі КорпЛайт не шукаємо, бо такий пошук проводиться при підтвердженні беком. Терещенко Ю. сказала не чіпати, зробити поки костилями.
                //Якщо не знаходемо в ABS, то шукаємо в базі Корп2
                User userCorp2 = _corp2RelatedCustomers.GetExistUser(new RelatedCustomer { TaxCode = taxCode, DocSeries = docSeries, DocNumber = docNumber });

                if (userCorp2 != null)
                {
                    data = Mapper.MapUserToRelatedCustomer(userCorp2);
                    data.UserId = null;
					data.NoInn = 0;
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }

                return data == null ? Request.CreateResponse(HttpStatusCode.OK) : Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Create new related customer
        /// </summary>
        /// <param name="relatedCustomer"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corplight/RelatedCustomers/create")]
        public HttpResponseMessage Post(RelatedCustomer relatedCustomer)
        {
            try
            {
                if (_relCustValidator.IsExistByParameters(
                    relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email))
                {
                    return Request.CreateResponse(
                        HttpStatusCode.BadRequest,
                        "Користувач з вказаними параметрами вже існує");
                }

                var id = _relaredCustRepository.Add(relatedCustomer);
                if (relatedCustomer.AcskRegistrationId.HasValue && relatedCustomer.AcskRegistrationId != 0)
                {   //insert into MBM_ACSK_REGISTRATION
                    _acskRepository.MapRelatedCustomerToAcskUser(id, new Common.Models.Acsk.AcskSendProfileInfo
                    {
                        RegistrationId = (int?)relatedCustomer.AcskRegistrationId,
                        RegistrationDate = relatedCustomer.AcskRegistrationDate,
                        UserId = relatedCustomer.AcskUserId
                    }); 
                }

                _logger.Info(string.Format(
                    "Створено нового користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, email:{3}",
                    relatedCustomer.Id, relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email));

                _logger.Info(string.Format(
                    "Користувачу Id:{0} надано доступ до клієнта RNK:{1}, номер підпису:{2}",
                    relatedCustomer.Id, relatedCustomer.CustId, relatedCustomer.SignNumber));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Updtae related customer
        /// </summary>
        /// <param name="id"></param>
        /// <param name="relatedCustomer"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corplight/RelatedCustomers/update/{id}")]
        public HttpResponseMessage Put(decimal id, RelatedCustomer relatedCustomer)
        {
            try
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
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Map related customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <param name="signNumber"></param>
        /// <returns></returns>
        //[HttpPut]
        //[PUT("api/cdo/corplight/RelatedCustomers/mapCustomer/{id}/{custId}/{signNumber}")]
        //public HttpResponseMessage MapCustomer(decimal id, decimal custId, decimal signNumber)
        //{
        //    try
        //    {
        //        if (_relCustValidator.CustomerIsMapped(id, custId))
        //        {
        //            return Request.CreateResponse(
        //                HttpStatusCode.BadRequest,
        //                "Користувач вже прикріплений до клієнта");
        //        }
        //        _relaredCustRepository.MapRelatedCustomerToUser(null, custId, id, signNumber);
        //        _logger.Info(string.Format(
        //            "Користувачу Id:{0} надано доступ до клієнта RNK:{1}, номер підпису:{2}",
        //            id, custId, signNumber));

        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
        //    }
        //}
        [HttpPut]
        [PUT("api/cdo/corplight/RelatedCustomers/updateAndMap/")]
        public HttpResponseMessage UpdateAndMap(RelatedCustomer relatedCustomer)
        {
            try
            {
                _relaredCustRepository.UpdateAndMap(relatedCustomer);
                if (relatedCustomer.AcskRegistrationId.HasValue && relatedCustomer.AcskRegistrationId != 0)
                {   //insert into MBM_ACSK_REGISTRATION
                    _acskRepository.MapRelatedCustomerToAcskUser(relatedCustomer.Id.Value, new Common.Models.Acsk.AcskSendProfileInfo
                    {
                        RegistrationId = (int?)relatedCustomer.AcskRegistrationId,
                        RegistrationDate = relatedCustomer.AcskRegistrationDate,
                        UserId = relatedCustomer.AcskUserId
                    });
                }
                _logger.Info(string.Format(
                    "Користувачу Id:{0} надано доступ до клієнта RNK:{1}, номер підпису:{2}",
                    relatedCustomer.Id, relatedCustomer.CustId, relatedCustomer.SignNumber));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        /// <summary>
        /// Unmap related customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corplight/RelatedCustomers/unMapCustomer/{id}/{custId}")]
        public HttpResponseMessage UnMapCustomer(decimal id, decimal custId)
        {
            try
            {
                _relaredCustRepository.SetRelatedCustomerApproved(id, custId, false, "delete");

                _logger.Info(string.Format(
                    "Підтверджено видалення користувача Id:{0}", id));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Visa relate customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corplight/RelatedCustomers/visa/{id}/{custId}")]
        public HttpResponseMessage Visa(decimal id, decimal custId)
        {
            try
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
                    "Бек офісом підтверджено картку нового користувача Id:{0}, RNK:{1}", id, custId));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Visa relate customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corplight/RelatedCustomers/visa/{id}/{custId}/{userId}")]
        public HttpResponseMessage Visa(decimal id, long custId, string userId)
        {
            try
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
                    "Бек офісом підтверджено картку користувача Id:{0}, RNK:{1}, userId:{2}", id, custId, userId));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Delete related customer
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[HttpDelete]
        //[DELETE("api/cdo/corplight/RelatedCustomers/{id}")]
        //public HttpResponseMessage Delete(decimal id)
        //{
        //    try
        //    {
        //        _relaredCustRepository.Delete(id);

        //        _logger.Info(string.Format(
        //            "Видалено користувача Id:{0}", id));
        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
        //    }
        //}

        [HttpPost]
        [POST("api/cdo/corplight/RelatedCustomers/requestCertificate/{relCustId}")]
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
        [DELETE("api/cdo/corplight/RelatedCustomers/deleteRequest/{relCustId}/{customerId}")]
        public HttpResponseMessage RequestCertificate(decimal relCustId, decimal customerId)
        {
            try
            {
                _relaredCustRepository.SetRelatedCustomerApproved(relCustId, customerId, false, "rejected");

                _logger.Info(string.Format(
                    "Відхилено запит на підтвердження змін по користувачу Id:{0}", relCustId));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        //HACK: Moved to Common
        /// <summary>
        /// Get the data of customer (For physical customers only !!!)
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        //[HttpGet]
        //[GET("api/cdo/corplight/customers/getfopdata/{customerId}")]
        //public HttpResponseMessage GetFOPData(decimal customerId)
        //{
        //    var res = _relaredCustRepository.GetFOPData(customerId);
        //    return Request.CreateResponse(HttpStatusCode.OK, res);
        //}
    }

}
