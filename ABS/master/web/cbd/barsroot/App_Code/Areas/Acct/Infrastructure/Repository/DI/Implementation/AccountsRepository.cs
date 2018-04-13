using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract;
using Areas.Acct.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Implementation
{
    public class AccountsRepository : IAccountsRepository
    {
        readonly AcctEntities _entities;

        private string GetUserBranch()
        {
            const string sql = @"select 
                                    sys_context('bars_context', 'user_branch') 
                                from 
                                    dual";
            return _entities.ExecuteStoreQuery<string>(sql).FirstOrDefault();
        }

        public AccountsRepository(IAcctModel model)
        {
		    _entities = model.AcctEntities;
        }
        public IQueryable<V_TOBO_ACCOUNTS_LITE> GetAccounts()
        {
            string branch = GetUserBranch();
            return GetAccounts(branch);
        }
        public IQueryable<V_TOBO_ACCOUNTS_LITE> GetAccounts(string branch)
        {
            object[] parameters =         
            { 
                new OracleParameter("p_branch",OracleDbType.Varchar2).Value=branch
            };
            //_entities.Connection.Open();
            return _entities.V_TOBO_ACCOUNTS_LITE.Where(i => i.BRANCH == branch);//.Where("it.BRANCH = :p_branch", parameters);
        }

        public ACCOUNT GetAccount(int id)
        {
            return _entities.ACCOUNTS.FirstOrDefault(i => i.ACC == id);
        }






        public List<GROUPS_ACC> GetGroupsAcc(int id)
        {
            object[] parameters = 
                    { 
                        new OracleParameter("p_acc",OracleDbType.Decimal).Value=id
                    };
            string sql = "SELECT * FROM groups_acc g where g.id in (select * from table(sec.getAgrp(:p_acc)))";
            return _entities.ExecuteStoreQuery<GROUPS_ACC>(sql, parameters).ToList();
        }

        public IQueryable<GROUPS_ACC> GetGroupsAccNotInGroupsAccs(int id)
        {
            var group = GetGroupsAcc(id).Select(it=>it.ID);
            return _entities.GROUPS_ACC.Where(i=> !group.Contains(i.ID)).OrderBy(i => i.ID);
        }
        public IQueryable<GROUPS_ACC> GetHandbookGroupsAcc()
        {
            return _entities.GROUPS_ACC.OrderBy(i => i.ID);
        }
        /*
		public object[] GetRates(string[] data)
		{
			object[] obj = new object[3];
			DataSet ds = new DataSet();
			DataSet ds_list = new DataSet();
			int count = 0;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string order = data[3];
				string acc = data[0];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				int tarifSchemeId = 0;
				string tarifSchemeName = string.Empty;

				// определяем есть ли схема тарифов на базе
				bool isTarifScheme = Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM ALL_OBJECTS WHERE OBJECT_NAME = 'TARIF_SCHEME' and OBJECT_TYPE = 'TABLE'"));
				SetParameters("p_acc", BarsWebService.DB_TYPE.Decimal, acc, BarsWebService.DIRECTION.Input);

				if (isTarifScheme)
				{
					ArrayList reader = SQL_reader(@"select t.id, t.name
							 from tarif_scheme t, accountsw w
							 where w.acc = :nAcc and w.tag = 'SHTAR' and trim(w.value) = to_char(t.id)");
					if (reader.Count > 0)
					{
						tarifSchemeId = Convert.ToInt32(reader[0]);
						tarifSchemeName = Convert.ToString(reader[1]);
					}

					ds_list = SQL_SELECT_dataset(@"SELECT a.kod kod, a.tar tar, a.pr pr, a.smin smin, a.smax smax, TO_CHAR(a.bdate,'DD/MM/YYYY')  bdat, TO_CHAR(a.edate,'DD/MM/YYYY') edat 
											   FROM v_acc_tarif a
											   WHERE a.acc=:p_acc");
					ClearParameters();
					count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from tarif"));
					SetParameters("tarifSchemeId", DB_TYPE.Decimal, tarifSchemeId, DIRECTION.Input);
					ds = SQL_SELECT_dataset(@"SELECT a.kod kod, a.name name, b.lcv lcv, a.smin smin, a.tar tar, a.pr pr,a.smax smax, '' bdat, '' edat  
										 FROM v_sh_tarif a, tabval b
										 WHERE a.kv=b.kv and a.id=:tarifSchemeId order by " + order, startpos, pageSize);
				}
				else
				{
					ds_list = SQL_SELECT_dataset(@"SELECT b.kod kod, a.tar tar, a.pr pr, a.smin smin, a.smax smax, TO_CHAR(a.bdate,'DD/MM/YYYY')  bdat, TO_CHAR(a.edate,'DD/MM/YYYY') edat 
											   FROM acc_tarif a, tarif b 
											   WHERE a.kod(+)=b.kod AND a.acc(+)=:p_acc");
					ClearParameters();
					count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from tarif"));

					ds = SQL_SELECT_dataset(@"SELECT a.kod kod, a.name name, b.lcv lcv, a.smin smin, a.tar tar, a.pr pr,a.smax smax, '' bdat, '' edat  
										 FROM tarif a, tabval b
										 WHERE a.kv=b.kv order by " + order, startpos, pageSize);
				}
				DataRow row = null;
				DataRow row_list = null;
				for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
				{
					row = ds.Tables[0].Rows[i];
					row_list = ds_list.Tables[0].Select("kod=" + row["kod"])[0];
					if (row_list["tar"].ToString() != "") row["tar"] = row_list["tar"];
					if (row_list["pr"].ToString() != "") row["pr"] = row_list["pr"];
					if (row_list["smin"].ToString() != "") row["smin"] = row_list["smin"];
					if (row_list["smax"].ToString() != "") row["smax"] = row_list["smax"];
					row["bdat"] = row_list["bdat"];
					row["edat"] = row_list["edat"];
				}
				ds.Tables[0].AcceptChanges();
				obj[0] = ds.GetXml();
				obj[1] = count;
				obj[2] = tarifSchemeName;
				return obj;
			}
			catch (System.Exception ex)
			{
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}*/
        public IQueryable<V_SH_TARIF> GetAccountTarif(int id, DataSourceRequest request)
        {
            object[] parameters = 
                    { 
                        new OracleParameter("p_acc",OracleDbType.Decimal).Value=id
                    };
            /*var reader = _entities.ExecuteStoreQuery<TARIF_SCHEME>(@"select *
							 from tarif_scheme t, accountsw w
							 where w.acc = :p_acc 
                                and w.tag = 'SHTAR' 
                                and trim(w.value) = to_char(t.id)",parameters).FirstOrDefault() ??
                         new TARIF_SCHEME {ID = 0, NAME = string.Empty};*/
            var accW = _entities.ACCOUNTSWs.FirstOrDefault(i => i.ACC == id && i.TAG == "SHTAR");
            decimal tarifSchemeId = 0;
            if (accW != null)
            {
                decimal accwShtar = Convert.ToDecimal(accW.VALUE);
                var tarifScheme = _entities.TARIF_SCHEME.FirstOrDefault(i => i.ID == accwShtar);
                if (tarifScheme != null)
                {
                    tarifSchemeId = tarifScheme.ID;
                }
            }

            //var dsList = _entities.ExecuteStoreQuery<V_ACC_TARIF>(@"SELECT * FROM v_acc_tarif a WHERE a.acc=:p_acc",parameters);
            var dsList = _entities.V_ACC_TARIF.Where(i => i.ACC == id);
            var ds = _entities.V_SH_TARIF.Where(i => i.ID == tarifSchemeId);
            var dsResult = ds.ToDataSourceResult(request);
            var dsResultData = dsResult.Data;

            foreach (var row in (IEnumerable<V_SH_TARIF>)dsResultData)
            {
                var rowList = dsList.FirstOrDefault(i=>i.KOD == row.KOD);
                if (rowList != null)
                {
                    if (rowList.TAR != null) row.TAR = rowList.TAR;    
                    if (rowList.PR != null) row.PR = rowList.PR;
                    if (rowList.SMIN != null) row.SMIN = rowList.SMIN;
                    if (rowList.SMAX != null) row.SMAX = rowList.SMAX;  
                    row.BDATE = rowList.BDATE;
                    row.EDATE = rowList.EDATE;
                }

            }

            /*var accW = _entities.ACCOUNTSWs.FirstOrDefault(i => i.ACC == id && i.TAG == "SHTAR");
            var tarifScheme = _entities.TARIF_SCHEME.FirstOrDefault(i=> i.ID.ToString().Trim() == accW.VALUE.Trim());*/

            return null;
            /*if (reader.Count > 0)
            {
                tarifSchemeId = Convert.ToInt32(reader[0]);
                tarifSchemeName = Convert.ToString(reader[1]);
            }

            var ds_list = _entities.ExecuteStoreQuery<V_ACC_TARIF>(@"SELECT a.kod kod, 
                                                    a.tar tar, 
                                                    a.pr pr,
                                                    a.smin smin, 
                                                    a.smax smax, 
                                                    a.bdate, 
                                                    a.edate 
											   FROM v_acc_tarif a
											   WHERE a.acc=:p_acc",parameters);
            var count = _entities.TARIFs.Count();
            SetParameters("tarifSchemeId", BarsWebService.DB_TYPE.Decimal, tarifSchemeId, BarsWebService.DIRECTION.Input);

            var tarif = (from item in _entities.
                                    join w in _entities.ACCOUNTSWs
                                        on item.ID.ToString() equals w.VALUE
                                where w.ACC== id && w.TAG == "SHTAR"
                                select item);

            ds = SQL_SELECT_dataset(@"SELECT a.kod kod, a.name name, b.lcv lcv, a.smin smin, a.tar tar, a.pr pr,a.smax smax, '' bdat, '' edat  
										 FROM v_sh_tarif a, tabval b
										 WHERE a.kv=b.kv and a.id=:tarifSchemeId order by " + order, startpos, pageSize);*/
        }
    }
}