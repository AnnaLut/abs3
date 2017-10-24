using System.Linq;
using Areas.Sto.Models;
using BarsWeb.Areas.Sto.Models;

namespace BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Summary description for IContractRepository
    /// </summary>
    public interface IContractRepository
    {
        IQueryable<STO_LST> ContractData();
        IQueryable<pipe_FREQ> GetFREQ();
        IQueryable<pipe_TTS> GetTTS();
        IQueryable<string> GetNLS(decimal RNK, decimal? KV);
        IQueryable<string> GetNMK(decimal RNK);
        string CurrentBranch();
        IQueryable<V_STO_DET> ContractDetData();
        IQueryable<STO_GRP> GroupData();
        int ClaimProc(string idd, string statusId, string disclaimId);
        IQueryable<STO_DISCLAIMER> DisclaimerData();
        IQueryable<V_STO_DET_HIST> DetInfoData();        
        decimal AddPayment(payment newpayment);
        decimal AvaliableNPP(decimal IDS);
        IQueryable<pipe_customer> GetRNKLIST(string OKPO);
        decimal AddIDS(ids newids);
        IQueryable<DropDown> GetKVs(decimal? RNK);

    }
}
