using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepLockDocViewRepository
    {
        IQueryable<SepLockView> GetLockDoc(decimal rec);
    }
}