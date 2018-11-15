using BarsWeb.Areas.Utilities.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Utilities.Models;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System;
using System.Data;

namespace BarsWeb.Areas.Utilities.Infrastructure.DI.Implementation
{
    public class PayDocsRepository : IPayDocsRepository
    {
        public PayDocsRepository()
        {

        }

        public List<KFList> GetKF()
        {
            List<KFList> output = new List<KFList>();
            try
            {
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = @"select kf, name from V_MV_BANKS order by kf";
                    using (OracleDataReader rdr = cmd.ExecuteReader())
                        while (rdr.Read())
                            output.Add(new KFList { KF = rdr.GetString(0), NAME = rdr.GetString(1) });

                    return output;
                }
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public string PaySelectedDocs(List<string> list_kf)
        {
            string output = "";
            try
            {
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = @"BARS.MV_PAY_DATE";
                    foreach (string kf in list_kf)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input);
                        try
                        {
                            cmd.ExecuteNonQuery();
                        }
                        catch (Exception e)
                        {
                            output += "</br><b>" + kf + "</b> :  " + e.Message + "; </br>";
                        }
                    }
                    return output;
                }
            }
            catch(Exception e)
            {
                throw new Exception(e.Message);
            }
        }
    }
}