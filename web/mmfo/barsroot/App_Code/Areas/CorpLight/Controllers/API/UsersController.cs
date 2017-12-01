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
using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using clientregister;
using BarsWeb.Areas.CorpLight.Models;
using BarsWeb.Areas.CorpLight.Infrastructure.Services;
using BarsWeb.Core.Logger;
using Ninject;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CorpLight.Controllers.Api
{ 
    /// <summary>
    /// Controller for managing users
    /// </summary>
    [AuthorizeApi]
    //[CheckAccessPage]
    public class UsersController : ApiController
    {
        private readonly IUsersManage<string, decimal> _usersManage;
        private readonly IRelatedCustomersRepository _relatedCustRepository;
        private readonly IBanksRepository _bankRepository;
        private readonly IDbLogger _logger;

        public UsersController(
            IRelatedCustomersRepository relatedCustomersRepository,
            IBanksRepository bankRepository,
            ICorpLightUserManageService corpLightUserManageService,
            IDbLogger logger)
        {
            _relatedCustRepository = relatedCustomersRepository;
            _bankRepository = bankRepository;            
            _usersManage = corpLightUserManageService.GetCorpLightUserManage();
            _logger = logger;

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
        /// <param name="bankId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/CorpLight/Users/GetCustomerUsers")]
        public List<BankingUser> GetCustomerUsers(long customerId, string bankId)
        {
            return _usersManage.GetCustomerUsers(customerId, bankId);
        }

        /// <summary>
        /// Get users by provider
        /// </summary>
        /// <param name="providerType"></param>
        /// <param name="provideValue"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/CorpLight/Users/GetUserByProvider")]
        public BankingUser GetUserByProvider(LoginProviderType providerType, string provideValue)
        {
            return _usersManage.GetUserByProvider(providerType, provideValue);
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
        [GET("api/CorpLight/Users/GetUserById")]
        public BankingUser GetUserById(string userId)
        {
            return _usersManage.GetUserById(userId);
        }

       /// <summary>
       /// Validate mobile phone
       /// </summary>
       /// <param name="phoneNumber"></param>
        [POST("api/CorpLight/Users/validateMobilePhone/{phoneNumber}")]
        public void ValidateMobilePhone(string phoneNumber)
        {
            var confirmPhoneList = GetConfirmPhoneList();
            var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phoneNumber);
            if (curentPhone == null)
            {
                curentPhone = new defaultWebService.ConfirmPhone
                {
                    Phone = phoneNumber,
                    Secret = GetSecret()
                };
                _relatedCustRepository.SendSms(phoneNumber, "Your secure code is " + curentPhone.Secret);

                confirmPhoneList.Add(curentPhone);
            }
        }
        /// <summary>
        /// Send sms method
        /// </summary>
        /// <param name="phone"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        private string GetSecret()
        {
            var randObj = new Random((int)DateTime.Now.Ticks & 0x0000FFFF);
            return string.Format("{0:F8}", randObj.NextDouble());
        }

        /// <summary>
        /// Validate one time pass
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <param name="code"></param>
        [POST("api/CorpLight/Users/validateOneTimePass")]
        public void ValidateOneTimePass(string phoneNumber, string code)
        {
            var confirmPhoneList = GetConfirmPhoneList();
            var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phoneNumber);
            if (curentPhone ==null || curentPhone.Secret != code)
            {
                throw new Exception("Невірний код");
            }
            confirmPhoneList.Remove(curentPhone);
        }

        /// <summary>
        /// Add new user 
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/CorpLight/Users/AddNewUser")]
        public BankingUser AddNewUser(CreateUserModel user)
        {
            var result = _usersManage.AddUser(user);
            _logger.Info(string.Format(
                "Створено нового користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, email:{3}", 
                result.Id, result.TaxCode, result.PhoneNumber, result.Email));

            try
            {
                var rnk = Convert.ToDecimal(user.Customers[0].CustomerId);
                _relatedCustRepository.MapRelatedCustomerToUser(
                    result.Id, 
                    rnk, 
                    user.RelatedCustId.Value, 
                    user.IsExistCust.Value);

                _logger.Info(string.Format(
                    "Користувачу ID:{0} надано доступ до клієнта RNK:{1}", result.Id, rnk));
            }
            catch 
            {
                //
            }

            return result;
        }
        /// <summary>
        /// Update user
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/CorpLight/Users/UpdateUser")]
        public BankingUser UpdateUser(BankingUser user)
        {
            var result = _usersManage.UpdateUser(user);
            _logger.Info(string.Format("Оновлено дані по користувачу ID:{0}", result.Id));
            return result;
        }

        /// <summary>
        /// Lock user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/CorpLight/Users/LockUser")]
        public HttpResponseMessage LockUser(string userId, long customerId)
        {
            _usersManage.LockUserCustomer(userId, customerId, _bankRepository.GetOurMfo());

            _logger.Info(string.Format(
                "Користувачу ID:{0} заблоковано доступ до клієнта RNK:{1}", userId, customerId));
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Unlock user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="customerId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/CorpLight/Users/UnLockUser")]
        public HttpResponseMessage UnLockUser(string userId, long customerId)
        {
            _usersManage.UnLockUserCustomer(userId, customerId,_bankRepository.GetOurMfo());
            _logger.Info(string.Format(
                "Користувачу ID:{0} розблоковано доступ до клієнта RNK:{1}", userId, customerId));
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Delete user 
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="customerId"></param>
        /// <param name="relCustId"></param>
        /// <returns></returns>
        [HttpDelete]
        [DELETE("api/CorpLight/Users/DeleteUser")]
        public HttpResponseMessage DeleteUser(string userId, long customerId, decimal relCustId)
        {
            if (!string.IsNullOrEmpty(userId) && userId.ToLower() != "null")
            {
                _usersManage.DeleteUserCustomer(userId, customerId, _bankRepository.GetOurMfo());
                _logger.Info(string.Format(
                    "Користувачу ID:{0} видалено доступ до клієнта RNK:{1}", userId, customerId));
            }
            try
            {
                _relatedCustRepository.RemoveRelatedCustomer(relCustId, customerId);
                _logger.Info(string.Format(
                    "Видалено користувач relCustId:{0} прикріпленого до клієнта RNK:{1}", relCustId, customerId));
            }
            catch 
            {
                //
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}