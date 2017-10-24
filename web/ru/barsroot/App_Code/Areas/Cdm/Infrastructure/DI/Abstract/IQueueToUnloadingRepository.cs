using System.Collections.Generic;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Models;
using Kendo.Mvc.UI;


namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract
{
    public interface IQueueToUnloadingRepository
    {
        IEnumerable<QueueToUnLoading> GetQueueToUnloading(DataSourceRequest request);
    }
}
