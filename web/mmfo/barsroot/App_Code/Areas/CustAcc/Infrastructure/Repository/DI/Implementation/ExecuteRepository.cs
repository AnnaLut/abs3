using Bars.Classes;
using BarsWeb.Areas.CustAcc.Models;
using Oracle.DataAccess.Client;
using System.Data;
using Oracle.DataAccess.Types;
using System;
using BarsWeb.Areas.Ndi.Infrastructure;

namespace BarsWeb.Areas.CustAcc.Infrastructure.Repository.DI.Implementation
{
    public class ExecuteRepository : IExecuteRepository
    {
        private CustAcc _entities;
        public CheckResult NbsReservCheck(decimal acc, string nbs)
        {
            CheckResult result = new CheckResult();
            string _msg = String.Empty;
            string _nbs = nbs.IsNullOrEmpty() ? "" : nbs;

            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.accreg.check_user_permissions", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_acc", OracleDbType.Decimal, acc, ParameterDirection.Input);
                command.Parameters.Add("p_nbs", OracleDbType.Varchar2, _nbs, ParameterDirection.Input);

                OracleParameter rez = new OracleParameter("p_rez", OracleDbType.Decimal,
                    ParameterDirection.InputOutput);
                command.Parameters.Add(rez);

                command.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000, _msg, ParameterDirection.InputOutput);

                command.ExecuteNonQuery();

                result.rez = ((OracleDecimal)rez.Value).Value;
                result.msg = Convert.ToString(command.Parameters["p_msg"].Value);

                return result;
            }
            finally
            {
                connection.Close();   
            }
        }
    }
}