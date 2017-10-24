using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class ADMSegmentsRepository : IADMSegmentsRepository
    {
        Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public BarsSql _getAllAPPADM;
        public ADMSegmentsRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }
        public IEnumerable<V_DWHLOG> GetDWHData()
        {            
            
            InitAllAPPADM();
           
            var result = _entities.ExecuteStoreQuery<V_DWHLOG>(@"select package_id, status, errordescription, package_type, recieved_date, bank_date from V_DWHLOG");
            return result;
        }
        public decimal CountAllAPPS()
        {
            InitAllAPPADM();
           // var a = _kendoSqlCounter.TransformSql(_getAllAPPADM, request);
            var result = _entities.ExecuteStoreQuery<decimal>(@"select package_id, status, errordescription, package_type, recieved_date, bank_date from V_DWHLOG").Single();
            return result;
        }
        private void InitAllAPPADM()
        {
            _getAllAPPADM = new BarsSql()
            {
                SqlText = string.Format(@"select package_id, status, errordescription, package_type, recieved_date, bank_date from V_DWHLOG"),
                SqlParams = new object[] { }
            };
        }
    }
}
