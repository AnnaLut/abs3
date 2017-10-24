using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface ISecAuditRepository
    {
        IEnumerable<SecAudit> GetSecAuditData(DataSourceRequest request, string filter);

        decimal GetSecAuditCount(DataSourceRequest request, string filter);

        void InitSecAuditSql(string filter);
    }
}
