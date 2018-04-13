using System;
using BarsWeb.Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract
{
    public interface ILimitsDistributionMfoRepository
    {
        UpdateDbStatus UploadFile(DateTime date, byte[] file);
    }
}
