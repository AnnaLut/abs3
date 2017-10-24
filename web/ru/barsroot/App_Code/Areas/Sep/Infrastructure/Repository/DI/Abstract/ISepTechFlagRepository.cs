using System.Data.Objects;
using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// ISepTechFlagRepository for SepTechFlagRepository
    /// </summary>
    public interface ISepTechFlagRepository
    {
        void GetNModel();
    }
}