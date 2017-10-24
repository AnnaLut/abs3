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

                using (OracleCommand cmdInsertInfo = connect.CreateCommand()) { 

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
                    var array_kvs = account.CurrencyId.Split(',').Distinct().ToArray();

                    foreach (var kv in array_kvs)
                    {
                        cmdInsertInfo.Parameters.Clear();
                        cmdInsertInfo.Parameters.Add("p_acc", OracleDbType.Decimal, 38, acc, ParameterDirection.ReturnValue);
                        cmdInsertInfo.Parameters.Add("p_rnk", OracleDbType.Decimal, account.CustomerId, ParameterDirection.Input);
                        cmdInsertInfo.Parameters.Add("p_nls", OracleDbType.Varchar2, account.Number, ParameterDirection.Input);
                        cmdInsertInfo.Parameters.Add("p_kv", OracleDbType.Decimal, Convert.ToDecimal(kv), ParameterDirection.Input);
                        cmdInsertInfo.Parameters.Add("p_nms", OracleDbType.Varchar2, account.Name, ParameterDirection.Input);
                        cmdInsertInfo.Parameters.Add("p_tip", OracleDbType.Char, account.Type, ParameterDirection.Input);
                        cmdInsertInfo.Parameters.Add("p_grp", OracleDbType.Decimal, account.Group, ParameterDirection.Input);
                        cmdInsertInfo.Parameters.Add("p_isp", OracleDbType.Decimal, account.UserId, ParameterDirection.Input);
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
                }
                txCommitted = true;
                transaction.Commit();
                return Convert.ToDecimal(acc);

            }
            catch (Exception ex)
            {
                if (!txCommitted) transaction.Rollback();
                throw ex;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }

}
