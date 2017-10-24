using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Doc.Models;

namespace BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract
{
    public interface IAdvertisingRepository
    {
        IQueryable<TicketsAdvertising> GetAllAdvertising();
        TicketsAdvertising GetAdvertising(int id);
        int AddAdvertising(TicketsAdvertising advertising);
        int EditAdvertising(TicketsAdvertising advertising);
        void UpdateBranchList(int id, IEnumerable<string> branchList);
        decimal? ValidateIsExistAdvertising(decimal? id, DateTime? dateBagin, DateTime? dateEnd, string branch, string transactionCodeList);
        bool DeleteAdvertising(int id);
        /*DateTime GetBankDate();*/
    }
}
