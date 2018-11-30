using System.Collections.Generic;
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
        List<STOContractData> GetContractDataList(int group_id);
        IQueryable<pipe_FREQ> GetFREQ();
        List<pipe_TTS> GetTTS();
        IQueryable<string> GetNLS(decimal RNK, decimal? KV);
        IQueryable<string> GetNMK(decimal RNK);
        string CurrentBranch();
        IQueryable<V_STO_DET> ContractDetData();
        IQueryable<STO_GRP> GroupData();
        List<STOGroup> GetGroupsList();
        int ClaimProc(string idd, string statusId, string disclaimId);
        IQueryable<STO_DISCLAIMER> DisclaimerData();
        IQueryable<V_STO_DET_HIST> DetInfoData();
        decimal AddPayment(payment newpayment);
        decimal AvaliableNPP(decimal IDS);
        List<pipe_customer> GetRNKLIST(string OKPO, decimal? RNK);
        decimal AddIDS(ids newids);
        IQueryable<DropDown> GetKVs(decimal? RNK);
        string Remove_Contract(decimal ids);
		void BeginTransaction();
        void Commit();
        void Rollback();
        /// <summary>
        /// Добавление предустановленных допреквизитов к макету платежа
        /// </summary>
        /// <param name="idd">ИД макета</param>
        /// <param name="tag">Тег допреквизита</param>
        /// <param name="value">Предустановленное значение</param>
        void SetStoOperw(decimal idd, string tag, string value);

        List<PaymentDopRekvModel> GetDopRekvforPaymentList(decimal idd);
        List<GovBuyingCodeRekv> GetGovCodesValue();
    }
}
