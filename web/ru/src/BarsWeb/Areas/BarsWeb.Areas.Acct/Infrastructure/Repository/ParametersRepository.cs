using System;
using System.Linq;
using BarsWeb.Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for Accounts
    /// </summary>
    public class ParametersRepository : IParametersRepository
    {
        readonly AcctDbContext _dbContext;

        public ParametersRepository(IAcctModel model)
        {
            _dbContext = model.GetDbContext();
        }

        public IQueryable<Parameter> GetAllParameters()
        {
            throw new NotImplementedException();
        }

        public Parameter GetParameterByName(string name)
        {
            // todo: хук для глобальних параметрів
            if (name == "ACC_RESERVE")
            {
                return GetGlobalParam(name);
            }

            throw new NotImplementedException();
        }

        private Parameter GetGlobalParam(string name)
        {
            const string sql = @"select 
                                    par as name,
                                    val as value,
                                    comm as description
                                from 
                                    params p
                                where 
                                    p.par = :p_par";
            var result = _dbContext.Database.SqlQuery<Parameter>(sql, name).FirstOrDefault();
            return result;
        } 
    }

    public interface IParametersRepository
    {
        IQueryable<Parameter> GetAllParameters();
        Parameter GetParameterByName(string name);
    }
}
