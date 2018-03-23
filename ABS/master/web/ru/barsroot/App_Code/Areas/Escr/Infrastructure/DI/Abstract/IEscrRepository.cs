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
        void SetComment(decimal deal_id, string comment, string state_code, decimal object_type, decimal obj_check, Oracle.DataAccess.Client.OracleCommand cmd);
        void SetDocDate(decimal deal_id, string doc_date);
        void SetNdTxt(decimal deal_id, string tag, string value, Oracle.DataAccess.Client.OracleCommand cmd);
        void SetCreditState(decimal deal_id, string state_code);
        decimal GroupByRegister(GroupByParams param);
        void DelGroupRegister(List<decimal> registers);
        void DelDealRegister(List<decimal> deals, Oracle.DataAccess.Client.OracleCommand cmd);
        EscrChkStateResult CheckState(EscrGetStateParam param);
        ImportParams GetRegDeal(ImportParams param);
        string GetStatusCode(decimal status_id, Oracle.DataAccess.Client.OracleCommand cmd);
        void SetNewSum(decimal? deal_id, decimal? new_good_cost, decimal? new_deal_sum, decimal? new_comp_sum, Oracle.DataAccess.Client.OracleCommand cmd);
        IQueryable<EscrRefList> GetRefList();
        void PayOrDelete(List<decimal> all_list, byte type);
        IQueryable<EscrJournal> GetJournalList();
        IQueryable<EscrJournalDetail> GetJournalDetail(decimal id);
        void RestoreGLK(decimal id);
    }
}