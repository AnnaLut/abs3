using Bars.Classes;
using BarsWeb.Areas.CustAcc.Models;
using Oracle.DataAccess.Client;
using System.Data;
using Oracle.DataAccess.Types;
using System;
using BarsWeb.Areas.Ndi.Infrastructure;
using Bars.WebServices.GercPayModels.OracleHelper;

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
                OracleCommand command = new OracleCommand("bars.p_nbs_reserv_check", connection);
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
        public int IsUserBackOffice()
        {
            int group_cnt = 0;
			using (OracleConnection connection = OraConnector.Handler.UserConnection)
			{
				using (OracleCommand cmd = new OracleCommand())
				{
					cmd.CommandText = @"select count(*) idgs 
											from GROUPS_staff 
												where idu = ( select bars.user_id user_id
																from params$base
																	where par = 'REGNCODE'
																		and rownum = 1 )				
													  and idg in (1018, 1020, 1044, 1025)";     //1044 WAY4-АБС
																								//1018 Підрозділ бек-офісу
																								//1020 Група технологів
					cmd.CommandType = CommandType.Text;
					cmd.Connection = connection;

					using (OracleDataReader reader = cmd.ExecuteReader())
					{
						while (reader.Read())
						{
							group_cnt += Convert.ToInt32(reader["idgs"].ToString());
						}
					}
				}
			}
			return group_cnt;
        }
    }
}