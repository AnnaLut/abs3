using Areas.BpkW4.Models;
using Bars.Oracle;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Web;
public class AcceptAccRepository : IAcceptAccRepository
{
    public void DenyAcceptAcc(ReserveAccsKeys keys)
    {
        OracleConnection connect = new OracleConnection();

        bool txCommitted = false;

        IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
        connect = conn.GetUserConnection();
        var msg = "";

        OracleTransaction tx = connect.BeginTransaction();
        try
        {
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "BEGIN " +
							 " ACCREG.REJECT_RESERVE_ACC( :p_nls, :p_kv, :p_errmsg);  " +
                             " end; ";
			foreach (decimal kv in keys.KV)
            {
                cmd.Parameters.Clear();
				cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, keys.NLS, ParameterDirection.Input);
				cmd.Parameters.Add("p_kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
                cmd.Parameters.Add("p_errmsg", OracleDbType.Decimal, msg, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }


            tx.Commit();
            txCommitted = true;
        }
        finally
        {
            if (!txCommitted) tx.Rollback();

            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}