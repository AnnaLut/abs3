using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface INewCreditRepository
    {
        Dictionary<int, string> getVidd(decimal rnk);
        Dictionary<int, string> getAim(byte vidd, string dealDate);
        Dictionary<int, string> getBusMod(decimal rnk);
        decimal createDeal(CreateDeal credit);
        decimal updateDeal(CreateDeal credit);
        string setNdTxt(decimal? nd, List<NdTxt> txt);
        Dictionary<int, string> getRang(byte vidd);
        void afterSaveDeal(AfterParams param);
        void setMultiExtInt(MultiExtIntParams param);
        CreditFormData getDeal(decimal nd);
        PrologParam GetProlog(decimal nd);
        string SetProlog(decimal nd, DateTime bnkDate, decimal kprolog, decimal sos, DateTime dateStart, DateTime dateEnd);
        AuthStaticData GetAuthStaticData(decimal nd);
        string Authorize(decimal nd, int type, string pidstava, string initiative);
        CustomerInfo GetCustomerInfo(decimal rnk, OracleConnection conn = null);
        DataSourceInfo GetDataSources();
        MoreCreditDataSource GetMoreCreditsParams(decimal? nd);
        string GetIFRS(int bus_mod, string sppi);
        string GetSPPI(decimal rnk);
        float GetActualLimit(long? sub_nd, long? nd_gkd);
    }
}