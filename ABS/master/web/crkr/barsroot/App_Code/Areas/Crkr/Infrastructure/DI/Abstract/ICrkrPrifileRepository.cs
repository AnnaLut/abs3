using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Crkr.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface ICrkrProfileRepository
    {
        List<CrcaProfile> GetProfiles(CrkrBag model, [DataSourceRequest] DataSourceRequest request);
        List<object> GetClients(ClientSearch model);
    }
}