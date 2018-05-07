using System;
using System.Linq;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class ValidateCustomerRepository : IValidateCustomerRepository
    {
        readonly ClientsDbContext _dbContext;
        public ValidateCustomerRepository(IClientsModel model)
        {
            _dbContext = model.GetDbContext();
        }

        public ActionStatus CloseCustomerValidation(decimal id)
        {
            var result = new ActionStatus();
            var acctCount = GetCountOpenAccounts(id);
            if (acctCount > 0)
            {
                result.Status = ActionStatusCode.Error;
                result.Message = " * " + string.Format(Resources.ClientsResource.CustomerHaveNotCloseAccounts, acctCount);
            }
            var dptCount = GetCountOpenDptTrusstee(id);
            if (dptCount > 0)
            {
                result.Status = ActionStatusCode.Error;
                result.Message += " * " + Resources.ClientsResource.CustomerHaveNotCloseDptTrusstee;
            }
            if (!ValidateDateClose(id))
            {
                result.Status = ActionStatusCode.Error;
                result.Message += " * " + string.Format(Resources.ClientsResource.CustomerCannotByClosedDateLessBankDate);
            }
            
            return result;
        }

        public ActionStatus RestoreCustomerValidation(decimal id)
        {
            var result = new ActionStatus();
            if (!ValidateRestoreDateClose(id))
            {
                result.Status = ActionStatusCode.Error;
                result.Message = Resources.ClientsResource.CustomerNotClosed;
                return result;
            }
            if(!ValidateRestoreDate(id))
            {
                result.Status = ActionStatusCode.Error;
                result.Message = Resources.ClientsResource.CustomerCannotByOpenDateLessBankDate;
                return result;
            }

            return result;
        }

        private int GetCountOpenAccounts(decimal id)
        {
            const string sql = "SELECT count(*) FROM accounts a, cust_acc ca WHERE a.acc=ca.acc and ca.rnk=:p_rnk and a.dazs is null";
            var result = _dbContext.Database.SqlQuery<int>(sql, id).FirstOrDefault();
            return result;
        }

        private int GetCountOpenDptTrusstee(decimal id)
        {
            const string sql = "SELECT count(t.rnk) FROM dpt_trustee t WHERE t.fl_act > 0 and rnk_tr=:p_rnk";
            var result = _dbContext.Database.SqlQuery<int>(sql, id).FirstOrDefault();
            return result;
        }

        private bool ValidateRestoreDateClose(decimal id)
        {
            var result = true;
            const string dateCloseSql = "SELECT date_off FROM customer WHERE rnk=:p_rnk";
            var dateClose = _dbContext.Database.SqlQuery<DateTime?>(dateCloseSql, id).FirstOrDefault();

            if (dateClose == null)
            {
                result = false;
            }
            return result;
        }

        private bool ValidateRestoreDate(decimal id)
        {
            var result = true;
            const string dateCloseSql = "SELECT date_off FROM customer WHERE rnk=:p_rnk";
            var dateClose = _dbContext.Database.SqlQuery<DateTime?>(dateCloseSql, id).FirstOrDefault();

            const string bankDateSql = "SELECT bankdate FROM dual";
            var bahkDate = _dbContext.Database.SqlQuery<DateTime?>(bankDateSql).FirstOrDefault();

            if (bahkDate < dateClose)
            {
                result = false;
            }
            return result;
        }

        private bool ValidateDateClose(decimal id)
        {
            var result = true;
            const string dateOpenSql = "SELECT date_on FROM customer WHERE rnk=:p_rnk";
            var dateOpen = _dbContext.Database.SqlQuery<DateTime?>(dateOpenSql, id).FirstOrDefault();

            const string bankDateSql = "SELECT bankdate FROM dual";
            var bahkDate = _dbContext.Database.SqlQuery<DateTime?>(bankDateSql).FirstOrDefault();

            if (bahkDate < dateOpen)
            {
                result = false;
            }

            return result;
        }
    }

    public interface IValidateCustomerRepository
    {
        ActionStatus CloseCustomerValidation(decimal id);
        ActionStatus RestoreCustomerValidation(decimal id);
    }
}