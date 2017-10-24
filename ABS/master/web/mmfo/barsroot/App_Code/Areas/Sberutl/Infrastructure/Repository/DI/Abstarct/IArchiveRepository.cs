using BarsWeb.Areas.Sberutl.Models;
using System;
using System.Collections.Generic;
using System.Web;

namespace BarsWeb.Areas.Sberutl.Infrastructure.Repository.DI.Abstract
{
    public interface IArchiveRepository
    {
        List<OBPC_SALARY_IMPORT_LOG> GetGridData(Int32 param);
    }
}