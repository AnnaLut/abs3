using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class BanksRepository : IBanksRepository
    {
        private KernelContext _entities;
        public BanksRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Kernel", "Kernel");
            _entities = new KernelContext(connectionStr); 
        }

        public string GetOurMfo()
        {
            return _entities.ExecuteStoreQuery<string>("SELECT f_ourmfo() from dual").Single();
        }

        public IQueryable<BankViewModel> GetOurBanks()
        {
            var ourMfo = GetOurMfo();
            return GetBankList().Where(b => b.Mfop == ourMfo);
        }

        public IQueryable<BankViewModel> GetBankList()
        {
            return _entities.ExecuteStoreQuery<BankViewModel>("SELECT * FROM BANKS").AsQueryable();
        }

        public string GetOurSab()
        {
            var ourMfo = GetOurMfo();
            return GetBankList().Single(b => b.Mfo == ourMfo).Sab;
        }
    }
}