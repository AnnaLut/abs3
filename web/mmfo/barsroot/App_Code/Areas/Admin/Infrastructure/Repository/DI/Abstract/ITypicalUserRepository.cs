using System.Collections.Generic;
using Areas.Admin.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface ITypicalUserRepository
    {
        IEnumerable<STAFF_TIPS> TypicalUser(DataSourceRequest request);
        decimal CountTypicalUser(DataSourceRequest request);
    }
}