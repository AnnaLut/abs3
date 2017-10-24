using System.Collections.Generic;
using BarsWeb.Areas.Admin.Models.ListSet;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Summary description for IListSetRepository
    /// </summary>
    public interface IListSetRepository
    {
        #region ListSet Data

        IEnumerable<LIST_SET> ListSetData(DataSourceRequest request);
        decimal CountListSetData(DataSourceRequest request);

        #endregion

        #region List_funcset Data

        IEnumerable<LIST_FUNCSET> ListFuncsetData(DataSourceRequest request, decimal setId);
        decimal CountListFuncsetData(DataSourceRequest request, decimal setId);

        #endregion

        #region Operlist_handbook Data 

        IEnumerable<OPERLIST_Handbook> OperlistHandbook(DataSourceRequest request, decimal setId);
        decimal CountOperlistHandbook(DataSourceRequest request, decimal setId);

        #endregion

        #region ListSetTools

        void CreateSet(string name, string comment);
        void DropSet(decimal id);
        void UpdateSet(decimal id, string name, string comm);

        #endregion

        #region ListFuncSerTools

        void AddFuncToSet(decimal setId, decimal functionId);
        void DropFuncFromSet(decimal setId, decimal functionId);
        void UpdateFunc(decimal setId, decimal functionId, decimal functionActivity, string functionComments);
        void UpdateFuncPosition(decimal setId, decimal functionId, decimal functionPosition);

        #endregion
    }
}