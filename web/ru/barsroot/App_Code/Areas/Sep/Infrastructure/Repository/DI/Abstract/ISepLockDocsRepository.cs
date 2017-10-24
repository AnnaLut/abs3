using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepLockDocsRepository
    {
        decimal GetSepLockDocCount(int DefCode, int Code, DataSourceRequest request);        
        IQueryable<SepLockDoc> GetSepLockDoc(int DefCode, int Code, DataSourceRequest request);
        decimal GetSepLockDocResource(DataSourceRequest request);
        bool DeleteSepLockDocs(List<SepLockDoc> Docs, DataSourceRequest request);
        bool DeleteSepLockDocsByCode(int DefCode, int Code, DataSourceRequest request);
        bool ReturnSepLockDocs(string Reason, List<SepLockDoc> Docs, DataSourceRequest request);
        bool ReturnSepLockDocsByCode(string Reason, int DefCode, int Code, DataSourceRequest request);
        bool UnlockSepLockDocs(List<SepLockDoc> Docs, DataSourceRequest request);
        bool UnLockSepLockDocsByCode(int DefCode, int Code, DataSourceRequest request);
        bool UnlockSepDocsTo902(List<SepLockDoc> Docs, DataSourceRequest request);
        bool UnlockSepDocsTo902ByCode(int DefCode, int Code, DataSourceRequest request);
        bool isValidUserBankDate();
    }
}