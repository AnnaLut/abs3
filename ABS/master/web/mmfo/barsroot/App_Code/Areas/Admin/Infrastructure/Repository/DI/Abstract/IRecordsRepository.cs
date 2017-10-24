using System.Collections.Generic;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models.EditRecords;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IRecordsRepository
    {
        List<ListOtch> GetListId();
        List<LeftGrid> GetLeftGrid(decimal nGrp);
    }
}