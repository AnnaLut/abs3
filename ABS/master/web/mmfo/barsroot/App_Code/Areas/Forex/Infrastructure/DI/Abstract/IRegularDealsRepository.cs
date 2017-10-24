using BarsWeb.Areas.Forex.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Forex.Infrastructure.DI.Abstract
{
    public interface IRegularDealsRepository
    {
        IQueryable<BOPCODE> GetCodePurposeOfPayment(string KOD);
        IQueryable<SW_BANKS> GetBanksSWIFTParticipants(string BICK);
        ForexPartner GetPartnersForexDeals(string KVB, string KEY, string VALUE);
       
        List<Revenue> GetRevenueDropDown(decimal? kv);
        List<INIC> GetINICDropDown();

       decimal GetCheckPS(string MFO, decimal KV);
        decimal? GetSWRef(decimal DealTag);
        // decimal GetPartnersForexDealsDataCount(decimal currency, DataSourceRequest request);
        // decimal GetCodePurposeOfPaymentDataCount(DataSourceRequest request);
        // decimal GetBanksSWIFTParticipantsDataCount(DataSourceRequest request);
        IQueryable<Currency> GetCurrencyProp(decimal kv);
        OutDealTag SaveGhanges(Agreement agreement);
        void SaveGhangesPartners(FOREX_ALIEN partner);
        void InsertOperw(decimal pInic, decimal nND);
        decimal GetRNKB(string MFOB,string BICB,string KOD_B);
        string GetNLSA(decimal? codeAgent);
        DateTime GetBankDate();
        decimal? GetCrossCourse(decimal KVA, decimal KVB, DateTime BankDate);
        decimal? GetFinResult(decimal KVA, decimal NSA, decimal KVB, decimal NSB);
        IQueryable<Prepare> GetDefSettings();
        List<AccountModels> getAccModelList(decimal ND, DataSourceRequest request);
        decimal getAccModelListDataCount(decimal ND, DataSourceRequest request);
        IQueryable<RefDetail> getSwapTag(decimal dealTag);

        IQueryable<CustLims> GetCustLimits(decimal OKPOB);
        void SWIFTCreateMsg(decimal DealTag);
        void PutDepo(decimal DealTag);
        string GetDealType(string DealTag);
        string GetDealTag();
        IQueryable<FX_DEAL> GetFXDeal(decimal DealTag);
        IQueryable<FXUPD> GetFXUPDeal(decimal DealTag);
        FXUPD GetFXUPDealAllFields(FXUPD _fxupd);
        void UpdateChanges(FXUPD fxupd);        
    }

}