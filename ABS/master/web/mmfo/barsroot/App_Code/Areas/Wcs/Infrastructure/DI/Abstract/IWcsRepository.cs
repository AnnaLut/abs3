using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.Wcs.Models;

namespace BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract
{
    public interface IWcsRepository
    {
        IQueryable<ScoringQuestion> GetScoringQuestion(int bidId);
        int GetCountGarantees(int? bidId);
        ScoringResult GetResult(int? bidId);
        IQueryable<ServiceList> GetServiceList();
        string GetValue(string bid_id, string question_id);
        void SetServices(string bidId, string services);
    }
}