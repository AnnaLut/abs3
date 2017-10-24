using System;
using System.Linq;
using BarsWeb.Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for Accounts
    /// </summary>
    public class StatemantRepository : IStatemantRepository
    {
        readonly AcctDbContext _dbContext;
        private readonly IAccountsRepository _acctRepository;

        public StatemantRepository(IAcctModel model, IAccountsRepository acctRepository)
        {
            _dbContext = model.GetDbContext();
            _acctRepository = acctRepository;
        }

        public Statement GetStatement(decimal acctId, DateTime dateStart, DateTime dateEnd)
        {
            var account = _acctRepository.GetAccount(acctId);
            if (account == null)
            {
                return null;
            }
            
            var statement = new Statement
            {
                AccountId = acctId,
                AccountName = account.Name,
                AccountNumber = account.Number,
                AccountCurrencyId = account.CurrencyId,
                //PaymentsList = GetStatementPayments(acctId, dateStart, dateEnd).ToList()
            };
            statement.PaymentsList = GetStatementPayments(acctId, dateStart, dateEnd);
            statement.Turnovers = GetStatementTurnovers(acctId, dateStart, dateEnd);

            return statement;
        }

        public Statement GetStatement(decimal acctId, DateTime dateStart, DateTime dateEnd, string type)
        {
            var account = _acctRepository.GetAccount(acctId, type);
            if (account == null)
            {
                return null;
            }

            var statement = new Statement
            {
                AccountId = acctId,
                AccountName = account.Name,
                AccountNumber = account.Number,
                AccountCurrencyId = account.CurrencyId,
            };
            //statement.PaymentsList = GetStatementPayments(acctId, dateStart, dateEnd);
            statement.Turnovers = GetStatementTurnovers(acctId, dateStart, dateEnd);

            return statement;
        }

        public StatementTurnovers GetStatementTurnovers(decimal acctId, DateTime dateStart, DateTime dateEnd)
        {
            const string sql = 
                        @"select 
                            sa.OSTF / power(10, tv.dig) as InBalance,
                            (sl.TurnoverDebit / power(10, tv.dig)) as TurnoverDebit, 
                            (sl.TurnoverCredit / power(10, tv.dig)) as TurnoverCredit,
                            (sa.ostf + sl.TurnoverCredit - sl.TurnoverDebit) / power(10, tv.dig) as OutBalance,
                            sl.min_date as MinDate,
                            sl.max_date as MaxDate
                        from (
                            select 
                                s.acc,
                                sum(s.dos) as TurnoverDebit,
                                sum(s.kos) as TurnoverCredit,    
                                min(s.fdat) as min_date,
                                max(s.fdat) as max_date
                            from 
                                saldoa s
                            where 
                                s.acc = :p_acc
                                and s.fdat >= :p_dateStart
                                and s.fdat < :p_dateEnd
                            group by s.acc
                            ) sl,
                            saldoa sa,
                            tabval tv,
                            accounts a
                        where 
                            sa.acc = sl.acc
                            and a.acc = sa.acc
                            and TV.KV = a.kv
                            and sl.min_date = SA.FDAT";

            var result = _dbContext.Database.SqlQuery<StatementTurnovers>(sql, acctId, dateStart, dateEnd).FirstOrDefault();
            return result;
        }

        public IQueryable<StatementPayment> GetStatementPayments(decimal accId, DateTime dateStart, DateTime dateEnd)
        {
            var result = _dbContext.StatementPayments.Where(i => i.AccountId == accId && i.FactDate >= dateStart && i.FactDate < dateEnd);
            return result;
        }
    }

    public interface IStatemantRepository
    {
        Statement GetStatement(decimal acctId, DateTime dateStart, DateTime dateEnd);
        Statement GetStatement(decimal acctId, DateTime dateStart, DateTime dateEnd, string type);
        StatementTurnovers GetStatementTurnovers(decimal acctId, DateTime dateStart, DateTime dateEnd);
        IQueryable<StatementPayment> GetStatementPayments(decimal acctId, DateTime dateStart, DateTime dateEnd);
    }

}
