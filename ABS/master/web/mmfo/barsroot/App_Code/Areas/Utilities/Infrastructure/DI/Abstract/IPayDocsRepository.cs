using System;
using BarsWeb.Areas.Utilities.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.Utilities.Infrastructure.DI.Abstract
{
    public interface IPayDocsRepository
    {
        List<KFList> GetKF();
        string PaySelectedDocs(List<string> list_kf);
    }
}