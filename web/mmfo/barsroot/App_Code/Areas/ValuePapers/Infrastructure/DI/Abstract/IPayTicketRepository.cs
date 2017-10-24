using BarsWeb.Areas.ValuePapers.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract
{
    public interface IPayTicketRepository
    {
        PayTicketInputs GetModel(string strPar01, string strPar02, decimal? nGrp, decimal? nMode);
        List<PayTicketGrid> GetGridData(string strPar01, string strPar02, decimal? nGrp, decimal? nMode, decimal? p_nRyn, decimal? p_nPf);
        AfterSaveParams SaveCP(int p_nTipD, int p_cb_Zo, int p_nGrp, int p_nID, int p_nRYN, string p_nVidd, decimal p_SUMK);
        double GetSumiAll(string strPar01, int kv, int pf, int emi, string vidd, int dox, int ryn);
        object GetModel(int p_ID, decimal? nGrp);
        IList<DropDownModel> dataListFor_cbm_RYN(int kv);
        List<PayTicketGrid> GetGridData(int p_ID, int nRYN, int nGRP);
    }
}
