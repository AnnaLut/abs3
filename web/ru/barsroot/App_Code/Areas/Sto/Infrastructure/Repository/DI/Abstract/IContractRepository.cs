using System.Linq;
using Areas.Sto.Models;

namespace BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Summary description for IContractRepository
    /// </summary>
    public interface IContractRepository
    {
        IQueryable<STO_LST> ContractData();
        string CurrentBranch();
        IQueryable<V_STO_DET> ContractDetData();
        IQueryable<STO_GRP> GroupData();
        int ClaimProc(string idd, string statusId, string disclaimId);
        IQueryable<STO_DISCLAIMER> DisclaimerData();
        IQueryable<V_STO_DET_HIST> DetInfoData();
    }
}
