using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Угода
    /// </summary>
    public struct Agreement
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("parent_agr_type")]
        public String ParentAgrType;
        [JsonProperty("parent_agr_code")]
        public String ParentAgrCode;
        [JsonProperty("agr_type")]
        public String AgrType;
        [JsonProperty("agr_code")]
        public String AgrCode;
        [JsonProperty("agr_number")]
        public String AgrNumber;
        [JsonProperty("agr_status")]
        public Byte AgrStatus;
        [JsonProperty("agr_date_open")]
        public DateTime AgrDateOpen;
        [JsonProperty("agr_date_close")]
        public DateTime? AgrDateClose;
        [JsonProperty("third_persons")]
        public List<ThirdPersons> ThirdPersons;
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
        [JsonProperty("agr_bpk_codes")]
        public List<UInt64> AgrBpkCodes;

        public static Agreement GetInstance(String ObjID, OracleConnection con)
        {

            String AgrType = ObjID.Split(';')[0];
            using (OracleCommand cmd = con.CreateCommand())
            {
                Agreement res = new Agreement();

                switch (AgrType)
                {
                    case "DPT":
                        Decimal DptID = Convert.ToDecimal(ObjID.Split(';')[1]);
                        cmd.CommandText = @"select rnk, parent_agr_type, parent_agr_code,
                                               agr_type, agr_code, agr_number, agr_status, agr_date_open, agr_date_close, created, changed, user_login, user_fio, branch_id
                                          from TABLE (ead_integration.get_AgrDPT_Instance_Set(:p_agr_id))";
                        cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

                        using (OracleDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                                res.ParentAgrType = Convert.ToString(rdr["parent_agr_type"]);
                                res.ParentAgrCode = Convert.ToString(rdr["parent_agr_code"]);
                                res.AgrType = Convert.ToString(rdr["agr_type"]);
                                res.AgrCode = Convert.ToString(rdr["agr_code"]);
                                res.AgrNumber = Convert.ToString(rdr["agr_number"]);
                                res.AgrStatus = Convert.ToByte(rdr["agr_status"]);
                                res.AgrDateOpen = Convert.ToDateTime(rdr["agr_date_open"]);
                                res.AgrDateClose = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                                res.Created = Convert.ToDateTime(rdr["created"]);
                                res.Changed = Convert.ToDateTime(rdr["changed"]);
                                res.UserLogin = Convert.ToString(rdr["user_login"]);
                                res.UserFio = Convert.ToString(rdr["user_fio"]);
                                res.BranchId = Convert.ToString(rdr["branch_id"]);
                            }
                        }

                        // связанные РНК
                        res.ThirdPersons = new List<ThirdPersons>();

                        cmd.Parameters.Clear();
                        cmd.CommandText = @"select rnk, linkpersonstateid from TABLE (ead_integration.get_AgrDPT_LinkedRnk_Set(:p_agr_id))";//в выборку не должны попадать дублирующие записи.
                                                                                                                                            //Union - в выборку должен попасть вноситель вклада(ACTION_ID = 0) если на данный момент он не владелец счета (t1.rnk <> t2.rnk)
                        cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

                        using (OracleDataReader rdr = cmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                res.ThirdPersons.Add(new ThirdPersons(Convert.ToUInt64(rdr["rnk"]), Convert.ToByte(rdr["linkpersonstateid"])));
                            }
                        }

                        break;

                    case "WAY":
                        Decimal ND = Convert.ToDecimal(ObjID.Split(';')[1]);
                        cmd.CommandText = @"select rnk, parent_agr_type, parent_agr_code,
                                               agr_type, agr_code, agr_number, agr_status, agr_date_open, agr_date_close, created, changed, user_login, user_fio, branch_id                                                 
                                          from TABLE (ead_integration.get_AgrBPK_Instance_Set(:p_agr_id))";
                        cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, ND, ParameterDirection.Input);

                        using (OracleDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                                res.ParentAgrType = Convert.ToString(rdr["parent_agr_type"]);
                                res.ParentAgrCode = Convert.ToString(rdr["parent_agr_code"]);
                                res.AgrType = Convert.ToString(rdr["agr_type"]);
                                res.AgrCode = Convert.ToString(rdr["agr_code"]);
                                res.AgrNumber = Convert.ToString(rdr["agr_number"]);
                                res.AgrStatus = Convert.ToByte(rdr["agr_status"]);
                                res.AgrDateOpen = Convert.ToDateTime(rdr["agr_date_open"]);
                                res.AgrDateClose = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                                res.Created = Convert.ToDateTime(rdr["created"]);
                                res.Changed = Convert.ToDateTime(rdr["changed"]);
                                res.UserLogin = Convert.ToString(rdr["user_login"]);
                                res.UserFio = Convert.ToString(rdr["user_fio"]);
                                res.BranchId = Convert.ToString(rdr["branch_id"]);
                            }
                        }
                        break;
                    case "DKBO":
                        Decimal DKBOND = Convert.ToDecimal(ObjID.Split(';')[1]);
                        cmd.CommandText = @"select rnk, parent_agr_type, parent_agr_code,
                                               agr_type, agr_code, agr_number, agr_status, agr_date_open, agr_date_close, created, changed, user_login, user_fio, branch_id    
                                          from TABLE (ead_integration.get_AgrDKBO_Instance_Set(:p_agr_id))";
                        cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DKBOND, ParameterDirection.Input);

                        using (OracleDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                                res.ParentAgrType = Convert.ToString(rdr["parent_agr_type"]);
                                res.ParentAgrCode = Convert.ToString(rdr["parent_agr_code"]);
                                res.AgrType = Convert.ToString(rdr["agr_type"]);
                                res.AgrCode = Convert.ToString(rdr["agr_code"]);
                                res.AgrNumber = Convert.ToString(rdr["agr_number"]);
                                res.AgrStatus = Convert.ToByte(rdr["agr_status"]);
                                res.AgrDateOpen = Convert.ToDateTime(rdr["agr_date_open"]);
                                res.AgrDateClose = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                                res.Created = Convert.ToDateTime(rdr["created"]);
                                res.Changed = Convert.ToDateTime(rdr["changed"]);
                                res.UserLogin = Convert.ToString(rdr["user_login"]);
                                res.UserFio = Convert.ToString(rdr["user_fio"]);
                                res.BranchId = Convert.ToString(rdr["branch_id"]);
                                res.ThirdPersons = new List<ThirdPersons>();
                            }
                        }

                        // Параметр на період завершення впровадження ДКБО. Массив кодів угод БПК, створених після появи ДКБО. для депозитів не заповнюємо
                        res.AgrBpkCodes = new List<UInt64>();

                        cmd.Parameters.Clear();
                        cmd.CommandText = @"select column_value as ND from TABLE (ead_integration.get_AgrBPKcodes_Set(:p_agr_id, :p_acc_list))";
                        cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DKBOND, ParameterDirection.Input);
                        if (ObjID.Split(';').Length == 3)
                        {
                            cmd.Parameters.Add("p_acc_list", OracleDbType.Varchar2, Convert.ToString(ObjID.Split(';')[2]), ParameterDirection.Input);

                            using (OracleDataReader rdr = cmd.ExecuteReader())
                            {
                                while (rdr.Read())
                                {
                                    res.AgrBpkCodes.Add(Convert.ToUInt64(rdr["ND"]));
                                }
                            }
                        }
                        break;
                    default:
                        throw new Bars.Exception.BarsException("Попытка создать объект сделка Agr неизвестного типа " + AgrType);
                }
                return res;
            }
        }
    }
}