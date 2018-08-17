using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;

namespace Bars.EAD.Structs.Params.Dicts
{
    /// <summary>
    /// Параметри - Довідник - Відділення
    /// </summary>
    public struct DictDataBranch
    {
        [JsonProperty("code")]
        public String Code;
        [JsonProperty("name")]
        public String Name;
        [JsonProperty("is_closed")]
        public Boolean IsClosed;
        [JsonProperty("close_date")]
        public DateTime? CloseDate;

        public static List<DictDataBranch> GetInstanceList(OracleConnection con)
        {
            List<DictDataBranch> res = new List<DictDataBranch>();

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select code, name, close_date from table(ead_integration.get_Data_Branch)";

                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        DictDataBranch data = new DictDataBranch();

                        data.Code = Convert.ToString(rdr["code"]);
                        data.Name = Convert.ToString(rdr["name"]);
                        data.IsClosed = rdr["close_date"] == DBNull.Value ? false : true;
                        data.CloseDate = rdr["close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["close_date"]);

                        res.Add(data);
                    }
                }
            }

            return res;
        }
    }
}