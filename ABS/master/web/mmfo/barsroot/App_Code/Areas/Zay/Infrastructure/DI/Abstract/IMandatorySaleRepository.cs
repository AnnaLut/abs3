using System.Collections.Generic;
using BarsWeb.Areas.Zay.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract
{
    public interface IMandatorySaleRepository
    {
        IEnumerable<MandatorySale> GetMandatorySaleList(DataSourceRequest request);
        decimal GetMandatorySaleCount(DataSourceRequest request);
        void DelZay(decimal refDoc);
        IEnumerable<ZayDoc> GetZayLinkedDocs(decimal refDoc, DataSourceRequest request);
        decimal GetZayLinkedDocCount(decimal refDoc, DataSourceRequest request);
        string GetOperNazn(decimal refDoc);
        void DoZayDebt(ZayDebt bidParams);
    }
}