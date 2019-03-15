using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Надрукований документ
    /// </summary>
    public struct Document
    {
        [JsonProperty("ticket_id")]
        public String TicketId;
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("doc_type")]
        public String DocType;
        [JsonProperty("doc_print_number")]
        public String DocPrintNumber;
        [JsonProperty("doc_pages_count")]
        public UInt16? DocPagesCount;
        [JsonProperty("doc_binary_data")]
        public String DocBinaryData;
        [JsonProperty("doc_request_number")]
        public String DocRequestNumber;
        [JsonProperty("agr_code")]
        public String AgrCode;
        [JsonProperty("agr_type")]
        public String AgrType;
        [JsonProperty("account_type")]
        public String AccountType;
        [JsonProperty("account_number")]
        public String AccountNumber;
        [JsonProperty("account_currency")]
        public String AccountCurrency;
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

        public static Document GetInstance(String ObjID, OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select ticket_id, rnk, doc_type, doc_print_number, doc_pages_count, doc_binary_data, doc_request_number, agr_code, 
                                agr_type, account_type, account_number, account_currency, created, changed, user_login, user_fio, branch_id
                                from table(ead_integration.get_Doc_Instance(:p_doc_id))";
                cmd.Parameters.Add("p_doc_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

                Document res = new Document();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                    	res.TicketId = Convert.ToString(rdr["ticket_id"]);
                        res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                        res.DocType = Convert.ToString(rdr["doc_type"]);
                        res.DocPrintNumber = Convert.ToString(rdr["doc_print_number"]);
                        res.DocPagesCount = rdr["doc_pages_count"] == DBNull.Value ? (UInt16?)null : Convert.ToUInt16(rdr["doc_pages_count"]);
                        res.DocBinaryData = rdr["doc_binary_data"] == DBNull.Value ? String.Empty : Convert.ToBase64String((Byte[])rdr["doc_binary_data"]);
                        res.DocRequestNumber = Convert.ToString(rdr["doc_request_number"]);
                        res.AgrCode = rdr["agr_code"] == DBNull.Value ? String.Empty : Convert.ToString(rdr["agr_code"]);
                        res.AgrType = Convert.ToString(rdr["agr_type"]);
                        res.AccountType = Convert.ToString(rdr["account_type"]);
                        res.AccountNumber = Convert.ToString(rdr["account_number"]);
                        res.AccountCurrency = Convert.ToString(rdr["account_currency"]);
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