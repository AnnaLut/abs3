using System.Linq;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IBanksRepository
    {
        string GetOurMfo();
        string GetOurSab();
        IQueryable<BankViewModel> GetBankList();
        IQueryable<BankViewModel> GetOurBanks();
    }
}