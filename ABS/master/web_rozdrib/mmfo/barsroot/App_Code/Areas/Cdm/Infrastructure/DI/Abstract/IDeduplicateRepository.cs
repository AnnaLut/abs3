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
        DupMainCard GetMainCard(decimal rnk);
        IEnumerable<DupChildCard> GetChildCards(decimal rnk);
        IEnumerable<AttrGroup> GetAttrGroups(decimal rnk);
        IEnumerable<AttributeMainCard> GetCardAttributes(decimal rnk);
        void SetCardAsMaster(decimal mRnk, decimal dRnk);
        void IgnoreChild(decimal mRnk, decimal dRnk);
        void MergeDupes(decimal mRnk, decimal dRnk);
        void MoveAttributesFromChild(decimal rnk, string[] attributes, string[] values);
        EBK_GCIF GetGcif(decimal rnk, string kf = null);
    }
}
