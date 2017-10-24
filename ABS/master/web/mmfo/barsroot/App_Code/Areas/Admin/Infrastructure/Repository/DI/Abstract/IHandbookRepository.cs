using System.Collections.Generic;
using Areas.Admin.Models;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IHandbookRepository
    {
        IEnumerable<STAFF_TIPS> GroupsData();
        IEnumerable<STAFF_CLASS> ClassesData();
    }
}