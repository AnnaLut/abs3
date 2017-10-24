
using BarsWeb.Areas.Admin.Models.CommunicationObject;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface ICommunicationObjectRepository
    {
        List<CommObjDropDown> GetDropDownCommObj();

        List<CommObj> GetCommObjGrid([DataSourceRequest]DataSourceRequest request, int id);

        decimal GetCommObjDataCount([DataSourceRequest]DataSourceRequest request, int id);
    }
}
