using System.Collections.Generic;
using System.Linq;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Models;
using Kendo.Mvc.UI;
using DropDownList = BarsWeb.Areas.Cdm.Models.DropDownList;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract
{
    public interface IQualityRepository
    {
        IEnumerable<QualityGroup> GetQualityGroups(bool isAdminMode, string type);
        IEnumerable<QualitySubGroup> GetQualitySubGroups(string type);
        IQueryable<EBK_CUST_SUBGRP_V> GetAdvisoryList(AdvisoryListParams advisoryListParams);
        IQueryable<V_EBKC_LEGAL_SUBGRP> GetAdvisoryListLegal(AdvisoryListParams advisoryListParams);
        IQueryable<V_EBKC_PRIV_SUBGRP> GetAdvisoryListPrivate(AdvisoryListParams advisoryListParams);
        IEnumerable<EBK_CUST_SUBGRP_V> GetAdvisoryList(AdvisoryListParams advisoryListParams, DataSourceRequest request);
        IEnumerable<V_EBKC_LEGAL_SUBGRP> GetAdvisoryListLegal(AdvisoryListParams advisoryListParams, DataSourceRequest request);
        IEnumerable<V_EBKC_PRIV_SUBGRP> GetAdvisoryListPrivate(AdvisoryListParams advisoryListParams, DataSourceRequest request);
        decimal GetAdvisoryListCount(AdvisoryListParams advisoryListParams, DataSourceRequest request);
        IQueryable<EBK_CUST_ATTR_RECOMEND_V> GetCustAdvisory(decimal rnk);
        IQueryable<V_EBKC_PRIV_ATTR_RECOMEND> GetCustAdvisoryPrivate(decimal rnk);
        IQueryable<V_EBKC_LEGAL_ATTR_RECOMEND> GetCustAdvisoryLegal(decimal rnk);
        IQueryable<EBK_CARD_ATTR_GROUPS> GetAllAttrGroups();
        IQueryable<EBK_CUST_ATTR_LIST_V> GetCustAttributesList(decimal rnk);
        IQueryable<V_EBKC_LEGAL_ATTR_LIST> GetCustAttributesListLegal(decimal rnk);
        IQueryable<V_EBKC_PRIV_ATTR_LIST> GetCustAttributesListPrivate(decimal rnk);
        int SaveCustomerAttributes(IEnumerable<CustomerAttribute> attributes, string type);
        List<DropDownList> GetAllDropDownData(string type);
        IEnumerable<DropDownItem> GetDialogData(string dialogName, DataSourceRequest request);
        string LastDialogDescription();
        decimal LastDialogDataLendth();
        IEnumerable<CustomQualityGroup> GetCustomGroupsList(decimal groupId);
        void DeleteQualitySubgroup(decimal group, decimal subGroup);
        void AddSubgroup(decimal group, string sign, decimal percent);
    }
}