using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IADMSegmentsRepository
    {
        IEnumerable<V_DWHLOG> GetDWHData();


        decimal CountAllAPPS();
    }
}