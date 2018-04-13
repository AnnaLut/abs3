using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Http;
//using AttributeRouting;
//using AttributeRouting.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Region;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Region;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Controllers.Api
{
    /// <summary>
    /// API для получения данных об остатках наличности из регионов
    /// </summary>
    [AuthorizeApi]
    public class LoadController : ApiController
    {
        private readonly IAccountRepository _accountRepository;// = new AccountRepository(new CashModel());

        public LoadController(IAccountRepository repository)
        {
            _accountRepository = repository;
        }

        /// <summary>
        /// Получить список банковских дней
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cash/load/bankdates")]
        public BankDatesResponse BankDates()
        {
            var response = new BankDatesResponse
            {
                Success = true
            };

            try
            {
                IQueryable<V_CLIM_FDAT> dbRecords = _accountRepository.GetBankDates();
                IQueryable<DateTime> viewRecords = dbRecords.Select(x => x.FDAT);
                response.BankDates = viewRecords;
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.ErrorMessage = ex.ToString();
            }
            return response;
        }

        /// <summary>
        /// Получить список остатков по кассовым счетам
        /// </summary>
        /// <param name="bankdate">Строка в формате yyyy-MM-dd</param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cash/load/accountsrest")]
        public AccountsRestResponse AccountsRest(string bankdate)
        {
            var response = new AccountsRestResponse
            {
                Success = true
            };

            try
            {
                DateTime? date = StringToDate(bankdate);
                if (date != null)
                {
                    IEnumerable<RegionAccountRest> accountsRests = _accountRepository.GetAccountRests((DateTime)date);
                    response.AccountsRests = accountsRests;
                }
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.ErrorMessage = ex.ToString();
            }
            return response;
        }


        /// <summary>
        /// Получить список кассовых счетов
        /// </summary>
        /// <param name="new">Вычитывать счета только для текущей банковской даты</param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cash/load/accounts")]
        public AccountsResponse Accounts(bool @new = false)
        {
            var response = new AccountsResponse
            {
                Success = true
            };

            try
            {
                DateTime? bankDate = null;
                if (@new)
                {
                    bankDate = _accountRepository.GetBankDate();
                }

                IEnumerable<RegionAccount> accounts = GetAccountsFromDb(bankDate);
                response.BankDate = bankDate;
                response.Accounts = accounts;
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.ErrorMessage = ex.ToString();
            }
            return response;
        }
        /// <summary>
        /// Получить список всех отделений (бранчей)
        /// </summary>
        [HttpGet]
        [GET("api/cash/load/Branches")]
        public BranchesResponse Branches()
        {
            var response = new BranchesResponse
            {
                Success = true
            };
            try
            {
                response.Branches = GetBranchesFromDb();
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.ErrorMessage = ex.ToString();
            }
            return response;
        }

        /// <summary>
        /// Получить список транзакцій на дату
        /// </summary>
        [HttpGet]
        [GET("api/cash/load/Transactions")]
        public TransactionsResponse Transactions(string bankdate)
        {
            var response = new TransactionsResponse
            {
                Success = true
            };
            try
            {
                DateTime? date = StringToDate(bankdate);
                if (date != null)
                {
                    IEnumerable<RegionTransaction> transactions = _accountRepository.GetTransactions((DateTime) date);
                    response.Transactions = transactions;
                }
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.ErrorMessage = ex.ToString();
            }
            return response;
        }
        private IEnumerable<RegionAccount> GetAccountsFromDb(DateTime? bankdate = null)
        {
            IQueryable<V_CLIM_ACCOUNTS> dbRecords = _accountRepository.GetAccounts();

            if (bankdate.HasValue)
            {
                dbRecords = dbRecords.Where(f => f.ACC_DAPP == bankdate);
            }

            IQueryable<RegionAccount> viewRecords = ModelConverter.ToViewModel(dbRecords);
            return viewRecords;
        }
        private IEnumerable<RegionBranch> GetBranchesFromDb()
        {
            IQueryable<V_CLIM_BRANCH> dbRecords = _accountRepository.GetBranches();
            IQueryable<RegionBranch> viewRecords = ModelConverter.ToViewModel(dbRecords);
            return viewRecords;
        }
        /// <summary>
        /// Конвертировать строку в дату
        /// </summary>
        /// <param name="date">Строка в формате yyyy-MM-dd</param>
        /// <returns>Null при ошибке конвертации</returns>
        private DateTime? StringToDate(string date)
        {
            if (!string.IsNullOrEmpty(date))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                const string format = "yyyy-MM-dd";

                DateTime parsedDate;
                if (DateTime.TryParseExact(date, format, provider, DateTimeStyles.None, out parsedDate))
                {
                    return parsedDate;
                }
            }
            return null;
        }

    }
}