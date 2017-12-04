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

namespace BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Implementation
{
    public class ReserveAccsRepository : IReserveAccsRepository
    {

        public decimal Reserved(ReservedAccountRegister account)
        {
            bool txCommitted = false;
            OracleConnection connect = new OracleConnection();
            decimal? acc = null;
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            var transaction = connect.BeginTransaction();
            try
            {

                OracleCommand cmdInsertInfo = connect.CreateCommand();

                cmdInsertInfo.CommandText = @"begin accreg.p_reserve_acc (
                            :p_acc,
                            :p_rnk,
                            :p_nls,     
                            :p_kv,       
                            :p_nms,      
                            :p_tip,      
                            :p_grp,      
                            :p_isp,      
                            :p_pap,      
                            :p_vid,      
                            :p_pos,      
                            :p_blkd,     
                            :p_blkk,     
                            :p_lim,     
                            :p_ostx,     
                            :p_nlsalt,          
                            :p_branch,
                            :p_ob22,
                            :p_agrm_num,
                            :p_trf_id); end;";
                cmdInsertInfo.BindByName = true;
                var array_kvs = account.CurrencyId.Split(',');

                foreach (var kv in array_kvs)
                {
                    cmdInsertInfo.Parameters.Clear();
                    cmdInsertInfo.Parameters.Add("p_acc", OracleDbType.Decimal, 38, acc, ParameterDirection.InputOutput);
                    cmdInsertInfo.Parameters.Add("p_rnk", OracleDbType.Decimal, account.CustomerId, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_nls", OracleDbType.Varchar2, account.Number, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_kv", OracleDbType.Decimal, Convert.ToDecimal(kv), ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_nms", OracleDbType.Varchar2, account.Name, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_tip", OracleDbType.Char, account.Type, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_grp", OracleDbType.Decimal, account.Group, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_isp", OracleDbType.Decimal, account.UserId == null ? GetIsp(connect) : account.UserId, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_pap", OracleDbType.Decimal, account.Pap, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_vid", OracleDbType.Decimal, account.Subspecies, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_pos", OracleDbType.Decimal, account.Pos, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_blkd", OracleDbType.Decimal, account.DebitBlockCode, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_blkk", OracleDbType.Decimal, account.CreditBlockCode, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_lim", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_ostx", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_nlsalt", OracleDbType.Varchar2, 0, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_branch", OracleDbType.Varchar2, account.Branch, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_ob22", OracleDbType.Varchar2, account.Ob22, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_agrm_num", OracleDbType.Varchar2, account.ND, ParameterDirection.Input);
                    cmdInsertInfo.Parameters.Add("p_trf_id", OracleDbType.Decimal, account.Tarriff, ParameterDirection.Input);

                    cmdInsertInfo.ExecuteNonQuery();
                }
                txCommitted = true;
                transaction.Commit();
                return Convert.ToDecimal(Convert.ToString(cmdInsertInfo.Parameters["p_acc"].Value));

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (!txCommitted) transaction.Rollback();
                connect.Close();
                connect.Dispose();
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

        public void Activate(List<decimal> accountId)
        {
            bool txCommitted = false;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleTransaction tx = connection.BeginTransaction();
                try
                {


                    foreach (decimal id in accountId)
                    {
                        String ob22 = GetOb22(connection, id);
                        OracleCommand cmd = connection.CreateCommand();
                        cmd.CommandText = @"begin 
                                                accreg.p_unreserve_acc(:p_acc, 1, :p_ob22);
                                             end;";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_acc", OracleDbType.Decimal, id, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ob22", OracleDbType.Varchar2, ob22, ParameterDirection.Input);
                        cmd.ExecuteNonQuery();
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
    }
}

