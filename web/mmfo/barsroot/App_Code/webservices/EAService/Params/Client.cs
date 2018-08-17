using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Клієнт Физ.лицо
    /// </summary>
    public struct Client
    {
        [JsonProperty("branch_id")]
        public String BranchId;
        [JsonProperty("rnk")]
        public UInt64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("fio")]
        public String Fio;
        [JsonProperty("client_type")]
        public Byte ClientType;
        [JsonProperty("inn")]
        public String Inn;
        [JsonProperty("birth_date")]
        public DateTime BirthDate;
        [JsonProperty("document_series")]
        public String DocumentSeries;
        [JsonProperty("document_number")]
        public String DocumentNumber;
        [JsonProperty("mergedRNK")]
        public List<Int64> MergedRnk;
        [JsonProperty("user_login")]
        public String UserLogin;
        [JsonProperty("user_fio")]
        public String UserFio;
        [JsonIgnore]
        public String DocumentType;

        public static Client GetInstance(String ObjID, OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"SELECT rnk, changed, created, branch_id, user_login, user_fio, client_type,
                                       fio, inn, birth_date, document_type, document_series, document_number
                                  FROM TABLE (ead_integration.get_Client_Instance(:p_rnk))";
                cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

                Client res = new Client();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.BranchId = Convert.ToString(rdr["branch_id"]);
                        res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                        res.Changed = Convert.ToDateTime(rdr["changed"]);
                        res.Created = Convert.ToDateTime(rdr["created"]);
                        res.Fio = Convert.ToString(rdr["fio"]);
                        res.ClientType = Convert.ToByte(rdr["client_type"]);
                        res.Inn = Convert.ToString(rdr["inn"]);
                        res.BirthDate = Convert.ToDateTime(rdr["birth_date"]);
                        res.DocumentSeries = Convert.ToString(rdr["document_series"]);
                        res.DocumentNumber = Convert.ToString(rdr["document_number"]);
                        res.UserLogin = Convert.ToString(rdr["user_login"]);
                        res.UserFio = Convert.ToString(rdr["user_fio"]);
                        res.DocumentType = Convert.ToString(rdr["document_type"]);
                    }
                }

                // влитые РНК
                res.MergedRnk = new List<Int64>();

                cmd.CommandText = @"select mrg_rnk from TABLE (ead_integration.get_MergedRNK(:p_rnk))";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        res.MergedRnk.Add(Convert.ToInt64(rdr["mrg_rnk"]));
                    }
                }

                return res;
            }
        }
    }
}