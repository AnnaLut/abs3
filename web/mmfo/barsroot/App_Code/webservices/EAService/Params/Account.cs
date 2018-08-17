using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Метод «SetAccountData»  призначено для актуалізації інформації про рахунки клієнта фізичної особи в рамках визначеної угоди клієнта
    /// </summary>
    public struct Account
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("agr_type")]
        public String AgrType;
        [JsonProperty("agr_code")]
        public String AgrCode;
        [JsonIgnore]
        public String AgrNumber;
        [JsonProperty("account_type")]
        public String AccountType;
        [JsonProperty("account_number")]
        public String AccountNumber;
        [JsonProperty("account_currency")]
        public String AccountCurrency;
        [JsonProperty("account_mfo")]
        public UInt32 AccountMfo;
        [JsonProperty("account_open_date")]
        public DateTime AccountOpenDate;
        [JsonProperty("account_close_date")]
        public DateTime? AccountCloseDate;
        [JsonProperty("account_status")]
        public Byte AccountStatus;
        [JsonIgnore]
        public bool? AccountIsRemoteControl;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("user_login")]
        public String UserLogin;
        [JsonProperty("user_fio")]
        public String UserFio;
        [JsonProperty("branch_id")]
        public String BranchId;

        public static Account GetInstance(String ObjID, OracleConnection con)
        {
            String AgrType = ObjID.Split(';')[0];
            UInt64 ACC = Convert.ToUInt64(ObjID.Split(';')[1]);

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select rnk, agr_type, agr_code, agr_number, account_type, account_number, account_currency, account_mfo, account_open_date, account_close_date, account_status, account_is_remote_control, created, changed, user_login, user_fio, branch_id
                                  from TABLE (ead_integration.get_ACC_Instance_Set(:p_agr_type, :p_acc))";
                cmd.BindByName = true;
                cmd.Parameters.Add("p_agr_type", OracleDbType.Varchar2, AgrType, ParameterDirection.Input);
                cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);

                Account res = new Account();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                        res.AgrType = Convert.ToString(rdr["agr_type"]);
                        res.AgrCode = Convert.ToString(rdr["agr_code"]);
                        res.AgrNumber = Convert.ToString(rdr["agr_number"]);
                        res.AccountType = Convert.ToString(rdr["account_type"]);
                        res.AccountNumber = Convert.ToString(rdr["account_number"]);
                        res.AccountCurrency = Convert.ToString(rdr["account_currency"]);
                        res.AccountMfo = Convert.ToUInt32(rdr["account_mfo"]);
                        res.AccountOpenDate = Convert.ToDateTime(rdr["account_open_date"]);
                        res.AccountCloseDate = rdr["account_close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["account_close_date"]);
                        res.AccountStatus = Convert.ToByte(rdr["account_status"]);
                        res.AccountIsRemoteControl = rdr["account_is_remote_control"] == DBNull.Value ? (Boolean?)null : Convert.ToBoolean(rdr["account_is_remote_control"]);
                        res.Created = Convert.ToDateTime(rdr["created"]);
                        res.Changed = Convert.ToDateTime(rdr["changed"]);
                        res.UserLogin = Convert.ToString(rdr["user_login"]);
                        res.UserFio = Convert.ToString(rdr["user_fio"]);
                        res.BranchId = Convert.ToString(rdr["branch_id"]);
                    }
                }
                return res;
            }
        }
    }
}