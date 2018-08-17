using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Linq;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Метод «SetAccountDataU» призначено для актуалізації інформації про рахунки корпоративного клієнта в рамках визначеної угоди клієнта
    /// </summary>
    public struct UAccount
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("agr_code")]
        public String AgrCode;
        [JsonProperty("agr_type")]
        public String AgrType;
        [JsonIgnore]
        public String AgrNumber;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("account_number")]
        public String AccountNumber;
        [JsonProperty("currency_code")]
        public String CurrencyCode;
        [JsonProperty("account_type")]
        public String AccountType;
        [JsonProperty("mfo")]
        public UInt32 Mfo;
        [JsonProperty("open_date")]
        public DateTime OpenDate;
        [JsonProperty("close_date")]
        public DateTime? CloseDate;
        [JsonProperty("branch_id")]
        public String BranchId;
        [JsonProperty("user_login")]
        public String UserLogin;
        [JsonProperty("user_fio")]
        public String UserFio;
        [JsonProperty("account_status")]
        public Byte AccountStatus;
        [JsonProperty("remote_controled")]
        public bool RemoteControled;

        public static UAccount GetInstance(String ObjID, OracleConnection con)
        {
            String AgrType = ObjID.Split(';')[0];
            UInt64 ACC = Convert.ToUInt64(ObjID.Split(';')[1]);
            bool ReservedAcc = ObjID.Split(';').ElementAtOrDefault(2) == "RSRV";

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.BindByName = true;
                cmd.Parameters.Add("p_agr_type", OracleDbType.Varchar2, AgrType, ParameterDirection.Input);

                cmd.CommandText = string.Format(@"select 
                                                    rnk, 
                                                    changed, 
                                                    created, 
                                                    user_login, 
                                                    user_fio, 
                                                    account_number, 
                                                    currency_code, 
                                                    mfo, 
                                                    branch_id, 
                                                    open_date, 
                                                    close_date, 
                                                    account_status, 
                                                    agr_number, 
                                                    agr_code, 
                                                    account_type, 
                                                    agr_type, 
                                                    remote_controled
                                                  from TABLE (ead_integration.{0}(:p_agr_type, :p_acc))", ReservedAcc ? "get_UACCRsrv_Instance_Set" : "get_UACC_Instance_Set");

                cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);

                UAccount res = new UAccount();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                        res.AgrCode = Convert.ToString(rdr["agr_code"]);
                        res.AgrType = Convert.ToString(rdr["agr_type"]);
                        res.AgrNumber = Convert.ToString(rdr["agr_number"]);
                        res.Changed = Convert.ToDateTime(rdr["changed"]);
                        res.AccountNumber = Convert.ToString(rdr["account_number"]);
                        res.CurrencyCode = Convert.ToString(rdr["currency_code"]);
                        res.AccountType = Convert.ToString(rdr["account_type"]);
                        res.Mfo = Convert.ToUInt32(rdr["mfo"]);
                        res.OpenDate = Convert.ToDateTime(rdr["open_date"]);
                        res.CloseDate = rdr["close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["close_date"]);
                        res.BranchId = Convert.ToString(rdr["branch_id"]);
                        res.UserLogin = Convert.ToString(rdr["user_login"]);
                        res.UserFio = Convert.ToString(rdr["user_fio"]);
                        res.AccountStatus = Convert.ToByte(rdr["account_status"]);
                        res.RemoteControled = Convert.ToBoolean(rdr["remote_controled"]);
                    }
                }
                return res;
            }
        }
    }
}