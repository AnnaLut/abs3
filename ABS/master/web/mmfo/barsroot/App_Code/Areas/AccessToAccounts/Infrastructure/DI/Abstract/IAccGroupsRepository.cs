using System.Linq;
using System.Collections.Generic;
using Areas.AccessToAccounts.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract
{
    public interface IAccGroupsRepository
    {
        IQueryable<AccGroups> GetAccGroups();
        IQueryable<IssuedAccounts> GetIssuedAccounts(decimal? grpId, decimal? ACC, string NLS);
        IQueryable<NotIssuedAccounts> GetNotIssuedAccounts(decimal? grpId, string nls);
        void addAgrp(decimal grpId, decimal acc);
        void delAgrp(decimal grpId, decimal acc);
    }
}
