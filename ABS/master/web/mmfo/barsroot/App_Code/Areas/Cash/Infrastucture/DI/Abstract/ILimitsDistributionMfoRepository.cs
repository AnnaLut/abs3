using System;
using BarsWeb.Areas.Cash.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract
{
    public interface ILimitsDistributionMfoRepository
    {
        UpdateDbStatus UploadFile(DateTime date, byte[] file);
        List<MfoProtocolModel> GetMfoProtocolData(decimal sessionId);
    }
}
