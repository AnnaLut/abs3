using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using ARC_RRP = Models.ARC_RRP;
using ZAG_A = Areas.Sep.Models.ZAG_A;

/// <summary>
/// Інформаційні повідомлення з СЕП. (Одержанi iнф-нi: Запити)
/// </summary>

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepTZRepository
    {
        List<SepTZ> GetSepTZList(DataSourceRequest request, AccessType accessType, string externParams);
        decimal GetSepTZCount(AccessType accessType, DataSourceRequest request, string externParams);
        void DeleteSepTZRow(decimal rowREC);
        IQueryable<ARC_RRP> GetRowReply(string dRec);
        IQueryable<ACCOUNTS> GetS902();
        IQueryable<ARC_RRP> GetReport(string mode, DateTime dStart, DateTime dEnd);
        decimal GetReportCount(string mode, DateTime dStart, DateTime dEnd, DataSourceRequest request);
        IEnumerable<ZAG_A> GetZagA(string arcFn, DateTime arcDate_a);
    }
}
