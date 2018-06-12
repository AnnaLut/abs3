using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Net;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Linq;

using Bars.Application;
using Bars.Classes;
using barsroot.core;
using BarsWeb.Core.Logger;
using ibank.core;
using Oracle.DataAccess.Client;
using Newtonsoft.Json;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;


namespace Bars.EAD.Structs.Params.Dicts
{
    /// <summary>
    /// Параметри - Довідник - Відділення
    /// </summary>
    public struct Dict_Data_Branch
    {
        [JsonProperty("code")]
        public String Code;
        [JsonProperty("name")]
        public String Name;
        [JsonProperty("is_closed")]
        public Boolean Is_Closed;
        [JsonProperty("close_date")]
        public DateTime? Close_Date;

        public static List<Dict_Data_Branch> GetInstanceList(OracleConnection con)
        {
            List<Dict_Data_Branch> res = new List<Dict_Data_Branch>();

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select code, name, close_date from table(ead_integration.get_Data_Branch)";

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    Dict_Data_Branch data = new Dict_Data_Branch();

                    data.Code = Convert.ToString(rdr["code"]);
                    data.Name = Convert.ToString(rdr["name"]);
                    data.Is_Closed = rdr["close_date"] == DBNull.Value ? false : true;
                    data.Close_Date = rdr["close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["close_date"]);

                    res.Add(data);
                }

                rdr.Close();
            }

            return res;
        }
    }
}

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Надрукований документ
    /// </summary>
    public struct Document
    {
        [JsonProperty("RNK")]
        public UInt64 RNK;
        [JsonProperty("doc_type")]
        public String doc_type;
        [JsonProperty("doc_id")]
        public String doc_id;
        [JsonProperty("doc_pages_count")]
        public UInt16? doc_pages_count;
        [JsonProperty("doc_binary_data")]
        public String doc_binary_data;
        [JsonProperty("doc_request_number")]
        public String doc_request_number;
        [JsonProperty("agr_code")]
        public UInt64? agr_code;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("account_type")]
        public String account_type;
        [JsonProperty("account_number")]
        public String account_number;
        [JsonProperty("account_currency")]
        public String account_currency;
        [JsonProperty("created")]
        public DateTime created;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonProperty("branch_id")]
        public String branch_id;
        //[JsonProperty("linkedrnk")]
        //public Int64? LinkedRnk;

        public static Document GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select rnk, doc_type, doc_id, doc_pages_count, doc_binary_data, doc_request_number, agr_code, 
                                agr_type, account_type, account_number, account_currency, created, changed, user_login, user_fio, branch_id
                                from table(ead_integration.get_Doc_Instance(:p_doc_id))";
            cmd.Parameters.Add("p_doc_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Document res = new Document();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.RNK = Convert.ToUInt64(rdr["rnk"]);
                    res.doc_type = Convert.ToString(rdr["doc_type"]);
                    res.doc_id = Convert.ToString(rdr["doc_id"]);
                    res.doc_pages_count = rdr["doc_pages_count"] == DBNull.Value ? (UInt16?)null : Convert.ToUInt16(rdr["doc_pages_count"]);
                    res.doc_binary_data = rdr["doc_binary_data"] == DBNull.Value ? String.Empty : Convert.ToBase64String((Byte[])rdr["doc_binary_data"]);
                    res.doc_request_number = Convert.ToString(rdr["doc_request_number"]);
                    res.agr_code = rdr["agr_code"] == DBNull.Value ? (UInt64?)null : Convert.ToUInt64(rdr["agr_code"]);
                    res.agr_type = Convert.ToString(rdr["agr_type"]);
                    res.account_type = Convert.ToString(rdr["account_type"]);
                    res.account_number = Convert.ToString(rdr["account_number"]);
                    res.account_currency = Convert.ToString(rdr["account_currency"]);
                    res.created = Convert.ToDateTime(rdr["created"]);
                    res.changed = Convert.ToDateTime(rdr["changed"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                    //res.LinkedRnk = rdr["linkedrnk"] == DBNull.Value ? (Int64?)null : Convert.ToInt64(rdr["linkedrnk"]);
                }
                rdr.Close();
            }

            return res;
        }
    }

    /// <summary>
    /// Параметри - Клієнт Физ.лицо
    /// </summary>
    public struct Client
    {
        [JsonProperty("branch_id")]
        public String branch_id;
        [JsonProperty("rnk")]
        public UInt64 rnk;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("created")]
        public DateTime created;
        [JsonProperty("fio")]
        public String fio;
        [JsonProperty("client_type")]
        public Byte client_type;
        [JsonProperty("inn")]
        public String inn;
        [JsonProperty("birth_date")]
        public DateTime birth_date;
        [JsonProperty("document_series")]
        public String document_series;
        [JsonProperty("document_number")]
        public String document_number;
        [JsonProperty("mergedRNK")]
        public List<Int64> mergedRNK;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonIgnoreAttribute]
        public String document_type;

        public static Client GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"SELECT rnk, changed, created, branch_id, user_login, user_fio, client_type,
                                       fio, inn, birth_date, document_type, document_series, document_number
                                  FROM TABLE (ead_integration.get_Client_Instance(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Client res = new Client();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                    res.rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.changed = Convert.ToDateTime(rdr["changed"]);
                    res.created = Convert.ToDateTime(rdr["created"]);
                    res.fio = Convert.ToString(rdr["fio"]);
                    res.client_type = Convert.ToByte(rdr["client_type"]);
                    res.inn = Convert.ToString(rdr["inn"]);
                    res.birth_date = Convert.ToDateTime(rdr["birth_date"]);
                    res.document_series = Convert.ToString(rdr["document_series"]);
                    res.document_number = Convert.ToString(rdr["document_number"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                    res.document_type = Convert.ToString(rdr["document_type"]);

                }
                rdr.Close();
            }

            // влитые РНК
            res.mergedRNK = new List<Int64>();

            cmd.CommandText = @"select mrg_rnk from TABLE (ead_integration.get_MergedRNK(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.mergedRNK.Add(Convert.ToInt64(rdr["mrg_rnk"]));
                }

                rdr.Close();
            }

            return res;
        }
    }
    /// <summary>
    /// Параметри - Клієнт Юр.лицо
    /// </summary>
    public struct UClient
    {
        [JsonProperty("branch_id")]
        public String branch_id;
        [JsonProperty("rnk")]
        public UInt64 rnk;
        [JsonProperty("mergedRNK")]
        public List<UInt64> MergedRNK;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("created")]
        public DateTime created;
        [JsonProperty("client_name")]
        public String client_name;
        [JsonProperty("client_type")]
        public Byte client_type;
        [JsonProperty("inn_edrpou")]
        public String inn_edrpou;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonProperty("actualized_by_user_fio")]
        public String actualized_by_user_fio;
        [JsonProperty("actualized_by_user_login")]
        public String actualized_by_user_login;
        [JsonProperty("actualized_by_branch_id")]
        public String actualized_by_branch_id;
        [JsonProperty("actualized_date")]
        public DateTime actualized_date;
        [JsonProperty("third_persons_clients")]
        public List<Third_Persons_Clients> Third_Persons_Clients;
        [JsonProperty("third_persons_non_clients")]
        public List<Third_Persons_Non_Clients> Third_Persons_Non_Clients;

        public static UClient GetInstance(String ObjID, OracleConnection con)
        {
            UClient res = new UClient();

            //DBLogger.Debug("UCLIENT rnk = " + ObjID);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select branch_id,rnk,changed,created,client_type,client_name,inn_edrpou,user_login,user_fio,
                                       actualized_by_user_fio, actualized_by_user_login, actualized_by_branch_id, actualized_date
                                  from TABLE (ead_integration.get_UClient_Instance(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    // DBLogger.Debug("Uclient:  res.Rnk = " + res.Rnk.ToString());
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                    res.rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.changed = Convert.ToDateTime(rdr["changed"]);
                    res.created = Convert.ToDateTime(rdr["created"]);
                    res.client_name = Convert.ToString(rdr["client_name"]);
                    res.client_type = Convert.ToByte(rdr["client_type"]);
                    res.inn_edrpou = Convert.ToString(rdr["inn_edrpou"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                    res.actualized_by_user_fio = Convert.ToString(rdr["actualized_by_user_fio"]);
                    res.actualized_by_user_login = Convert.ToString(rdr["actualized_by_user_login"]);
                    res.actualized_by_branch_id = Convert.ToString(rdr["actualized_by_branch_id"]);
                    res.actualized_date = Convert.ToDateTime(rdr["actualized_date"]);
                }
                rdr.Close();
            }

            // третьи лица, связанные с данным юр. лицом кліенти банку
            res.Third_Persons_Clients = new List<Third_Persons_Clients>();

            cmd.CommandText = @"select rnk, personstateid, date_begin_powers, date_end_powers
                                from TABLE (ead_integration.get_Third_Person_Client_Set(:p_rnk))";//лише клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.Third_Persons_Clients.Add(new Third_Persons_Clients(Convert.ToUInt64(rdr["rnk"]), Convert.ToInt16(rdr["personstateid"]),
                        (rdr["date_begin_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_begin_powers"])),
                        (rdr["date_end_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_end_powers"]))));
                }
                rdr.Close();
            }
            // третьи лица, связанные с данным юр. лицом не кліенти банку
            res.Third_Persons_Non_Clients = new List<Third_Persons_Non_Clients>();

            cmd.CommandText = @"select id, personstateid, name, client_type, inn_edrpou, date_begin_powers, date_end_powers
                                  from TABLE (ead_integration.get_Third_Person_NonClient_Set(:p_rnk))";//лише не клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.Third_Persons_Non_Clients.Add(new Third_Persons_Non_Clients(Convert.ToString(rdr["id"]), Convert.ToInt16(rdr["personstateid"]), Convert.ToString(rdr["name"]), Convert.ToByte(rdr["client_type"]), Convert.ToString(rdr["inn_edrpou"])
                        , (rdr["date_begin_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_begin_powers"]))
                        , (rdr["date_end_powers"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["date_end_powers"]))));
                }
                rdr.Close();
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

                rdr.Close();
            }

            return res;
        }
    }

    /// <summary>
    /// Параметри - Юр.лицо - третьи лица кліенти банку
    /// </summary>
    public struct Third_Persons_Clients
    {
        [JsonProperty("rnk")]
        public UInt64 rnk;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("date_begin_powers")]
        public DateTime? date_begin_powers;
        [JsonProperty("date_end_powers")]
        public DateTime? date_end_powers;


        public Third_Persons_Clients(UInt64 rnk, Int16 PersonStateID, DateTime? date_begin_powers, DateTime? date_end_powers)
        {
            this.rnk = rnk;
            this.PersonStateID = PersonStateID;
            this.date_begin_powers = date_begin_powers;
            this.date_end_powers = date_end_powers;
        }
    }
    /// <summary>
    /// Параметри - Юр.лицо - третьи лица не кліенти банку
    /// </summary>
    public struct Third_Persons_Non_Clients
    {
        [JsonProperty("ID")]
        public String ID;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("name")]
        public String name;
        [JsonProperty("client_type")]
        public Byte client_type;
        [JsonProperty("inn_edrpou")]
        public String inn_edrpou;
        [JsonProperty("date_begin_powers")]
        public DateTime? date_begin_powers;
        [JsonProperty("date_end_powers")]
        public DateTime? date_end_powers;

        public Third_Persons_Non_Clients(String ID, Int16 PersonStateID, String name, Byte client_type, String inn_edrpou, DateTime? date_begin_powers, DateTime? date_end_powers)
        {
            this.ID = ID;
            this.PersonStateID = PersonStateID;
            this.client_type = client_type;
            this.name = name;
            this.inn_edrpou = inn_edrpou;
            this.date_begin_powers = date_begin_powers;
            this.date_end_powers = date_end_powers;

        }
    }
    /// <summary>
    /// Параметри - Угода - Связанное лицо
    /// </summary>
    public struct Third_Persons
    {
        [JsonProperty("RNK")]
        public UInt64 rnk;
        [JsonProperty("third_person_state")]
        public Byte third_person_state;

        public Third_Persons(UInt64 rnk, Byte third_person_state)
        {
            this.rnk = rnk;
            this.third_person_state = third_person_state;
        }
    }
    /// <summary>
    /// Параметри - Угода
    /// </summary>
    public struct Agreement
    {
        [JsonProperty("RNK")]
        public UInt64 rnk;
        [JsonProperty("parent_agr_type")]
        public String parent_agr_type;
        [JsonProperty("parent_agr_code")]
        public String parent_agr_code;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("agr_code")]
        public String agr_code;
        [JsonProperty("agr_number")]
        public String agr_number;
        [JsonProperty("agr_status")]
        public Byte agr_status;
        [JsonProperty("agr_date_open")]
        public DateTime agr_date_open;
        [JsonProperty("agr_date_close")]
        public DateTime? agr_date_close;
        [JsonProperty("third_persons")]
        public List<Third_Persons> third_persons;
        [JsonProperty("created")]
        public DateTime created;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonProperty("branch_id")]
        public String branch_id;
        [JsonProperty("agr_bpk_codes")]
        public List<UInt64> agr_bpk_codes;

        public static Agreement GetInstance(String ObjID, OracleConnection con)
        {

            String AgrType = ObjID.Split(';')[0];
            OracleCommand cmd = con.CreateCommand();
            Agreement res = new Agreement();

            switch (AgrType)
            {
                case "DPT":
                    Decimal DptID = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select rnk, parent_agr_type, parent_agr_code,
                                               agr_type, agr_code, agr_number, agr_status, agr_date_open, agr_date_close, created, changed, user_login, user_fio, branch_id
                                          from TABLE (ead_integration.get_AgrDPT_Instance_Set(:p_agr_id))";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            res.rnk = Convert.ToUInt64(rdr["rnk"]);
                            res.parent_agr_type = Convert.ToString(rdr["parent_agr_type"]);
                            res.parent_agr_code = Convert.ToString(rdr["parent_agr_code"]);
                            res.agr_type = Convert.ToString(rdr["agr_type"]);
                            //res.agr_code = rdr["agr_code"] == DBNull.Value ? (Int32?)null : Convert.ToInt32(rdr["agr_code"]);
                            res.agr_code = Convert.ToString(rdr["agr_code"]);
                            res.agr_number = Convert.ToString(rdr["agr_number"]);
                            res.agr_status = Convert.ToByte(rdr["agr_status"]);
                            res.agr_date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                            res.agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                            res.created = Convert.ToDateTime(rdr["created"]);
                            res.changed = Convert.ToDateTime(rdr["changed"]);
                            res.user_login = Convert.ToString(rdr["user_login"]);
                            res.user_fio = Convert.ToString(rdr["user_fio"]);
                            res.branch_id = Convert.ToString(rdr["branch_id"]);
                        }
                        rdr.Close();
                    }

                    // связанные РНК
                    res.third_persons = new List<Third_Persons>();

                    cmd.CommandText = @"select rnk, linkpersonstateid from TABLE (ead_integration.get_AgrDPT_LinkedRnk_Set(:p_agr_id))";//в выборку не должны попадать дублирующие записи.
                    //Union - в выборку должен попасть вноситель вклада(ACTION_ID = 0) если на данный момент он не владелец счета (t1.rnk <> t2.rnk)
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            res.third_persons.Add(new Third_Persons(Convert.ToUInt64(rdr["rnk"]), Convert.ToByte(rdr["linkpersonstateid"])));
                        }

                        rdr.Close();
                    }

                    break;

                case "WAY":
                    Decimal ND = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select rnk, parent_agr_type, parent_agr_code,
                                               agr_type, agr_code, agr_number, agr_status, agr_date_open, agr_date_close, created, changed, user_login, user_fio, branch_id                                                 
                                          from TABLE (ead_integration.get_AgrBPK_Instance_Set(:p_agr_id))";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, ND, ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            res.rnk = Convert.ToUInt64(rdr["rnk"]);
                            res.parent_agr_type = Convert.ToString(rdr["parent_agr_type"]);
                            res.parent_agr_code = Convert.ToString(rdr["parent_agr_code"]);
                            res.agr_type = Convert.ToString(rdr["agr_type"]);
                            //res.agr_code = rdr["agr_code"] == DBNull.Value ? (Int32?)null : Convert.ToInt32(rdr["agr_code"]);
                            res.agr_code = Convert.ToString(rdr["agr_code"]);
                            res.agr_number = Convert.ToString(rdr["agr_number"]);
                            res.agr_status = Convert.ToByte(rdr["agr_status"]);
                            res.agr_date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                            res.agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                            res.created = Convert.ToDateTime(rdr["created"]);
                            res.changed = Convert.ToDateTime(rdr["changed"]);
                            res.user_login = Convert.ToString(rdr["user_login"]);
                            res.user_fio = Convert.ToString(rdr["user_fio"]);
                            res.branch_id = Convert.ToString(rdr["branch_id"]);
                        }

                        rdr.Close();
                    }
                    break;
                case "DKBO":
                    Decimal DKBOND = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select rnk, parent_agr_type, parent_agr_code,
                                               agr_type, agr_code, agr_number, agr_status, agr_date_open, agr_date_close, created, changed, user_login, user_fio, branch_id    
                                          from TABLE (ead_integration.get_AgrDKBO_Instance_Set(:p_agr_id))";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DKBOND, ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            res.rnk = Convert.ToUInt64(rdr["rnk"]);
                            res.parent_agr_type = Convert.ToString(rdr["parent_agr_type"]);
                            res.parent_agr_code = Convert.ToString(rdr["parent_agr_code"]);
                            res.agr_type = Convert.ToString(rdr["agr_type"]);
                            //res.agr_code = rdr["agr_code"] == DBNull.Value ? (Int32?)null : Convert.ToInt32(rdr["agr_code"]);
                            res.agr_code = Convert.ToString(rdr["agr_code"]);
                            res.agr_number = Convert.ToString(rdr["agr_number"]);
                            res.agr_status = Convert.ToByte(rdr["agr_status"]);
                            res.agr_date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                            res.agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                            res.created = Convert.ToDateTime(rdr["created"]);
                            res.changed = Convert.ToDateTime(rdr["changed"]);
                            res.user_login = Convert.ToString(rdr["user_login"]);
                            res.user_fio = Convert.ToString(rdr["user_fio"]);
                            res.branch_id = Convert.ToString(rdr["branch_id"]);
                        }

                        rdr.Close();
                    }

                    // Параметр на період завершення впровадження ДКБО. Массив кодів угод БПК, створених після появи ДКБО. для депозитів не заповнюємо
                    res.agr_bpk_codes = new List<UInt64>();

                    cmd.CommandText = @"select column_value as ND from TABLE (ead_integration.get_AgrBPKcodes_Set(:p_agr_id, :p_acc_list))";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, DKBOND, ParameterDirection.Input);
                    if (ObjID.Split(';').Length == 3)
                    {
                        cmd.Parameters.Add("p_acc_list", OracleDbType.Varchar2, Convert.ToString(ObjID.Split(';')[2]), ParameterDirection.Input);

                        using (OracleDataReader rdr = cmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                res.agr_bpk_codes.Add(Convert.ToUInt64(rdr["ND"]));
                            }
                            rdr.Close();
                        }
                    }
                    break;
                default:
                    throw new Bars.Exception.BarsException("Попытка создать объект сделка Agr неизвестного типа " + AgrType);
            }
            return res;
        }
    }
    /// <summary>
    /// Параметри - Угода Юр.лица
    /// </summary>
    public struct UAgreement
    {
        [JsonProperty("RNK")]
        public UInt64 rnk;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("created")]
        public DateTime created;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonProperty("branch_id")]
        public String branch_id;
        [JsonProperty("agr_code")]
        public String agr_code;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("agr_status")]
        public Byte agr_status;
        [JsonProperty("agr_number")]
        public String agr_number;
        [JsonProperty("agr_date_open")]
        public DateTime agr_date_open;
        [JsonProperty("agr_date_close")]
        public DateTime? agr_date_close;

        public static UAgreement GetInstance(String ObjID, OracleConnection con)
        {
            //dbLogger.Info("UAGR obj_id = " + ObjID);
            String AgrType = ObjID.Split(';')[0];
            OracleCommand cmd = con.CreateCommand();
            cmd.Parameters.Clear();
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

                    if (ReservedAcc)
                    {
                        cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrACCRsrv_Instance_Set(:p_rsrv_id))";
                        cmd.Parameters.Add("p_rsrv_id", OracleDbType.Int64, ACC, ParameterDirection.Input);
                    }
                    else
                    {
                        cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrACC_Instance_Set(:p_acc))";
                        cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);
                    }

                    break;
                case "DPT_OLD":
                    String NLS = ObjID.Split(';')[1].Split('|')[0];
                    DateTime Daos = DateTime.ParseExact(ObjID.Split(';')[1].Split('|')[1], "yyyyMMdd", null);
                    ACC = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[2]);

                    cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDPTOLD_Instance_Set(:p_nls, :p_daos, :p_acc))";
                    //DBLogger.Info("p_nls = " + NLS + " p_daos = " + Daos + " p_acc = " + ACC);

                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, NLS, ParameterDirection.Input);
                    cmd.Parameters.Add("p_daos", OracleDbType.Date, Daos, ParameterDirection.Input);
                    cmd.Parameters.Add("p_acc", OracleDbType.Decimal, ACC, ParameterDirection.Input);

                    break;
                case "DBO":
                    Decimal DBO = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[0]);
                    //dbLogger.Info("UAGR DBO(RNK) = " + DBO);
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

            //dbLogger.Info("cmd.CommandText = " + cmd.CommandText);

            UAgreement res = new UAgreement();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    //   DBLogger.Info("Convert.ToString(rdr[agr_code]) = " + Convert.ToString(rdr["agr_code"]));

                    res.rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.changed = Convert.ToDateTime(rdr["changed"]);
                    res.created = Convert.ToDateTime(rdr["created"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                    res.agr_code = Convert.ToString(rdr["agr_code"]);
                    res.agr_type = Convert.ToString(rdr["agr_type"]);
                    res.agr_status = Convert.ToByte(rdr["agr_status"]);
                    res.agr_number = Convert.ToString(rdr["agr_number"]);
                    res.agr_date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                    res.agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                }

                //  DBLogger.Info("res_id = " + res.Agr_code);
                rdr.Close();
            }

            return res;
        }
    }
    /// <summary>
    /// Метод «SetAccountData»  призначено для актуалізації інформації про рахунки клієнта фізичної особи в рамках визначеної угоди клієнта
    /// </summary>
    public struct Account
    {
        [JsonProperty("RNK")]
        public UInt64 rnk;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("agr_code")]
        public String agr_code;
        //        [JsonProperty("agr_number")]
        [JsonIgnoreAttribute]
        public String agr_number;
        [JsonProperty("account_type")]
        public String account_type;
        [JsonProperty("account_number")]
        public String account_number;
        [JsonProperty("account_currency")]
        public String account_currency;
        [JsonProperty("account_mfo")]
        public UInt32 account_mfo;
        [JsonProperty("account_open_date")]
        public DateTime account_open_date;
        [JsonProperty("account_close_date")]
        public DateTime? account_close_date;
        [JsonProperty("account_status")]
        public Byte account_status;
        //        [JsonProperty("account_is_remote_control")]
        [JsonIgnoreAttribute]
        public bool? account_is_remote_control;
        [JsonProperty("created")]
        public DateTime created;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonProperty("branch_id")]
        public String branch_id;

        public static Account GetInstance(String ObjID, OracleConnection con)
        {
            //   DBLogger.Debug("ACC");

            String AgrType = ObjID.Split(';')[0];
            UInt64 ACC = Convert.ToUInt64(ObjID.Split(';')[1]);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select rnk, agr_type, agr_code, agr_number, account_type, account_number, account_currency, account_mfo, account_open_date, account_close_date, account_status, account_is_remote_control, created, changed, user_login, user_fio, branch_id
                                  from TABLE (ead_integration.get_ACC_Instance_Set(:p_agr_type, :p_acc))";
            cmd.Parameters.Clear();
            cmd.BindByName = true;
            cmd.Parameters.Add("p_agr_type", OracleDbType.Varchar2, AgrType, ParameterDirection.Input);
            cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);

            Account res = new Account();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.agr_type = Convert.ToString(rdr["agr_type"]);
                    res.agr_code = Convert.ToString(rdr["agr_code"]);
                    res.agr_number = Convert.ToString(rdr["agr_number"]);
                    res.account_type = Convert.ToString(rdr["account_type"]);
                    res.account_number = Convert.ToString(rdr["account_number"]);
                    res.account_currency = Convert.ToString(rdr["account_currency"]);
                    res.account_mfo = Convert.ToUInt32(rdr["account_mfo"]);
                    res.account_open_date = Convert.ToDateTime(rdr["account_open_date"]);
                    res.account_close_date = rdr["account_close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["account_close_date"]);
                    res.account_status = Convert.ToByte(rdr["account_status"]);
                    res.account_is_remote_control = rdr["account_is_remote_control"] == DBNull.Value ? (Boolean?)null : Convert.ToBoolean(rdr["account_is_remote_control"]);
                    res.created = Convert.ToDateTime(rdr["created"]);
                    res.changed = Convert.ToDateTime(rdr["changed"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                }
                rdr.Close();
            }
            //  DBLogger.Debug("ACC ok");
            return res;
        }
    }

    /// <summary>
    /// Метод «SetAccountDataU» призначено для актуалізації інформації про рахунки корпоративного клієнта в рамках визначеної угоди клієнта
    /// </summary>
    public struct UAccount
    {
        [JsonProperty("RNK")]
        public UInt64 rnk;
        [JsonProperty("agr_code")]
        public String agr_code;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonIgnoreAttribute]
        public String agr_number;
        [JsonProperty("changed")]
        public DateTime changed;
        [JsonProperty("account_number")]
        public String account_number;
        [JsonProperty("currency_code")]
        public String currency_code;
        [JsonProperty("account_type")]
        public String account_type;
        [JsonProperty("mfo")]
        public UInt32 mfo;
        [JsonProperty("open_date")]
        public DateTime open_date;
        [JsonProperty("close_date")]
        public DateTime? close_date;
        [JsonProperty("branch_id")]
        public String branch_id;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;
        [JsonProperty("account_status")]
        public Byte account_status;
        [JsonProperty("remote_controled")]
        public bool remote_controled;
        //[JsonProperty("created")]
        //public DateTime Created;

        public static UAccount GetInstance(String ObjID, OracleConnection con)
        {
            //   DBLogger.Debug("UACC");

            String AgrType = ObjID.Split(';')[0];
            UInt64 ACC = Convert.ToUInt64(ObjID.Split(';')[1]);
            bool ReservedAcc = ObjID.Split(';').ElementAtOrDefault(2) == "RSRV";

            OracleCommand cmd = con.CreateCommand();
            cmd.Parameters.Clear();
            cmd.BindByName = true;
            cmd.Parameters.Add("p_agr_type", OracleDbType.Varchar2, AgrType, ParameterDirection.Input);
            if (ReservedAcc)
            {
                cmd.CommandText = @"select rnk, changed, created, user_login, user_fio, account_number, currency_code, mfo, branch_id, open_date, close_date, account_status, agr_number, agr_code, account_type, agr_type, remote_controled
                                 from TABLE (ead_integration.get_UACCRsrv_Instance_Set(:p_agr_type, :p_rsrv_id))";
                cmd.Parameters.Add("p_rsrv_id", OracleDbType.Int64, ACC, ParameterDirection.Input);
            }
            else
            {
                cmd.CommandText = @"select rnk, changed, created, user_login, user_fio, account_number, currency_code, mfo, branch_id, open_date, close_date, account_status, agr_number, agr_code, account_type, agr_type, remote_controled
                                 from TABLE (ead_integration.get_UACC_Instance_Set(:p_agr_type, :p_acc))";
                cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);
            }

            UAccount res = new UAccount();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.agr_code = Convert.ToString(rdr["agr_code"]);
                    res.agr_type = Convert.ToString(rdr["agr_type"]);
                    res.agr_number = Convert.ToString(rdr["agr_number"]);
                    res.changed = Convert.ToDateTime(rdr["changed"]);
                    res.account_number = Convert.ToString(rdr["account_number"]);
                    res.currency_code = Convert.ToString(rdr["currency_code"]);
                    res.account_type = Convert.ToString(rdr["account_type"]);
                    res.mfo = Convert.ToUInt32(rdr["mfo"]);
                    res.open_date = Convert.ToDateTime(rdr["open_date"]);
                    res.close_date = rdr["close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["close_date"]);
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                    res.account_status = Convert.ToByte(rdr["account_status"]);
                    res.remote_controled = Convert.ToBoolean(rdr["remote_controled"]);
                    //res.Created = Convert.ToDateTime(rdr["created"]);
                }
                rdr.Close();
            }
            //  DBLogger.Debug("ACC ok");
            return res;
        }
    }

    /// <summary>
    /// Параметри - Актуалізація ідент. документів
    /// </summary>
    public struct Actualization
    {
        [JsonProperty("RNK")]
        public UInt64 rnk;
        [JsonProperty("branch_id")]
        public String branch_id;
        [JsonProperty("actual_date")]
        public DateTime actual_date;
        [JsonProperty("user_login")]
        public String user_login;
        [JsonProperty("user_fio")]
        public String user_fio;

        public static Actualization GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select rnk, branch_id, user_login, user_fio,actual_date from TABLE (ead_integration.get_Act_Instance_Rec(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToUInt64(ObjID), ParameterDirection.Input);

            Actualization res = new Actualization();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.branch_id = Convert.ToString(rdr["branch_id"]);
                    res.actual_date = Convert.ToDateTime(rdr["actual_date"]);
                    res.user_login = Convert.ToString(rdr["user_login"]);
                    res.user_fio = Convert.ToString(rdr["user_fio"]);
                }

                rdr.Close();
            }
            return res;
        }
    }

    /// <summary>
    /// Параметри - Довідник
    /// </summary>
    public struct Dictionary
    {
        public static Object[] GetData(String ObjID, OracleConnection con)
        {
            Object[] res = null;
            switch (ObjID)
            {
                case "EA-UB":
                    List<Dicts.Dict_Data_Branch> list = Dicts.Dict_Data_Branch.GetInstanceList(con);
                    res = list.ConvertAll(item => (Object)item).ToArray();
                    break;
            }

            return res;
        }
    }

    /// <summary>
    /// Параметри - Начало сессии взаимодействия с ЕА
    /// </summary>
    public struct StartSession
    {
        public String User_Login;
        public String User_Fio;
        public String User_Password;
        public String EA_ServiceUrl;

        public static StartSession GetInstance(String kf)
        {
            StartSession res = new StartSession();
            IDbLogger _dbLogger;
            _dbLogger = DbLoggerConstruct.NewDbLogger();

            String EadParLogin = "ead.User_Login" + kf;
            String EadParUserFio = "ead.User_Fio" + kf;
            String EadParUserPassword = "ead.User_Password" + kf;
            String EAdServiceUrl = "ead.ServiceUrl" + kf;

            _dbLogger.Info(String.Format("EadParLogin= {0}, EadParUserFio= {1}, EadParUserPassword= {2} ", EadParLogin, EadParUserFio, EadParUserPassword));
            res.User_Login = Bars.Configuration.ConfigurationSettings.AppSettings[EadParLogin];
            res.User_Fio = Bars.Configuration.ConfigurationSettings.AppSettings[EadParUserFio];
            res.EA_ServiceUrl = Bars.Configuration.ConfigurationSettings.AppSettings[EAdServiceUrl];

            String PasswordClear = Bars.Configuration.ConfigurationSettings.AppSettings[EadParUserPassword];
            using (MD5 MD5Hash = MD5.Create())
            {
                String PasswordHash = StartSession.GetMd5Hash(MD5Hash, PasswordClear);
                res.User_Password = PasswordHash;
            }

            return res;
        }
        public static String GetMd5Hash(MD5 md5Hash, String input)
        {
            Byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
                sBuilder.Append(data[i].ToString("x2"));

            return sBuilder.ToString();
        }
    }

    /// <summary>
    /// Параметри - Данные документа
    /// </summary>
    public class DocumentData
    {
        [JsonProperty("RNK")]
        public UInt64? rnk;
        [JsonProperty("doc_id")]
        public String ID;
        [JsonProperty("doc_type")]
        public String Struct_Code;
        [JsonProperty("doc_request_number")]
        public String Doc_Request_Number;
        [JsonProperty("agr_code")]
        public Double? Agreement_ID;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("account_type")]
        public String account_type;
        [JsonProperty("account_number")]
        public String account_number;
        [JsonProperty("account_currency")]
        public String account_currency;


        public DocumentData(String ID)
        {
            this.ID = ID;
        }
        public DocumentData(Decimal rnk, Double? Agreement_ID, String Struct_Code)
        {
            this.rnk = Convert.ToUInt64(rnk);
            this.Agreement_ID = Agreement_ID;
            this.Struct_Code = Struct_Code;
        }
        public DocumentData(Decimal rnk, Double? Agreement_ID, String Struct_Code, String Doc_Request_Number, String agr_type, String account_type, String account_number, String account_currency)
        {
            this.rnk = Convert.ToUInt64(rnk);
            this.Agreement_ID = Agreement_ID;
            this.Struct_Code = Struct_Code;
            this.Doc_Request_Number = Doc_Request_Number;
            this.agr_type = agr_type;
            this.account_type = account_type;
            this.account_number = account_number;
            this.account_currency = account_currency;
        }
    }
}

namespace Bars.EAD.Structs.Result
{
    /// <summary>
    /// Ответ - Ошибка
    /// </summary>
    public class Error
    {
        [JsonProperty("error_code")]
        public String Error_Code;
        [JsonProperty("error_text")]
        public String Error_Text;
        [JsonProperty("error")]
        public String Error_Text2;

        public Error() { }
    }

    /// <summary>
    /// Ответ - Ошибка при EA crash
    /// </summary>
    public class ErrorOnCrash
    {
        [JsonProperty("code")]
        public String Error_Code;
        [JsonProperty("message")]
        public String Error_Text;

        public ErrorOnCrash() { }
    }

    /// <summary>
    /// Ответ синхронизации
    /// </summary>
    public class SyncResult
    {
        [JsonProperty("error")]
        public String Error
        {
            get;
            set;
        }

        public SyncResult() { }
    }

    /// <summary>
    /// Ответ - Надрукований документ
    /// </summary>
    public class Doc : SyncResult
    {
        [JsonProperty("ID")]
        public Int64 ID;

        public Doc() : base() { }
    }

    /// <summary>
    /// Ответ - Клієнт
    /// </summary>
    public class Client : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;

        public Client() : base() { }
    }
    /// <summary>
    /// Ответ - Клієнт юр.лицо
    /// </summary>
    public class UClient : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;

        public UClient() : base() { }
    }

    /// <summary>
    /// Ответ - Счета юр.лица
    /// </summary>
    public class Acc : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("ACCOUNTS")]
        public List<Int64> Accounts;

        public Acc() : base() { }
    }

    /// <summary>
    /// Ответ - Угода
    /// </summary>
    public class Agr : SyncResult
    {
        [JsonProperty("ID")]
        public Int64 ID;

        public Agr() : base() { }
    }
    /// <summary>
    /// Ответ - Угода Юр.особи
    /// </summary>
    public class UAgr : SyncResult
    {
        [JsonProperty("ID")]
        public String ID;

        public UAgr() : base() { }
    }

    /// <summary>
    /// Ответ - Актуалізація ідент. документів
    /// </summary>
    public class Act : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("DOCS")]
        public List<Int64> Docs;

        public Act() : base() { }
    }

    /// <summary>
    /// Ответ - Начало сессии взаимодействия с ЕА
    /// </summary>
    public class StartSession
    {
        [JsonProperty("sessionid")]
        public String SessionID;
    }

    /// <summary>
    /// Ответ - Закрытие сессии взаимодействия с ЕА
    /// </summary>
    public class CloseSession
    {
        [JsonProperty("sessionid")]
        public String SessionID;
    }

    /// <summary>
    /// Ответ - Данные документа
    /// </summary>
    public class DocumentData
    {
        [JsonProperty("doc_link")]
        public String DocLink { get; set; }
        [JsonProperty("struct_code")]
        public String Struct_Code { get; set; }
        [JsonProperty("struct_name")]
        public String Struct_Name { get; set; }

        public DocumentData()
        {
        }
    }
}

namespace Bars.EAD
{
    /// <summary>
    /// Сообщение ЕА - базовое
    /// </summary>
    public class BaseMessage
    {
        # region Приватные свойства
        protected String _Method;
        protected Object _Params;
        protected Int64 _ID;
        # endregion

        # region Публичные свойства
        [JsonProperty("method")]
        public String Method
        {
            get
            {
                return this._Method;
            }
        }
        [JsonProperty("params")]
        public Object Params
        {
            get
            {
                return this._Params;
            }
            set
            {
                this._Params = value;
            }
        }
        [JsonProperty("message_id")]
        public String Message_ID
        {
            get
            {
                return String.Format("BARS-MESS-{0}", this._ID);
            }
        }
        # endregion

        # region Конструктор
        public BaseMessage(String Method, Int64 ID)
        {
            this._Method = Method;
            this._ID = ID;
        }
        public BaseMessage(String Method, OracleConnection con)
            : this(Method, BaseMessage.GetNextID(con))
        {
        }
        # endregion

        # region Приватные методы
        # endregion

        # region Публичные методы
        public String GetJSONString()
        {
            JsonSerializerSettings settings = new JsonSerializerSettings();
            return Newtonsoft.Json.JsonConvert.SerializeObject(this, settings);
        }
        # endregion

        # region Статические методы
        public static Int64 GetNextID(OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select s_eadsyncqueue.nextval as sync_id from dual";

            Int64 res = Convert.ToInt64(cmd.ExecuteScalar());

            return res;
        }
        # endregion
    }

    /// <summary>
    /// Сообщение ЕА - сессионное
    /// </summary>
    public class SessionMessage : BaseMessage
    {
        # region Приватные свойства
        private String _SessionID;
        # endregion

        # region Публичные свойства
        [JsonProperty("sessionid")]
        public String SessionID
        {
            get
            {
                return this._SessionID;
            }
        }
        # endregion

        # region Конструктор
        public SessionMessage(String SessionID, String Method, Int64 ID)
            : base(Method, ID)
        {
            this._SessionID = SessionID;
        }
        public SessionMessage(String SessionID, String Method, OracleConnection con)
            : this(SessionID, Method, BaseMessage.GetNextID(con))
        {
        }
        # endregion

        # region Приватные методы
        # endregion

        # region Публичные методы
        # endregion
    }

    /// <summary>
    /// Сообщение ЕА - из очереди синхронизации
    /// </summary>
    public class SyncMessage : SessionMessage
    {
        # region Приватные свойства
        private DateTime _CrtDate;
        private String _TypeID;
        private String _ObjID;
        # endregion

        # region Публичные свойства
        [JsonIgnoreAttribute]
        public String TypeID
        {
            get
            {
                return this._TypeID;
            }
        }
        [JsonIgnoreAttribute]
        public String ObjID
        {
            get
            {
                return this._ObjID;
            }
        }
        # endregion

        # region Конструктор
        public SyncMessage(Int64 ID, String SessionID, OracleConnection con, String kf)
            : base(SessionID, SyncMessage.GetMethodByID(ID, con), ID)
        {
            Init(con, kf);
            InitParams(con);
        }
        # endregion

        # region Приватные методы
        private void Init(OracleConnection con, String kf)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select sq.crt_date, sq.type_id, sq.obj_id
                                  from ead_sync_queue sq, ead_types t
                                 where sq.id = :p_sync_id
                                   and sq.type_id = t.id
                                   and sq.kf = :p_kf";
            cmd.Parameters.Add("p_sync_id", OracleDbType.Int64, this._ID, ParameterDirection.Input);
            cmd.Parameters.Add("p_kf", OracleDbType.Int64, kf, ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    this._CrtDate = Convert.ToDateTime(rdr["crt_date"]);
                    this._TypeID = Convert.ToString(rdr["type_id"]);
                    this._ObjID = Convert.ToString(rdr["obj_id"]);
                }

                rdr.Close();
            }
        }
        private void InitParams(OracleConnection con)
        {
            switch (this.TypeID)
            {
                case "DOC":
                    this._Params = new Object[1] { Structs.Params.Document.GetInstance(this._ObjID, con) };
                    break;
                case "CLIENT":
                    this._Params = new Object[1] { Structs.Params.Client.GetInstance(this._ObjID, con) };
                    break;
                case "AGR":
                    this._Params = new Object[1] { Structs.Params.Agreement.GetInstance(this._ObjID, con) };
                    break;
                case "UAGR":
                    this._Params = new Object[1] { Structs.Params.UAgreement.GetInstance(this._ObjID, con) };
                    break;
                case "ACT":
                    this._Params = new Object[1] { Structs.Params.Actualization.GetInstance(this._ObjID, con) };
                    break;
                case "ACC":
                    this._Params = new Object[1] { Structs.Params.Account.GetInstance(this._ObjID, con) };//счета клиента-физ.лица
                    break;
                case "UACC":
                    this._Params = new Object[1] { Structs.Params.UAccount.GetInstance(this._ObjID, con) };//счета клиента-юр.лица
                    break;
                case "DICT":
                    this._Params = Structs.Params.Dictionary.GetData(this._ObjID, con);
                    break;
                case "UCLIENT":
                    this._Params = new Object[1] { Structs.Params.UClient.GetInstance(this._ObjID, con) };//Отдельный класс для клиентов юр.лиц в связи с разным подходом к формированию сообщения.
                    break;
            }
        }
        # endregion

        # region Публичные методы
        # endregion

        # region Статические методы
        public static String GetMethodByID(Int64 ID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select t.method
                                  from ead_sync_queue sq, ead_types t
                                 where sq.id = :p_sync_id
                                   and sq.type_id = t.id";
            cmd.Parameters.Add("p_sync_id", OracleDbType.Int64, ID, ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return res;
        }
        # endregion
    }

    /// <summary>
    /// Сообщение ЕА - Довідник
    /// </summary>
    public class DictMessage : SyncMessage
    {
        # region Приватные свойства
        # endregion

        # region Публичные свойства
        [JsonProperty("dictionary_id")]
        public String Dictionary_ID { get; set; }
        [JsonProperty("row_count")]
        public Int32 Row_Count { get; set; }
        # endregion

        # region Конструктор
        public DictMessage(Int64 ID, String SessionID, OracleConnection con, string kf)
            : base(ID, SessionID, con, kf)
        {
            InitParams(con);
        }
        # endregion

        # region Приватные методы
        private void InitParams(OracleConnection con)
        {
            this.Dictionary_ID = this.ObjID;
            this.Row_Count = (this.Params as Object[]).Length;
        }
        # endregion

        # region Публичные методы
        # endregion

        # region Статические методы
        # endregion
    }

    /// <summary>
    /// Cообщение ЕА - начало сессии взаимодействия с ЕА
    /// </summary>
    public class StartSessionMessage : BaseMessage
    {
        # region Приватные свойства
        # endregion

        # region Публичные свойства
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("user_password")]
        public String User_Password;
        public String EADServiceUrl;
        # endregion

        # region Конструктор
        public StartSessionMessage(OracleConnection con, String kf)
            : base("StartSession", con)
        {
            InitParams(con, kf);
        }
        # endregion

        # region Приватные методы
        private void InitParams(OracleConnection con, String kf)
        {
            Structs.Params.StartSession per = Structs.Params.StartSession.GetInstance(kf);

            this.User_Login = per.User_Login;
            this.User_Fio = per.User_Fio;
            this.User_Password = per.User_Password;
            this.EADServiceUrl = per.EA_ServiceUrl;
        }
        # endregion

        # region Публичные методы
        # endregion
    }

    /// <summary>
    /// Cообщение ЕА - закрытие сессии взаимодействия с ЕА
    /// </summary>
    public class CloseSessionMessage : SessionMessage
    {
        # region Приватные свойства
        # endregion

        # region Публичные свойства
        # endregion

        # region Конструктор
        public CloseSessionMessage(String SessionID, OracleConnection con)
            : base(SessionID, "CloseSession", con)
        {
        }
        # endregion

        # region Приватные методы
        # endregion

        # region Публичные методы
        # endregion
    }

    /// <summary>
    /// Ответ ЕА
    /// </summary>
    public class Response
    {
        # region Приватные свойства
        # endregion

        # region Публичные свойства
        [JsonIgnoreAttribute]
        public String Method;
        [JsonProperty("status")]
        public String Status;
        [JsonProperty("RESULT")]
        public Object Result;
        [JsonProperty("current_timestamp")]
        public DateTime Current_Timestamp;
        [JsonProperty("message_id")]
        public String Message_ID;
        [JsonProperty("responce_id")]
        public String Responce_ID;
        [JsonProperty("error")]
        public Bars.EAD.Structs.Result.ErrorOnCrash error;
        # endregion

        # region Конструктор
        public Response()
        {
        }
        # endregion

        # region Приватные методы
        # endregion

        # region Публичные методы
        # endregion

        # region Статические методы
        public static Response CreateFromJSONString(String Method, String JSONString)
        {
            JsonSerializerSettings settings = new JsonSerializerSettings();
            Response res = Newtonsoft.Json.JsonConvert.DeserializeObject<Response>(JSONString, settings);
            res.Method = Method;

            return res;
        }
        # endregion
    }

    /// <summary>
    /// Сервис для интеграции с ЕА
    /// version 3.2   01/02/2018
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class EADService : Bars.BarsWebService
    {
        private readonly IDbLogger _dbLogger;
        public EADService()
        {
            _dbLogger = DbLoggerConstruct.NewDbLogger();
        }

        #region Статические свойства
        public static String EA_ServiceUrl
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl"];
            }
        }
        public static Int32 EA_TimeOut
        {
            get
            {
                return Convert.ToInt32(Bars.Configuration.ConfigurationSettings.AppSettings["ead.TimeOut"]);
            }
        }
        public static String EA_ClientCertificateNumber
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.CertificateNumber"];
            }
        }
        public static Boolean EA_UsingSSL
        {
            get
            {
                return Convert.ToBoolean(Bars.Configuration.ConfigurationSettings.AppSettings["ead.Using_SSL"]);
            }
        }
        /*public static String EA_CertificatePath
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.CertificatePath"];
            }
        }
        public static String EA_CertificatePassword
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.CertificatePassword"];
            }
        }
        */
        # endregion

        # region Веб-методы
        [WebMethod(EnableSession = true)]
        public void MsgProcess(Int64 ID, String WSProxyUserName, String WSProxyPassword, String kf)
        {
            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);
            if (isAuthenticated)
            {
                LoginUser(WSProxyUserName);
            }
            else
            {
                //_dbLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
            }

            try
            {
                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

                // Начинаем сессию взаимодействия и вычитываем сообщение
                String SessionID;
                SyncMessage msg;
                if (con.State != ConnectionState.Open)
                    con.Open();
                try
                {
                    SessionID = StartSession(con, kf);

                    // если синхронизация справочников то используем другой класс
                    if (SyncMessage.GetMethodByID(ID, con) == "SetDictionaryData")
                    {
                        msg = new DictMessage(ID, SessionID, con, kf);
                    }
                    else
                    {
                        msg = new SyncMessage(ID, SessionID, con, kf);
                    }
                }
                finally
                {
                    con.Close();
                }
                String _EAServiceUrl = Convert.ToString(Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl" + kf]);
                // Формируем сообщение
                String MessageID = msg.Message_ID;
                DateTime MessageDate = DateTime.Now;
                String Message = msg.GetJSONString();

                BbConnection bb_con = new BbConnection();
                // пакет для записи в БД
                EadPack ep = new EadPack(bb_con);

                // устанавлдиваем статус
                ep.MSG_SET_STATUS_SEND(ID, MessageID, MessageDate, Message, kf);

                // отправляем запрос по Http
                Response rsp;
                try
                {
                    String ResponseText = GetEAResponseText(Message, _EAServiceUrl);
                    // сохраняем ответ
                    ep.MSG_SET_STATUS_RECEIVED(ID, ResponseText, kf);

                    // парсим ответ
                    rsp = Response.CreateFromJSONString(msg.Method, ResponseText);
                    ep.MSG_SET_STATUS_PARSED(ID, rsp.Responce_ID, rsp.Current_Timestamp, kf);

                    // Анализируем ответ
                    if (rsp.Status == "ERROR" || String.IsNullOrEmpty(rsp.Status))
                    {
                        // устанавлдиваем статус "Помилка"
                        if (rsp.Result != null)
                        {
                            Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                            ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", err.Error_Code, err.Error_Text), kf);
                        }
                        else
                        {
                            // Structs.Result.Error2 err2 = (rsp.error as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error2>();
                            ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", rsp.error.Error_Code, rsp.error.Error_Text), kf);
                        }
                    }
                    else
                    {
                        Boolean HasErrors = false;

                        foreach (Newtonsoft.Json.Linq.JToken obj in (rsp.Result as Newtonsoft.Json.Linq.JArray))
                        {
                            Structs.Result.SyncResult res = obj.ToObject<Structs.Result.SyncResult>();
                            if (!String.IsNullOrEmpty(res.Error))
                            {
                                // устанавлдиваем статус "Помилка"
                                ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}", res.Error), kf);
                                HasErrors = true;
                                break;
                            }
                        }

                        if (!HasErrors)
                            // устанавлдиваем статус "Виконано"
                            ep.MSG_SET_STATUS_DONE(ID, kf);
                    }
                }
                catch (System.Exception e)
                {  // устанавливаем статус "Помилка" и выходим
                    ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі SEND: {0}, {1}", e.Message, e.StackTrace), kf);
                }

                // Заканчиваем сессию взаимодействия
                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    CloseSession(SessionID, con, _EAServiceUrl);
                }
                finally
                {
                    con.Close();
                }
            }
            finally
            {
                LogOutUser();
            }
        }
        # endregion

        /// <summary>
        /// Copies the contents of input to output. Doesn't close either stream.
        /// </summary>
        public static void CopyStream(Stream input, Stream output)
        {
            byte[] buffer = new byte[8 * 1024];
            int len;
            while ((len = input.Read(buffer, 0, buffer.Length)) > 0)
            {
                output.Write(buffer, 0, len);
            }
        }
        # region Статические методы
        // Получить ответ по заданому запросу
        public static String GetEAResponseText(String Message, String _EAServiceUrl)
        {
            Byte[] MessageBytes = Encoding.UTF8.GetBytes(Message);
            String ResponseText;

            //создаем соединение WebRequest Request = WebRequest.Create(EA_ServiceUrl);
            HttpWebRequest Request = (HttpWebRequest)WebRequest.Create(_EAServiceUrl);
            if (EA_UsingSSL)//для SSL соединянния добавляем сертификат клиента
            {
                //добавляем сертификат клиента
                ClientCertificate CC = new ClientCertificate();

                try
                {
                    //находим в хранилище сертификат по серийному номеру
                    Request.ClientCertificates.Add(CC.GetCertificate(EA_ClientCertificateNumber));
                }
                catch (System.Exception ex)
                {/*обработка ошибок: сертификат не найден или другая*/
                    if (ex is ArgumentNullException)
                    {
                        return String.Format("Не вдалося встановити захищене з'еднання. Не знайдено сертифiкат користувача з номером: {0}", EA_ClientCertificateNumber);
                    }
                    else
                        return String.Format("Не вдалося встановити захищене з'еднання: {0}", ex.Message);
                }
            }

            Request.Method = "POST";
            Request.ContentType = "application/json; charset=\"UTF-8\";";
            Request.ContentLength = MessageBytes.Length;

            Request.Timeout = EA_TimeOut;
            //для синхронізації довідників таймаути збільшено.        
            if (Message.Contains("SetDictionaryData"))
            {
                Request.Timeout = EA_TimeOut * 10;
            }

            using (Stream RequestStream = Request.GetRequestStream())
            {

                RequestStream.Write(MessageBytes, 0, MessageBytes.Length);
                RequestStream.Close();
            }

            // ответ
            try
            {
                using (WebResponse Response = Request.GetResponse())
                {
                    using (Stream ResponseStream = Response.GetResponseStream())
                    {
                        using (StreamReader rdr = new StreamReader(ResponseStream))
                        {
                            ResponseText = rdr.ReadToEnd();
                            rdr.Close();
                        }
                        ResponseStream.Close();
                    }
                    Response.Close();
                }
                return ResponseText;
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
        }
        // Начать сессию взаимодействия с ЕА
        public static String StartSession(OracleConnection con, String kf)
        {
            String _EAServiceUrl = Convert.ToString(Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl" + kf]);
            String res = String.Empty;

            // Формируем сообщение
            StartSessionMessage msg = new StartSessionMessage(con, kf);
            String Message = msg.GetJSONString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message, _EAServiceUrl);

            Response rsp = Response.CreateFromJSONString("StartSession", ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR")
            {
                // устанавлдиваем статус "Помилка"
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                throw new System.Exception(String.Format("Неможливо розпочати сессію взаємодії з ЕА: {0}, {1}", err.Error_Code, err.Error_Text));
            }
            else
            {
                res = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.StartSession>().SessionID;
            }

            return res;
        }
        // Закрыть сессию взаимодействия с ЕА
        public static void CloseSession(String SessionID, OracleConnection con, String _EA_ServiceUrl)
        {
            // Формируем сообщение
            CloseSessionMessage msg = new CloseSessionMessage(SessionID, con);
            String Message = msg.GetJSONString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message, _EA_ServiceUrl);

            Response rsp = Response.CreateFromJSONString("CloseSession", ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR")
            {
                // устанавлдиваем статус "Помилка"
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                throw new System.Exception(String.Format("Неможливо закрити сессію взаємодії з ЕА: {0}, {1}", err.Error_Code, err.Error_Text));
            }
        }

        // получение данных документа
        /// <summary>
        /// GetDocumentData(Int64? ID ... String Doc_Request_Number)) - obsolete
        /// </summary>
        public static List<Structs.Result.DocumentData> GetDocumentData(Int64? ID, Decimal? Rnk, Double? Agreement_ID, Int16? Struct_Code, String Doc_Request_Number, String kf)
        {
            return GetDocumentData(ID.ToString(), Rnk, Agreement_ID, Struct_Code.ToString(), Doc_Request_Number, null, null, null, null, kf);
        }
        public static List<Structs.Result.DocumentData> GetDocumentData(String ID, Decimal? Rnk, Double? Agreement_ID, String Struct_Code, String Doc_Request_Number, String agr_type, String account_type, String account_number, String account_currency, String kf)
        {
            String _EAServiceUrl = Convert.ToString(Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl" + kf]);
            List<Structs.Result.DocumentData> res = new List<Structs.Result.DocumentData>();

            // считаем что пользователь авторизирован
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            // Начинаем сессию взаимодействия и вычитываем сообщение
            String SessionID;
            SessionMessage msg;
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                SessionID = StartSession(con, kf);
                msg = new SessionMessage(SessionID, "GetDocumentData", con);
            }
            finally
            {
                con.Close();
            }

            // формируем параметры запроса
            if (!String.IsNullOrWhiteSpace(ID))
                msg.Params = new Structs.Params.DocumentData(ID);
            else
            {
                if (String.IsNullOrEmpty(Doc_Request_Number))
                {
                    msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code);
                }
                else
                {
                    msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code, Doc_Request_Number, agr_type, account_type, account_number, account_currency);

                }
            }

            // Формируем сообщение
            String Message = msg.GetJSONString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message, _EAServiceUrl);

            // парсим ответ
            Response rsp = Response.CreateFromJSONString(msg.Method, ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR" || String.IsNullOrEmpty(rsp.Status))
            {
                // устанавлдиваем статус "Помилка"
                if (rsp.Result != null)
                {
                    Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                    throw new System.Exception(err.Error_Code + err.Error_Text);
                }
                else
                {
                    // Structs.Result.Error2 err2 = (rsp.error as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error2>();
                    throw new System.Exception(rsp.error.Error_Code + rsp.error.Error_Text);
                }
            }
            else
            {
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).First.ToObject<Structs.Result.Error>();
                if (!String.IsNullOrEmpty(err.Error_Text2) && err.Error_Text2.Contains("Documents not found.Document file name is empty")) throw new System.Exception(err.Error_Text2);

                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = "select name from ead_struct_codes where id = :p_id";
                    cmd.Parameters.Add("p_id", OracleDbType.Varchar2, ParameterDirection.Input);

                    foreach (Newtonsoft.Json.Linq.JToken obj in (rsp.Result as Newtonsoft.Json.Linq.JArray))
                    {
                        Structs.Result.DocumentData objDD = obj.ToObject<Structs.Result.DocumentData>();

                        // выбираем наименование документа из БД
                        cmd.Parameters["p_id"].Value = objDD.Struct_Code;
                        objDD.Struct_Name = Convert.ToString(cmd.ExecuteScalar());

                        res.Add(objDD);
                    }
                }
                finally
                {
                    con.Close();
                }
            }

            // Заканчиваем сессию взаимодействия
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                CloseSession(SessionID, con, _EAServiceUrl);
            }
            finally
            {
                con.Close();
            }

            return res;
        }
        # endregion
    }
}