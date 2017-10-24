using BarsWeb.Areas.DptAdm.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract
{
    public interface IAdditionalFuncRepository
    {
        void SynchronizeDeposits();
        void UpdatedDepositsFL();
        List<T> GetVDPT<T>();
        List<T> GetOperations<T>();
        void TransferSrokdeposits(dynamic OPERATION, dynamic ID);
    }
}