using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Implementation
{
    public class KrnModuleRepository : IKrnModuleRepository
    {
        private KernelContext _entities;
        public KrnModuleRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Kernel", "Kernel");
            _entities = new KernelContext(connectionStr);
        }
        public IQueryable<KRN_MODULE_VRS_HIST> GetKrnModuleList() 
        {
            var list = _entities.KRN_MODULE_VRS_HIST;
            return list.AsQueryable();
        }
    }
}
