using System;
using System.Collections.Generic;
using BarsWeb.Areas.F601.Models;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.F601.Infrastructure.DI
{
    public interface IF601DeltaRepository
    {
       // int ExecuteStoreProcedere(string commandText, params object[] parameters);
        List<NBUReportInstance> GetReports();
        List<NBUSessionHistory> GetNBUSessionHistory(Decimal? id);
        List<NBUSessionData> GetNBUSessionData(Decimal?reportId, Decimal?sessionId);
    }
}