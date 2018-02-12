using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract
{
    public interface IAcceptAccRepository
    {
        void DenyAcceptAcc(ReserveAccsKeys keys);
    }
}