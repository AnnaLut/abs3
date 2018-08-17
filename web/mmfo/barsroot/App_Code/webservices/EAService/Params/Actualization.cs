using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Актуалізація ідент. документів
    /// </summary>
    public struct Actualization
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("branch_id")]
        public String BranchId;
        [JsonProperty("actual_date")]
        public DateTime ActualDate;
        [JsonProperty("user_login")]
        public String UserLogin;
        [JsonProperty("user_fio")]
        public String UserFio;

        public static Actualization GetInstance(String ObjID, OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select rnk, branch_id, user_login, user_fio,actual_date from TABLE (ead_integration.get_Act_Instance_Rec(:p_rnk))";
                cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToUInt64(ObjID), ParameterDirection.Input);

                Actualization res = new Actualization();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                        res.BranchId = Convert.ToString(rdr["branch_id"]);
                        res.ActualDate = Convert.ToDateTime(rdr["actual_date"]);
                        res.UserLogin = Convert.ToString(rdr["user_login"]);
                        res.UserFio = Convert.ToString(rdr["user_fio"]);
                    }
                }
                return res;
            }
        }
    }
}