using System;
using CorpLight.Users;
using CorpLight.Users.Models;
using CorpLight.Users.Models.Enums;
using System.Web.Http;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using clientregister;
using BarsWeb.Core.Logger;
using Ninject;

using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.CorpLight.Services;

using BarsWeb.Areas.CDO.CorpLight.Models;
using BarsWeb.Areas.CDO.CorpLight.Repository;
using System.Text.RegularExpressions;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CDO.CorpLight.Controllers.Api
{
    /// <summary>
    /// Controller for managing users
    /// </summary>
    [AuthorizeApi]
    //[CheckAccessPage]
    public class UsersController : ApiController
    {
        private readonly IUsersManage<string, string> _usersManage;
        private readonly ICLRelatedCustomersRepository _relatedCustRepository;
        private readonly IBanksRepository _bankRepository;
        //private readonly IDbLogger _logger;
        private readonly ICLCustomersRepository _customersRepository;
        private readonly string corpLightExMessage = "Виникла помилка під час запросу до сервісу CorpLight. Зверніться до адміністратора.";

        public UsersController(
            ICLRelatedCustomersRepository relatedCustomersRepository,
            IBanksRepository bankRepository,
            ICorpLightUserManageService corpLightUserManageService,
            //IDbLogger logger,
            ICLCustomersRepository customersRepository)
        {
            _relatedCustRepository = relatedCustomersRepository;
            _bankRepository = bankRepository;
            _usersManage = corpLightUserManageService.GetCorpLightUserManage();
            //_logger = logger;
            _customersRepository = customersRepository;
            SslValidation();
        }
        private void SslValidation()
        {
            ServicePointManager.ServerCertificateValidationCallback =
                delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
                {
                    return true;
                };
        }

        /// <summary>
        /// Get customer users
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/Users/GetCustomerUsers/{customerId}")]
        public List<BankingUser> GetCustomerUsers(string customerId)
        {
            try
            {
                return _usersManage.GetCustomerUsers(customerId);
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Get users by provider
        /// </summary>
        /// <param name="providerType"></param>
        /// <param name="provideValue"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/Users/GetUserByProvider")]
        public BankingUser GetUserByProvider(LoginProviderType providerType, string provideValue)
        {
            try
            {
                return _usersManage.GetUserByProvider(providerType, provideValue);
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Get list of users to confirm phone
        /// </summary>
        /// <returns></returns>
        private List<defaultWebService.ConfirmPhone> GetConfirmPhoneList()
        {
            var sesionList = HttpContext.Current.Session["ConfirmCellPhoneList"];
            if (sesionList == null)
            {
                HttpContext.Current.Session["ConfirmCellPhoneList"] = new List<defaultWebService.ConfirmPhone>();
            }

            return (List<defaultWebService.ConfirmPhone>)HttpContext.Current.Session["ConfirmCellPhoneList"];
        }

        /// <summary>
        /// Get user by id
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        [GET("api/cdo/corplight/Users/GetUserById")]
        public BankingUser GetUserById(string userId)
        {
            try
            {
                return _usersManage.GetUserById(userId);
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Validate mobile phone
        /// </summary>
        /// <param name="phoneNumber"></param>
        [POST("api/cdo/corplight/Users/validateMobilePhone")]
        public HttpResponseMessage ValidateMobilePhone(string phoneNumber)
        {
            try
            {
                var confirmPhoneList = GetConfirmPhoneList();

                Regex regex = new Regex(@"\+[0-9]{12}$");
                Match match = regex.Match(phoneNumber);
                var phone = match.Success ? phoneNumber : "+" + phoneNumber.Trim();

                var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phone);
                if (curentPhone == null)
                {
                    curentPhone = new defaultWebService.ConfirmPhone
                    {
                        Phone = phone,
                        Secret = GetSecret()
                    };
                    _relatedCustRepository.SendSms(curentPhone.Phone, "Your secure code is " + curentPhone.Secret);

                    confirmPhoneList.Add(curentPhone);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = "Ok", Message = "Успішно" });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        private string GetSecret()
        {
            var randObj = new Random((int)DateTime.Now.Ticks & 0x0000FFFF);
            return string.Format("{0:F0}", randObj.Next(10000000, 99999999));
        }

        /// <summary>
        /// Validate one time pass
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <param name="code"></param>
        [POST("api/cdo/corplight/Users/validateOneTimePass")]
        public HttpResponseMessage ValidateOneTimePass(string phoneNumber, string code)
        {
            try
            {
                var confirmPhoneList = GetConfirmPhoneList();

                Regex regex = new Regex(@"\+[0-9]{12}$");
                Match match = regex.Match(phoneNumber);
                var phone = match.Success ? phoneNumber : "+" + phoneNumber.Trim();

                var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phone);
                if (curentPhone == null || curentPhone.Secret != code)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Невірний код");
                }
                confirmPhoneList.Remove(curentPhone);
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = "Ok", Message = "Успішно" });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Add new user 
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corplight/Users/AddNewUser")]
        public BankingUser AddNewUser(CreateUserModel user)
        {
            try
            {
                var customer = _customersRepository.Get(user.CustId.Value);
                user.Customers[0].EDRPO = customer.CL_OKPO;

                BankingUser result = null;
                try
                {
                    result = _usersManage.AddUser(user, ((long)user.CustId).ToString());
                }
                catch (Exception ex)
                {
                    throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                }
                //_logger.Info(string.Format(
                //    "Створено нового користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, email:{3}",
                //    result.Id, result.TaxCode, result.PhoneNumber, result.Email));

                var rnk = Convert.ToDecimal(user.CustId);
                _relatedCustRepository.MapRelatedCustomerToUser(
                    result.Id,
                    rnk,
                    user.RelatedCustId.Value,
                    user.IsExistCust.Value);

                //_logger.Info(string.Format(
                //    "Користувачу ID:{0} надано доступ до клієнта RNK:{1}", result.Id, rnk));

                return result;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        /// <summary>
        /// Update user
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corplight/Users/UpdateUser/{customerId}")]
        public BankingUser UpdateUser(CreateUserModel user, string customerId)
        {
            try
            {
                // TODO update client part !
                var customer = _customersRepository.Get(user.CustId.Value);
                user.Customers[0].EDRPO = customer.CL_OKPO;

                try
                {
                    var result = _usersManage.UpdateUser(user, customerId);
                    //_logger.Info(string.Format("Оновлено дані по користувачу ID:{0}", result.Id));
                    return result;
                }
                catch (Exception ex)
                {
                    throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Lock user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corplight/Users/LockUser/{userId}/{customerId}")]
        public HttpResponseMessage LockUser(string userId, string customerId)
        {
            try
            {
                _usersManage.LockUserCustomer(userId, customerId);

                //_logger.Info(string.Format(
                //    "Користувачу ID:{0} заблоковано доступ до клієнта RNK:{1}", userId, customerId));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, corpLightExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Unlock user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corplight/Users/UnLockUser/{userId}/{customerId}")]
        public HttpResponseMessage UnLockUser(string userId, string customerId)
        {
            // TODO check on the client part
            try
            {
                _usersManage.UnLockUserCustomer(userId, customerId);
                //_logger.Info(string.Format(
                //    "Користувачу ID:{0} розблоковано доступ до клієнта RNK:{1}", userId, customerId));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, corpLightExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Delete user 
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="customerId"></param>
        /// <param name="relCustId"></param>
        /// <returns></returns>
        [HttpDelete]
        [DELETE("api/cdo/corplight/Users/DeleteUser/{userId}/{customerId}/{relCustId}")]
        public HttpResponseMessage DeleteUser(string userId, long customerId, decimal relCustId)
        {
            try
            {
                if (!string.IsNullOrEmpty(userId) && userId.ToLower() != "null")
                {
                    //var customer = _customersRepository.Get(customerId);
                    try
                    {
                        _usersManage.DeleteUserCustomer(userId, customerId.ToString());
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                    }//_logger.Info(string.Format(
                    //    "Користувачу ID:{0} видалено доступ до клієнта RNK:{1}", userId, customerId));
                }

                _relatedCustRepository.RemoveRelatedCustomer(relCustId, customerId);
                //_logger.Info(string.Format(
                //    "Видалено користувач relCustId:{0} прикріпленого до клієнта RNK:{1}", relCustId, customerId));

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
    }
}