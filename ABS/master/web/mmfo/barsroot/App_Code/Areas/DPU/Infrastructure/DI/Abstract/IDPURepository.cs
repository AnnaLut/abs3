using System.Collections.Generic;
using System.Linq;
using Areas.DptAdm.Models;
using BarsWeb.Areas.DptAdm.Models;
using System.Web.Mvc;
using BarsWeb.Areas.DPU.Models;

namespace BarsWeb.Areas.DPU.Infrastructure.DI.Abstract
{
    public interface IDPURepository
    {
        void BeforeStart();
        List<T> GetDataForGrid<T>(dynamic id);
        List<T> GetDataForDocGrid<T>();
        void DeleteRow(dynamic acc, dynamic ref1);
        void PayBack(dynamic row);
        void CreditedAmount(dynamic row, dynamic acc);
    }
}