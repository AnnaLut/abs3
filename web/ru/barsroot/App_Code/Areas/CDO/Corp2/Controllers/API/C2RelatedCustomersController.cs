using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System.Web.Http.ModelBinding;
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
using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Corp2.Repository;
using BarsWeb.Areas.CDO.Corp2.Services;
using BarsWeb.Areas.CDO.Corp2.Models;
using BarsWeb.Areas.CDO.CorpLight.Repository;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CDO.Corp2.Controllers.Api
{
    /// <summary>
    /// Controller for managing Related customers
    /// </summary>
    [AuthorizeApi]
    public class C2RelatedCustomersController : ApiController
    {
        private ICLRelatedCustomersRepository _clrelaredCustRepository;
        private ICorp2RelatedCustomerValidator _corp2RelatedCustomerValidator;
        private ICorp2RelatedCustomersRepository _corp2RelatedCustomers;
        private readonly string corp2ExMessage = "Виникла помилка під час запросу до сервісу Corp2. Зверніться до адміністратора.";
        private readonly string corpLightExMessage = "Виникла помилка під час запросу до сервісу CorpLight. Зверніться до адміністратора.";
        private readonly IDbLogger _logger;

        public C2RelatedCustomersController(
            ICLRelatedCustomersRepository relaredCustRepository,
            ICorp2RelatedCustomerValidator corp2RelatedCustomerValidator,
            ICorp2RelatedCustomersRepository corp2RelatedCustomers
            ,IDbLogger logger)
        {
            _clrelaredCustRepository = relaredCustRepository;
            _corp2RelatedCustomerValidator = corp2RelatedCustomerValidator;
            _corp2RelatedCustomers = corp2RelatedCustomers;
            _logger = logger;
        }

        [HttpGet]
        [GET("api/cdo/corp2/RelatedCustomers/")]
        public HttpResponseMessage GetUsers([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal custId)
        {
            try
            {
                BarsSql sql = SqlCreator.SerchAllRelatedCustomers(custId);
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<RelatedCustomer>(sql).ToList();

                foreach (var item in data)
                {
                    decimal userId;
                    if (item.UserId != null && decimal.TryParse(item.UserId, out userId))
                    {
                        try
                        {
                            item.LockoutEnabled = _corp2RelatedCustomers.Corp2Services.UserManager.IsBlocked(userId);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
                        }
                    }
                }
                //decimal dataCount = _corp2RelatedCustomers.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        //[HttpPut]
        //[PUT("api/cdo/corp2/blockUser/{userId}")]
        //public HttpResponseMessage BlockUser(decimal userId)
        //{
        //    try
        //    {
        //        _corp2RelatedCustomers.Corp2Services.UserManager.BlockUser(_corp2RelatedCustomers.Corp2Services.GetSecretKey(), userId);
        //        //_logger.Info("Блокування користувача UserId: " + userId);
        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, corp2ExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
        //    }
        //}
        //[HttpPut]
        //[PUT("api/cdo/corp2/unblockUser/{userId}")]
        //public HttpResponseMessage UnblockUser(decimal userId)
        //{
        //    try
        //    {
        //        _corp2RelatedCustomers.Corp2Services.UserManager.UnBlockUser(_corp2RelatedCustomers.Corp2Services.GetSecretKey(), userId);
        //        //_logger.Info("Розблокування користувача UserId: " + userId);
        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, corp2ExMessage + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
        //    }
        //}
        [HttpGet]
        [GET("api/cdo/corp2/getcustaccs")]
        public HttpResponseMessage GetCorp2CustomerAccounts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? custId)
        {
            try
            {
                BarsSql sql = SqlCreator.SelectCorp2CustomerAccounts(custId);
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<Corp2CustomerAccount>(sql).ToList();
                //decimal dataCount = _corp2RelatedCustomers.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpPut]
        [PUT("api/cdo/corp2/unloadAccsToCorp2/")]
        public HttpResponseMessage UnloadCustomerAccountsToCorp2(decimal[] accIdList)
        {
            try
            {
                _corp2RelatedCustomers.UnloadCustomerAccountsToCorp2(accIdList);
                //_logger.Info("Відмічені рахунки вигружено до Corp2");
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, "Виникла помилка під час вигрузки рахунків до Корп2" + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        #region User Details Window
        [HttpGet]
        [GET("api/cdo/corp2/getbytaxcode/{custId}/{taxCode}/{docSeries}/{docNumber}")]
        public HttpResponseMessage GetByTaxCodeCorp2(decimal custId, string taxCode, string docSeries, string docNumber)
        {
            try
            {
                //Шукаємо користувача в базі ABS Corp2
                BarsSql sql = SqlCreator.GetByTaxCodeFrom_REL_CUSTOMERS(taxCode);
                var users = _corp2RelatedCustomers.ExecuteStoreQuery<RelatedCustomer>(sql).ToList();
                //Шукаємо користувача прикріпленного до даного клієнта
                RelatedCustomer data = users.FirstOrDefault(i => i.CustId == custId);
                if (data != null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest,
                        string.Format("Користувач з ІПН: {0} вже існує у клієнта id: {1}", taxCode, custId));
                }

                data = users.FirstOrDefault(i => i.CustId != custId);
                if (data != null)
                {
                    //data.Sdo = "Corp2";
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }

                //Якщо не знаходимо, то шукаємо в ABS CorpLight
                data = _clrelaredCustRepository.GetByTaxCode(taxCode);
                if (data != null)
                {
                    data.Id = null;
                    data.UserId = null;
                    //data.Sdo = "CorpLight";
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }

                //Якщо не знаходемо в ABS, то шукаємо в базі Корп2
                User userCorp2 = _corp2RelatedCustomers.GetExistUser(new RelatedCustomer { TaxCode = taxCode, DocSeries = docSeries, DocNumber = docNumber });
                
                if (userCorp2 != null)
                {
                    data = Mapper.MapUserToRelatedCustomer(userCorp2);
                    data.UserId = null;
                    //data.Sdo = "Corp2";
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }

                //Якщо не знаходимо ані в ABS, ані в Корп2, то шукаємо в базі КорпЛайт
                BankingUser userCorpLight = null;
                try
                {
                    var clUsers = _clrelaredCustRepository.GetExistUsers();
                    if (clUsers != null) userCorpLight = clUsers.Where(bu => bu.TaxCode == taxCode).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    var erNumber = _logger.Exception(ex);
                    return Request.CreateResponse(HttpStatusCode.OK, 
                        new { error = string.Format("{0}<br> Запис в sec_audit №{1} від {2}", corpLightExMessage, erNumber, DateTime.Now ) });
                    //throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                }
                if (userCorpLight != null)
                {
                    decimal acskRegId;
                    data = new RelatedCustomer
                    {
                        UserId = null,
                        Email = userCorpLight.Email,
                        CellPhone = userCorpLight.PhoneNumber,
                        FirstName = userCorpLight.FirstName,
                        LastName = userCorpLight.LastName,
                        SecondName = userCorpLight.Patronymic,
                        FullNameGenitiveCase = userCorpLight.DisplayName,
                        LockoutEnabled = userCorpLight.LockoutEnabled,
                        AcskRegistrationId = decimal.TryParse(userCorpLight.AcskRegistrationId, out acskRegId) ? new Nullable<decimal>(acskRegId) : null,
                        //AcskAuthorityKey = userCorpLight.AcskAuthorityKey,
                        TaxCode = userCorpLight.TaxCode
                        //Sdo = "CorpLight"
                    };
                }
                return data == null ? Request.CreateResponse(HttpStatusCode.OK) : Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpPost]
        [POST("api/cdo/corp2/RelatedCustomers/create/")]
        public HttpResponseMessage CreateUser(RelatedCustomer relatedCustomer)
        {
            try
            {
                if (_corp2RelatedCustomerValidator.IsExistByParameters(
                    relatedCustomer.TaxCode, /*relatedCustomer.CellPhone, */relatedCustomer.Email))
                {
                    return Request.CreateResponse(
                        HttpStatusCode.BadRequest,
                        "Користувач з вказаними параметрами вже існує");
                }
                _corp2RelatedCustomers.Add(relatedCustomer);
                //_logger.Info(string.Format(
                //    "Створено нового користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, Email:{3}",
                //    relatedCustomer.Id, relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpPut]
        [PUT("api/cdo/corp2/RelatedCustomers/updateAndMap/")]
        public HttpResponseMessage UpdateAndMap(RelatedCustomer relatedCustomer)
        {
            try
            {
                _corp2RelatedCustomers.UpdateAndMap(relatedCustomer);

                //_logger.Info(string.Format(
                //"Користувач Id:{0} TaxCode:{1}, PhoneNumber:{2}, Email:{3} оновлений та прикріплений до нового клієнта Id:{4}",
                //relatedCustomer.Id, relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email, relatedCustomer.CustId));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpPut]
        [PUT("api/cdo/corp2/RelatedCustomers/update/")]
        public HttpResponseMessage UpdateUser(RelatedCustomer relatedCustomer)
        {
            try
            {
                _corp2RelatedCustomers.UpdateRelatedCustomer(relatedCustomer);
                //_logger.Info(string.Format(
                //"Відредаговано дані користувача Id:{0} TaxCode:{1}, PhoneNumber:{2}, Email:{3}",
                //relatedCustomer.Id, relatedCustomer.TaxCode, relatedCustomer.CellPhone, relatedCustomer.Email));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        #endregion

        #region Customer Account Visa Setting
        [HttpPost]
        [POST("api/cdo/corp2/savecustomeraccount/")]
        public HttpResponseMessage UpdateCustomerAccount(Corp2CustomerAccount acc)
        {
            try
            {
                _corp2RelatedCustomers.UpdateCustomerAccount(acc);
                //_logger.Info(string.Format(
                //    "Рахунок оновлено - BANK_ACC: {0}, KF: {1}",
                //    acc.BANK_ACC, acc.KF));

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getaccvisacounts")]
        public HttpResponseMessage GetCustomerAccountVisaCounts(/*[ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, */decimal? accId)
        {
            try
            {
                BarsSql sql = SqlCreator.SelectCustomerAccountVisaCounts((int)accId.Value);
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<CustAccVisaCount>(sql).ToList();
                //decimal dataCount = _corp2RelatedCustomers.CountGlobal(request, sql);
                if (null == data)
                {
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpPost]
        [POST("api/cdo/corp2/addvisa/")]
        public HttpResponseMessage AddAccountVisa(CustAccVisaCount visa)
        {
            try
            {
                if (_corp2RelatedCustomerValidator.IsExistAccountVisa(visa))
                {
                    return Request.CreateResponse(
                        HttpStatusCode.BadRequest,
                        "Рахунок з вказаними рівнем візи вже існує");
                }
                _corp2RelatedCustomers.AddAccountVisa(visa);
                //_logger.Info(string.Format(
                //    "Створено новий рівень візи для рахунка: {0}, рівень візи - {1}, кількість віз рівня - {2}",
                //    visa.ACC_ID, visa.VISA_ID, visa.COUNT));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpPost]
        [POST("api/cdo/corp2/editvisa/")]
        public HttpResponseMessage EditAccountVisa(CustAccVisaCount visa)
        {
            try
            {
                _corp2RelatedCustomers.EditAccountVisa(visa);
                //_logger.Info(string.Format(
                //    "Відредаговано рівень візи для рахунка: {0}, рівень візи - {1}, кількість віз рівня - {2}",
                //    visa.ACC_ID, visa.VISA_ID, visa.COUNT));

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        [HttpPost]
        [POST("api/cdo/corp2/deletevisa/")]
        public HttpResponseMessage DeleteAccountVisa(CustAccVisaCount visa)
        {
            try
            {
                _corp2RelatedCustomers.DeleteAccountVisa(visa);
                //_logger.Info(string.Format(
                //    "Видалено рівень візи для рахунка: {0}, рівень візи - {1}, кількість віз рівня - {2}",
                //    visa.ACC_ID, visa.VISA_ID, visa.COUNT));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        #endregion

        #region Corp2 User Connection Params Setting
        [HttpPost]
        [POST("api/cdo/corp2/saveuserconnparams")]
        public HttpResponseMessage SaveUserConnParams(UserConnParamModel model)
        {
            try
            {
                _corp2RelatedCustomers.SaveUserWithConnectionSettings(model);
                //_logger.Info("Збережено налаштування користувача по модулям");
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getusermodules")]
        public HttpResponseMessage GetUserModules(decimal? userId)
        {
            BarsSql sql = SqlCreator.SelectUserModules(userId);
            try
            {
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<ModuleViewModel>(sql).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getavailablemodules")]
        public HttpResponseMessage GetAvailableModules(/*[ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, */decimal? userId)
        {
            BarsSql sql = SqlCreator.SelectAvailableModules(userId);
            try
            {
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<ModuleViewModel>(sql).ToList();
                //decimal dataCount = _corp2RelatedCustomers.CountGlobal(request, sql);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getuserfuncs/{userId}")]
        public HttpResponseMessage GetUserFuncs(decimal? userId)
        {
            BarsSql sql = SqlCreator.SelectUserFuncs(userId);
            try
            {
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<FunctionViewModel>(sql).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getavailablefuncs/{userId}")]
        public HttpResponseMessage GetAvailableFuncs(decimal? userId)
        {
            BarsSql sql = SqlCreator.SelectAvailableFuncs(userId);
            try
            {
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<FunctionViewModel>(sql).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getuserlimit/{userId}")]
        public HttpResponseMessage GetUserLimit(int userId)
        {
            BarsSql sql = SqlCreator.SelectUserLimits(userId);
            try
            {
                var data = _corp2RelatedCustomers.ExecuteStoreQuery<LimitViewModel>(sql).ToList().FirstOrDefault();
                if(data == null)
                {
                    data = new LimitViewModel() { USER_ID = userId, LIMIT_ID = "UNLIMITED" };
                }
                else if (string.IsNullOrEmpty(data.LIMIT_ID))
                {
                    data.LIMIT_ID = "UNLIMITED";
                }
                if (data.DOC_SUM == null || data.DOC_SENT_COUNT == null || data.DOC_CREATED_COUNT == null)
                {
                    var limitDictionary = ReadLimitDictionary();
                    var limit = limitDictionary["UNLIMITED"];
                    if(limit != null)
                    {
                        data.DOC_SUM = data.DOC_SUM ?? limit.DOC_SUM;
                        data.DOC_SENT_COUNT = data.DOC_SENT_COUNT ?? limit.DOC_SENT_COUNT;
                        data.DOC_CREATED_COUNT = data.DOC_CREATED_COUNT ?? limit.DOC_CREATED_COUNT;
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        private Dictionary<string, LimitDictionaryItem> ReadLimitDictionary()
        {
            BarsSql sql = SqlCreator.SelectLimitDictionaryItems();
            var limitDictionary = new Dictionary<string, LimitDictionaryItem>();
            var data = _corp2RelatedCustomers.ExecuteStoreQuery<LimitDictionaryItem>(sql).ToList();
            foreach (var item in data)
            {
                limitDictionary.Add(item.LIMIT_ID, item);
            }
            return limitDictionary;
        }
        [HttpGet]
        [GET("api/cdo/corp2/getlimitdictionary")]
        public HttpResponseMessage GetLimitDictionary()
        {
            try
            {
                var limitDictionary = ReadLimitDictionary();
                return Request.CreateResponse(HttpStatusCode.OK, limitDictionary);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        [HttpGet]
        [GET("api/cdo/corp2/getcorp2useraccspermissions")]
        public HttpResponseMessage GetCorp2UserAccsPermissions([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? custId, decimal? userId)
        {
            try
            {
                //BarsSql sql = Infrastructure.Repository.SqlCreator.SelectCorp2UserAccsPermissions(custId, userId);
                var data = _corp2RelatedCustomers.SelectCorp2UserAccsPermissions(custId, userId);
                //decimal dataCount = _corp2RelatedCustomers.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                //return Request.CreateResponse(HttpStatusCode.OK, new { Data = relatedCustomers, Total = relatedCustomers.Count });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        #endregion        

        #region Підтверджеення користувачів беком - clmode=visa
        /// <summary>
        /// Visa relate customer to the user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpPut]
        [PUT("api/cdo/corp2/RelatedCustomers/visa/{id}/{custId}")]
        public HttpResponseMessage VisaCorp2(decimal id, decimal custId)
        {
            try
            {
                if (!_corp2RelatedCustomerValidator.CustomerIsMapped(id, custId))
                {
                    return Request.CreateResponse(
                        HttpStatusCode.BadRequest,
                        "Користувач Корп2 не прикріплений до клієнта");
                }
                BarsSql sql = SqlCreator.SearchUserByIdAndCustomerId(id, custId);
                var relCust = _corp2RelatedCustomers.ExecuteStoreQuery<RelatedCustomer>(sql).FirstOrDefault();
                if (relCust == null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, "Користувача з ID=" + id + " не знайдено!");
                }
                User existUser = null;
                if (relCust.ApprovedType == "add")
                {
                    existUser = _corp2RelatedCustomers.GetExistUser(relCust);
                }

                _corp2RelatedCustomers.VisaSaveUserWithConnectionSettingsToCorp2(relCust);

                if (existUser != null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK,
                        new
                        {
                            Status = "ERROR",
                            Message = "Користувач з вказаними даними вже існує в системі ПІБ: " + existUser.FullNameGenitiveCase +
                                        " телефон: " + existUser.PhoneNumber + " email: " + existUser.Email,
                            Data = existUser
                        });
                }

                //_logger.Info(string.Format(
                //    "Бек офісом підтверджено картку клієнта Id:{0}, RNK:{1}", id, custId));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        [HttpDelete]
        [DELETE("api/cdo/corp2/RelatedCustomers/deleteRequest/{relCustId}/{customerId}")]
        public HttpResponseMessage RequestCertificateCorp2(decimal relCustId, decimal customerId)
        {
            try
            {
                _corp2RelatedCustomers.SetRelatedCustomerApproved(relCustId, customerId, false, "rejected");

                //_logger.Info(string.Format(
                //    "Відхилено запит на підтвердження змін по користувачу Id:{0}", relCustId));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        #endregion
    }
}
