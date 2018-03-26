using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Net;
using System.Text;
using System.IO;
using System.Security.Cryptography;

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
using System.Linq;


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
    public struct Doc
    {
        [JsonProperty("ID")]
        public UInt64 ID;
        [JsonProperty("RNK")]
        public UInt64? Rnk;
        [JsonProperty("agreement_id")]
        public Int64? Agreement_ID;
        [JsonProperty("doc_type")]
        public String Doc_Type;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("branch_id")]
        public String Branch_ID;
        [JsonProperty("struct_code")]
        public Int16 Struct_Code;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("pages_count")]
        public Int64? Pages_Count;
        [JsonProperty("binary_data")]
        public String Binary_Data;
        [JsonProperty("linkedrnk")]
        public Int64? LinkedRnk;
        [JsonProperty("doc_request_number")]
        public String Doc_Request_Number;


        public static Doc GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select id, agreement_id, doc_type, user_login, user_fio, branch_id, struct_code, changed, created, pages_count, binary_data, rnk, linkedrnk, doc_request_number
                                from table(ead_integration.get_Doc_Instance(:p_doc_id))";
            cmd.Parameters.Add("p_doc_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Doc res = new Doc();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.ID = Convert.ToUInt64(rdr["id"]);
                    res.Agreement_ID = rdr["agreement_id"] == DBNull.Value ? (Int64?)null : Convert.ToInt64(rdr["agreement_id"]);
                    res.Doc_Type = Convert.ToString(rdr["doc_type"]);
                    res.User_Login = Convert.ToString(rdr["user_login"]);
                    res.User_Fio = Convert.ToString(rdr["user_fio"]);
                    res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                    res.Struct_Code = Convert.ToInt16(rdr["struct_code"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
                    res.Created = Convert.ToDateTime(rdr["created"]);
                    res.Pages_Count = Convert.ToInt64(rdr["pages_count"]);
                    res.Binary_Data = rdr["binary_data"] == DBNull.Value ? String.Empty : Convert.ToBase64String((Byte[])rdr["binary_data"]);
                    res.Rnk = rdr["rnk"] == DBNull.Value ? (UInt64?)null : Convert.ToUInt64(rdr["rnk"]);
                    res.LinkedRnk = rdr["linkedrnk"] == DBNull.Value ? (Int64?)null : Convert.ToInt64(rdr["linkedrnk"]);
                    res.Doc_Request_Number = Convert.ToString(rdr["doc_request_number"]);
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
        public String Branch_ID;
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("fio")]
        public String Fio;
        [JsonProperty("client_type")]
        public String Client_Type;
        [JsonProperty("inn")]
        public String Inn;
        [JsonProperty("birth_date")]
        public DateTime? Birth_Date;
        [JsonProperty("document_series")]
        public String Document_Series;
        [JsonProperty("document_number")]
        public String Document_Number;
        [JsonProperty("client_data")]
        public String Client_Data;
        [JsonProperty("mergedRNK")]
        public List<Int64> MergedRNK;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonIgnoreAttribute]
        public String Document_Type;

        public static Client GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"SELECT rnk, changed, created, branch_id, user_login, user_fio, client_type,
                                       fio, inn, birth_date, document_type, document_series, document_number, client_data
                                  FROM TABLE (ead_integration.get_Client_Instance(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Client res = new Client();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
                    res.Created = Convert.ToDateTime(rdr["created"]);
                    res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                    res.User_Login = Convert.ToString(rdr["user_login"]);
                    res.User_Fio = Convert.ToString(rdr["user_fio"]);
                    res.Client_Type = Convert.ToString(rdr["client_type"]);
                    res.Fio = Convert.ToString(rdr["fio"]);
                    res.Inn = Convert.ToString(rdr["inn"]);
                    res.Birth_Date = rdr["birth_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["birth_date"]);
                    res.Document_Type = Convert.ToString(rdr["document_type"]);
                    res.Document_Series = Convert.ToString(rdr["document_series"]);
                    res.Document_Number = Convert.ToString(rdr["document_number"]);
                    res.Client_Data = Convert.ToString(rdr["client_data"]);

                }
                rdr.Close();
            }

            // влитые РНК
            res.MergedRNK = new List<Int64>();

            cmd.CommandText = @"select mrg_rnk from TABLE (ead_integration.get_MergedRNK(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.MergedRNK.Add(Convert.ToInt64(rdr["mrg_rnk"]));
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
        public String Branch_ID;
        [JsonProperty("rnk")]
        public UInt64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("client_type")]
        public String Client_Type;
        [JsonProperty("client_name")]
        public String Client_Name;
        [JsonProperty("inn_edrpou")]
        public String Inn_edrpou;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("actualized_date")]
        public DateTime Actualized_Date;
        [JsonProperty("actualized_by")]
        public String Actualized_By;
        [JsonProperty("mergedRNK")]
        public List<UInt64> MergedRNK;
        [JsonProperty("third_persons_clients")]
        public List<Third_Persons_Clients> Third_Persons_Clients;
        [JsonProperty("third_persons_non_clients")]
        public List<Third_Persons_Non_Clients> Third_Persons_Non_Clients;

        public static UClient GetInstance(String ObjID, OracleConnection con)
        {
            UClient res = new UClient();

            //DBLogger.Debug("UCLIENT rnk = " + ObjID);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select branch_id,rnk,changed,created,client_type,client_name,inn_edrpou,user_login,user_fio,actualized_date,actualized_by
                                  from TABLE (ead_integration.get_UClient_Instance(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    // DBLogger.Debug("Uclient:  res.Rnk = " + res.Rnk.ToString());
                    res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                    res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
                    res.Created = Convert.ToDateTime(rdr["created"]);
                    res.Client_Type = Convert.ToString(rdr["client_type"]);
                    res.Client_Name = Convert.ToString(rdr["client_name"]);
                    res.Inn_edrpou = Convert.ToString(rdr["inn_edrpou"]);
                    res.User_Login = Convert.ToString(rdr["user_login"]);
                    res.User_Fio = Convert.ToString(rdr["user_fio"]);
                    res.Actualized_Date = Convert.ToDateTime(rdr["actualized_date"]);
                    res.Actualized_By = Convert.ToString(rdr["actualized_by"]);
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
                    res.Third_Persons_Non_Clients.Add(new Third_Persons_Non_Clients(Convert.ToUInt64(rdr["id"]), Convert.ToInt16(rdr["personstateid"]), Convert.ToString(rdr["name"]), Convert.ToInt16(rdr["client_type"]), Convert.ToString(rdr["inn_edrpou"])
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
        public UInt64 Rnk;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("date_begin_powers")]
        public DateTime? BDate;
        [JsonProperty("date_end_powers")]
        public DateTime? EDate;


        public Third_Persons_Clients(UInt64 Rnk, Int16 PersonStateID, DateTime? BDate, DateTime? EDate)
        {
            this.Rnk = Rnk;
            this.PersonStateID = PersonStateID;
            this.BDate = BDate;
            this.EDate = EDate;
        }
    }
    /// <summary>
    /// Параметри - Юр.лицо - третьи лица не кліенти банку
    /// </summary>
    public struct Third_Persons_Non_Clients
    {
        [JsonProperty("ID")]
        public UInt64 ID;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("Name")]
        public String Name;
        [JsonProperty("client_type")]
        public Int16 Client_Type;
        [JsonProperty("inn_edrpou")]
        public String Inn_Edrpou;
        [JsonProperty("date_begin_powers")]
        public DateTime? BDate;
        [JsonProperty("date_end_powers")]
        public DateTime? EDate;

        public Third_Persons_Non_Clients(UInt64 ID, Int16 PersonStateID, String Name, Int16 Client_Type, String Inn_Edrpou, DateTime? BDate, DateTime? EDate)
        {
            this.ID = ID;
            this.PersonStateID = PersonStateID;
            this.Client_Type = Client_Type;
            this.Name = Name;
            this.Inn_Edrpou = Inn_Edrpou;
            this.BDate = BDate;
            this.EDate = EDate;

        }
    }
    /// <summary>
    /// Параметри - Угода - Связанное лицо
    /// </summary>
    public struct LinkedRNK
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("LinkPersonStateID")]
        public Int64 LinkPersonStateID;

        public LinkedRNK(UInt64 Rnk, Int16 LinkPersonStateID)
        {
            this.Rnk = Rnk;
            this.LinkPersonStateID = LinkPersonStateID;
        }
    }
    /// <summary>
    /// Параметри - Угода
    /// </summary>
    public struct Agr
    {
        [JsonProperty("agr_code")]
        public UInt64 Agr_code;
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("branch_id")]
        public String Branch_ID;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("agr_type")]
        public String Agr_Type;
        [JsonProperty("agr_status")]
        public String Agr_Status;
        [JsonProperty("agr_number")]
        public String Agr_Number;
        [JsonProperty("agr_date_open")]
        public DateTime Agr_date_open;
        [JsonProperty("account_number")]
        public String Account_Number;
        [JsonProperty("agr_date_close")]
        public DateTime? Agr_date_close;
        [JsonProperty("linkedRNK")]
        public List<LinkedRNK> LinkedRNK;

        public static Agr GetInstance(String ObjID, OracleConnection con)
        {

            String AgrType = ObjID.Split(';')[0];
            OracleCommand cmd = con.CreateCommand();
            Agr res = new Agr();

            switch (AgrType)
            {
                case "DPT":
                    Decimal DptID = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close, account_number
                                          from TABLE (ead_integration.get_AgrDPT_Instance_Set(:p_agr_id))";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Int64, Convert.ToInt64(DptID), ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            res.Agr_code = Convert.ToUInt64(rdr["agr_code"]);
                            res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                            res.Changed = Convert.ToDateTime(rdr["changed"]);
                            res.Created = Convert.ToDateTime(rdr["created"]);
                            res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                            res.User_Login = Convert.ToString(rdr["user_login"]);
                            res.User_Fio = Convert.ToString(rdr["user_fio"]);
                            res.Agr_Type = Convert.ToString(rdr["agr_type"]);
                            res.Agr_Status = Convert.ToString(rdr["agr_status"]);
                            res.Agr_Number = Convert.ToString(rdr["agr_number"]);
                            res.Agr_date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                            res.Account_Number = Convert.ToString(rdr["account_number"]);
                            res.Agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                        }

                        rdr.Close();
                    }

                    // связанные РНК
                    res.LinkedRNK = new List<LinkedRNK>();

                    cmd.CommandText = @"select rnk, linkpersonstateid from TABLE (ead_integration.get_AgrDPT_LinkedRnk_Set(:p_agr_id))";//в выборку не должны попадать дублирующие записи.
                    //Union - в выборку должен попасть вноситель вклада(ACTION_ID = 0) если на данный момент он не владелец счета (t1.rnk <> t2.rnk)
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Int64, Convert.ToUInt64(DptID), ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            res.LinkedRNK.Add(new LinkedRNK(Convert.ToUInt64(rdr["rnk"]), Convert.ToInt16(rdr["linkpersonstateid"])));
                        }

                        rdr.Close();
                    }
                    break;

                case "WAY":
                    Decimal ND = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select agr_code, rnk, changed, created, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close, account_number
                                          from TABLE (ead_integration.get_AgrBPK_Instance_Set(:p_agr_id))";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Int64, Convert.ToInt64(ND), ParameterDirection.Input);

                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            res.Agr_code = Convert.ToUInt64(rdr["agr_code"]);
                            res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                            res.Changed = Convert.ToDateTime(rdr["changed"]);
                            res.Created = Convert.ToDateTime(rdr["created"]);
                            res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                            res.User_Login = Convert.ToString(rdr["user_login"]);
                            res.User_Fio = Convert.ToString(rdr["user_fio"]);
                            res.Agr_Type = Convert.ToString(rdr["agr_type"]);
                            res.Agr_Status = Convert.ToString(rdr["agr_status"]);
                            res.Agr_Number = Convert.ToString(rdr["agr_number"]);
                            res.Agr_date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                            res.Account_Number = Convert.ToString(rdr["account_number"]);
                            res.Agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                        }

                        rdr.Close();
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
    public struct UAgr
    {
        [JsonProperty("agr_code")]
        public String Agr_code;
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("client_type")]
        public Int64 Client_type;
        [JsonProperty("branch_id")]
        public String Branch_ID;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("agr_type")]
        public String Agr_Type;
        [JsonProperty("agr_status")]
        public String Agr_Status;
        [JsonProperty("agr_number")]
        public String Agr_Number;
        [JsonProperty("agr_date_open")]
        public DateTime Agr_Date_open;
        [JsonProperty("agr_date_close")]
        public DateTime? Agr_date_close;

        public static UAgr GetInstance(String ObjID, OracleConnection con)
        {
            //dbLogger.Info("UAGR obj_id = " + ObjID);
            String AgrType = ObjID.Split(';')[0];
            OracleCommand cmd = con.CreateCommand();
            switch (AgrType)
            {
                case "DPT":
                    Decimal DpuID = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select agr_code, rnk, changed, created, client_type, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDPU_Instance_Set(:p_dpu_id))";
                    //DBLogger.Info("p_dpu_id = " + DpuID.ToString());

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_dpu_id", OracleDbType.Decimal, DpuID, ParameterDirection.Input);

                    break;
                case "ACC":
                    Decimal ACC = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[0]);
                    //DateTime Daos = DateTime.ParseExact(ObjID.Split(';')[1].Split('|')[1], "yyyyMMdd", null);
                    //Decimal RNK = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[2]);

                    cmd.CommandText = @"select agr_code, rnk, changed, created, client_type, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrACC_Instance_Set(:p_acc))";
                    //DBLogger.Info("p_branch = " + Branch + " p_daos = " + Daos + " p_rnk = " + RNK);

                    cmd.Parameters.Clear();
                    //cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
                    //cmd.Parameters.Add("p_daos", OracleDbType.Date, Daos, ParameterDirection.Input);
                    //cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                    cmd.Parameters.Add("p_acc", OracleDbType.Decimal, ACC, ParameterDirection.Input);

                    break;
                case "DPT_OLD":
                    String NLS = ObjID.Split(';')[1].Split('|')[0];
                    DateTime Daos = DateTime.ParseExact(ObjID.Split(';')[1].Split('|')[1], "yyyyMMdd", null);
                    ACC = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[2]);

                    cmd.CommandText = @"select agr_code, rnk, changed, created, client_type, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDPTOLD_Instance_Set(:p_nls, :p_daos, :p_acc))";
                    //DBLogger.Info("p_nls = " + NLS + " p_daos = " + Daos + " p_acc = " + ACC);

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, NLS, ParameterDirection.Input);
                    cmd.Parameters.Add("p_daos", OracleDbType.Date, Daos, ParameterDirection.Input);
                    cmd.Parameters.Add("p_acc", OracleDbType.Decimal, ACC, ParameterDirection.Input);

                    break;
                case "DBO":
                    Decimal DBO = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[0]);
                    //dbLogger.Info("UAGR DBO(RNK) = " + DBO);
                    cmd.CommandText = @"select agr_code, rnk, changed, created, client_type, branch_id, user_login, user_fio, agr_type, 
                                               agr_status, agr_number, agr_date_open, agr_date_close
                                          from TABLE (ead_integration.get_UAgrDBO_Instance_Set(:p_rnk))";

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_rnk", OracleDbType.Int64, DBO, ParameterDirection.Input);
                    
                    break;
                default:
                    throw new Bars.Exception.BarsException("Попытка создать объект сделка UAgr неизвестного типа " + AgrType);
            }

            //dbLogger.Info("cmd.CommandText = " + cmd.CommandText);

            UAgr res = new UAgr();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    //   DBLogger.Info("Convert.ToString(rdr[agr_code]) = " + Convert.ToString(rdr["agr_code"]));

                    res.Agr_code = Convert.ToString(rdr["agr_code"]);
                    res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
                    res.Created = Convert.ToDateTime(rdr["created"]);
                    res.Client_type = Convert.ToInt64(rdr["client_type"]);
                    res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                    res.User_Login = Convert.ToString(rdr["user_login"]);
                    res.User_Fio = Convert.ToString(rdr["user_fio"]);
                    res.Agr_Type = Convert.ToString(rdr["agr_type"]);
                    res.Agr_Status = Convert.ToString(rdr["agr_status"]);
                    res.Agr_Number = Convert.ToString(rdr["agr_number"]);
                    res.Agr_Date_open = Convert.ToDateTime(rdr["agr_date_open"]);
                    res.Agr_date_close = rdr["agr_date_close"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["agr_date_close"]);
                }

                //  DBLogger.Info("res_id = " + res.Agr_code);
                rdr.Close();
            }

            return res;
        }
    }
    /// <summary>
    /// Метод «SetAccountDataU» призначено для актуалізації інформації про рахунки корпоративного клієнта в рамках визначеної угоди клієнта
    /// </summary>
    public struct Account
    {
        [JsonProperty("RNK")]
        public UInt64 RNK;
        [JsonProperty("agr_number")]
        public String agr_number;
        [JsonProperty("agr_code")]
        public String agr_code;
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("changed")]
        public DateTime Changed;
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
        public byte account_status;
        [JsonProperty("remote_controled")]
        public bool remote_controled;
        //[JsonProperty("created")]
        //public DateTime Created;

        public static Account GetInstance(String ObjID, OracleConnection con)
        {
            //   DBLogger.Debug("ACC");

            String AgrType = ObjID.Split(';')[0];
            UInt64 ACC = Convert.ToUInt64(ObjID.Split(';')[1]);
			bool ReservedAcc = ObjID.Split(';').ElementAtOrDefault(2) == "RSRV";

            OracleCommand cmd = con.CreateCommand();
			cmd.Parameters.Clear();
            cmd.BindByName = true;
            cmd.Parameters.Add("p_agr_type", OracleDbType.Varchar2, AgrType, ParameterDirection.Input);
			if(ReservedAcc)
            {
                cmd.CommandText = @"select rnk, changed, created, user_login, user_fio, account_number, currency_code, mfo, branch_id, open_date, close_date, account_status, agr_number, agr_code, account_type, agr_type, remote_controled
                                 from TABLE (ead_integration.get_UACCRsrv_Instance_Set(:p_agr_type, :p_rsrv_id))";
                cmd.Parameters.Add("p_rsrv_id", OracleDbType.Int64, ACC, ParameterDirection.Input);
            }
            else
            {
				cmd.CommandText = @"select rnk, changed, created, user_login, user_fio, account_number, currency_code, mfo, branch_id, open_date, close_date, account_status, agr_number, agr_code, account_type, agr_type, remote_controled
                                  from TABLE (ead_integration.get_ACC_Instance_Set(:p_agr_type, :p_acc))";            
				cmd.Parameters.Add("p_acc", OracleDbType.Int64, ACC, ParameterDirection.Input);
			}

            Account res = new Account();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.RNK = Convert.ToUInt64(rdr["rnk"]);
                    res.agr_number = Convert.ToString(rdr["agr_number"]);
                    res.agr_code = Convert.ToString(rdr["agr_code"]);
                    res.agr_type = Convert.ToString(rdr["agr_type"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
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
    public struct Act
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("branch_id")]
        public String Branch_ID;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("actual_date")]
        public DateTime Actual_Date;

        public static Act GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select rnk, branch_id, user_login, user_fio,actual_date from TABLE (ead_integration.get_Act_Instance_Rec(:p_rnk))";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToUInt64(ObjID), ParameterDirection.Input);

            Act res = new Act();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.Rnk = Convert.ToUInt64(rdr["rnk"]);
                    res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                    res.User_Login = Convert.ToString(rdr["user_login"]);
                    res.User_Fio = Convert.ToString(rdr["user_fio"]);
                    res.Actual_Date = Convert.ToDateTime(rdr["actual_date"]);
                }

                rdr.Close();
            }
            return res;
        }
    }

    /// <summary>
    /// Параметри - Довідник
    /// </summary>
    public struct Dict
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

        public static StartSession GetInstance()
        {
            StartSession res = new StartSession();

            res.User_Login = Bars.Configuration.ConfigurationSettings.AppSettings["ead.User_Login"];
            res.User_Fio = Bars.Configuration.ConfigurationSettings.AppSettings["ead.User_Fio"];

            String PasswordClear = Bars.Configuration.ConfigurationSettings.AppSettings["ead.User_Password"];
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
        [JsonProperty("ID")]
        public Int64? ID;
        [JsonProperty("RNK")]
        public UInt64? Rnk;
        [JsonProperty("struct_code")]
        public Int16? Struct_Code;
        [JsonProperty("agreement_id")]
        public Double? Agreement_ID;
        [JsonProperty("doc_request_number")]
        public String Doc_Request_Number;
/*
        [JsonProperty("agr_type")]
        public String agr_type;
        [JsonProperty("account_type")]
        public String account_type;
        [JsonProperty("account_number")]
        public String account_number;
        [JsonProperty("account_currency")]
        public String account_currency;
*/

        public DocumentData(Int64? ID)
        {
            this.ID = ID;
        }
        public DocumentData(Decimal Rnk, Double? Agreement_ID, Int16? Struct_Code)
        {
            this.Rnk = Convert.ToUInt64(Rnk);
            this.Agreement_ID = Agreement_ID;
            this.Struct_Code = Struct_Code;
        }
        public DocumentData(Decimal Rnk, Double? Agreement_ID, Int16? Struct_Code, String Doc_Request_Number, String agr_type, String account_type, String account_number, String account_currency)
        {
            this.Rnk = Convert.ToUInt64(Rnk);
            this.Agreement_ID = Agreement_ID;
            this.Struct_Code = Struct_Code;
            this.Doc_Request_Number = Doc_Request_Number;
/*
            this.agr_type = agr_type;
            this.account_type = account_type;
            this.account_number = account_number;
            this.account_currency = account_currency;
*/
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
        public Int16 Struct_Code { get; set; }
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
        public SyncMessage(Int64 ID, String SessionID, OracleConnection con)
            : base(SessionID, SyncMessage.GetMethodByID(ID, con), ID)
        {
            Init(con);
            InitParams(con);
        }
        # endregion

        # region Приватные методы
        private void Init(OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select sq.crt_date, sq.type_id, sq.obj_id
                                  from ead_sync_queue sq, ead_types t
                                 where sq.id = :p_sync_id
                                   and sq.type_id = t.id";
            cmd.Parameters.Add("p_sync_id", OracleDbType.Int64, this._ID, ParameterDirection.Input);

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
                    this._Params = new Object[1] { Structs.Params.Doc.GetInstance(this._ObjID, con) };
                    break;
                case "CLIENT":
                    this._Params = new Object[1] { Structs.Params.Client.GetInstance(this._ObjID, con) };
                    break;
                case "AGR":
                    this._Params = new Object[1] { Structs.Params.Agr.GetInstance(this._ObjID, con) };
                    break;
                case "UAGR":
                    this._Params = new Object[1] { Structs.Params.UAgr.GetInstance(this._ObjID, con) };
                    break;
                case "ACT":
                    this._Params = new Object[1] { Structs.Params.Act.GetInstance(this._ObjID, con) };
                    break;
                case "ACC":
                    this._Params = new Object[1] { Structs.Params.Account.GetInstance(this._ObjID, con) };//счета клиента-юр.лица
                    break;
                case "DICT":
                    this._Params = Structs.Params.Dict.GetData(this._ObjID, con);
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
        public DictMessage(Int64 ID, String SessionID, OracleConnection con)
            : base(ID, SessionID, con)
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
        # endregion

        # region Конструктор
        public StartSessionMessage(OracleConnection con)
            : base("StartSession", con)
        {
            InitParams(con);
        }
        # endregion

        # region Приватные методы
        private void InitParams(OracleConnection con)
        {
            Structs.Params.StartSession per = Structs.Params.StartSession.GetInstance();

            this.User_Login = per.User_Login;
            this.User_Fio = per.User_Fio;
            this.User_Password = per.User_Password;
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
    /// version 3.1   01/01/2018
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

        # region Приватные методы
        private string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        private void LoginUser(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, GetHostName(), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }
        # endregion

        # region Веб-методы
        [WebMethod(EnableSession = true)]
        public void MsgProcess(Int64 ID, String WSProxyUserName, String WSProxyPassword)
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
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            // Начинаем сессию взаимодействия и вычитываем сообщение
            String SessionID;
            SyncMessage msg;
            if (con.State != ConnectionState.Open)
                con.Open();
            try
            {
                SessionID = StartSession(con);

                // если синхронизация справочников то используем другой класс
                if (SyncMessage.GetMethodByID(ID, con) == "SetDictionaryData")
                {
                    msg = new DictMessage(ID, SessionID, con);
                }
                else
                {
                    msg = new SyncMessage(ID, SessionID, con);
                }
            }
            finally
            {
                con.Close();
            }

            // Формируем сообщение
            String MessageID = msg.Message_ID;
            DateTime MessageDate = DateTime.Now;
            String Message = msg.GetJSONString();

            BbConnection bb_con = new BbConnection();
            // пакет для записи в БД
            EadPack ep = new EadPack(bb_con);

            // устанавлдиваем статус
            ep.MSG_SET_STATUS_SEND(ID, MessageID, MessageDate, Message);

            // отправляем запрос по Http
            Response rsp;
            try
            {
                String ResponseText = GetEAResponseText(Message);
                // сохраняем ответ
                ep.MSG_SET_STATUS_RECEIVED(ID, ResponseText);

                // парсим ответ
                rsp = Response.CreateFromJSONString(msg.Method, ResponseText);
                ep.MSG_SET_STATUS_PARSED(ID, rsp.Responce_ID, rsp.Current_Timestamp);

                // Анализируем ответ
                if (rsp.Status == "ERROR" || String.IsNullOrEmpty(rsp.Status))
                {
                    // устанавлдиваем статус "Помилка"
                    if (rsp.Result != null)
                    {
                        Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                        ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", err.Error_Code, err.Error_Text));
                    }
                    else
                    {
                        // Structs.Result.Error2 err2 = (rsp.error as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error2>();
                        ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", rsp.error.Error_Code, rsp.error.Error_Text));
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
                            ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}", res.Error));
                            HasErrors = true;
                            break;
                        }
                    }

                    if (!HasErrors)
                        // устанавлдиваем статус "Виконано"
                        ep.MSG_SET_STATUS_DONE(ID);
                }
            }
            catch (System.Exception e)
            {  // устанавливаем статус "Помилка" и выходим
                ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі SEND: {0}, {1}", e.Message, e.StackTrace));
            }

            // Заканчиваем сессию взаимодействия
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                CloseSession(SessionID, con);
            }
            finally
            {
                con.Close();
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
        public static String GetEAResponseText(String Message)
        {
            Byte[] MessageBytes = Encoding.UTF8.GetBytes(Message);
            String ResponseText;

            //создаем соединение WebRequest Request = WebRequest.Create(EA_ServiceUrl);
            HttpWebRequest Request = (HttpWebRequest)WebRequest.Create(EA_ServiceUrl);
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
        public static String StartSession(OracleConnection con)
        {
            String res = String.Empty;

            // Формируем сообщение
            StartSessionMessage msg = new StartSessionMessage(con);
            String Message = msg.GetJSONString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message);

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
        public static void CloseSession(String SessionID, OracleConnection con)
        {
            // Формируем сообщение
            CloseSessionMessage msg = new CloseSessionMessage(SessionID, con);
            String Message = msg.GetJSONString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message);

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
        public static List<Structs.Result.DocumentData> GetDocumentData(Int64? ID, Decimal? Rnk, Double? Agreement_ID, Int16? Struct_Code, String Doc_Request_Number)
        {
            return GetDocumentData(ID, Rnk, Agreement_ID, Struct_Code, Doc_Request_Number, null, null, null, null);
        }
        public static List<Structs.Result.DocumentData> GetDocumentData(Int64? ID, Decimal? Rnk, Double? Agreement_ID, Int16? Struct_Code, String Doc_Request_Number, String agr_type, String account_type, String account_number, String account_currency)
        {
            List<Structs.Result.DocumentData> res = new List<Structs.Result.DocumentData>();

            // считаем что пользователь авторизирован
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            // Начинаем сессию взаимодействия и вычитываем сообщение
            String SessionID;
            SessionMessage msg;
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                SessionID = StartSession(con);
                msg = new SessionMessage(SessionID, "GetDocumentData", con);
            }
            finally
            {
                con.Close();
            }

            // формируем параметры запроса
            if (ID.HasValue)
                msg.Params = new Structs.Params.DocumentData(ID.Value);
            else
            {
                if (String.IsNullOrEmpty(Doc_Request_Number))
                {
                    msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code.Value);
                }
                else
                {
                    msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code.Value, Doc_Request_Number, agr_type, account_type, account_number, account_currency);

                }
            }

            // Формируем сообщение
            String Message = msg.GetJSONString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message);

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
                    cmd.Parameters.Add("p_id", OracleDbType.Int16, ParameterDirection.Input);

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
                CloseSession(SessionID, con);
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