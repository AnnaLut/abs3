using Areas.CustomerList.Models;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using Dapper;
using Bars.Classes;
using System.Text;

namespace BarsWeb.Areas.CustomerList.Infrastructure.DI.Implementation
{
	public class AccountsSpecparamRepository : IAccountsSpecparamRepository
	{
		public IEnumerable<AccSpecparamDTI> GetAccounts(AccountsSparamcustfilterDTI externFilter)
		{
			var query = new StringBuilder(@"select * from V_ACCOUNTS_SPECPARCUST v where 1=1 ");
			if (!String.IsNullOrEmpty(externFilter.metaFilter))
				query.Append(" AND " + externFilter.metaFilter);

			if (externFilter.Custtype != null)
				query.Append(String.Format(" AND v.custtype = {0}", externFilter.Custtype));
			else
				throw new Exception("Не задано тип контрагента(custtype), перевірте налаштування запуску функції");
			
			
			if (!String.IsNullOrEmpty(externFilter.nls))
				query.Append(String.Format(" AND v.NLS like '{0}%'", externFilter.nls));
			if (!String.IsNullOrEmpty(externFilter.branch))
				query.Append(String.Format(" AND v.BRANCH like '{0}%'", externFilter.branch));
			if (!String.IsNullOrEmpty(externFilter.nms))
				query.Append(String.Format(" AND v.NMS) like '%{0}%'", externFilter.nms));
			if (!String.IsNullOrEmpty(externFilter.ob22))
				query.Append(String.Format(" AND v.OB22 = '{0}'", externFilter.ob22));
			if (!String.IsNullOrEmpty(externFilter.rnk))
				query.Append(String.Format(" AND v.RNK = {0}", externFilter.rnk));
			if (externFilter.kv != null)
				query.Append(String.Format(" AND v.KV = {0}", externFilter.kv));
			if (!externFilter.showClosed)
				query.Append(String.Format(" AND v.DAZS is null", externFilter.rnk));

			var resultSet = new List<AccSpecparamDTI>();
			using (IDbConnection db = OraConnector.Handler.IOraConnection.GetUserConnection())
			{
				return db.Query<AccSpecparamDTI>(query.ToString()).ToList();
			}
		}

		public IEnumerable<BranchDTI> GetAvaliableBranchList()
		{
			var query = @"select BRANCH, NAME 
							from branch 
							where branch like sys_context('bars_context','user_branch_mask') and date_closed is null order by branch asc";
			using (IDbConnection db = OraConnector.Handler.IOraConnection.GetUserConnection())
			{
				return db.Query<BranchDTI>(query).ToList();
			}
		}
		public IEnumerable<OB22DTI> GetAvaliableOb22List()
		{
			var query = "select OB22, CONCAT(OB22,CONCAT(' - ',NAME)) as \"NAME\" from v_sb_ob22";
			using (IDbConnection db = OraConnector.Handler.IOraConnection.GetUserConnection())
			{
				return db.Query<OB22DTI>(query).ToList();
			}
		}
	}
}