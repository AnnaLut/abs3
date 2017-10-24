using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.CTRV.Infrastructure.Repository.DI.Abstract
{
    public interface ICheckServerConnRepository
    {
        string GetStatus();
    }
}
