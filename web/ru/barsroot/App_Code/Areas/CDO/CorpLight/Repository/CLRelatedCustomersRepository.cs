using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using CorpLight.Users;
using CorpLight.Users.Models;
using CorpLight.Users.Models.Enums;
using Models;
using System.Text.RegularExpressions;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.CorpLight.Services;
using System.Web;
using barsroot.core;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CDO.CorpLight.Repository
{
    public class CLRelatedCustomersRepository : ICLRelatedCustomersRepository
    {
        #region baseSql
        private string baseSql = @"select 
                                  rc.id as Id,       
                                  rc.tax_code as TaxCode,       
                                  rc.first_name as FirstName,   
                                  rc.last_name as LastName,
                                  rc.second_name as SecondName,
                                  rc.doc_type as DocType,        
                                  rc.doc_series as DocSeries,
                                  rc.doc_number as DocNumber,
                                  rc.doc_organization as DocOrganization,
                                  rc.doc_date as DocDate,
                                  rc.doc_date_to as DocDateTo,
                                  rc.birth_date as BirthDate,
                                  rc.cell_phone as CellPhone,
                                  rc.email as Email,
                                  rc.address as Address,
                                  rc.no_inn as NoInn,
                                  rc.acsk_actual as AcskActual,
                                  um.cust_id as CustId,  
                                  um.sign_number as SignNumber,
                                  um.user_id as UserId,
                                  um.is_approved as IsApprovedDecimal,
                                  um.approved_type as ApprovedType,
                                  ca.region_id as addressRegionId,
                                  reg.name as addressRegionName,
                                  ca.city as addressCity,
                                  ca.street as addressStreet,
                                  ca.house_number as addressHouseNumber,
                                  ca.addition as addressAddition,
                                  ar.registration_id as AcskRegistrationId,
                                  ar.registration_date as AcskRegistrationDate,
                                  ar.acsk_user_id as AcskUserId,
                                  (case when 
                                    ((select count(0) 
                                    from mbm_rel_cust_visa_stamps vs 
                                    where VS.REL_CUST_ID = rc.id) >= 
                                    (select parameter_value
                                    from mbm_parameters
                                    where parameter_name = 'Acsk.VisaCount')) then 1
                                    else 0
                                   end) as HasAllSignesDecimal                                   
                              from
                                  MBM_REL_CUSTOMERS rc
                            left join mbm_rel_customers_address ca on(
                                rc.id = ca.rel_cust_id
                            )  
                            left join mbm_acsk_regions reg on(
                                reg.id = ca.region_id
                            )   
                            left join mbm_acsk_registration ar on(
                                rc.id = ar.rel_cust_id
                            )                          
                            left join mbm_cust_rel_users_map um on (
                                  rc.id = um.rel_cust_id {0}) ";
        #endregion
        readonly EntitiesBars _entities;
        private readonly IUsersManage<string, string> _usersManage;
        private readonly IBanksRepository _bankRepository;
        private readonly IProfileSignRepository _profileSignRepository;
        private readonly IParametersRepository _parametersRepository;
        private readonly ICLCustomersRepository _customersRepository;
        private List<Parameter> parameters;
        private readonly string corpLightExMessage = "Виникла помилка під час запросу до сервісу CorpLight. Зверніться до адміністратора.";

        public CLRelatedCustomersRepository(
            ICDOModel model,
            ICorpLightUserManageService corpLightUserManageService,
            IBanksRepository bankRepository,
            IProfileSignRepository profileSignRepository,
            IParametersRepository parametersRepository,
            ICLCustomersRepository custRepository)
        {
            _entities = model.CorpLightEntities;
            _usersManage = corpLightUserManageService.GetCorpLightUserManage();
            _bankRepository = bankRepository;
            _profileSignRepository = profileSignRepository;
            _parametersRepository = parametersRepository;
            _customersRepository = custRepository;

            parameters = _parametersRepository.GetAll().ToList();

            SslValidation();
        }
        private void SslValidation()
        {
            // ReSharper disable once UnusedAnonymousMethodSignature
            ServicePointManager.ServerCertificateValidationCallback = delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
        }
        //HACK: Moved to Common
        //public IEnumerable<RelatedCustomer> GetCustomerRelatedCustomers(decimal custId)
        //{
        //    var sql = @"select 
        //                    cr.rnk as CustId,
        //                    cr.relext_id as relid,
        //                    cr.relcust_rnk as rnk,
        //                    cr.okpo as taxcode,
        //                    cr.doc_number as DocNumber,
        //                    cr.doc_serial as DocSeries,
        //                    REGEXP_SUBSTR (cr.name, '[^[:space:]]+', 1) LastName,
        //                    REGEXP_SUBSTR (cr.name, '[^[:space:]]+', 1, 2) FirstName,
        //                    REGEXP_SUBSTR (cr.name, '[^[:space:]]+', 1, 3) SecondName,
        //                    cr.doc_date as DocDate,
        //                    to_char(cr.Doc_Type) as DocType,
        //                    cr.doc_issuer as DocOrganization,
        //                    cr.sex,
        //                    cr.birthday as BirthDate,
        //                    cr.tel as CellPhone,
        //                    cr.email as email,
        //                    cr.adr as Address
        //                from 
        //                    v_cust_relations cr
        //                where
        //                    CR.CUSTTYPE = 2
        //                    and cr.rnk = :p_rnk";
        //    var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, custId);
        //    return result;
        //}

        public IEnumerable<RelatedCustomer> GetAll(decimal custId)
        {
            var sql = string.Format(baseSql, "") + " where um.cust_id = :p_cust_id";
            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, custId).ToList();
            if (result.Count > 0)
            {
                List<BankingUser> clUsers = null;
                try
                {
                    clUsers = _usersManage.GetCustomerUsers(((long)custId).ToString());
                }
                catch (Exception ex)
                {
                    throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                }
                foreach (var item in result.Where(i => i.UserId != null))
                {
                    BankingUser clUser = null;
                    if (clUsers != null)
                        clUser = clUsers.FirstOrDefault(i => i.Id == item.UserId);
                    if (clUser != null)
                    {
                        //item.CellPhone = clUser.PhoneNumber;
                        item.LockoutEnabled = clUser.Customers[0].IsDisable;
                    }
                }
            }

            return result;
        }

        public RelatedCustomer GetById(decimal id)
        {
            var sql = string.Format(baseSql, " and um.cust_id = :p_cust_id") + @" where rc.id = :p_id";

            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, null, id).FirstOrDefault();
            return result;
        }

        public RelatedCustomer GetById(decimal id, decimal? custId)
        {
            var sql = string.Format(baseSql, " and um.cust_id = :p_cust_id") + @" where rc.id = :p_id";

            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, custId, id).FirstOrDefault();
            return result;
        }

        public RelatedCustomer GetByTaxCode(string taxCode)
        {
            var sql = string.Format(baseSql, " and um.cust_id = :p_cust_id") + @" where rc.tax_code = :p_tax_code";

            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, null, taxCode).FirstOrDefault();
            return result;
        }

        private void AddRelatedCustomerAddress(decimal relCustId, RelatedCustomerAddress address)
        {
            string sql = string.Empty;
            var countUserAddress = _entities.ExecuteStoreQuery<decimal>(
                "select count(0) from mbm_rel_customers_address where rel_cust_id = :p_rel_cust_id",
                relCustId).FirstOrDefault();
            if (countUserAddress == 0)
            {
                sql = @"insert into mbm_rel_customers_address
                            (region_id, city, street, house_number, addition, rel_cust_id)
                        values
                            (:region_id, :city, :street, :house_number, :addition, :rel_cust_id)";
            }
            else
            {
                sql = @"update mbm_rel_customers_address set
                            region_id = :region_id, 
                            city = :city, 
                            street = :street, 
                            house_number = :house_number, 
                            addition = :addition
                        where
                            rel_cust_id = :rel_cust_id";

            }
            _entities.ExecuteStoreCommand(
                    sql,
                    address.RegionId,
                    address.City,
                    address.Street,
                    address.HouseNumber,
                    address.Addition,
                    relCustId);
        }

        public void Add(RelatedCustomer relatedCustomer)
        {
            var id = _entities.ExecuteStoreQuery<decimal>(
                "select MBM_REL_CUST_SEQ.nextval from dual").FirstOrDefault();

            var sql = @"Insert into MBM_REL_CUSTOMERS
                            (ID, 
                            TAX_CODE, 
                            FIRST_NAME, 
                            LAST_NAME, 
                            SECOND_NAME,
                            DOC_TYPE, 
                            DOC_SERIES, 
                            DOC_NUMBER, 
                            DOC_ORGANIZATION, 
                            DOC_DATE,
                            DOC_DATE_TO,
                            BIRTH_DATE, 
                            CELL_PHONE, 
                            EMAIL, 
                            NO_INN)
                        Values
                            (:p_id,  
                            :p_TAX_CODE, 
                            :p_FIRST_NAME, 
                            :p_LAST_NAME, 
                            :p_SECOND_NAME,
                            :p_DOC_TYPE, 
                            :p_DOC_SERIES, 
                            :p_DOC_NUMBER, 
                            :p_DOC_ORGANIZATION, 
                            :p_DOC_DATE,
                            :p_DOC_DATE_TO,
                            :p_BIRTH_DATE, 
                            :p_CELL_PHONE, 
                            :p_EMAIL,
                            :p_NO_INN)";

            var parameters = new object[]
            {
                id,
                relatedCustomer.TaxCode,
                relatedCustomer.FirstName,
                relatedCustomer.LastName,
                relatedCustomer.SecondName,
                relatedCustomer.DocType,
                relatedCustomer.DocSeries,
                relatedCustomer.DocNumber,
                relatedCustomer.DocOrganization,
                relatedCustomer.DocDate,
                relatedCustomer.DocDateTo,
                relatedCustomer.BirthDate,
                relatedCustomer.CellPhone,
                relatedCustomer.Email,
                relatedCustomer.NoInn
            };

            _entities.ExecuteStoreCommand(sql, parameters);
            if (relatedCustomer.CustId != null && relatedCustomer.SignNumber != null)
            {
                MapRelatedCustomerToUser(null, relatedCustomer.CustId.Value, id, relatedCustomer.SignNumber.Value);
            }

            var address = new RelatedCustomerAddress
            {
                RegionId = relatedCustomer.AddressRegionId,
                City = relatedCustomer.AddressCity,
                Street = relatedCustomer.AddressStreet,
                HouseNumber = relatedCustomer.AddressHouseNumber,
                Addition = relatedCustomer.AddressAddition
            };

            AddRelatedCustomerAddress(id, address);
        }

        public void Delete(decimal id)
        {
            var sql = @"delete from MBM_REL_CUSTOMERS where id = :p_id";
            _entities.ExecuteStoreCommand(sql, id);
        }

        public void Update(RelatedCustomer relatedCustomer)
        {
            if (relatedCustomer.Id == null)
            {
                throw new Exception("Parameter ID cannot be null");
            }
            if (relatedCustomer.CustId == null)
            {
                throw new Exception("Parameter RelatedCustomerId cannot be null");
            }
            var relCustInBase = GetById(relatedCustomer.Id.Value, relatedCustomer.CustId);
            if (relCustInBase == null)
            {
                throw new Exception("Related customer is not faund");
            }

            var sql = @"update MBM_REL_CUSTOMERS set
                            TAX_CODE = :p_TAX_CODE, 
                            FIRST_NAME = :p_FIRST_NAME, 
                            LAST_NAME = :p_LAST_NAME, 
                            SECOND_NAME = :p_SECOND_NAME,
                            DOC_TYPE = :p_DOC_TYPE, 
                            DOC_SERIES = :p_DOC_SERIES, 
                            DOC_NUMBER = :p_DOC_NUMBER, 
                            DOC_ORGANIZATION = :p_DOC_ORGANIZATION, 
                            DOC_DATE = :p_DOC_DATE,
                            DOC_DATE_TO = :p_DOC_DATE_TO,
                            BIRTH_DATE = :p_BIRTH_DATE, 
                            CELL_PHONE = :p_CELL_PHONE, 
                            EMAIL = :p_EMAIL,
                            NO_INN = :p_NO_INN,
                            ACSK_ACTUAL = 0
                        where 
                            id = :p_id";

            var parameters = new object[]
            {
                relatedCustomer.TaxCode,
                relatedCustomer.FirstName,
                relatedCustomer.LastName,
                relatedCustomer.SecondName,
                relatedCustomer.DocType,
                relatedCustomer.DocSeries,
                relatedCustomer.DocNumber,
                relatedCustomer.DocOrganization,
                relatedCustomer.DocDate,
                relatedCustomer.DocDateTo,
                relatedCustomer.BirthDate,
                relatedCustomer.CellPhone,
                relatedCustomer.Email,
                relatedCustomer.NoInn,
                relatedCustomer.Id
            };
            _entities.ExecuteStoreCommand(sql, parameters);

            _profileSignRepository.DeleteAll(relatedCustomer.Id.Value);

            var address = new RelatedCustomerAddress
            {
                RegionId = relatedCustomer.AddressRegionId,
                City = relatedCustomer.AddressCity,
                Street = relatedCustomer.AddressStreet,
                HouseNumber = relatedCustomer.AddressHouseNumber,
                Addition = relatedCustomer.AddressAddition
            };

            AddRelatedCustomerAddress(relatedCustomer.Id.Value, address);

            UpdateSignNumber(relatedCustomer.Id.Value, relatedCustomer.CustId.Value, relatedCustomer.SignNumber ?? 0);
            SetRelatedCustomerApproved(
                relatedCustomer.Id.Value,
                relatedCustomer.CustId.Value,
                false,
                relCustInBase.UserId == null ? "add" : "update");
        }

        public void SetAcskActual(decimal relCustId, decimal value)
        {
            var sql = @"update MBM_REL_CUSTOMERS set
                            ACSK_ACTUAL = :p_ACSK_ACTUAL
                        where 
                            id = :p_id";
            _entities.ExecuteStoreCommand(sql, value, relCustId);
        }

        public void UpdateSignNumber(decimal relatedCustId, decimal custId, decimal signNumber)
        {
            var sql = @"update mbm_cust_rel_users_map set  
                            sign_number = :p_sign_number,
                            is_approved = 0
                        where
                            rel_cust_id = :p_id
                            and cust_id = :p_cust_id";
            _entities.ExecuteStoreCommand(sql, signNumber, relatedCustId, custId);
        }

        public void UpdateUserIdInRelatedCustomer(decimal relatedCustId, decimal custId, string userId)
        {
            var sql = @"update mbm_cust_rel_users_map set  
                            user_id = :p_user_id
                        where
                            rel_cust_id = :p_id
                            and cust_id = :p_cust_id";
            _entities.ExecuteStoreCommand(sql, userId, relatedCustId, custId);
        }
        public void MapRelatedCustomerToUser(
            string userId, decimal custId, decimal relatedCustId, decimal signNumber)
        {
            var sql = @"insert into 
                            mbm_cust_rel_users_map(cust_id, rel_cust_id, sign_number, user_id, is_approved, approved_type)
                        values
                            (:cust_id, :rel_cust_id, :rel_cust_id, :user_id, :is_approved, :approved_type)";
            _entities.ExecuteStoreCommand(sql, custId, relatedCustId, signNumber, userId, 0, "add");
        }

        public void RemoveRelatedCustomer(
            decimal relCustId, decimal custId)
        {
            var sql = @"delete from
                            mbm_cust_rel_users_map
                        where 
                            cust_id = :cust_id
                            and rel_cust_id = :rel_cust_id";
            _entities.ExecuteStoreCommand(sql, custId, relCustId);
        }
        public void RemoveRelatedCustomerFromUser(
            string userId, decimal custId)
        {
            var sql = @"delete from
                            mbm_cust_rel_users_map
                        where 
                            cust_id = :cust_id
                            and user_id = :user_id";
            _entities.ExecuteStoreCommand(sql, custId, userId);
        }

        public BankingUser GetExistUser(RelatedCustomer relCust)
        {
            try
            {
                var users = _usersManage
                    .GetAllUsers(relCust.CellPhone, relCust.Email);

                if (users != null)
                    return users.FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
            }
            return null;
        }
        public List<BankingUser> GetExistUsers()
        {
            try
            {
                var users = _usersManage
                    .GetAllUsers();

                return users;
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
            }
        }
        public IEnumerable<decimal> GetAllIdNotVisa()
        {
            var sql = @"select 
                            distinct cust_id 
                        from 
                            mbm_cust_rel_users_map
                        where 
                            is_approved = 0 or is_approved is null";
            var result = _entities.ExecuteStoreQuery<decimal>(sql).ToList();
            return result;
        }
        public void VisaMapedRelatedCustomerToUser(decimal id, decimal custId)
        {
            var relCust = GetAll(custId).FirstOrDefault(i => i.Id == id);

            var customer = _customersRepository.Get(custId);

            if (relCust != null && relCust.Id != null && relCust.CustId != null && customer != null)
            {
                var acskAuthorityKeyParam = parameters.FirstOrDefault(i => i.Name == "Acsk.AuthorityKey");
                var acskAuthorityKey = acskAuthorityKeyParam == null ? "" : acskAuthorityKeyParam.Value;
                var clUser = new BankingUser
                {
                    Id = null,
                    Customers = new List<UserCustomers>
                    {
                        new UserCustomers
                        {
                             EDRPO = customer.CL_OKPO,
                            IsDisable = false,
                            LoginProviders = new List<LoginProvider>
                            {
                                new LoginProvider
                                {
                                    IsDisable = false,
                                    Type = LoginProviderType.MobilePhone,
                                    Value = relCust.CellPhone
                                }
                            },
                            Roles = new List<RoleType>
                            {
                                relCust.SignNumber == 1 ? RoleType.Director : RoleType.Accountant
                            }
                        }
                    },
                    DisplayName = relCust.LastName + " " + relCust.FirstName + " " + relCust.SecondName,
                    Email = relCust.Email,
                    FirstName = relCust.FirstName,
                    LastName = relCust.LastName,
                    Patronymic = relCust.SecondName,
                    LockoutEnabled = false,
                    Name = relCust.Email,
                    PhoneNumber = relCust.CellPhone,
                    TaxCode = relCust.TaxCode,
                    AcskRegistrationId = relCust.AcskRegistrationId == null
                                ? null : Convert.ToInt32(relCust.AcskRegistrationId).ToString("X8"),
                    AcskAuthorityKey = relCust.AcskRegistrationId == null ? null : acskAuthorityKey
                };
                BankingUser bankingUser;
                if (relCust.ApprovedType == "add")
                {
                    var existUser = GetExistUser(relCust);

                    if (existUser != null)
                    {
                        throw new Exception("Користувач з вказаними даними вже існує в системі ПІБ: " +
                                            existUser.DisplayName +
                                            " телефон: " + existUser.PhoneNumber + " email: " + existUser.Email);
                    }
                    try
                    {
                        bankingUser = _usersManage.AddUser(clUser, ((long)custId).ToString());
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                    }
                    if (bankingUser != null)
                    {
                        UpdateUserIdInRelatedCustomer(relCust.Id.Value, relCust.CustId.Value, bankingUser.Id);
                        SetRelatedCustomerApproved(id, relCust.CustId.Value, true, null);
                    }
                }
                else if (relCust.ApprovedType == "update" || (relCust.IsApproved))
                {
                    clUser.Id = relCust.UserId;
                    try
                    {
                        bankingUser = _usersManage.UpdateUser(clUser, ((long)custId).ToString());
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                    }
                    if (bankingUser != null)
                    {
                        SetRelatedCustomerApproved(id, relCust.CustId.Value, true, null);
                    }
                }
                else if (relCust.ApprovedType == "delete")
                {
                    if (relCust.UserId != null)
                    {
                        try
                        {
                            _usersManage.DeleteUserCustomer(relCust.UserId, ((long)custId).ToString());
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
                        }
                    }
                    RemoveRelatedCustomer(id, custId);
                }
            }
        }

        //public void VisaMapedRelatedCustomerToUser(decimal id, decimal custId)
        //{
        //    var relCust = GetAll(custId).FirstOrDefault(i=> i.Id == id);

        //    if (relCust != null && relCust.Id != null && relCust.CustId != null)
        //    {
        //        var acskAuthorityKeyParam = parameters.FirstOrDefault(i=>i.Name == "Acsk.AuthorityKey");
        //        var acskAuthorityKey = acskAuthorityKeyParam == null ? "" : acskAuthorityKeyParam.Value;
        //        var clUser = new BankingUser
        //        {
        //            Id = null,
        //            Customers = new List<UserCustomers>
        //            {
        //                new UserCustomers
        //                {
        //                    BankId = _bankRepository.GetOurMfo(),
        //                    CustomerId = relCust.CustId.ToString(),
        //                    IsDisable = false,
        //                    LoginProviders = new List<LoginProvider>
        //                    {
        //                        new LoginProvider
        //                        {
        //                            IsDisable = false,
        //                            Type = LoginProviderType.MobilePhone,
        //                            Value = relCust.CellPhone
        //                        }
        //                    },
        //                    Roles = new List<RoleType>
        //                    {
        //                        relCust.SignNumber == 1 ? RoleType.Director : RoleType.Accountant
        //                    }
        //                }
        //            },
        //            DisplayName = relCust.LastName + " " + relCust.FirstName + " " + relCust.SecondName,
        //            Email = relCust.Email,
        //            FirstName = relCust.FirstName,
        //            LastName = relCust.LastName,
        //            Patronymic = relCust.SecondName,
        //            LockoutEnabled = false,
        //            Name = relCust.Email,
        //            PhoneNumber = relCust.CellPhone,
        //            TaxCode = relCust.TaxCode,
        //            AcskRegistrationId = relCust.AcskRegistrationId == null 
        //                        ? null : Convert.ToInt32(relCust.AcskRegistrationId).ToString("X8"),
        //            AcskAuthorityKey = relCust.AcskRegistrationId == null ? null : acskAuthorityKey
        //        };
        //        BankingUser bankingUser;
        //        if (relCust.ApprovedType == "add")
        //        {
        //            var existUser = GetExistUser(relCust);

        //            if (existUser != null)
        //            {
        //                throw new Exception("Користувач з вказаними даними вже існує в системі ПІБ: " +
        //                                    existUser.DisplayName +
        //                                    " телефон: " + existUser.PhoneNumber + " email: " + existUser.Email);
        //            }

        //            bankingUser = _usersManage.AddUser(clUser);
        //            if (bankingUser != null)
        //            {
        //                UpdateUserIdInRelatedCustomer(relCust.Id.Value, relCust.CustId.Value, bankingUser.Id);
        //                SetRelatedCustomerApproved(id, relCust.CustId.Value, true, null);
        //            }
        //        }
        //        else if (relCust.ApprovedType == "update" || (relCust.IsApproved))
        //        {
        //            clUser.Id = relCust.UserId;
        //            bankingUser = _usersManage.UpdateUser(clUser);
        //            if (bankingUser != null)
        //            {
        //                SetRelatedCustomerApproved(id, relCust.CustId.Value, true, null);
        //            }
        //        }
        //        else if (relCust.ApprovedType == "delete")
        //        {
        //            if (relCust.UserId != null)
        //            {
        //                var bankCode = _bankRepository.GetOurMfo();
        //                _usersManage.DeleteUserCustomer(relCust.UserId, custId, bankCode);
        //            }
        //            RemoveRelatedCustomer(id, custId);
        //        }
        //    }
        //}

        public void VisaMapedRelatedCustomerToExistUser(decimal id, long custId, string userId)
        {
            var relCust = GetAll(custId).FirstOrDefault(i => i.Id == id);
            var customer = _customersRepository.Get(custId);
            if (relCust == null)
            {
                throw new Exception("User not found");
            }
            if (customer == null)
            {
                throw new Exception("Customer not found");
            }

            BankingUser bankingUser = null;
            try
            {
                bankingUser = _usersManage.AddCustomerToUser(userId, custId.ToString(), customer.CL_OKPO, relCust.SignNumber);
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
            }
            if (bankingUser != null)
            {
                UpdateUserIdInRelatedCustomer(id, custId, userId);
                SetRelatedCustomerApproved(id, custId, true, null);
            }
        }

        public void SetRelatedCustomerApproved(decimal relCustId, decimal custId, bool approved, string approvedType)
        {
            var sql = @"update mbm_cust_rel_users_map set  
                            is_approved = :p_is_approved,
                            approved_type = :p_approved_type
                        where
                            rel_cust_id = :p_id
                            and cust_id = :p_cust_id";
            _entities.ExecuteStoreCommand(sql, approved ? 1 : 0, approvedType, relCustId, custId);
        }
        //HACK: Moved to Common
        //public RelatedCustomer GetFOPData(decimal id)
        //{
        //    // TODO implement
        //    var sql = string.Format(@"SELECT 
        //                    -1 AS Id,
        //                    CUS.OKPO AS TaxCode, 
        //                    TRIM(F_NAME.VALUE) AS FirstName,
        //                    TRIM(L_NAME.VALUE) AS LastName,
        //                    TRIM(M_NAME.VALUE) AS SecondName,
        //                    PER.BDAY AS BirthDate,  
        //                    TO_CHAR(PER.PASSP) AS DocType,
        //                    PER.PDATE AS DocDate,
        //                    PER.SER AS DocSeries, 
        //                    PER.NUMDOC AS DocNumber, 
        //                    PER.ORGAN AS DocOrganization,
        //                    TRIM(TOWN.VALUE) AS AddressCity,
        //                    TRIM(STREET.VALUE) AS AddressStreet

        //                FROM CUSTOMER CUS 
        //                    LEFT JOIN PERSON PER ON PER.RNK = CUS.RNK AND PER.PASSP = 1
        //                    LEFT JOIN V_CUSTOMERW F_NAME ON F_NAME.RNK = CUS.RNK AND F_NAME.TAG = 'SN_FN' 
        //                    LEFT JOIN V_CUSTOMERW L_NAME ON L_NAME.RNK = CUS.RNK AND L_NAME.TAG = 'SN_LN' 
        //                    LEFT JOIN V_CUSTOMERW M_NAME ON M_NAME.RNK = CUS.RNK AND M_NAME.TAG = 'SN_MN'
        //                    LEFT JOIN V_CUSTOMERW TOWN ON TOWN.RNK = CUS.RNK AND TOWN.TAG = 'FGTWN'
        //                    LEFT JOIN V_CUSTOMERW STREET ON STREET.RNK = CUS.RNK AND STREET.TAG = 'FGADR'
        //                WHERE CUS.RNK = {0}
        //                    AND CUS.CUSTTYPE = 3", id);

        //    var query = _entities.ExecuteStoreQuery<RelatedCustomer>(sql);

        //    var result = query.FirstOrDefault();
        //    if (result != null)
        //    {
        //        // TODO manipulations with new adressing system

        //        if (!string.IsNullOrEmpty(result.AddressStreet))
        //        {
        //            var match = Regex.Match(result.AddressStreet, @"(\s|[.,_])*(\d+)(\s|[.,_]|\p{L})*$");
        //            if (match.Success)
        //            {
        //                int index = match.Groups[1].Index;
        //                result.AddressHouseNumber = result.AddressStreet.Substring(index);
        //                result.AddressStreet = result.AddressStreet.Substring(0, match.Index);
        //            }
        //        }

        //    }

        //    return result;
        //}
        public bool IsExistByEmail(string email)
        {
            var sql = @"select 
                            count(*) 
                        from 
                            MBM_REL_CUSTOMERS
                        where 
                            email = :p_email";
            var result = _entities.ExecuteStoreQuery<decimal>(sql, email).FirstOrDefault();
            try
            {
                var users = _usersManage.GetAllUsers();
                BankingUser clUser = null;
                if(users != null)
                    clUser = users.FirstOrDefault(x => x.Email == email);
                return result > 0 || clUser != null ? true : false;
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
            }
        }
        public bool IsExistByPhone(string phone)
        {
            var sql = @"select 
                            count(*) 
                        from 
                            MBM_REL_CUSTOMERS
                        where 
                            CELL_PHONE = :phone";
            var result = _entities.ExecuteStoreQuery<decimal>(sql, phone).FirstOrDefault();
            try
            {
                BankingUser clUser = null;
                var users = _usersManage.GetAllUsers();
                if(users != null)
                    clUser = users.FirstOrDefault(x => x.PhoneNumber == phone);
                return result > 0 || clUser != null ? true : false;
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
            }
        }

        public List<Customers> GetClients(String dateFrom, String dateTo, string banks, string logName, HttpContext context)
        {
            try
            {
                IFormatProvider culture = new System.Globalization.CultureInfo("uk-UA", true);
                DateTime df = DateTime.Parse(dateFrom, culture, System.Globalization.DateTimeStyles.AssumeLocal);
                DateTime dt = DateTime.Parse(dateTo, culture, System.Globalization.DateTimeStyles.AssumeLocal);
            }
            catch
            {
                throw new Exception("Невалідна дата. Потрібний формат dd/MM/yyyy");
            }
            try
            {
                var clients = _usersManage.GetClients(dateFrom, dateTo, banks);
                return clients;
            }
            catch (Exception ex)
            {
                throw new Exception(corpLightExMessage + Environment.NewLine + ex.Message);
            }
        }

        public void LoginUser(String userName, HttpContext context)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                var sql = @"begin
                                bars.bars_login.login_user(:p_session_id, :p_user_id, :p_hostname, :p_appname);
                            end;";
                _entities.ExecuteStoreCommand(sql, context.Session.SessionID, userMap.user_id, GetHostName(), "barsroot");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            // Если выполнили установку параметров
            context.Session["UserLoggedIn"] = true;
        }

        private string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        public void SendSms(string phone, string message)
        {

            var sql = new Kernel.Models.BarsSql
            {
                SqlText = @"begin 
                                BARS.p_clt_sendsms(:p_phone, :p_msg_text); 
                            end;",
                SqlParams = new object[] {
                     new OracleParameter("p_phone", OracleDbType.Varchar2) { Value = phone },
                     new OracleParameter("p_msg_text", OracleDbType.Varchar2) { Value = message }
                 }
            };
            int res = _entities.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
        }
    }

    /// <summary>
    /// Contains logic for accessing and operationg with related customers
    /// </summary>
    public interface ICLRelatedCustomersRepository
    {
        //HACK: Moved to Common
        /// <summary>
        /// Get related customers (shorted)
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        //IEnumerable<RelatedCustomer> GetCustomerRelatedCustomers(decimal custId);

        /// <summary>
        /// Get related customers with all fields
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        IEnumerable<RelatedCustomer> GetAll(decimal custId);
        /// <summary>
        /// Get existed users with similar creditals
        /// </summary>
        /// <param name="relCust"></param>
        /// <returns></returns>
        BankingUser GetExistUser(RelatedCustomer relCust);
        List<BankingUser> GetExistUsers();
        /// <summary>
        /// Get all not visa customers id`s
        /// </summary>
        /// <returns></returns>
        IEnumerable<decimal> GetAllIdNotVisa();
        /// <summary>
        /// Get
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        RelatedCustomer GetById(decimal id);
        /// <summary>
        /// Get
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        RelatedCustomer GetById(decimal id, decimal? custId);
        RelatedCustomer GetByTaxCode(string taxCode);
        //HACK: Moved to Common
        /// <summary>
        /// Get main data from main customer requisites for creating new related user (available only for FOP)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //RelatedCustomer GetFOPData(decimal id);
        /// <summary>
        /// Add related customer
        /// </summary>
        /// <param name="relatedCustomer"></param>
        void Add(RelatedCustomer relatedCustomer);
        /// <summary>
        /// Delete related custoomer
        /// </summary>
        /// <param name="id"></param>
        void Delete(decimal id);
        /// <summary>
        /// Updtae related customer
        /// </summary>
        /// <param name="type"></param>
        void Update(RelatedCustomer type);

        /// <summary>
        /// Map related customer to user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="custId"></param>
        /// <param name="relatedCustId"></param>
        /// <param name="signNumber"></param>
        void MapRelatedCustomerToUser(string userId, decimal custId, decimal relatedCustId, decimal signNumber);

        /// <summary>
        /// Remove related customer 
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="custId"></param>
        void RemoveRelatedCustomer(decimal relCustId, decimal custId);
        /// <summary>
        /// Remove related customer from user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="custId"></param>
        void RemoveRelatedCustomerFromUser(string userId, decimal custId);
        /// <summary>
        /// Visa mapped related customer
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        void VisaMapedRelatedCustomerToUser(decimal id, decimal custId);
        /// <summary>
        /// Visa mapped related customer to exist user
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <param name="userId"></param>
        void VisaMapedRelatedCustomerToExistUser(decimal id, long custId, string userId);
        /// <summary>
        /// Set related customer approoved
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="custId"></param>
        /// <param name="approved"></param>
        /// <param name="approvedType"></param>
        void SetRelatedCustomerApproved(decimal relCustId, decimal custId, bool approved, string approvedType);

        /// <summary>
        /// Set state of asck profile request (1- send, 0 - no send/no actual)
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="val"></param>
        void SetAcskActual(decimal relCustId, decimal val);
        void SendSms(String phone, String message);
        bool IsExistByEmail(string email);
        bool IsExistByPhone(string phone);
        void LoginUser(String userName, HttpContext context);
        List<Customers> GetClients(String dateFrom, String dateTo, string banks, string logName, HttpContext context);
    }
}