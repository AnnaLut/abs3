using System.Data.Objects;
using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models; 
using Kendo.Mvc.UI;
using System.Collections.Generic;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepPaymentStateRepository
    {
        List<SepPaymentStateInfo> GetSepPaymentStateInfo(SepPaymentStateFilterParams filter, DataSourceRequest request);
        ObjectResult<SepFileDoc> GetSepPaymentStateDocs(SepFileDocParams docParams, DataSourceRequest request);
        decimal GetSepPaymentStateDocsCount(SepFileDocParams p);
    }
}