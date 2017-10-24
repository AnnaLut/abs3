using System;
using System.Linq;
using BarsWeb.Areas.Docs.Models;
using BarsWeb.Areas.Docs.Models.Permission;

namespace BarsWeb.Areas.Docs.Infrastructure.Repository
{
    public class PaymentsRepository : IPaymentsRepository
    {
        private readonly DocsDbContext _dbContext;

        public PaymentsRepository(IDocsModel model)
        {
            _dbContext = model.GetDbContext();
        }

        public IQueryable<PaymentUserIn> GetAllUserIn(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsUserIn.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentUserOut> GetAllUserOut(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsUserOut.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentBranchIn> GetAllBranchIn(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsBranchIn.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentBranchOut> GetAllBranchOut(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsBranchOut.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentArcsUserIn> GetAllArcsUserIn(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsArchUserIn.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentArcsUserOut> GetAllArcsUserOut(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsArchUserOut.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentArcsBranchIn> GetAllArcsBranchIn(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsArchBranchIn.Where(i => i.DateSystem >= dateStart && i.DateSystem <= dateEnd);
        }

        public IQueryable<PaymentArcsBranchOut> GetAllArcsBranchOut(DateTime dateStart, DateTime dateEnd)
        {
            return _dbContext.PaymentsArchBranchOut.Where(i =>i.DateSystem  >= dateStart && i.DateSystem <=  dateEnd);
        }

        public Payment Get(int id)
        {
            throw new NotImplementedException();
        }

        public Payment GetArcs(int id)
        {
            throw new NotImplementedException();
        }

        public Payment Update(Payment payment)
        {
            throw new NotImplementedException();
        }

        public Payment Create(Payment payment)
        {
            throw new NotImplementedException();
        }
    }

    public interface IPaymentsRepository
    {
        IQueryable<PaymentUserIn> GetAllUserIn(DateTime dateStart, DateTime dateEnd);
        IQueryable<PaymentUserOut> GetAllUserOut(DateTime dateStart, DateTime dateEnd);
        IQueryable<PaymentBranchIn> GetAllBranchIn(DateTime dateStart, DateTime dateEnd);
        IQueryable<PaymentBranchOut> GetAllBranchOut(DateTime dateStart, DateTime dateEnd);

        IQueryable<PaymentArcsUserIn> GetAllArcsUserIn(DateTime dateStart, DateTime dateEnd);
        IQueryable<PaymentArcsUserOut> GetAllArcsUserOut(DateTime dateStart, DateTime dateEnd);
        IQueryable<PaymentArcsBranchIn> GetAllArcsBranchIn(DateTime dateStart, DateTime dateEnd);
        IQueryable<PaymentArcsBranchOut> GetAllArcsBranchOut(DateTime dateStart, DateTime dateEnd);

        Payment Get(int id);
        Payment GetArcs(int id);
        Payment Update(Payment payment);
        Payment Create(Payment payment);
    }
}