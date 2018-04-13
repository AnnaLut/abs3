using System;
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.Escr.Models;

namespace BarsWeb.Areas.Escr.Infrastructure.DI.Abstract
{
    public interface IEscrRepository
    {
        IQueryable<EscrRegisterMain> GetRegisterMain(string dateFrom, string dateTo, string type, string kind);
        IQueryable<EscrEvents> GetEvents(decimal customerId, decimal dealId);
        IQueryable<EscrProd> GetProd();
        IQueryable<EscrViddRee> GetVidd();
        decimal SaveRegister(EscrSaveRegister param);
        IQueryable<EscrRegister> GetRegister(string dateFrom, string dateTo, string type, string kind);
        IQueryable<EscrRegisterDeals> GetRegisterDeals(decimal registerId);
        string SendRegister(List<decimal> registers);
        void SetComment(decimal deal_id, string comment, string state_code, decimal object_type, decimal obj_check);
        void SetDocDate(decimal deal_id, string doc_date);
        void SetCreditState(decimal deal_id, string state_code);
        decimal GroupByRegister(GroupByParams param);
        void DelGroupRegister(List<decimal> registers);
        void DelDealRegister(List<decimal> deals);
        EscrChkStateResult CheckState(EscrGetStateParam param);
        ImportParams GetRegDeal(ImportParams param);
        string GetStatusCode(decimal status_id);
        void GenRegPl(List<decimal> registers);
        string Validate(decimal reg_id);
        void SetOutNumber(decimal reg_id, string out_number);
        void СhangeCompSum(decimal deal_id, decimal new_good_cost);
        void DelRegEvent(decimal deal_id, decimal event_id);
        void SetNewSum(decimal deal_id, decimal? new_good_cost, decimal? new_deal_sum, decimal? new_comp_sum);

    }
}