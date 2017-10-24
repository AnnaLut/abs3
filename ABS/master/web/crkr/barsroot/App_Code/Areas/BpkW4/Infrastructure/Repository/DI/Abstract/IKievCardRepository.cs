using BarsWeb.Areas.BpkW4.Models;
using System.Linq;
using System.Collections.Generic;
using Areas.BpkW4.Models;
using Kendo.Mvc.UI;


namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract 
{
    public interface IKievCardRepository
    {
        decimal ImportKievCardProjects(string extractPath);
        IEnumerable<KievCardImported> GetImportedProjects(decimal id);
        IQueryable<STAFF> GetStaff(string branch);
        IQueryable<V_W4_PRODUCTGRP_KK> GetGroups();
        IQueryable<V_W4_PRODUCT_KK> GetOtherProducts(string prodGrp);
        IQueryable<V_BPK_PROECT_KK> GetSalaryProducts(string prodGrp);
        IQueryable<V_W4_CARD_KK> GetCards(string product);
        Ticket SaveFile(PackageParams fileParams);
        IEnumerable<OwSalaryData> GetSalaryData(decimal fileId, DataSourceRequest request);
        string GetReceiptForFile(decimal fileId);
    }
}