using System.Linq;
using BarsWeb.Areas.KFiles.Models;
using System.Collections.Generic;
using Kendo.Mvc.UI;
using Areas.KFiles.Models;

namespace BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract
{
    public interface IKFilesAccountCorpRepository
    {
        List<V_CORP_ACCOUNTS_WEB> GetAccountCorp([DataSourceRequest] DataSourceRequest request, List<decimal> corpIndexes);
        decimal GetAccountCorpDataCount([DataSourceRequest] DataSourceRequest request, List<decimal> corpIndexes);
        IQueryable<V_OB_CORPORATION> GetCorpFilter();
        List<V_ROOT_CORPORATION> GetDropDownAltCorpName([DataSourceRequest] DataSourceRequest request);
        void  AccCorpSave(List<AccCorpSave> accCorpSave);
        List<V_ORG_CORPORATIONS> GetCorporationsGrid([DataSourceRequest] DataSourceRequest request);
        decimal GetCorporationsDataCount([DataSourceRequest] DataSourceRequest request);
    }
}
