using Areas.CustomerList.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.CustomerList.Infrastructure.DI.Abstract
{
	public interface IAccountsSpecparamRepository
	{
		IEnumerable<AccSpecparamDTI> GetAccounts(AccountsSparamcustfilterDTI externFilter);
		IEnumerable<BranchDTI> GetAvaliableBranchList();
		IEnumerable<OB22DTI> GetAvaliableOb22List();

	}
}