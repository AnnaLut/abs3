using System.Data;
using BarsWeb.Areas.Acct.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for Validate
    /// </summary>
    public class ValidateAcctRepository : IValidateAcctRepository
    {
        private readonly AcctDbContext _dbContext;
        private readonly IModuleConfiguration _config;

        public ValidateAcctRepository(IAcctModel model, IModuleConfiguration config)
        {
            _dbContext = model.GetDbContext();
            _config = config;
        }

        public ValidateModel ValidateCustomer(decimal customerId)
        {
            var result = new ValidateModel();
            if (_config.IsAccReserve)
            {
                var sql = "begin kl.check_attr_foropenacc(:p_rnk, :p_msg); end;";

                object[] parameters = {
                    new OracleParameter("p_rnk", OracleDbType.Decimal, customerId, ParameterDirection.Input),
                    new OracleParameter("p_msg", OracleDbType.Varchar2, 4000){Direction = ParameterDirection.ReturnValue}
                };

                _dbContext.Database.ExecuteSqlCommand(sql, parameters);

                var mess = ((OracleParameter)parameters[1]).Value.ToString();

                if (!string.IsNullOrEmpty(mess) && mess.ToLower().Trim() != "null")
                {
                    result.Status = ValidateStatus.Error;
                    result.Message = mess;
                }
            }

            return result;
        }

    }

    public interface IValidateAcctRepository
    {
        ValidateModel ValidateCustomer(decimal customerId);
    }
}
