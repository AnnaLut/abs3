using Areas.PRVN.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;
using System.Web;

namespace BarsWeb.Areas.PRVN.Infrastructure.DI.Abstract
{
    public interface ISrrCostRepository
    {
        List<InsertRowResult> UploadSrrCostFile(HttpPostedFile file);
    }
}