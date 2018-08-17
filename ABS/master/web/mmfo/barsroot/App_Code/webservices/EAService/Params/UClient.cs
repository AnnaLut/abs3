using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace Bars.EAD.Structs.Params
{
   /// <summary>
    /// Параметри - Клієнт Юр.лицо
    /// </summary>
    public struct UClient
    {
        [JsonProperty("branch_id")]
        public String BranchId;
        [JsonProperty("rnk")]
        public UInt64 Rnk;
        [JsonProperty("mergedRNK")]
        public List<UInt64> MergedRNK;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("client_name")]
        public String ClientName;
        [JsonProperty("client_type")]
        public Byte ClientType;
        [JsonProperty("inn_edrpou")]
        public String InnEdrpou;
        [JsonProperty("user_login")]
        public String UserLogin;
        [JsonProperty("user_fio")]
        public String UserFio;
        [JsonProperty("actualized_by_user_fio")]
        public String ActualizedByUserFio;
        [JsonProperty("actualized_by_user_login")]
        public String ActualizedByUserLogin;
        [JsonProperty("actualized_by_branch_id")]
        public String ActualizedByBranchId;
        [JsonProperty("actualized_date")]
        public DateTime ActualizedDate;
        [JsonProperty("third_persons_clients")]
        public List<ThirdPersonsClients> ThirdPersonsClients;
        [JsonProperty("third_persons_non_clients")]
        public List<ThirdPersonsNonClients> ThirdPersonsNonClients;

        public static UClient GetInstance(String ObjID, OracleConnection con)
        {
            UClient res = new UClient();

            //DBLogger.Debug("UCLIENT rnk = " + ObjID);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select branch_id,rnk,changed,created,client_type,client_name,inn_edrpou,user_login,user_fio,
                                       actualized_by_user_fio, actualized_by_user_login, actualized_by_branch_id, actualized_date
                                  from TABLE (ead_integration.get_UClient_Instance(:p_rnk))";
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.BranchId = Convert.ToString(rdr["branch_id"]);
                    res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
                    res.Created = Convert.ToDateTime(rdr["created"]);
                    res.ClientName = Convert.ToString(rdr["client_name"]);
                    res.ClientType = Convert.ToByte(rdr["client_type"]);
                    res.InnEdrpou = Convert.ToString(rdr["inn_edrpou"]);
                    res.UserLogin = Convert.ToString(rdr["user_login"]);
                    res.UserFio = Convert.ToString(rdr["user_fio"]);
                    res.ActualizedByUserFio = Convert.ToString(rdr["actualized_by_user_fio"]);
                    res.ActualizedByUserLogin = Convert.ToString(rdr["actualized_by_user_login"]);
                    res.ActualizedByBranchId = Convert.ToString(rdr["actualized_by_branch_id"]);
                    res.ActualizedDate = Convert.ToDateTime(rdr["actualized_date"]);
                }
            }

            // третьи лица, связанные с данным юр. лицом кліенти банку
            res.ThirdPersonsClients = new List<ThirdPersonsClients>();

            cmd.CommandText = @"select rnk, personstateid, date_begin_powers, date_end_powers
                                from TABLE (ead_integration.get_Third_Person_Client_Set(:p_rnk))";//лише клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.ThirdPersonsClients.Add(new ThirdPersonsClients(Convert.ToUInt64(rdr["rnk"]), Convert.ToInt16(rdr["personstateid"]),
                        (rdr["date_begin_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_begin_powers"])),
                        (rdr["date_end_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_end_powers"]))));
                }
            }
            // третьи лица, связанные с данным юр. лицом не кліенти банку
            res.ThirdPersonsNonClients = new List<ThirdPersonsNonClients>();

            cmd.CommandText = @"select id, personstateid, name, client_type, inn_edrpou, date_begin_powers, date_end_powers
                                  from TABLE (ead_integration.get_Third_Person_NonClient_Set(:p_rnk))";//лише не клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.ThirdPersonsNonClients.Add(new ThirdPersonsNonClients(Convert.ToString(rdr["id"]), Convert.ToInt16(rdr["personstateid"]), Convert.ToString(rdr["name"]), Convert.ToByte(rdr["client_type"]), Convert.ToString(rdr["inn_edrpou"])
                        , (rdr["date_begin_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_begin_powers"]))
                        , (rdr["date_end_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_end_powers"]))));
                }
            }
            // перечень РНК клиента, которые уже не являются активными 
            res.MergedRNK = new List<UInt64>();

            cmd.CommandText = @"select mrg_rnk from TABLE (ead_integration.get_MergedRNK(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToUInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.MergedRNK.Add(Convert.ToUInt64(rdr["mrg_rnk"]));
                }
            }

            return res;
        }
    }
}