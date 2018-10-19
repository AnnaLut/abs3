using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using Areas.Reporting.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using Telerik.Web.UI;
using BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.ReserveAccs.Models;
using Bars.Classes;
using System.Data;
using BarsWeb.Areas.Acct.Models.Bases;
using BarsWeb.Areas.ReserveAccs.Models.Bases;
using Dapper;
using BarsWeb.Areas.BpkW4.Models;
using System.Threading.Tasks;
using Bars.Web.Report;
using System.Web.Services;

namespace BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Implementation
{
    public class ReserveAccsRepository : IReserveAccsRepository
    {
        public decimal Reserved(ReservedAccountRegister account)
        {
			using (OracleConnection connect = OraConnector.Handler.UserConnection)
			{
				var transaction = connect.BeginTransaction();
				try
				{
					if (account.Tarriff == null)
					{
						if (!String.IsNullOrEmpty(account.mainCurr))
						{
							var sql = String.Format("select aw.value from ACCOUNTSW aw join accounts a on a.acc = aw.acc and a.nls = '{0}' and a.kv = {1} and aw.tag = 'SHTAR'", account.Number, account.mainCurr);
							account.Tarriff = connect.Query<decimal?>(sql).SingleOrDefault();
						}
					}

					using (OracleCommand cmdInsertInfo = connect.CreateCommand())
					{
						//cmdInsertInfo.CommandText = @"begin accreg.p_reserve_acc"
						cmdInsertInfo.CommandText = @"begin accreg.RSRV_ACC_NUM(
																	:p_nls,
																	:p_kv,
																	:p_nms,
																	:p_branch,
																	:p_isp,
																	:p_vid,
																	:p_rnk,
																	:p_agrm_num,
																	:p_trf_id,
																	:p_ob22,
																	:p_errmsg); end;";

						cmdInsertInfo.BindByName = true;
						var array_kvs = account.CurrencyId.Split(',');
						var err_msg = "";
						foreach (var kv in array_kvs)
						{
							cmdInsertInfo.Parameters.Clear();
							cmdInsertInfo.Parameters.Add("p_nls", OracleDbType.Varchar2, account.Number, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_kv", OracleDbType.Decimal, Convert.ToDecimal(kv), ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_nms", OracleDbType.Varchar2, account.Name, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_branch", OracleDbType.Varchar2, account.Branch, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_isp", OracleDbType.Decimal, account.UserId == null ? GetIsp(connect) : account.UserId, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_vid", OracleDbType.Decimal, account.ddVid, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_rnk", OracleDbType.Decimal, account.CustomerId, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_agrm_num", OracleDbType.Varchar2, account.ND, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_trf_id", OracleDbType.Decimal, account.Tarriff, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_ob22", OracleDbType.Varchar2, account.Ob22, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 4000, err_msg, ParameterDirection.Output);
							cmdInsertInfo.ExecuteNonQuery();

							err_msg = Convert.ToString(cmdInsertInfo.Parameters["p_errmsg"].Value);
							if (err_msg != "null")
								throw new Exception(err_msg);
						}
						transaction.Commit();
						return Convert.ToDecimal(Convert.ToString(cmdInsertInfo.Parameters["p_nls"].Value));
					}
				}
				catch (Exception ex)
				{
					transaction.Rollback();
					throw ex;
				}
			}
        }
        public List<SpecParamList> GetSpecParamList()
        {
            List<SpecParamList> list = new List<SpecParamList>();
            OracleConnection connect = new OracleConnection();
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {

                OracleCommand cmdInfo = connect.CreateCommand();

                cmdInfo.CommandText = @"select spid ID, semantic NAME from sparam_list";
                cmdInfo.BindByName = true;

                OracleDataReader iReader = cmdInfo.ExecuteReader();

                while (iReader.Read())
                {
                    SpecParamList sparam = new SpecParamList();
                    if (!iReader.IsDBNull(0))
                        sparam.ID = Convert.ToString(iReader.GetOracleDecimal(0).Value);
                    if (!iReader.IsDBNull(1))
                        sparam.NAME = Convert.ToString(iReader.GetOracleString(1).Value);
                    list.Add(sparam);
                }

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
        }
        public String GetNDBO(Decimal rnk)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand cmd = connection.CreateCommand();
                try
                {
                    // check parameter first
                    cmd.CommandText = "select kl.get_customerw(:p_rnk, 'NDBO') from dual";
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                    var dboNum = Convert.ToString(cmd.ExecuteScalar());
                    return dboNum;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        public List<string> Activate(ReserveAccsKeys keys)
        {
            bool txCommitted = false;
			var result_acc = new List<string>();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleTransaction tx = connection.BeginTransaction();
                try
                {
                    foreach (decimal kv in keys.KV)
                    {
						//String ob22 = GetOb22(connection, id);
						string t_acc = "";
                        OracleCommand cmd = connection.CreateCommand();
						cmd.Transaction = tx;
                        cmd.CommandText = @"begin 
                                                accreg.p_unreserve_acc(:p_nls, :p_kv, :p_acc);
                                             end;";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, keys.NLS, ParameterDirection.Input);
						cmd.Parameters.Add("p_kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
						cmd.Parameters.Add("p_acc", OracleDbType.Decimal, t_acc, ParameterDirection.Output);
                        cmd.ExecuteNonQuery();
						result_acc.Add(t_acc);
					}
                    tx.Commit();
                    txCommitted = true;
                }
                catch (Exception e)
                {
                    if (e.Message.StartsWith("ORA-20000"))
                    {
                        var mess = e.Message.Substring(10, e.Message.Length - 11);
                        var indexOra = mess.IndexOf("ORA", StringComparison.Ordinal);
                        int length;
                        if (indexOra != -1)
                        {
                            length = indexOra;
                        }
                        else
                        {
                            length = mess.Length;
                        }
                        mess = mess.Substring(0, length);
                        throw new Exception(mess);
                    }
                    throw;
                }
                finally
                {
                    if (!txCommitted) tx.Rollback();
                }
				return result_acc;
			}
        }
        private String GetOb22(OracleConnection connection, Decimal accountId)
        {
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandText = "select ob22 from accounts where acc = :p_acc";
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, accountId, ParameterDirection.Input);
                var ob22 = Convert.ToString(cmd.ExecuteScalar());
                return ob22;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private Decimal GetIsp(OracleConnection connection)
        {
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                // check parameter first
                cmd.CommandText = "select user_id from dual";
                var isp = Convert.ToDecimal(cmd.ExecuteScalar());
                return isp;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
		public List<Models.Bases.ReservedAccountBase> GetReadyEtalonAccounts(ReservedKey key)
		{
			var sql = String.Format("select acc as \"Id\", nls as \"Number\", kv as \"CurrencyId\", nms as \"Name\", rnk as \"CustomerId\" from accounts where nls = {0} and rnk = {1} and dazs is null", key.nls, key.rnk);
			using (var connection = OraConnector.Handler.UserConnection)
			{
				return connection.Query<Models.Bases.ReservedAccountBase>(sql).ToList();
			}
		}
		public List<V_RESERVED_ACC> GetReservedAccounts(ReservedKey key)
		{
			var sql = String.Format("select * from V_RESERVED_ACC where nls = {0} and rnk = {1}", key.nls, key.rnk);
			using (var connection = OraConnector.Handler.UserConnection)
			{
				return connection.Query<V_RESERVED_ACC>(sql).ToList();
			}
		}
		public void AcceptWithDublication(ReservedDublicateAccKey key)
		{
			using (var connection = OraConnector.Handler.UserConnection)
			{
				var transaction = connection.BeginTransaction();
				using (var cmdInsertInfo = connection.CreateCommand())
				{
					cmdInsertInfo.Transaction = transaction;
					cmdInsertInfo.CommandText = @"begin accreg.UNRSRV_ACC(
													 :p_acc, 
													 :p_kv,
													 :p_errmsg ); end;";
					try
					{
						var err_msg = "";
						foreach (var kv in key.kv)
						{
							cmdInsertInfo.Parameters.Clear();
							cmdInsertInfo.Parameters.Add("p_acc", OracleDbType.Decimal, key.acc, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
							cmdInsertInfo.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 4000, err_msg , ParameterDirection.Output);
							cmdInsertInfo.ExecuteNonQuery();
		
							err_msg = Convert.ToString(cmdInsertInfo.Parameters["p_errmsg"].Value);
							if (err_msg != "null")
							{
								throw new Exception(err_msg);
							}
						}
						transaction.Commit();
					}
					catch (Exception ex)
					{
						transaction.Rollback();
						throw ex;
					}
				}
			}
		}
        public decimal GetCreatedAccNLSKV(string nls, int? kv)
        {
            var sql = String.Format("select a.acc from accounts a where a.nls = '{0}'  and a.kv = {1}", nls, kv);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<decimal>(sql).SingleOrDefault();
            }
        }
		public string PrintDoc(ReservedPrintKey key)
		{
			string fileName = string.Empty;
			ReservedRtfReporter rep = new ReservedRtfReporter(new WebService().Context);
			rep.RoleList = "reporter,cc_doc";
			rep.resNls = key.nls;
			rep.resKv = key.kv;

			rep.TemplateID = key.templateId;
			using (var connection = OraConnector.Handler.UserConnection)
			{
				var sql = String.Format("select RSRV_ID from v_reserved_acc a where a.nls = '{0}' and a.kv = {1}", key.nls, key.kv);
				var reserve_id = connection.Query<int>(sql).SingleOrDefault();
				rep.ContractNumber = Convert.ToInt64(reserve_id);
			}

			rep.GenerateReserveReport();
			var tmp = rep.ReportFile;
			return tmp;

		}
		public List<SpecParamList> GetPrintDocs()
		{
			var sql = @"select d.ID, d.NAME from doc_scheme d where d.id like 'RSRV_%'";
			using (var connection = OraConnector.Handler.UserConnection)
			{
				return connection.Query<SpecParamList>(sql).ToList();
			}
		}
	}
}

