using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.ReserveAccs.Models;
using BarsWeb.Areas.ReserveAccs.Models.Bases;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Abstract
{
    public interface IReserveAccsRepository
    {
        decimal Reserved(ReservedAccountRegister account);
        List<SpecParamList> GetSpecParamList();
        String GetNDBO(Decimal rnk);
		List<string> Activate(ReserveAccsKeys keys);
		List<ReservedAccountBase> GetReadyEtalonAccounts(ReservedKey key);
		List<V_RESERVED_ACC> GetReservedAccounts(ReservedKey key);
		List<SpecParamList> GetPrintDocs();
		void AcceptWithDublication(ReservedDublicateAccKey key);
		decimal GetCreatedAccNLSKV(string nls, int? kv);
		string PrintDoc(ReservedPrintKey key);
	}
}
