using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface INewCreditRepository
    {
        IQueryable<CurrencyList> getCurrency();
        IQueryable<StanFinList> getStanFin();
        IQueryable<StanObsList> getStanObs();
        IQueryable<CRiskList> getCRisk(decimal fin, decimal obs);
        IQueryable<ViddList> getVidd(decimal rnk);
        IQueryable<SourList> getSour();
        IQueryable<AimList> getAim(decimal? rnk, string dealDate);
        NlsParam getAimBal(decimal? rnk, decimal? aim, bool yearDiff);
        void setMasIni(string nbs);
        IQueryable<BaseyList> getBasey();
        IQueryable<RangList> getRang(decimal? rnk);
        IQueryable<FreqList> getFreq();
        IQueryable<MetrList> getMetr();
        IQueryable<ParamsList> getTabList();
        IQueryable<NdTxtList> getNdTxt(string code);
        IQueryable<NdTxtList> getNdTxtDeal(decimal nd, string code);
        decimal createDeal(CreateDeal credit);
        decimal updateDeal(CreateDeal credit);
        void setNdTxt(decimal? nd, List<NdTxt> txt);
        void afterSaveDeal(AfterParams param);
        void setMultiExtInt(MultiExtIntParams param);
        CreateDeal getDeal(decimal nd);
        PrologParam GetProlog(decimal nd);
        IQueryable<MultiExtInt> getMultiExtInt(decimal nd);
        string SetProlog(decimal nd, DateTime bnkDate, decimal kprolog, decimal sos, DateTime dateStart, DateTime dateEnd);
    }
}