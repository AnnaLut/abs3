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
    public class KrnModuleVersionsRepository : IKrnModuleVersionsRepository
    {
        private KernelContext _entities;
        public KrnModuleVersionsRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Kernel", "Kernel");
            _entities = new KernelContext(connectionStr);
        }
        public IQueryable<KRN_MODULE_VERSIONS> GetKrnModuleVersionsList()
        {
            var list = _entities.KRN_MODULE_VERSIONS;
            return list.AsQueryable();
        }
    }
}
