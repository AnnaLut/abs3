using System.Collections.Generic;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract
{
    public interface IDeduplicateRepository
    {
        IEnumerable<DupGroup> RequestEbkClient(DupGroupParams groupParams, DataSourceRequest request);
        decimal RequestEbkClientCount(DupGroupParams groupParams, DataSourceRequest request);
        DupMainCard GetMainCard(decimal rnk, string type);
        IEnumerable<DupChildCard> GetChildCards(decimal rnk, string type);
        IEnumerable<AttrGroup> GetAttrGroups(decimal rnk, string type);
        IEnumerable<AttributeMainCard> GetCardAttributes(decimal rnk, string type);
        void SetCardAsMaster(decimal mRnk, decimal dRnk, string type);
        void IgnoreChild(decimal mRnk, decimal dRnk, string type);
        void MergeDupes(decimal mRnk, decimal dRnk, string type);
        void MoveAttributesFromChild(decimal rnk, string[] attributes, string[] values, string type);
        string GetGcif(decimal rnk, string kf);
    }
}
