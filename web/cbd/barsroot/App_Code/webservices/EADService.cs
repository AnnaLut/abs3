using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Xml;
using System.Globalization;
using System.Web.Script.Serialization;

using System.Net;
using System.Text;
using System.IO;
using System.Configuration;
using System.Security.Cryptography;
using System.Net.Mime;

using Bars.Application;
using Bars.Classes;
using barsroot.core;
using ibank.core;
using Bars.EAD;
using Bars.Logger;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Newtonsoft.Json;
using System.Security.Cryptography.X509Certificates;

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
            cmd.CommandText = @"select b.branch as code, b.name, b.date_closed as close_date
                                  from branch b
                                 order by b.branch";

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
        public Int64 ID;
        [JsonProperty("RNK")]
        public Int64? Rnk;
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


        public static Doc GetInstance(String ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"SELECT id,
       agreement_id,
       doc_type,
       user_login,
       user_fio,
       branch_id,
       struct_code,
       changed,
       created,
       nvl(pages_count,1) as pages_count,
       binary_data,
       NVL (rnk, linkedrnk) AS rnk,
       CASE WHEN rnk <> linkedrnk THEN linkedrnk ELSE NULL END AS linkedrnk
  FROM (SELECT d.id,
               d.rnk AS linkedrnk,
               d.agr_id AS agreement_id,
               LOWER (type_id) AS doc_type,
               sb.logname AS user_login,
               sb.fio AS user_fio,
               d.crt_branch AS branch_id,
               d.ea_struct_id AS struct_code,
               d.crt_date AS changed,
               d.crt_date AS created,
               d.page_count as pages_count, 
               d.scan_data AS binary_data,
               (SELECT DISTINCT
                       FIRST_VALUE (dds.rnk) OVER (ORDER BY idupd DESC)
                  FROM dpt_deposit_clos dds
                 WHERE dds.deposit_id = d.agr_id)
                  AS rnk
                                  from ead_docs d, staff$base sb
                                 where d.id = :p_doc_id
                                   and d.crt_staff_id = sb.id)";
            cmd.Parameters.Add("p_doc_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Doc res = new Doc();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.ID = Convert.ToInt64(rdr["id"]);
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
                    res.Rnk = rdr["rnk"] == DBNull.Value ? (Int64?)null : Convert.ToInt64(rdr["rnk"]);
                    res.LinkedRnk = rdr["linkedrnk"] == DBNull.Value ? (Int64?)null : Convert.ToInt64(rdr["linkedrnk"]);

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
        public Int64 Rnk;
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
            cmd.CommandText = @"select c.rnk,
                                       (select nvl(max(chgdate),C.DATE_ON) from customer_update  where rnk = c.rnk)  as changed,
                                       c.date_on as created,
                                       c.branch as branch_id,
                                       nvl((select sb.logname from  staff$base sb, customer_update cu where  cu.doneby = sb.logname and cu.idupd =
                                       (select max(cu.idupd) from customer_update cu where cu.rnk = c.rnk) ),'BARS')  as user_login,
                                       nvl((select sb.fio from  staff$base sb, customer_update cu where  cu.doneby = sb.logname and cu.idupd =
                                       (select max(cu.idupd) from customer_update cu where cu.rnk = c.rnk) ), 'Користувач BARS') as user_fio,
                                       decode(c.custtype, 1, 3, 2, 2, 3, 1) as client_type,
                                       c.nmk as fio,
                                       c.okpo as inn,
                                       p.bday as birth_date,
                                       p.passp as document_type,
                                       p.ser as document_series,
                                       p.numdoc as document_number,
                                       null as client_data
                                  from customer c, person p
                                 where c.rnk = :p_rnk
                                   and c.rnk = p.rnk
                                    and c.custtype = 3
                                  and c.SED<>91";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Client res = new Client();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.Rnk = Convert.ToInt64(rdr["rnk"]);
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
                //Bars.Logger.DBLogger.Info("Client_rnk = ", Convert.ToString(res.Rnk));
                rdr.Close();
            }

            // влитые РНК
            res.MergedRNK = new List<Int64>();

            cmd.CommandText = @"select distinct rnkfrom as mrg_rnk
                                from (select rn.rnkfrom, rn.rnkto
                                        from rnk2nls rn
                                    union all
                                    select rt.rnkfrom, rt.rnkto
                                        from rnk2tbl rt)
                                where rnkto = :p_rnk";
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
        public Int64 Rnk;
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
        [JsonProperty("third_persons_clients")]
        public List<Third_Persons_Clients> Third_Persons_Clients;
        [JsonProperty("third_persons_non_clients")]
        public List<Third_Persons_Non_Clients> Third_Persons_Non_Clients;

        public static UClient GetInstance(String ObjID, OracleConnection con)
        {
            UClient res = new UClient();

            //DBLogger.Debug("UCLIENT rnk = " + ObjID);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select c.branch as branch_id,
                                           c.rnk as rnk,
                                           cu.chgdate as changed,
                                           c.date_on as created,
                                           decode(c.custtype, 1, 2, 2, 2, 3, 3) as client_type,
                                           c.nmk as client_name,
                                           c.okpo as inn_edrpou,
                                           sb.logname as user_login,
                                           sb.fio as user_fio,
                                           cu.chgdate as actualized_date,
                                           cu.doneby as actualized_by
                                      from customer c, customer_update cu, staff$base sb
                                     where c.rnk = :p_rnk
                                       and c.rnk = cu.rnk
                                       and (c.custtype <> 3 or (c.custtype = 3 and c.SED = 91))
                                       and cu.idupd =
                                           (select max(cu.idupd) from customer_update cu where cu.rnk = c.rnk)
                                       and cu.doneby = sb.logname";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                   // DBLogger.Debug("Uclient:  res.Rnk = " + res.Rnk.ToString());
                    res.Branch_ID = Convert.ToString(rdr["branch_id"]);
                    res.Rnk = Convert.ToInt64(rdr["rnk"]);
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

            cmd.CommandText = @"select rel_rnk as rnk, rel_id as personstateid
                                      from customer_rel
                                      where rnk = :p_rnk
                                            and rel_id > 0
                                            and REL_INTEXT = 1";//лише клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.Third_Persons_Clients.Add(new Third_Persons_Clients(Convert.ToInt64(rdr["rnk"]), Convert.ToInt16(rdr["personstateid"])));
                }
                rdr.Close();
            }
            // третьи лица, связанные с данным юр. лицом не кліенти банку
            res.Third_Persons_Non_Clients = new List<Third_Persons_Non_Clients>();

            cmd.CommandText = @"SELECT t1.rel_rnk AS id,
                                   rel_id AS personstateid,
                                   t2.name,
                                   DECODE (T2.CUSTTYPE,  1, 2,  2, 1,  3, 3) AS client_type,
                                   T2.OKPO AS inn_edrpou
                                 FROM customer_rel t1, customer_extern t2
                                 WHERE     t1.rnk = :p_rnk
                                   AND T1.REL_RNK = T2.ID
                                   AND t1.rel_id > 0
                                   AND t1.REL_INTEXT = 0 ";//лише клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.Third_Persons_Non_Clients.Add(new Third_Persons_Non_Clients(Convert.ToInt64(rdr["id"]), Convert.ToInt16(rdr["personstateid"]),  Convert.ToString(rdr["name"]), Convert.ToInt16(rdr["client_type"]),Convert.ToInt64(rdr["inn_edrpou"]) ));
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
        public Int64 Rnk;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;

        public Third_Persons_Clients(Int64 Rnk, Int16 PersonStateID)
        {
            this.Rnk = Rnk;
            this.PersonStateID = PersonStateID;
        }
    }
    /// <summary>
    /// Параметри - Юр.лицо - третьи лица не кліенти банку
    /// </summary>
    public struct Third_Persons_Non_Clients
    {
        [JsonProperty("ID")]
        public Int64 ID;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("Name")]
        public String Name;
        [JsonProperty("client_type")]
        public Int16 Client_Type;
        [JsonProperty("inn_edrpou")]
        public Int64 Inn_Edrpou;

        public Third_Persons_Non_Clients(Int64 ID, Int16 PersonStateID, String Name, Int16 Client_Type, Int64 Inn_Edrpou)
        {
            this.ID = ID;
            this.PersonStateID = PersonStateID;
            this.Client_Type = Client_Type;
            this.Name = Name;
            this.Inn_Edrpou = Inn_Edrpou;
          
        }
    }
    /// <summary>
    /// Параметри - Угода - Связанное лицо
    /// </summary>
    public struct LinkedRNK
    {
        [JsonProperty("RNK")]
        public Int64 Rnk;
        [JsonProperty("LinkPersonStateID")]
        public Int64 LinkPersonStateID;

        public LinkedRNK(Int64 Rnk, Int16 LinkPersonStateID)
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
        public Int64 Agr_code;
        [JsonProperty("RNK")]
        public Int64 Rnk;
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
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select dc.deposit_id as agr_code,
                                       dc.rnk,
                                       dc.when as changed,
                                       dc.datz as created,
                                       dc.branch as branch_id,
                                       sb.logname as user_login,
                                       sb.fio as user_fio,
                                       'deposit' as agr_type,
                                       (select decode(count(1), 0, 1, 0)

                                          from dpt_deposit_clos dc0
                                         where dc0.deposit_id = dc.deposit_id
                                           and dc0.action_id in (1, 2)) as agr_status,
                                       dc.nd as agr_number,
                                       dc.dat_begin as agr_date_open,
                                       case 
                                       when DC.ACTION_ID in (1,2) then DC.BDATE
                                       when DC.ACTION_ID not in (1,2) then null
				       else null 
                                       end as agr_date_close,    
                                       (select a.nls from accounts a where a.acc = dc.acc) as account_number
                                  from dpt_deposit_clos dc, staff$base sb
                                 where dc.deposit_id = :p_agr_id
                                   and dc.actiion_author = sb.id
                                    order by dc.idupd desc";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_agr_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Agr res = new Agr();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.Agr_code = Convert.ToInt64(rdr["agr_code"]);
                    res.Rnk = Convert.ToInt64(rdr["rnk"]);
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

            cmd.CommandText = @"select distinct t.rnk_tr as rnk, decode(t.typ_tr, 'T', 1, 'H', 2, 'V', 5, 'B', 4,'C',6,'M',7 0) as linkpersonstateid
                                  from dpt_trustee t
                                 where t.dpt_id = :p_agr_id
                                    and t.fl_act > 0
                                 UNION
                                SELECT t1.rnk AS rnk, 3 AS linkpersonstateid
                                FROM 
                                        (SELECT *
                                              FROM dpt_deposit_clos
                                             WHERE deposit_id = :p_agr_id AND ACTION_ID = 0 AND ROWNUM = 1) 
                                    t1,
                                       (SELECT *
                                          FROM (  SELECT *
                                                    FROM dpt_deposit_clos
                                                   WHERE deposit_id = :p_agr_id
                                                ORDER BY idupd DESC)
                                         WHERE ROWNUM = 1) 
                                    t2
                                WHERE t1.rnk <> t2.rnk   
                                    ";//в выборку не должны попадать дублирующие записи.
            //Union - в выборку должен попасть вноситель вклада(ACTION_ID = 0) если на данный момент он не владелец счета (t1.rnk <> t2.rnk)
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_agr_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    res.LinkedRNK.Add(new LinkedRNK(Convert.ToInt64(rdr["rnk"]), Convert.ToInt16(rdr["linkpersonstateid"])));
                }

                rdr.Close();
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
        public Int64 Rnk;
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
           // DBLogger.Info("UAGR obj_id = " + ObjID);

            String AgrType = ObjID.Split(';')[0];
            OracleCommand cmd = con.CreateCommand();
            switch (AgrType)
            {
                case "DPT":
                    Decimal DpuID = Convert.ToDecimal(ObjID.Split(';')[1]);
                    cmd.CommandText = @"select dd.dpu_id as agr_code,
                                                dd.rnk as rnk,
                                                ddu.dateu as changed,
                                                dd.dat_begin as created,
                                                (select decode(c.custtype, 1, 2, 2, 2, 3, 3)
                                                    from customer c
                                                    where c.rnk = dd.rnk) as client_type,
                                                dd.branch as branch_id,
                                                sb.logname as user_login,
                                                sb.fio as user_fio,
                                                'dep_uo' as agr_type,
                                                decode(dd.closed, 0, 1, 1, 0) as agr_status,
                                                dd.nd as agr_number,
                                                dd.datz as agr_date_open,
                                                decode(dd.closed, 0, to_date(null), 1, gl.bd) as agr_date_close
                                            from dpu_deal dd, dpu_deal_update ddu, staff$base sb
                                            where dd.dpu_id = :p_dpu_id
                                            and dd.dpu_id = ddu.dpu_id
                                            and ddu.useru = sb.id
                                            and ddu.idu = (select max(ddu0.idu)
                                                            from dpu_deal_update ddu0
                                                            where ddu0.dpu_id = dd.dpu_id)";
                    //DBLogger.Info("p_dpu_id = " + DpuID.ToString());

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_dpu_id", OracleDbType.Decimal, DpuID, ParameterDirection.Input);

                    break;
                case "ACC":
                    String Branch = ObjID.Split(';')[1].Split('|')[0];
                    DateTime Daos = DateTime.ParseExact(ObjID.Split(';')[1].Split('|')[1], "yyyyMMdd", null);
                    Decimal RNK = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[2]);

                    cmd.CommandText = @"select t.agr_code,
                                                   t.rnk,
                                                   au.chgdate as changed,
                                                   t.created,
                                                   (select decode(custtype, 1, 2, 2, 2, 3, 3)
                                                      from customer
                                                     where rnk = t.rnk) as client_type,
                                                   t.branch_id,
                                                   sb.logname as user_login,
                                                   sb.fio as user_fio,
                                                   t.agr_type,
                                                   t.agr_status,
                                                   t.agr_number,
                                                   t.agr_date_open,
                                                   t.agr_date_close
                                              from (select trim(both '/' from a.branch) || '|' ||
                                                           to_char(trunc(a.daos), 'yyyymmdd') || '|' || a.rnk as agr_code,
                                                           a.rnk as rnk,
                                                           trunc(a.daos) as created,
                                                           a.branch as branch_id,
                                                           'pr_uo' as agr_type,
                                                           case
                                                             when max(a.dazs) is null or max(a.dazs) > sysdate then
                                                              1
                                                             else
                                                              0
                                                           end as agr_status,
                                                           max(sp.nkd) as agr_number,
                                                           trunc(a.daos) as agr_date_open,
                                                           case
                                                             when max(a.dazs) is null or max(a.dazs) > sysdate then
                                                              to_date(null)
                                                             else
                                                              max(a.dazs)
                                                           end as agr_date_close,
                                                           max(au.idupd) as max_idupd
                                                      from accounts a, specparam sp, accounts_update au
                                                     where a.branch = :p_branch
                                                       and trunc(a.daos) = :p_daos
                                                       and a.rnk = :p_rnk
                                                       and a.acc = au.acc
                                                       and a.acc = sp.acc(+)
                                                     group by a.branch, trunc(a.daos), a.rnk) t,
                                                   accounts_update au,
                                                   staff$base sb
                                             where t.max_idupd = au.idupd
                                               and au.doneby = sb.logname";
                    //DBLogger.Info("p_branch = " + Branch + " p_daos = " + Daos + " p_rnk = " + RNK);

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
                    cmd.Parameters.Add("p_daos", OracleDbType.Date, Daos, ParameterDirection.Input);
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);

                    break;
                case "DPT_OLD":
                    String NLS = ObjID.Split(';')[1].Split('|')[0];
                           Daos = DateTime.ParseExact(ObjID.Split(';')[1].Split('|')[1], "yyyyMMdd", null);
                    Decimal ACC = Convert.ToDecimal(ObjID.Split(';')[1].Split('|')[2]);

                    cmd.CommandText = @"select t.agr_code,
                                                   t.rnk,
                                                   au.chgdate as changed,
                                                   t.created,
                                                   (select decode(custtype, 1, 2, 2, 2, 3, 3)
                                                      from customer
                                                     where rnk = t.rnk) as client_type,
                                                   t.branch_id,
                                                   sb.logname as user_login,
                                                   sb.fio as user_fio,
                                                   t.agr_type,
                                                   t.agr_status,
                                                   t.agr_number,
                                                   t.agr_date_open,
                                                   t.agr_date_close
                                              from (select to_char(trunc(a.daos), 'yyyymmdd') || '|' ||
                                                           a.nls || '|' || to_char(a.kv) as agr_code,
                                                           a.rnk as rnk,
                                                           trunc(a.daos) as created,
                                                           a.branch as branch_id,
                                                           'dep_uo' as agr_type,
                                                           case
                                                             when max(a.dazs) is null or max(a.dazs) > sysdate then
                                                              1
                                                             else
                                                              0
                                                           end as agr_status,
                                                           max(sp.nkd) as agr_number,
                                                           trunc(a.daos) as agr_date_open,
                                                           case
                                                             when max(a.dazs) is null or max(a.dazs) > sysdate then
                                                              to_date(null)
                                                             else
                                                              max(a.dazs)
                                                           end as agr_date_close,
                                                           max(au.idupd) as max_idupd
                                                      from accounts a, specparam sp, accounts_update au
                                                     where a.nls = :p_nls
                                                       and trunc(a.daos) = :p_daos                                                       
                                                       and a.acc = :p_acc
                                                       and a.acc = au.acc
                                                       and a.acc = sp.acc(+)
                                                     group by A.BRANCH , trunc(a.daos),A.RNK, A.NLS, A.KV) t,
                                                   accounts_update au,
                                                   staff$base sb
                                             where t.max_idupd = au.idupd
                                               and au.doneby = sb.logname";
                    //DBLogger.Info("p_nls = " + NLS + " p_daos = " + Daos + " p_acc = " + ACC);

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, NLS, ParameterDirection.Input);
                    cmd.Parameters.Add("p_daos", OracleDbType.Date, Daos, ParameterDirection.Input);
                    cmd.Parameters.Add("p_acc", OracleDbType.Decimal, ACC, ParameterDirection.Input);

                    break;
                default:
                    throw new Bars.Exception.BarsException("Попытка создать объект сделка UAgr неизвестного типа " + AgrType);
            }

          //  DBLogger.Info("cmd.CommandText = " + cmd.CommandText);

            UAgr res = new UAgr();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                 //   DBLogger.Info("Convert.ToString(rdr[agr_code]) = " + Convert.ToString(rdr["agr_code"]));

                    res.Agr_code = Convert.ToString(rdr["agr_code"]);
                    res.Rnk = Convert.ToInt64(rdr["rnk"]);
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
    /// Счета клиента - Юр-лица
    /// </summary>
    public struct Acc
    {
        [JsonProperty("RNK")]
        public Int64 Rnk;
        [JsonProperty("changed")]
        public DateTime Changed;
        [JsonProperty("created")]
        public DateTime Created;
        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("account_number")]
        public String Account_Number;
        [JsonProperty("currency_code")]
        public String Currency_code;
        [JsonProperty("mfo")]
        public Int64 MFO;
        [JsonProperty("branch_id")]
        public String Branch_id;
        [JsonProperty("open_date")]
        public DateTime Open_date;
        [JsonProperty("close_date")]
        public DateTime? Close_date;
        [JsonProperty("agr_number")]
        public String Agr_number;
        [JsonProperty("agr_code")]
        public String Agr_code;
        [JsonProperty("account_type")]
        public String Account_type;
        [JsonProperty("account_status")]
        public Int64 Account_status;

        public static Acc GetInstance(String ObjID, OracleConnection con)
        {
         //   DBLogger.Debug("ACC");

            String AgrType = ObjID.Split(';')[0];
            Decimal ACC = Convert.ToDecimal(ObjID.Split(';')[1]);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select a.rnk as rnk,
                                       au.chgdate as changed,
                                       a.daos as created,
                                       sb.logname as user_login,
                                       sb.fio as user_fio,
                                       a.nls as account_number,
                                       a.kv as currency_code,
                                       f_ourmfo_g() as mfo,
                                       a.branch as branch_id,
                                       a.daos as open_date,
                                       a.dazs as close_date,
                                       case
                                         when (a.dazs is null and a.blkd = 0 and a.blkk = 0) then
                                          1
                                         when a.dazs is not null then
                                          2
                                         when (a.blkd <> 0 and a.blkk = 0) then
                                          3
                                         when (a.blkk <> 0 and a.blkd = 0) then
                                          4
                                         when (a.blkd <> 0 and a.blkd <> 0) then
                                          5
                                       end as account_status,
                                       case
                                         when (:p_agr_type = 'DPT') then
                                          (select to_char(max(dd.nd))
                                             from dpu_accounts da, dpu_deal dd
                                            where da.accid = a.acc
                                              and da.dpuid = dd.dpu_id)
                                         when (:p_agr_type = 'ACC') then
                                          (select to_char(max(sp.nkd)) from specparam sp where sp.acc = a.acc)
                                         when (:p_agr_type = 'DPT_OLD') then
                                          (select to_char(max(sp.nkd)) from specparam sp where sp.acc = a.acc)
                                       end as agr_number,
                                       case
                                         when (:p_agr_type = 'DPT') then
                                          (select to_char(max(da.dpuid))
                                             from dpu_accounts da
                                            where da.accid = a.acc)
                                         when (:p_agr_type = 'ACC') then
                                          trim(both '/' from a.branch) || '|' || to_char(a.daos, 'yyyymmdd') || '|' ||
                                          a.rnk
                                         when (:p_agr_type = 'DPT_OLD') then
                                          to_char(a.daos, 'yyyymmdd') || '|' || a.nls || '|' || to_char(a.kv)
                                       end as agr_code,
                                       case
                                         when (:p_agr_type = 'ACC') then
                                          'pr_uo'
                                         else
                                          'dep_uo'
                                       end as account_type
                                  from accounts a, accounts_update au, staff$base sb
                                 where a.acc = :p_acc
                                   and au.idupd =
                                       (select max(au0.idupd) from accounts_update au0 where au0.acc = a.acc)
                                   and au.isp = sb.id";

            cmd.Parameters.Clear();
            cmd.BindByName = true;
            cmd.Parameters.Add("p_agr_type", OracleDbType.Varchar2, AgrType, ParameterDirection.Input);
            cmd.Parameters.Add("p_acc", OracleDbType.Decimal, ACC, ParameterDirection.Input);

            Acc res = new Acc();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.Rnk = Convert.ToInt64(rdr["rnk"]);
                    res.Changed = Convert.ToDateTime(rdr["changed"]);
                    res.Created = Convert.ToDateTime(rdr["created"]);
                    res.User_Login = Convert.ToString(rdr["user_login"]);
                    res.User_Fio = Convert.ToString(rdr["user_fio"]);
                    res.Account_Number = Convert.ToString(rdr["account_number"]);
                    res.Currency_code = Convert.ToString(rdr["currency_code"]);
                    res.MFO = Convert.ToInt64(rdr["mfo"]);
                    res.Branch_id = Convert.ToString(rdr["branch_id"]);
                    res.Open_date = Convert.ToDateTime(rdr["open_date"]);
                    res.Close_date = rdr["close_date"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["close_date"]);
                    res.Account_status = Convert.ToInt64(rdr["account_status"]);
                    res.Agr_number = Convert.ToString(rdr["agr_number"]);
                    res.Agr_code = Convert.ToString(rdr["agr_code"]);
                    res.Account_type = Convert.ToString(rdr["account_type"]);
                }

                rdr.Close();
            }

          //  DBLogger.Debug("ACC ok");

            return res;
        }
    }
    /// <summary>
    /// Юр.лицо - счета клиента
    /// </summary>
    public struct ACCOUNTS
    {
        [JsonProperty("account_number")]
        public String Account_Number;
        [JsonProperty("currency_code")]
        public String Currency_code;
        [JsonProperty("mfo")]
        public Int64 MFO;
        [JsonProperty("branch_id")]
        public String Branch_id;
        [JsonProperty("open_date")]
        public DateTime Open_date;
        [JsonProperty("close_date")]
        public DateTime? Close_date;
        [JsonProperty("account_status")]
        public Int64 Account_status;


        public ACCOUNTS(String Account_Number, String Currency_code, Int64 MFO, String Branch_id, DateTime Open_date, DateTime? Close_date, Int64 Account_status)
        {
            this.Account_Number = Account_Number;
            this.Currency_code = Currency_code;
            this.MFO = MFO;
            this.Branch_id = Branch_id;
            this.Open_date = Open_date;
            this.Close_date = Close_date;
            this.Account_status = Account_status;
        }
    }

    /// <summary>
    /// Параметри - Актуалізація ідент. документів
    /// </summary>
    public struct Act
    {
        [JsonProperty("RNK")]
        public Int64 Rnk;
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
            cmd.CommandText = @"select vd.rnk,
                                       sb.branch  as branch_id,
                                       sb.logname as user_login,
                                       sb.fio     as user_fio,
                                       vd.chgdate as actual_date
                                  from ( select vd.rnk, vd.chgdate, vd.userid
                                           from PERSON_VALID_DOCUMENT_UPDATE vd
                                          where (vd.rnk, vd.chgdate) = (select rnk, max(chgdate)
                                                                          from PERSON_VALID_DOCUMENT_UPDATE  
                                                                         where rnk = :p_rnk
                                                                           and doc_state = 1            
                                                                         group by rnk)
                                       ) vd,
                                       STAFF$BASE sb
                                 where vd.userid = sb.id";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            Act res = new Act();
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    res.Rnk = Convert.ToInt64(rdr["rnk"]);
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
        public Int64? Rnk;
        [JsonProperty("agreement_id")]
        public Int64? Agreement_ID;
        [JsonProperty("struct_code")]
        public Int16? Struct_Code;

        public DocumentData(Int64 ID)
        {
            this.ID = ID;
        }
        public DocumentData(Int64 Rnk, Int64? Agreement_ID, Int16 Struct_Code)
        {
            this.Rnk = Rnk;
            this.Agreement_ID = Agreement_ID;
            this.Struct_Code = Struct_Code;
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

        public Error() { }
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
        public Int64 Rnk;

        public Client() : base() { }
    }
    /// <summary>
    /// Ответ - Клієнт юр.лицо
    /// </summary>
    public class UClient : SyncResult
    {
        [JsonProperty("RNK")]
        public Int64 Rnk;

        public UClient() : base() { }
    }

    /// <summary>
    /// Ответ - Счета юр.лица
    /// </summary>
    public class Acc : SyncResult
    {
        [JsonProperty("RNK")]
        public Int64 Rnk;
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
        public Int64 Rnk;
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
                    this._Params = new Object[1] { Structs.Params.Acc.GetInstance(this._ObjID, con) };//счета клиента-юр.лица
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
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class EADService : Bars.BarsWebService
    {
        # region Константы
        # endregion

        # region Конструкторы
        public EADService()
        {
        }
        # endregion

        # region Статические свойства
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
                     Bars.Logger.DBLogger.Info("WSProxyUserName= " + WSProxyUserName);
                }
                else
                {
                    Bars.Logger.DBLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
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
                    // Bars.Logger.DBLogger.Info("Send_Message= " + Message);

                    // отправляем запрос по Http
                    Response rsp;
            try
            {
                    String ResponseText = GetEAResponseText(Message);
                    // Bars.Logger.DBLogger.Info("GetEAResponseText(Message) " + ResponseText);
                    // сохраняем ответ
                    ep.MSG_SET_STATUS_RECEIVED(ID, ResponseText);

                    // парсим ответ
                    rsp = Response.CreateFromJSONString(msg.Method, ResponseText);
                    ep.MSG_SET_STATUS_PARSED(ID, rsp.Responce_ID, rsp.Current_Timestamp);

                    // Анализируем ответ
                    if (rsp.Status == "ERROR")
                    {
                        // устанавлдиваем статус "Помилка"
                        Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                        ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", err.Error_Code, err.Error_Text));
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
           // Bars.Logger.DBLogger.Info("Message= " + Message);
            // запрос
            //Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.GetEAResponseText: EA_ServiceUrl = " + EA_ServiceUrl);

            //создаем соединение WebRequest Request = WebRequest.Create(EA_ServiceUrl);
            HttpWebRequest Request = (HttpWebRequest)WebRequest.Create(EA_ServiceUrl);
            if (EA_UsingSSL)//для SSL соединянния добавляем сертификат клиента
            {
                //добавляем сертификат клиента
                ClientCertificate CC = new ClientCertificate();

                try
                {
                    // Добавляем сертификат из файла(при проблемах доступа к хранилищу)
                    //    X509Certificate cert = new X509Certificate(EA_CertificatePath, EA_CertificatePassword);

                    //Bars.Logger.DBLogger.Info("ClientCertificateSerialNumber = " + cert.GetSerialNumberString());
                    //Bars.Logger.DBLogger.Info("EA_CertificatePath = " + EA_CertificatePath);

                    //находим в хранилище сертификат по серийному номеру
                    Request.ClientCertificates.Add(CC.GetCertificate(EA_ClientCertificateNumber));
                    //или добавляем из загруженного
                    //Request.ClientCertificates.Add(cert);
                    //Bars.Logger.DBLogger.Info("cert.tostring = " + cert.ToString() );


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
              //  Bars.Logger.DBLogger.Info("SetDictionaryData: Request.Timeout = " + Request.Timeout.ToString());
            }

            //Bars.Logger.DBLogger.Debug("GetEAResponseText: Request Start");

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
                        //    Bars.Logger.DBLogger.Info("ResponseText = " + ResponseText);
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
               // Bars.Logger.DBLogger.Info("Response ex = " + ex.Message);
                throw ex;
            }

           // Bars.Logger.DBLogger.Debug("GetEAResponseText: Response Finish");
        }
        // Начать сессию взаимодействия с ЕА
        public static String StartSession(OracleConnection con)
        {
            String res = String.Empty;

            // Формируем сообщение
            StartSessionMessage msg = new StartSessionMessage(con);
            String Message = msg.GetJSONString();

            Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.StartSession: Message = " + Message);

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message);

           // Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.StartSession: ResponseText = " + ResponseText);

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

        //    Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.CloseSession: Message = " + Message);

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message);

           // Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.CloseSession: ResponseText = " + ResponseText);

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
        public static List<Structs.Result.DocumentData> GetDocumentData(Int64? ID, Int64? Rnk, Int64? Agreement_ID, Int16? Struct_Code)
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
                msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code.Value);

            // Формируем сообщение
            String Message = msg.GetJSONString();
           // Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.GetDocumentData: Message = " + Message);

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message);
           // Bars.Logger.DBLogger.Info("Bars.EAD.EA.EADService.GetDocumentData: ResponseText = " + ResponseText);

            // парсим ответ
            Response rsp = Response.CreateFromJSONString(msg.Method, ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR")
            {
                // устанавлдиваем статус "Помилка"
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                throw new System.Exception(String.Format("Помилка отримання документів з ЕА: {0}, {1}", err.Error_Code, err.Error_Text));
            }
            else
            {
                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = "select sc.name from ead_struct_codes sc where sc.id = :p_id";
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