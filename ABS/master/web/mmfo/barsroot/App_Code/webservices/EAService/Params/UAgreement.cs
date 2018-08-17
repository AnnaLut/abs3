using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Linq;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Угода Юр.лица
    /// </summary>
    public struct UAgreement
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("user_login")]
        public String UserLogin;
        [JsonProperty("user_fio")]
        public String UserFio;
        [JsonProperty("branch_id")]
        public String BranchId;
        [JsonProperty("agr_code")]
        public String AgrCode;
        [JsonProperty("agr_type")]
        public String AgrType;
        [JsonProperty("agr_status")]
        public Byte AgrStatus;
        [JsonProperty("agr_number")]
        public String AgrNumber;
        [JsonProperty("agr_date_open")]
        public DateTime AgrDateOpen;
        [JsonProperty("agr_date_close")]
        public DateTime? AgrDateClose;

        public static UAgreement GetInstance(String ObjID, OracleConnection con)
        {
            String AgrType = ObjID.Split(';')[0];
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.BindByName = true;
                switch (AgrType)
                {
                    case "DPT":
                        Decimal DpuID = Convert.ToDecimal(ObjID.Split(';')[1]);
                        cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDPU_Instance_Set(:p_dpu_id))";
                        cmd.Parameters.Add("p_dpu_id", OracleDbType.Decimal, DpuID, ParameterDirection.Input);

                        break;
                    case "ACC":
                        Decimal ACC = Convert.ToDecimal(ObjID.Split(';')[1]);
                        bool ReservedAcc = ObjID.Split(';').ElementAtOrDefault(2) == "RSRV";
                        cmd.CommandText = string.Format(@"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.{0}(:p_acc))", ReservedAcc ? "get_UAgrACCRsrv_Instance_Set" : "get_UAgrACC_Instance_Set");

                        cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);
                        break;
                    case "DPT_OLD":
                        String NLS = ObjID.Split(';')[1].Split('|')[0];
                        DateTime Daos = DateTime.ParseExact(ObjID.Split(';')[1].Split('|')[1], "yyyyMMdd", null);
                        ACC = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[2]);

                        cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDPTOLD_Instance_Set(:p_nls, :p_daos, :p_acc))";

                        cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, NLS, ParameterDirection.Input);
                        cmd.Parameters.Add("p_daos", OracleDbType.Date, Daos, ParameterDirection.Input);
                        cmd.Parameters.Add("p_acc", OracleDbType.Decimal, ACC, ParameterDirection.Input);

                        break;
                    case "DBO":
                        Decimal DBO = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[0]);
                        cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDBO_Instance_Set(:p_rnk))";

                        cmd.Parameters.Add("p_rnk", OracleDbType.Int64, DBO, ParameterDirection.Input);

                        break;

                    case "SALARY":
                        decimal pId = Convert.ToDecimal(ObjID.Split(';')[1]);
                        string pStatus = Convert.ToString(ObjID.Split(';')[2]);
                        cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type,
                                             agr_status, agr_number, agr_date_open, agr_date_close
                                        from TABLE (ead_integration.get_UAgrSalary_Instance_Set(:p_id,:p_status))";
                        cmd.Parameters.Add("p_id", OracleDbType.Decimal, pId, ParameterDirection.Input);
                        cmd.Parameters.Add("p_status", OracleDbType.Varchar2, pStatus, ParameterDirection.Input);

                        break;
                    default:
                        throw new Bars.Exception.BarsException("Попытка создать объект сделка UAgr неизвестного типа " + AgrType);
                }

                UAgreement res = new UAgreement();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                        res.Changed = Convert.ToDateTime(rdr["changed"]);
                        res.Created = Convert.ToDateTime(rdr["created"]);
                        res.UserLogin = Convert.ToString(rdr["user_login"]);
                        res.UserFio = Convert.ToString(rdr["user_fio"]);
                        res.BranchId = Convert.ToString(rdr["branch_id"]);
                        res.AgrCode = Convert.ToString(rdr["agr_code"]);
                        res.AgrType = Convert.ToString(rdr["agr_type"]);
                        res.AgrStatus = Convert.ToByte(rdr["agr_status"]);
                        res.AgrNumber = Convert.ToString(rdr["agr_number"]);
                        res.AgrDateOpen = Convert.ToDateTime(rdr["agr_date_open"]);
                        res.AgrDateClose = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                    }
                }

                return res;
            }
        }
    }
}