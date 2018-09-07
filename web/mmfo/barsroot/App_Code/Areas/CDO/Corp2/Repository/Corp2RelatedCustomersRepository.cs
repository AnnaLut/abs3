using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Data.Objects;
using System.Linq;
using Oracle.DataAccess.Client;
using Models;
using Kendo.Mvc.UI;
using System;
using System.Text;
using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Corp2.Models;
using BarsWeb.Areas.CDO.Corp2.Services;
using System.Data;

namespace BarsWeb.Areas.CDO.Corp2.Repository
{
    public class Corp2RelatedCustomersRepository : ICorp2RelatedCustomersRepository
    {
        readonly EntitiesBars _entities;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        private readonly IParametersRepository _parametersRepository;
        readonly ICorp2ProfileSignRepository _corp2ProfileSignRepository;
        private readonly IBanksRepository _bankRepository;
        private readonly ICorp2Services _corp2Services;
        private readonly string corp2ExMessage = "Виникла помилка під час запросу до сервісу Corp2. Зверніться до адміністратора.";

        public ICorp2Services Corp2Services { get { return _corp2Services; } }
        private List<Parameter> parameters;

        public Corp2RelatedCustomersRepository(
            ICorp2Services corp2Services,
            IKendoSqlTransformer sqlTransformer,
            IKendoSqlCounter kendoSqlCounter,
            IParamsRepository globalData,
            ICDOModel model,
            ICorp2ProfileSignRepository corp2ProfileSignRepository,
            IBanksRepository bankRepository,
            IParametersRepository parametersRepository
            )
        {
            //_entities = new Corp2Model(EntitiesConnection.ConnectionString("Corp2Model", "Corp2"));
            _entities = model.CorpLightEntities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
            _corp2ProfileSignRepository = corp2ProfileSignRepository;
            _bankRepository = bankRepository;
            _corp2Services = corp2Services;
            _parametersRepository = parametersRepository;
            parameters = _parametersRepository.GetAll().ToList();
        }

        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _entities.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _entities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _entities.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }
        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _entities.ExecuteStoreCommand(commandText, parameters);
        }
        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        public IEnumerable<RelatedCustomer> GetByTaxCodeFrom_REL_CUSTOMERS(string taxCode)
        {
            BarsSql sql = SqlCreator.GetByTaxCodeFrom_REL_CUSTOMERS(taxCode);
            return ExecuteStoreQuery<RelatedCustomer>(sql);
        }
        private void Update(RelatedCustomer relatedCustomer)
        {
            BarsSql sql = SqlCreator.UpdateRelatedCustomer(relatedCustomer);
            _entities.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

            var address = new RelatedCustomerAddress
            {
                RegionId = relatedCustomer.AddressRegionId,
                City = relatedCustomer.AddressCity,
                Street = relatedCustomer.AddressStreet,
                HouseNumber = relatedCustomer.AddressHouseNumber,
                Addition = relatedCustomer.AddressAddition
            };

            AddRelatedCustomerAddress(relatedCustomer.Id.Value, address);

            _corp2ProfileSignRepository.DeleteAll(relatedCustomer.Id.Value);
        }
        public void UpdateRelatedCustomer(RelatedCustomer relatedCustomer)
        {
            UnloadCustomerToCorp2(relatedCustomer.CustId.Value);
            Update(relatedCustomer);

            //if (relatedCustomer.SignNumber.HasValue &&
            //    System.Text.RegularExpressions.Regex.IsMatch(relatedCustomer.SignNumber.ToString(), "^[^0-2]$"))
            if(!string.IsNullOrEmpty(relatedCustomer.UserId) && !(relatedCustomer.IsCanSign.HasValue && relatedCustomer.IsCanSign.Value))
            {
                try
                {
                    Corp2Services.UserManager.AddOrUpdateUser(Corp2Services.GetSecretKey(), Mapper.MapRelatedCustomerToUser(relatedCustomer), GetOurMfo(), true);
                }
                catch (Exception ex)
                {

                    throw new Exception("Оновлення на стороні ABS збережно успішно." + corp2ExMessage + Environment.NewLine + ex.Message);
                }
                SetRelatedCustomerApproved(relatedCustomer.Id.Value, relatedCustomer.CustId.Value, true, null);
            }
            else
            {
                SetRelatedCustomerApproved(relatedCustomer.Id.Value, relatedCustomer.CustId.Value, false, relatedCustomer.UserId == null ? "add" : "update");
            }
        }
        /// <summary>
        /// Update and map user in ABS Corp2 and Corp2.
        /// This method's called when we create user for client, but this user already exists in another client
        /// </summary>
        /// <param name="relatedCustomer"></param>
        public void UpdateAndMap(RelatedCustomer relatedCustomer)
        {
            UnloadCustomerToCorp2(relatedCustomer.CustId.Value);
            Update(relatedCustomer);

            MapRelatedCustomerToUser(relatedCustomer.UserId, relatedCustomer.CustId.Value, relatedCustomer.Id.Value, 0);
            try
            {
                if (relatedCustomer.UserId != null)
                {
                    //var isBlock = !(relatedCustomer.IsCanSign.HasValue && relatedCustomer.IsCanSign.Value);
                    Corp2Services.UserManager.AddOrUpdateUser(Corp2Services.GetSecretKey(), Mapper.MapRelatedCustomerToUser(relatedCustomer), GetOurMfo(), true/*isBlock*/);
                }
            }
            catch (Exception ex)
            {

                throw new Exception("Оновлення на стороні ABS збережно успішно." + corp2ExMessage + Environment.NewLine + ex.Message);
            }
        }
        public void UpdateSignNumber(decimal relatedCustId, decimal custId, decimal signNumber)
        {
            var sql = @"update corp2_cust_rel_users_map set  
                            sign_number = :p_sign_number,
                            is_approved = 0
                        where
                            rel_cust_id = :p_id
                            and cust_id = :p_cust_id";
            _entities.ExecuteStoreCommand(sql, signNumber, relatedCustId, custId);
        }
        public void SetRelatedCustomerApproved(decimal relCustId, decimal custId, bool approved, string approvedType)
        {
            var sql = @"update corp2_cust_rel_users_map set  
                            is_approved = :p_is_approved,
                            approved_type = :p_approved_type
                        where
                            rel_cust_id = :p_id
                            and cust_id = :p_cust_id";
            _entities.ExecuteStoreCommand(sql, approved ? 1 : 0, approvedType, relCustId, custId);
        }
        private void AddRelatedCustomerAddress(decimal relCustId, RelatedCustomerAddress address)
        {
            string sql = string.Empty;
            var countUserAddress = _entities.ExecuteStoreQuery<decimal>(
                "select count(0) from CORP2_REL_CUSTOMERS_ADDRESS where rel_cust_id = :p_rel_cust_id",
                relCustId).FirstOrDefault();
            if (countUserAddress == 0)
            {
                sql = @"insert into CORP2_REL_CUSTOMERS_ADDRESS
                            (region_id, city, street, house_number, addition, rel_cust_id)
                        values
                            (:region_id, :city, :street, :house_number, :addition, :rel_cust_id)";
            }
            else
            {
                sql = @"update CORP2_REL_CUSTOMERS_ADDRESS set
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
        private void UnloadCustomerToCorp2(decimal custId)
        {
            _entities.ExecuteStoreCommand("begin barsaq.data_import.add_client(p_kf => :p_kf, p_rnk => :p_rnk); end;", GetOurMfo(), custId); //HACK: GetOurMfo
        }
        public decimal Add(RelatedCustomer relatedCustomer/*, decimal? custId, string custMFO*/)
        {
            UnloadCustomerToCorp2(relatedCustomer.CustId.Value);

            var id = _entities.ExecuteStoreQuery<decimal>(
                "select CORP2_REL_CUST_SEQ.nextval from dual").FirstOrDefault();

            string acskKeySn = relatedCustomer.AcskSertificateSn;
            if (string.IsNullOrEmpty(acskKeySn) && relatedCustomer.AcskRegistrationId.HasValue && relatedCustomer.AcskRegistrationId != 0)
            {
                try
                {
                    acskKeySn = ((int)relatedCustomer.AcskRegistrationId.Value).ToString("X8");
                }
                finally
                {
                }
            }
            #region insert into CORP2_REL_CUSTOMERS
            var sql = @"Insert into CORP2_REL_CUSTOMERS
                            (ID, 
                            LOGIN,
                            TAX_CODE, 
                            FIRST_NAME, 
                            LAST_NAME, 
                            SECOND_NAME,
                            DOC_TYPE, 
                            DOC_SERIES, 
                            DOC_NUMBER, 
                            DOC_ORGANIZATION, 
                            DOC_DATE, 
                            BIRTH_DATE,
                            CELL_PHONE,
                            EMAIL,
                            FIO_CARD,
                            key_id)
                        Values
                            (:p_id,
                            :p_login,
                            :p_TAX_CODE, 
                            :p_FIRST_NAME, 
                            :p_LAST_NAME, 
                            :p_SECOND_NAME,
                            :p_DOC_TYPE, 
                            :p_DOC_SERIES, 
                            :p_DOC_NUMBER, 
                            :p_DOC_ORGANIZATION, 
                            :p_DOC_DATE, 
                            :p_BIRTH_DATE,
                            :p_CELL_PHONE, 
                            :p_EMAIL,
                            :p_FIO_CARD,
                            :p_key_id)";

            var parameters = new object[]
            {
                id,
                relatedCustomer.Login,
                relatedCustomer.TaxCode,
                relatedCustomer.FirstName,
                relatedCustomer.LastName,
                relatedCustomer.SecondName,
                relatedCustomer.DocType,
                relatedCustomer.DocSeries,
                relatedCustomer.DocNumber,
                relatedCustomer.DocOrganization,
                relatedCustomer.DocDate,
                relatedCustomer.BirthDate,
                relatedCustomer.CellPhone,
                relatedCustomer.Email,
                relatedCustomer.FullNameGenitiveCase,
                acskKeySn
            };

            _entities.ExecuteStoreCommand(sql, parameters);
            #endregion
            MapRelatedCustomerToUser(relatedCustomer.UserId, relatedCustomer.CustId.Value, id, 0/*relatedCustomer.SignNumber.Value*/);

            var address = new RelatedCustomerAddress
            {
                RegionId = relatedCustomer.AddressRegionId,
                City = relatedCustomer.AddressCity,
                Street = relatedCustomer.AddressStreet,
                HouseNumber = relatedCustomer.AddressHouseNumber,
                Addition = relatedCustomer.AddressAddition
            };

            AddRelatedCustomerAddress(id, address);
            AddRelatedCustomerDefaultModulesAndFuncs(id);
            return id;
        }

        private void AddRelatedCustomerDefaultModulesAndFuncs(decimal id)
        {
            var defaultModulesIds = new string[] { "ACC", "CST", "DOC" };

            SaveModules(id, defaultModulesIds);

            //BarsSql sqlAllFuncs = SqlCreator.SelectFuncs();
            //var defaultFuncs = ExecuteStoreQuery<FunctionViewModel>(sqlAllFuncs)
            //    .Where(f => defaultModulesIds.Contains(f.ModuleId))
            //    .Select(f=>f.Id).Distinct().ToArray();
            //SaveFuncs(id, defaultFuncs);
        }

        public void MapRelatedCustomerToUser(
            string userId, decimal custId, decimal relatedCustId, decimal signNumber)
        {
            var sql = @"insert into 
                            corp2_cust_rel_users_map(cust_id, rel_cust_id, sign_number, user_id, is_approved, approved_type)
                        values
                            (:cust_id, :rel_cust_id, :rel_cust_id, :user_id, :is_approved, :approved_type)";
            _entities.ExecuteStoreCommand(sql, custId, relatedCustId, signNumber, userId, 0, "add");
        }
        public void UnloadCustomerAccountsToCorp2(decimal[] accIdList)
        {
            for (int i = 0; i < accIdList.Length; i++)
            {
                decimal p_acc = accIdList[i];

                _entities.ExecuteStoreCommand("begin barsaq.data_import.add_account_new(:p_acc); end;", p_acc);
            }
        }
        public void VisaSaveUserWithConnectionSettingsToCorp2(RelatedCustomer rc)
        {
            if (rc.ApprovedType != "delete")
            {
                var corp2UserIdLogin = SaveUserWithConnectionSettingsToCorp2(rc, true);
                if (rc.ApprovedType == "add")
                {
                    UpdateUserIdAndLoginInRelatedCustomer(rc.Id.Value, rc.CustId.Value, corp2UserIdLogin.Item1.ToString(), corp2UserIdLogin.Item2);
                    //var bankId =  GetOurMfo();
                    //_entities.ExecuteStoreCommand("begin barsaq.data_import.add_client(p_kf => :p_kf, p_rnk => :p_rnk); end;", bankId, rc.CustId.Value); //HACK: GetOurMfo
                }
                SetRelatedCustomerApproved(rc.Id.Value, rc.CustId.Value, true, null);
            }
            else
            {
                //Якщо видалення, то також зберігаємо в Корп2. Блокуємо користувача в Корп2 та відкріплюємо від клієнта в АБС
                SaveUserWithConnectionSettingsToCorp2(rc, true);
                DetachUserFromCustomer(rc.Id.Value, rc.CustId.Value);
            }
        }

        public void UpdateUserIdAndLoginInRelatedCustomer(decimal relatedCustId, decimal custId, string userId, string login)
        {
            var sql = @"BEGIN
                        update corp2_cust_rel_users_map set  
                            user_id = :p_user_id
                        where
                            rel_cust_id = :p_id
                            and cust_id = :p_cust_id;
                        UPDATE CORP2_REL_CUSTOMERS SET 
                            Login = :p_login
                            WHERE Id = :p_id;
                        END;";
            _entities.ExecuteStoreCommand(sql, userId, relatedCustId, custId, login);
        }
        private void DetachUserFromCustomer(
            decimal relCustId, decimal custId)
        {
            var sql = @"delete from
                            corp2_cust_rel_users_map
                        where 
                            cust_id = :cust_id
                            and rel_cust_id = :rel_cust_id";
            _entities.ExecuteStoreCommand(sql, custId, relCustId);
        }
        public User GetExistUser(RelatedCustomer relCust)
        {
            try
            {
                var user = Corp2Services.UserManager.GetUserByTaxCode(relCust.TaxCode, relCust.DocSeries, relCust.DocNumber);
                return user;
            }
            catch (Exception ex)
            {
                throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
            }
        }
        public void SetAcskActual(decimal relCustId, decimal value)
        {
            var sql = @"update CORP2_REL_CUSTOMERS set
                            ACSK_ACTUAL = :p_ACSK_ACTUAL
                        where 
                            id = :p_id";
            _entities.ExecuteStoreCommand(sql, value, relCustId);
        }
        public void UpdateRelatedCustomerKey(decimal relCustId, string newKeyId)
        {
            var sql = @"update CORP2_REL_CUSTOMERS set
                            KEY_ID = :p_KEY_ID
                        where 
                            id = :p_id";
            _entities.ExecuteStoreCommand(sql, newKeyId, relCustId);
        }
        //public void UpdateCustomerAccount(Corp2CustomerAccount acc)
        //{
        //    try
        //    {
        //        Corp2Services.CustomerManager.UpdateVisaQty(Corp2Services.GetSecretKey(), acc.CORP2_ACC.Value, acc.VISA_COUNT.Value);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
        //    }

        //    var sql = @"update BARSAQ.IBANK_ACC set
        //                    VISA_COUNT = :p_visa_count
        //                where 
        //                    ACC = :p_BANK_ACC and KF = :p_kf";
        //    _entities.ExecuteStoreCommand(sql, acc.VISA_COUNT, acc.BANK_ACC, acc.KF);
        //}
        //public void EditAccountVisa(CustAccVisaCount visa)
        //{
        //    try
        //    {
        //        Corp2Services.CustomerManager.UpdateVisaQtyCount(Corp2Services.GetSecretKey(), visa.CORP2_ACC_ID, visa.VISA_ID, visa.Old_VISA_ID, visa.COUNT.Value);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
        //    }

        //    var sql = @"update CORP2_ACC_VISA_COUNT set
        //                VISA_ID = :p_visa_id,
        //                COUNT = :p_count
        //            where 
        //                ACC_ID = :p_acc_id
        //                and VISA_ID = :p_old_visa_id";
        //    _entities.ExecuteStoreCommand(sql, visa.VISA_ID, visa.COUNT, visa.ACC_ID, visa.Old_VISA_ID);
        //}
        //public void AddAccountVisa(CustAccVisaCount visa)
        //{
        //    try
        //    {
        //        Corp2Services.CustomerManager.AddVisaQtyCount(Corp2Services.GetSecretKey(), visa.CORP2_ACC_ID, visa.VISA_ID, visa.COUNT.Value);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
        //    }

        //    var sql = @"insert into CORP2_ACC_VISA_COUNT 
        //                    (ACC_ID, VISA_ID, COUNT) values
        //                    (:p_acc_id, :p_visa_id, :p_count)";
        //    _entities.ExecuteStoreCommand(sql, visa.ACC_ID, visa.VISA_ID, visa.COUNT);
        //}
        //public void DeleteAccountVisa(CustAccVisaCount visa)
        //{
        //    try
        //    {
        //        Corp2Services.CustomerManager.DeleteVisaQtyCount(Corp2Services.GetSecretKey(), visa.CORP2_ACC_ID, visa.VISA_ID);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
        //    }

        //    var sql = @"delete CORP2_ACC_VISA_COUNT
        //            where 
        //                ACC_ID = :p_acc_id
        //                and VISA_ID = :p_visa_id";
        //    _entities.ExecuteStoreCommand(sql, visa.ACC_ID, visa.VISA_ID);
        //}
        public void SaveUserWithConnectionSettings(UserConnParamModel model)
        {
            var user = model.User;
            var userId = user.Id;

            try
            {
                SaveUserWithConnectionSettingsToABS(model);
            }
            catch (Exception ex)
            {
                throw new Exception("Виникла помилка при збереженні налаштувань по користувачу в ABS. Налаштування не збережено в Корп2" + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace);
            }


            //if (user.SignNumber == 1 || user.SignNumber == 2)
            if(user.IsCanSign.HasValue && user.IsCanSign.Value)
            {
                SetRelatedCustomerApproved(userId.Value, user.CustId.Value, false, user.UserId == null ? "add" : "update");
            }
            else
            {
                Tuple<decimal, string> uIdLogin;
                try
                {
                    uIdLogin = SaveUserWithConnectionSettingsToCorp2(model);
                }
                catch (Exception ex)
                {
                    throw new Exception("Налаштування успішно збережно в ABS." + Environment.NewLine + ex.Message);
                }
                if (!user.IsApproved)
                {
                    UpdateUserIdAndLoginInRelatedCustomer(userId.Value, user.CustId.Value, uIdLogin.Item1.ToString(), uIdLogin.Item2);
                }
                SetRelatedCustomerApproved(userId.Value, user.CustId.Value, true, null);
            }
        }
        private void SaveModules (decimal userId, string[] modulesIds)
        {
            if(modulesIds.Length > 0)
            {
                var sqlModules = new StringBuilder("BEGIN ");
                var parameters = new Queue<object>();
                parameters.Enqueue(userId);
                for (int i = 0; i < modulesIds.Length; i++)
                {
                    sqlModules.AppendFormat("INSERT INTO CORP2_USER_MODULES (USER_ID, MODULE_ID) VALUES (:p_userId, :p_moduleId{0});", i);
                    parameters.Enqueue(modulesIds[i]);
                }
                sqlModules.Append("END;");
                _entities.ExecuteStoreCommand(sqlModules.ToString(), parameters.ToArray());
            }
        }
        //private void SaveFuncs(decimal userId, decimal[] funcsIds)
        //{
        //    if (funcsIds.Length > 0)
        //    {
        //        var sqlFuncs = new StringBuilder("BEGIN ");
        //        var parameters = new Queue<object>();
        //        parameters.Enqueue(userId);
        //        for (int i = 0; i < funcsIds.Length; i++)
        //        {
        //            sqlFuncs.AppendFormat("INSERT INTO CORP2_USER_FUNCTIONS (USER_ID, FUNC_ID) VALUES (:p_userId, :p_funcId{0});", i);
        //            parameters.Enqueue(funcsIds[i]);
        //        }
        //        sqlFuncs.Append("END;");
        //        _entities.ExecuteStoreCommand(sqlFuncs.ToString(), parameters.ToArray());
        //    }
        //}
        private void SaveUserWithConnectionSettingsToABS(UserConnParamModel model)
        {
            var user = model.User;
            var userId = user.Id.Value;

            var sqlDel = @"begin 
                           DELETE CORP2_USER_MODULES
                                WHERE USER_ID = :p_user_id;
                           DELETE CORP2_USER_FUNCTIONS
                                WHERE USER_ID = :p_user_id; 
                          end;";
            _entities.ExecuteStoreCommand(sqlDel, userId);
            //Save User Modules
            SaveModules(userId, model.UserModules.Select(m => m.Id).ToArray());
            //if (model.UserModules.Count > 0)
            //{
            //    var sqlModules = new StringBuilder("BEGIN ");
            //    var parameters = new Queue<object>();
            //    parameters.Enqueue(userId);
            //    int index = 0;
            //    foreach (var item in model.UserModules)
            //    {
            //        sqlModules.AppendFormat("INSERT INTO CORP2_USER_MODULES (USER_ID, MODULE_ID) VALUES (:p_userId, :p_moduleId{0});", index);
            //        parameters.Enqueue(item.Id);
            //        index++;
            //    }
            //    sqlModules.Append("END;");
            //    _entities.ExecuteStoreCommand(sqlModules.ToString(), parameters.ToArray());
            //}
            //Save User Funcs
            //BarsSql sqlAllFuncs = SqlCreator.SelectFuncs();
            //var modulesIds = model.UserModules.Select(m => m.Id);
            //model.UserFuncs = ExecuteStoreQuery<FunctionViewModel>(sqlAllFuncs).Where(f => modulesIds.Contains(f.ModuleId)).ToList();
            //SaveFuncs(userId, model.UserFuncs.Select(f => f.Id).Distinct().ToArray());
            //if (model.UserFuncs.Count > 0)
            //{
            //    var sqlFuncs = new StringBuilder("BEGIN ");
            //    var parameters = new Queue<object>();
            //    parameters.Enqueue(userId);
            //    int index = 0;
            //    foreach (var id in model.UserFuncs.Select(f => f.Id).Distinct())
            //    {
            //        sqlFuncs.AppendFormat("INSERT INTO CORP2_USER_FUNCTIONS (USER_ID, FUNC_ID) VALUES (:p_userId, :p_funcId{0});", index);
            //        parameters.Enqueue(id);
            //        index++;
            //    }
            //    sqlFuncs.Append("END;");
            //    _entities.ExecuteStoreCommand(sqlFuncs.ToString(), parameters.ToArray());
            //}
            //Save User
            var sqlUser = @"merge into corp2_cust_rel_users_map c
                            using (select * from dual) p on ( :custid = c.cust_id and :relcustid = c.rel_cust_id)                                
                            when matched then update
                                set SIGN_NUMBER = :SIGN_NUMBER,
                                    SEQUENTIAL_VISA = :SEQUENTIAL_VISA
                            when not matched then
                                insert ( cust_id , rel_cust_id, sign_number, sequential_visa)
                                values (:custid, :relcustid, :SIGN_NUMBER, :SEQUENTIAL_VISA)";
            _entities.ExecuteStoreCommand(sqlUser, user.CustId, userId, user.SignNumber, user.SequentialVisa);
            //Save Limit
            var sqlLimit = @"merge into CORP2_USER_LIMIT l
                            using (select * from dual) p on ( :userid = l.user_id)                                
                            when matched then update
                                set LIMIT_ID = :LIMIT_ID,
                                    DOC_SUM = :DOC_SUM,
                                    DOC_CREATED_COUNT = :DOC_CREATED_COUNT,
                                    DOC_SENT_COUNT = :DOC_SENT_COUNT,
                                    DOC_DATE_LIM = :DOC_DATE_LIM
                            when not matched then
                                insert (user_id, LIMIT_ID, DOC_SUM, DOC_CREATED_COUNT, DOC_SENT_COUNT, DOC_DATE_LIM)
                                values (:userid, :LIMIT_ID, :DOC_SUM, :DOC_CREATED_COUNT, :DOC_SENT_COUNT, :DOC_DATE_LIM)";
            _entities.ExecuteStoreCommand(sqlLimit, userId,
                model.UserLimit.LIMIT_ID,
                model.UserLimit.DOC_SUM,
                model.UserLimit.DOC_CREATED_COUNT,
                model.UserLimit.DOC_SENT_COUNT,
                model.UserLimit.DOC_DATE_LIM);
            //Save Accs
            if (model.UserAccs.Count > 0)
            {
                var sqlModules = new StringBuilder("DECLARE custId number := :p_custId; BEGIN ");
                var parameters = new Queue<object>();
                parameters.Enqueue(user.CustId);
                parameters.Enqueue(userId);
                int index = 0;
                foreach (var i in model.UserAccs)
                {
                    var item = Mapper.MapUserAccountPermissionViewModelToDBModel(i);
                    sqlModules.AppendFormat("MERGE INTO CORP2_ACC_USERS au USING (SELECT * FROM dual) d on (:p_userId = au.user_id AND :p_nls{0} = au.nls AND :p_kf{0} = au.kf AND :p_kv{0} = au.kv) ", index);
                    sqlModules.AppendFormat("WHEN MATCHED THEN UPDATE SET CAN_VIEW = :p_canView{0}, CAN_DEBIT = :p_canDebit{0}, CAN_VISA = :p_canVisa{0}, VISA_ID = :p_visaId{0}, SEQUENTIAL_VISA = :p_seqVisa{0}, ACTIVE = :p_active{0}, CUST_ID = :p_custId ", index);
                    sqlModules.AppendFormat("WHEN NOT MATCHED THEN INSERT (USER_ID, NLS, KF, KV, CAN_VIEW, CAN_DEBIT, CAN_VISA, VISA_ID, SEQUENTIAL_VISA, ACTIVE, CUST_ID) VALUES (:p_userId, :p_nls{0}, :p_kf{0}, :p_kv{0}, :p_canView{0}, :p_canDebit{0}, :p_canVisa{0}, :p_visaId{0}, :p_seqVisa{0}, :p_active{0}, :p_custId); ", index);
                    parameters.Enqueue(item.NUM_ACC);
                    parameters.Enqueue(item.KF);
                    parameters.Enqueue(item.KV);
                    parameters.Enqueue(item.CAN_VIEW);
                    parameters.Enqueue(item.CAN_DEBIT);
                    parameters.Enqueue(item.CAN_VISA);
                    parameters.Enqueue(item.VISA_ID);
                    parameters.Enqueue(item.SEQUENTIAL_VISA);
                    parameters.Enqueue(item.ACTIVE);
                    index++;
                }
                sqlModules.Append("END;");
                _entities.ExecuteStoreCommand(sqlModules.ToString(), parameters.ToArray());
            }
        }
        private Tuple<decimal, string> SaveUserWithConnectionSettingsToCorp2(UserConnParamModel model)
        {
            BarsSql sql = SqlCreator.SearchUserByIdAndCustomerId(model.User.Id.Value, model.User.CustId.Value);
            var relCust = ExecuteStoreQuery<RelatedCustomer>(sql).FirstOrDefault();
            if (relCust == null)
            {
                throw new Exception("Користувача з ID=" + model.User.Id.Value + " не знайдено!");
            }

            var user = Mapper.MapRelatedCustomerToUser(relCust);

            try
            {
                var userIdLogin = Corp2Services.UserManager.AddOrUpdateUserWithConnectionSettings(Corp2Services.GetSecretKey(), user, GetOurMfo(),
                    model.UserModules.Select(m => m.Id).ToArray(),
                    /*model.UserFuncs.Select(f => f.Id).Distinct().ToArray(),*/
                    Mapper.MapLimitVMToLimit(model.UserLimit),
                    model.UserAccs.Select(a => Mapper.MapUserAccountPermissionViewModelToAccount(a)).ToArray(), true);

                return Tuple.Create((decimal)userIdLogin[0], userIdLogin[1].ToString());
            }
            catch (Exception ex)
            {
                throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
            }
        }
        private Tuple<decimal, string> SaveUserWithConnectionSettingsToCorp2(RelatedCustomer rc, bool isBlock)
        {
            //BarsSql sql = Infrastructure.Repository.SqlCreator.SearchById(model.User.Id.Value, model.User.CustId.Value);
            //var relCust = ExecuteStoreQuery<RelatedCustomer>(sql).FirstOrDefault();
            //if (relCust == null)
            //{
            //    throw new Exception("Користувача з ID=" + model.User.Id.Value + " не знайдено!");
            //}
            var user = Mapper.MapRelatedCustomerToUser(rc);
            var userId = rc.Id.Value;

            BarsSql sqlLimit = SqlCreator.SelectUserLimits(userId);
            var limit = ExecuteStoreQuery<Limit>(sqlLimit).ToList().FirstOrDefault();

            BarsSql sqlModules = SqlCreator.SelectUserModules(userId);
            var modules = ExecuteStoreQuery<ModuleViewModel>(sqlModules).Select(m => m.Id).ToArray();

            //BarsSql sqlFuncs = SqlCreator.SelectUserFuncs(userId);
            //var funcs = ExecuteStoreQuery<FunctionViewModel>(sqlFuncs).Select(f => f.Id).Distinct().ToArray();

            var accs = SelectCorp2UserAccsPermissionsForSave(rc.CustId, userId);

            try
            {
                var userIdLogin = Corp2Services.UserManager.AddOrUpdateUserWithConnectionSettings(Corp2Services.GetSecretKey(), user, GetOurMfo(),
                    modules, /*funcs,*/ limit, accs, isBlock);
                return Tuple.Create((decimal)userIdLogin[0], userIdLogin[1].ToString());
            }
            catch (Exception ex)
            {
                throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
            }
        }
        public List<UserAccountPermissionViewModel> SelectCorp2UserAccsPermissions(decimal? custId, decimal? userId)
        {
            BarsSql sql = SqlCreator.SelectCorp2UserAccsPermissions(custId, userId);
            var data = ExecuteStoreQuery<UserAccountPermissionDBModel>(sql).ToList();
            var perms = new List<UserAccountPermissionViewModel>();
            foreach (var item in data)
            {
                if (item.USER_ID == null) item.USER_ID = userId;
                perms.Add(Mapper.MapUserAccountPermissionDBModelToViewModel(item));
            }
            return perms;
        }
        private Account[] SelectCorp2UserAccsPermissionsForSave(decimal? custId, decimal? userId)
        {
            BarsSql sql = new BarsSql
            {
                SqlText = @"SELECT a.CORP2_ACC as ACCID,
                                   au.CAN_VIEW as CANVIEW, 
                                   au.can_visa as CANVISA, 
                                   au.can_debit as CANDEBIT,
                                   au.visa_id as VISAID,
                                   au.sequential_visa as SEQUENTIALVISA,
                                   au.ACTIVE
                                       FROM CORP2_ACC_USERS au 
                                       JOIN v_corp2_accounts a ON (a.rnk = au.cust_id AND a.num_acc = au.nls AND a.RNK = :custId AND a.IS_CORP2_ACC = 1)
                                WHERE au.USER_ID = :userId",
                SqlParams = new object[]
                {
                    new OracleParameter("custId", OracleDbType.Int64){ Value = custId},
                    new OracleParameter("userId", OracleDbType.Int64){ Value = userId}
                }
            };
            var data = ExecuteStoreQuery<Account>(sql).ToArray();
            return data;
        }
        public int IsBlocked(decimal userId, decimal custId)
        {
            try
            {
                return Corp2Services.UserManager.IsBlocked(userId, (int)custId, GetOurMfo());
            }
            catch (Exception ex)
            {
                throw new Exception(corp2ExMessage + Environment.NewLine + ex.Message);
            }
        }
        private string GetOurMfo()
        {
            var mfo  = _bankRepository.GetOurMfo();
            if (String.IsNullOrEmpty(mfo)) throw new Exception("Не знайдений МФО. Можливо, необхідно обрати відділення.");
            return mfo;
        }
    }

    public interface ICorp2RelatedCustomersRepository
    {
        ICorp2Services Corp2Services { get; }
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        void UpdateRelatedCustomer(RelatedCustomer sql);
        void UpdateAndMap(RelatedCustomer user);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="relatedCustomer"></param>
        /// <param name="custId">is RNK</param>
        /// <param name="custMFO">is KF</param>
        decimal Add(RelatedCustomer relatedCustomer/*, decimal? custId, string custMFO*/);
        void MapRelatedCustomerToUser(string userId, decimal custId, decimal relatedCustId, decimal signNumber);
        void UnloadCustomerAccountsToCorp2(decimal[] accIdList);
        //void VisaMapedRelatedCustomerToUser(decimal id, decimal custId);
        void VisaSaveUserWithConnectionSettingsToCorp2(RelatedCustomer rc);
        //void VisaMapedRelatedCustomerToExistUser(decimal id, long custId, string userId);
        void SetAcskActual(decimal relCustId, decimal val);
        User GetExistUser(RelatedCustomer relCust);
        void UpdateRelatedCustomerKey(decimal relCustId, string newKeyId);
        //void SubscribeCustomer(decimal custId);
        //void UpdateCustomerAccount(Corp2CustomerAccount acc);
        //void AddAccountVisa(CustAccVisaCount visa);
        //void EditAccountVisa(CustAccVisaCount visa);
        //void DeleteAccountVisa(CustAccVisaCount visa);
        void SetRelatedCustomerApproved(decimal relCustId, decimal custId, bool approved, string approvedType);
        void SaveUserWithConnectionSettings(UserConnParamModel model);
        List<UserAccountPermissionViewModel> SelectCorp2UserAccsPermissions(decimal? custId, decimal? userId);
        int IsBlocked(decimal userId, decimal custId);
        IEnumerable<RelatedCustomer> GetByTaxCodeFrom_REL_CUSTOMERS(string taxCode);
    }

    public class SqlCreator
    {
        #region private static string baseSql
        private static string baseSql = @"select 
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
                                  rc.birth_date as BirthDate,
                                  rc.CREATED_DATE as CreateDate,
                                  rc.cell_phone as CellPhone,
                                  rc.email as Email,
                                  rc.address as Address,
                                  rc.no_inn as NoInn,
                                  rc.acsk_actual as AcskActual,
                                  rc.login as Login,
                                  rc.Activate_Date as ActivateDate,
                                  rc.key_id as AcskSertificateSn,
                                  rc.FIO_CARD as FullNameGenitiveCase,
                                  um.cust_id as CustId,  
                                  um.sign_number as SignNumber,
                                  um.user_id as UserId,
                                  um.is_approved as IsApprovedDecimal,
                                  um.approved_type as ApprovedType,
                                  um.sequential_visa as SequentialVisa,
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
                                    from corp2_user_visa_stamps vs 
                                    where VS.USER_ID = rc.id) >= 
                                    (select parameter_value
                                    from mbm_parameters
                                    where parameter_name = 'Acsk.VisaCount')) then 1
                                    else 0
                                   end) as HasAllSignesDecimal
                              from
                                  corp2_REL_CUSTOMERS rc
                            left join corp2_rel_customers_address ca on(
                                rc.id = ca.rel_cust_id
                            )  
                            left join mbm_acsk_regions reg on(
                                reg.id = ca.region_id
                            )   
                            left join corp2_acsk_registration ar on(
                                rc.id = ar.rel_cust_id
                            )                          
                            left join corp2_cust_rel_users_map um on (
                                  rc.id = um.rel_cust_id {0})";
        #endregion

        internal static BarsSql SerchAllRelatedCustomers(decimal custId)
        {
            return new BarsSql
            {
                SqlText = string.Format(baseSql, "") + " where um.cust_id = :id",
                SqlParams = new object[]
                {
                    new OracleParameter("id", OracleDbType.Int32) { Value = custId }
                }
            };
        }
        internal static BarsSql SearchUserByIdAndCustomerId(decimal id, decimal custId)
        {
            return new BarsSql
            {
                SqlText = string.Format(baseSql, " and um.cust_id = :custId") + " where rc.id = :id",
                SqlParams = new object[]
                {
                    new OracleParameter("custId", OracleDbType.Int64){Value=custId},
                    new OracleParameter("id", OracleDbType.Int64){Value=id}
                }
            };
        }
        internal static BarsSql SearchUserById(decimal id)
        {
            return new BarsSql
            {
                SqlText = string.Format(baseSql, "") + " where rc.id = :id",
                SqlParams = new object[]
                {
                    new OracleParameter("id", OracleDbType.Int64){Value=id}
                }
            };
        }
        internal static BarsSql GetByTaxCodeFrom_REL_CUSTOMERS(string taxCode)
        {
            return new BarsSql
            {
                SqlText = string.Format(baseSql, "") + " where rc.tax_code = :p_tax_code",
                SqlParams = new object[]
                {
                    new OracleParameter("p_tax_code", OracleDbType.NVarchar2){ Value=taxCode}
                }
            };
        }
        internal static BarsSql UpdateRelatedCustomer(RelatedCustomer relatedCustomer)
        {
            string acskKeySn = relatedCustomer.AcskSertificateSn;
            if (string.IsNullOrEmpty(acskKeySn) && relatedCustomer.AcskRegistrationId.HasValue && relatedCustomer.AcskRegistrationId != 0)
            {
                try
                {
                    acskKeySn = ((int)relatedCustomer.AcskRegistrationId.Value).ToString("X8");
                }
                finally
                {
                }
            }
            return new BarsSql
            {
                SqlText = @"update CORP2_REL_CUSTOMERS set
                            TAX_CODE = :p_TAX_CODE, 
                            FIRST_NAME = :p_FIRST_NAME, 
                            LAST_NAME = :p_LAST_NAME, 
                            SECOND_NAME = :p_SECOND_NAME,
                            DOC_TYPE = :p_DOC_TYPE, 
                            DOC_SERIES = :p_DOC_SERIES, 
                            DOC_NUMBER = :p_DOC_NUMBER, 
                            DOC_ORGANIZATION = :p_DOC_ORGANIZATION, 
                            DOC_DATE = :p_DOC_DATE, 
                            BIRTH_DATE = :p_BIRTH_DATE, 
                            CELL_PHONE = :p_CELL_PHONE, 
                            EMAIL = :p_EMAIL,                            
                            ACSK_ACTUAL = 0,
                            FIO_CARD = :p_FIO_CARD,
                            key_id = :p_key_id
                        where 
                            id = :p_id",//NO_INN = :p_NO_INN,
                SqlParams = new object[]
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
                    relatedCustomer.BirthDate,
                    relatedCustomer.CellPhone,
                    relatedCustomer.Email,
                    relatedCustomer.FullNameGenitiveCase,
                    acskKeySn,
                    relatedCustomer.Id
                }
            };
        }
        internal static BarsSql SelectCorp2CustomerAccounts(decimal? custId)
        {
            return new BarsSql
            {
                SqlText = @"SELECT * FROM V_CORP2_ACCOUNTS 
                                WHERE RNK = NVL(:custId, 0)",
                SqlParams = new object[]
                {
                    new OracleParameter("custId", OracleDbType.Int64){ Value = custId}
                }
            };
        }

        internal static BarsSql SelectCorp2UserAccsPermissions(decimal? custId, decimal? userId)
        {
            return new BarsSql
            {
                SqlText = @"SELECT au.ACTIVE,
                                   a.NUM_ACC, a.CORP2_ACC, a.kf, a.code_curr as KV, a.NAME, a.RNK as CUST_ID, 
                                   au.USER_ID,
                                   au.CAN_VIEW, 
                                   au.can_visa, 
                                   au.can_debit,
                                   au.visa_id,
                                   au.sequential_visa
                                       FROM v_corp2_accounts a 
                                       LEFT JOIN CORP2_ACC_USERS au ON (a.rnk = au.cust_id AND a.num_acc = au.nls AND au.USER_ID = :userId)
                                WHERE a.RNK = :custId AND a.IS_CORP2_ACC = 1",
                SqlParams = new object[]
                {
                    new OracleParameter("userId", OracleDbType.Int64){ Value = userId},
                    new OracleParameter("custId", OracleDbType.Int64){ Value = custId}
                }
            };
        }
        internal static BarsSql SelectUserModules(decimal? userId)
        {
            return new BarsSql
            {
                SqlText = @"select m.MODULE_ID as Id, m.NAME as Name from CORP2_MODULES m
                                            JOIN CORP2_USER_MODULES um on(m.user_type=2 AND
                                            um.MODULE_ID = m.MODULE_ID AND um.USER_ID = NVL(:userId, 0))",
                SqlParams = new object[]
                {
                    new OracleParameter("userId", OracleDbType.Int64){ Value = userId}
                }
            };
        }
        internal static BarsSql SelectAvailableModules(decimal? userId)
        {
            return new BarsSql
            {
                SqlText = @"select t.MODULE_ID as Id, t.NAME as Name from CORP2_MODULES t WHERE t.user_type=2
                            MINUS
                            select m.MODULE_ID as Id, m.NAME as Name from CORP2_MODULES m
                                            JOIN CORP2_USER_MODULES um on(m.user_type=2 AND
                                            um.MODULE_ID = m.MODULE_ID AND um.USER_ID = NVL(:userId, 0)) ",
                SqlParams = new object[]
                {
                    new OracleParameter("userId", OracleDbType.Int64){ Value = userId}
                }
            };
        }
        //internal static BarsSql SelectAvailableFuncs(decimal? userId)
        //{
        //    var sql = @"SELECT t.FUNC_ID as Id, f.FUNC_NAME as Name, t.MODULE_ID as ModuleId FROM 
        //                 (SELECT mf.* FROM CORP2_MODULE_FUNCTIONS mf
        //                  MINUS
        //                  SELECT m.* FROM CORP2_MODULE_FUNCTIONS m
        //                                    JOIN CORP2_USER_FUNCTIONS uf ON (
        //                                    uf.FUNC_ID = m.FUNC_ID AND uf.USER_ID = NVL(:userId, 0))) t
        //              JOIN CORP2_FUNCTIONS f ON(f.FUNC_ID = t.FUNC_ID)";

        //    return new BarsSql
        //    {
        //        SqlText = sql,
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("userId", OracleDbType.Int64) { Value = userId }
        //        }
        //    };
        //}
        //internal static BarsSql SelectUserFuncs(decimal? userId)
        //{
        //    //var sql = @"SELECT mf.FUNC_ID as Id, f.FUNC_NAME as Name, mf.MODULE_ID as ModuleId FROM CORP2_MODULE_FUNCTIONS mf
        //    //                JOIN CORP2_USER_FUNCTIONS uf ON (uf.FUNC_ID = mf.FUNC_ID 
        //    //                                                AND uf.USER_ID = NVL(:userId, 0))
        //    //                JOIN CORP2_FUNCTIONS f ON(f.FUNC_ID = mf.FUNC_ID)";
        //    var sql = @"SELECT mf.FUNC_ID as Id, mf.MODULE_ID as ModuleId FROM CORP2_MODULE_FUNCTIONS mf
        //                    JOIN CORP2_USER_FUNCTIONS uf ON (uf.FUNC_ID = mf.FUNC_ID 
        //                                                    AND uf.USER_ID = NVL(:userId, 0))";
        //    return new BarsSql
        //    {
        //        SqlText = sql,
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("userId", OracleDbType.Int64) { Value = userId }
        //        }
        //    };
        //}
        //internal static BarsSql SelectFuncs()
        //{
        //    //var sql = @"SELECT mf.FUNC_ID as Id, f.FUNC_NAME as Name, mf.MODULE_ID as ModuleId FROM CORP2_MODULE_FUNCTIONS mf
        //    //                JOIN CORP2_USER_FUNCTIONS uf ON (uf.FUNC_ID = mf.FUNC_ID 
        //    //                                                AND uf.USER_ID = NVL(:userId, 0))
        //    //                JOIN CORP2_FUNCTIONS f ON(f.FUNC_ID = mf.FUNC_ID)";
        //    var sql = @"SELECT mf.FUNC_ID as Id, mf.MODULE_ID as ModuleId FROM CORP2_MODULE_FUNCTIONS mf";
        //    return new BarsSql
        //    {
        //        SqlText = sql,
        //    };
        //}

        //internal static BarsSql SelectCustomerAccountVisaCounts(int accId)
        //{
        //    return new BarsSql
        //    {
        //        SqlText = @"SELECT * FROM CORP2_ACC_VISA_COUNT 
        //                        WHERE ACC_ID = :accId",
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("accId", OracleDbType.Int32){ Value = accId}
        //        }
        //    };
        //}
        internal static BarsSql SelectUserLimits(decimal userId)
        {
            return new BarsSql
            {
                SqlText = "SELECT ul.* FROM CORP2_USER_LIMIT ul WHERE ul.USER_ID = :userId",
                SqlParams = new object[]
                {
                    new OracleParameter("userId", OracleDbType.Int32){ Value = (int)userId}
                }
            };
        }
        internal static BarsSql SelectLimitDictionaryItems()
        {
            return new BarsSql
            {
                SqlText = "SELECT l.* FROM CORP2_LIMITS l"
            };
        }
    }

}