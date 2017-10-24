using System;
using System.Collections.Generic;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract
{
    public interface ICurrencySightRepository
    {
        IEnumerable<CurrencyBuyModel> BuyDataList(decimal dk);
        IEnumerable<CurrencySaleModel> SaleDataList(decimal dk);
        IEnumerable<PrimaryBuy> PrimaryBuyDataList(decimal dk);
        IEnumerable<PrimarySale> PrimarySaleDataList(decimal dk);
        void SaveAdditionalDetails(AdditionalDetails details);
        void BackRequestFunc(BackRequestModel request);
        byte[] GetFileCorpData(decimal id);
        decimal CurrencyStatus(decimal kv);
        CurrencyRate CurrencyRate(decimal kv);
        void CurrencyRateUpdate(decimal id, decimal kursZ);
        void ZayCheckData(ZayCheckDataModel item);

        decimal IsReserved();
        decimal IsBlocked(decimal id);
        decimal CoveredValue();
        ReserveResult ReserveCheckout(decimal type, decimal id);
        void SetVisa(Visa item);

        IEnumerable<DealerBuy> DealerBuyData(decimal dk, decimal? sos = null, decimal? visa = null);
        IEnumerable<DealerSale> DealerSaleData(decimal dk, decimal? sos = null, decimal? visa = null);

        decimal DilViza();
        DateTime BankDate();

        void UpdateSosData(SetSos item);

        IEnumerable<DILER_KURS> DilerKursData(decimal mode);
        IEnumerable<DILER_KURS_CONV> DilerKursConvData(decimal mode);

        void UpdateDilerIndKurs(decimal? kvCode, bool blk, decimal? indBuy, decimal? indSale, decimal? indBuyVip, decimal? indSaleVip);
        IEnumerable<string> DealerFieldValues(decimal dk, decimal? sos, decimal? visa, string field);
        void UpdateDilerFactKurs(decimal? kvCode, decimal? fBuy, decimal? fSale);
        void SetDilerConvKurs(decimal type, decimal? pairKursF, decimal? pairKursS, decimal? newKurs);

        void BirjaSetViza(decimal id, DateTime? datz);
        void BirjaBackRequest(decimal id);

        void SepatationSum(SeparationModel item);

    }
}