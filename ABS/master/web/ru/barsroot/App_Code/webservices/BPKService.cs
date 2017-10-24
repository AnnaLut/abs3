using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using System.Xml;
using System.Globalization;
using System.Web.Script.Serialization;

using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using barsroot.core;
using BarsWeb.Core.Logger;
using Bars.Oracle;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.WebServices.BPK
{
    public class NewClient
    {
        private Int64 USER_ID;
        public String BRANCH;
        private String LASTNAME;
        private String FIRSTNAME;
        private String MIDDLENAME;
        private int GENDER;
        private int RESIDENT;
        private String BIRTHDATE;
        private String BPLACE;
        private String OKPO;
        private String PHONENUMBER_MOB;
        private String E_MAIL;
        private String DATEIN;
        private String DATEMOD;
        private String DATECLOSE;
        private int OPER_TYPE;
        private int CLIENTTYPE;
        private String ENGLASTNAME;
        private String ENGFIRSTNAME;
        private String COUNTRY;
        private String WORK;
        private String OFFICE;
        private String DATE_W;
        private String K060;
        private String K013;
        private String K070;
        private String K080;
        private String K110;
        private String K050;
        private String K051;
        private String COMPANYNAME;
        private String SHORTCOMPANYNAME;
        private String ADDR1_CITYNAME;
        private String ADDR1_PCODE;
        private String ADDR1_DOMAIN;
        private String ADDR1_REGION;
        private String ADDR1_STREET;
        private String ADDR2_CITYNAME;
        private String ADDR2_PCODE;
        private String ADDR2_DOMAIN;
        private String ADDR2_REGION;
        private String ADDR2_STREET;
        private int TYPEDOC;
        private String PASPSERIES;
        private String PASPNUM;
        private String PASPDATE;
        private String PASPISSUER;
        private int PRINSIDER;
        private String PHOTODATE;
        private int IS_SPECIAL_CLIENT;

        public Int64 RNK;
        public Int32 ResultCode;
        public String ResultDescription;
        string result;
        

        private bool SearchClient(String p_OKPO, String p_NMK, DateTime? p_BDAY, string p_SER, string p_NUMDOC)
        {
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;
           // DBLogger.Info("Пошук RNK Клієнта", "BPK_service");

            OracleConnection connect = new OracleConnection();
            try
            {
                // Создаем соединение
                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();

                cmd.Parameters.Clear();
                cmd.CommandText = "bars.p_search_customer";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, p_OKPO, ParameterDirection.Input);
                cmd.Parameters.Add("p_nmk", OracleDbType.Varchar2, p_NMK, ParameterDirection.Input);
                cmd.Parameters.Add("p_bday", OracleDbType.Date, p_BDAY, ParameterDirection.Input);
                cmd.Parameters.Add("p_ser", OracleDbType.Varchar2, p_SER, ParameterDirection.Input);
                cmd.Parameters.Add("p_numdoc", OracleDbType.Varchar2, p_NUMDOC, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust", OracleDbType.RefCursor, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                // Беремо з процедури RefCursor, в якому записані дані про всіх знайдених клієнтів
                OracleRefCursor refcur = (OracleRefCursor)cmd.Parameters["p_cust"].Value;

                OracleDataAdapter da = new OracleDataAdapter("", connect);
                System.Data.DataSet fClients = new System.Data.DataSet();
                da.Fill(fClients, refcur);
                
                string searchresultlog;
               
                foreach (DataRow row in fClients.Tables[0].Rows)
                {
                    searchresultlog = "SearchClient result: RNK =" + row["rnk"].ToString() + " ;OKPO =" + row["okpo"].ToString() + "; ФІО =" + row["nmk"].ToString();
                    this.result += String.Format("RNK ={0} ,ФІО={1}, OKPO ={2} ;", row["rnk"].ToString(), row["nmk"].ToString(), row["okpo"].ToString());
                    //DBLogger.Info(row["numdoc"].ToString(), "BPK_service");
                    //DBLogger.Info(row["nmk"].ToString(), "BPK_service");
                    //DBLogger.Info(row["ser"].ToString(), "BPK_service");
                    this.RNK = Convert.ToInt64(Convert.ToString(row["rnk"])) ;
                    this.BRANCH = Convert.ToString(row["branch"]);
                   // DBLogger.Info(searchresultlog, "BPK_service");
                    this.ResultCode++;
                }
                if (ResultCode > 0)
                {
                    return true;
                }
                else
                    return false;

                /*for (int i = 0; i < listSearchClient.Items.Count; i++)
                {
                    listSearchClient.Items[i].Text = "";
                    for (int j = 1; j < fClients.Tables[0].Rows[0].ItemArray.Length; j++)
                    {
                        listSearchClient.Items[i].Text += fClients.Tables[0].Rows[i].ItemArray[j];
                        listSearchClient.Items[i].Text += " / ";
                    }
                }*/
            }
            catch (System.Exception ex)
            {
                /*this.ResultCode = 3;
                this.ResultDescription = String.Format("Помилка при створенні клієнта: {0}", ex.Message);*/
               // DBLogger.Info(ex.Message, "BPK_service");
                return false;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            
        }

        public NewClient( 
         Int64 USER_ID,
         String BRANCH,
         String LASTNAME,
         String FIRSTNAME,
         String MIDDLENAME,
         int GENDER,
         int RESIDENT,
         String BIRTHDATE,
         String BPLACE,
         String OKPO,
         String PHONENUMBER_MOB,
         String E_MAIL,
         String DATEIN,
         String DATEMOD,
         String DATECLOSE,
         int OPER_TYPE,
         int CLIENTTYPE,
         String ENGLASTNAME, 
         String ENGFIRSTNAME,
         String COUNTRY,
         String WORK,
         String OFFICE,
         String DATE_W,
         String K060,
         String K013,
         String K070,
         String K080,
         String K110,
         String K050,
         String K051,
         String COMPANYNAME,
         String SHORTCOMPANYNAME,
         String ADDR1_CITYNAME,
         String ADDR1_PCODE,
         String ADDR1_DOMAIN,
         String ADDR1_REGION,
         String ADDR1_STREET,
         String ADDR2_CITYNAME,
         String ADDR2_PCODE,
         String ADDR2_DOMAIN,
         String ADDR2_REGION,
         String ADDR2_STREET,
         int TYPEDOC,
         String PASPSERIES,
         String PASPNUM,
         String PASPDATE,
         String PASPISSUER,
         int PRINSIDER,
         String PHOTODATE,
         int IS_SPECIAL_CLIENT)
        {
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;
            //DBLogger.Info("Beefore searchclient", "BPK_service");
            if (SearchClient(OKPO, LASTNAME + ' ' + FIRSTNAME + ' ' + MIDDLENAME, null ,PASPSERIES, PASPNUM ))
            {
               // DBLogger.Info("searchclient welldone", "BPK_service");
                this.ResultDescription = "Знайдено " + this.ResultCode.ToString() + "клієнтів! Реєстрація неможлива! Оберіть одного з клієнтів: " + this.result ;
                this.ResultCode = 4;
                return;
            }

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = @"select s_customer.nextval rnk from dual";
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    this.RNK = Convert.ToInt64(rdr["rnk"]);
                    this.BRANCH = BRANCH;
                    this.ResultDescription += String.Format("Cтворено RNK Клієнта РНК = {0} МФО = {1} ", this.RNK.ToString(), this.BRANCH);
                   // DBLogger.Info(String.Format("Cтворено RNK Клієнта РНК = {0} МФО = {1} ", this.RNK.ToString(), this.BRANCH), "BPK_service");
                }
                else
                {
                    this.ResultCode = 1;
                    this.ResultDescription = String.Format("Клієнта РНК = {0} МФО = {1} не створено", this.RNK.ToString() , this.BRANCH);
                }

                              //виклик процедури створення клієнта         
                                try
                                        { 
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Clear();
                                    cmd.CommandText = @"KL.OPEN_CLIENT";
                                    //cmd.CommandText = @"dpt_web.p_open_vklad_rnk";
                                    cmd.Parameters.Add("RNK_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                                    cmd.Parameters.Add("CUSTTYPE_", OracleDbType.Decimal, 3, ParameterDirection.Input);//допрацювати перевірку CLIENTTYPE
                                    cmd.Parameters.Add("ND_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("NMK_", OracleDbType.Varchar2, LASTNAME + ' ' + FIRSTNAME + ' ' + MIDDLENAME, ParameterDirection.Input);
                                    cmd.Parameters.Add("NMKV_", OracleDbType.Varchar2, LASTNAME + ' ' + FIRSTNAME + ' ' + MIDDLENAME, ParameterDirection.Input);
                                    cmd.Parameters.Add("NMKK_", OracleDbType.Varchar2, LASTNAME + ' ' + FIRSTNAME, ParameterDirection.Input);
                                    cmd.Parameters.Add("ADR_", OracleDbType.Varchar2, ADDR1_REGION + ' ' + ADDR1_CITYNAME + ' ' + ADDR1_STREET, ParameterDirection.Input);
                                    cmd.Parameters.Add("CODCAGENT_", OracleDbType.Decimal, RESIDENT == 1 ? 5 : 6, ParameterDirection.Input);//допрацювати перевірку 5 -фізособа резидент 6 - фізособа - нерезидент
                                    cmd.Parameters.Add("COUNTRY_", OracleDbType.Decimal, Convert.ToInt16(COUNTRY), ParameterDirection.Input);
                                    cmd.Parameters.Add("PRINSIDER_", OracleDbType.Decimal, PRINSIDER == 1 ? 1 : 99, ParameterDirection.Input);
                                    cmd.Parameters.Add("TGR_", OracleDbType.Decimal, 2, ParameterDirection.Input);//допрацювати перевірку - 2 - реєстр фіз осіб
                                    cmd.Parameters.Add("OKPO_", OracleDbType.Varchar2, OKPO, ParameterDirection.Input);
                                    cmd.Parameters.Add("STMT_", OracleDbType.Decimal, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("SAB_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    if (!String.IsNullOrEmpty(DATEIN)) cmd.Parameters.Add("DATEON_", OracleDbType.Date, DateTime.ParseExact(DATEIN, "yyyy.MM.dd", CultureInfo.InvariantCulture), ParameterDirection.Input); else cmd.Parameters.Add("DATEON_", OracleDbType.Date, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("TAXF_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("CREG_", OracleDbType.Decimal, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("CDST_", OracleDbType.Decimal, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("ADM_", OracleDbType.Varchar2, PASPISSUER, ParameterDirection.Input);
                                    cmd.Parameters.Add("RGTAX_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("RGADM_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("DATET_", OracleDbType.Date, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("DATEA_", OracleDbType.Date, null, ParameterDirection.Input);
                                    // if (String.IsNullOrEmpty(DATEIN)) cmd.Parameters.Add("DATET_", OracleDbType.Date, DateTime.ParseExact(DATEMOD, "yyyy.MM.dd", CultureInfo.InvariantCulture), ParameterDirection.Input); else cmd.Parameters.Add("DATET_", OracleDbType.Date, null, ParameterDirection.Input);
                                    // if (String.IsNullOrEmpty(DATEIN)) cmd.Parameters.Add("DATEA_", OracleDbType.Date, DateTime.ParseExact(DATEIN, "yyyy.MM.dd", CultureInfo.InvariantCulture), ParameterDirection.Input); else cmd.Parameters.Add("DATEA_", OracleDbType.Date, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("ISE_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("FS_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("OE_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("VED_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("SED_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("K050_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("NOTES_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("NOTESEC_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("CRISK_", OracleDbType.Decimal, 1, ParameterDirection.Input);
                                    cmd.Parameters.Add("PINCODE_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("RNKP_", OracleDbType.Decimal, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("LIM_", OracleDbType.Decimal, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("NOMPDV_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("MB_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("BC_", OracleDbType.Decimal, null, ParameterDirection.Input);
                                    cmd.Parameters.Add("TOBO_", OracleDbType.Varchar2, BRANCH, ParameterDirection.Input);
                                    cmd.Parameters.Add("ISP_", OracleDbType.Decimal, USER_ID, ParameterDirection.Input);
 
                                    cmd.ExecuteNonQuery();

                                    cmd.Parameters.Clear();
                                    cmd.CommandText = @"KL.setPersonAttr";
                                    
                                    cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                                    cmd.Parameters.Add("Sex_", OracleDbType.Char, GENDER == 1? '1':'2', ParameterDirection.Input);
                                    cmd.Parameters.Add("Passp_", OracleDbType.Decimal, TYPEDOC, ParameterDirection.Input);
                                    cmd.Parameters.Add("Ser_", OracleDbType.Varchar2, PASPSERIES, ParameterDirection.Input);
                                    cmd.Parameters.Add("Numdoc_", OracleDbType.Varchar2, PASPNUM , ParameterDirection.Input);
                                    if (!String.IsNullOrEmpty(PASPDATE)) cmd.Parameters.Add("Pdate_", OracleDbType.Date, DateTime.ParseExact(PASPDATE, "yyyy.MM.dd", CultureInfo.InvariantCulture), ParameterDirection.Input); else cmd.Parameters.Add("Pdate_", OracleDbType.Date, null, ParameterDirection.Input);
                                   // cmd.Parameters.Add("Pdate_", OracleDbType.Date, PASPDATE, ParameterDirection.Input);
                                    cmd.Parameters.Add("Organ_", OracleDbType.Varchar2, PASPISSUER, ParameterDirection.Input);
                                    if (!String.IsNullOrEmpty(BIRTHDATE)) cmd.Parameters.Add("Bday_", OracleDbType.Date, DateTime.ParseExact(BIRTHDATE, "yyyy.MM.dd", CultureInfo.InvariantCulture), ParameterDirection.Input); else cmd.Parameters.Add("Bday_", OracleDbType.Date, null, ParameterDirection.Input);
                                   // cmd.Parameters.Add("Bday_", OracleDbType.Date, BIRTHDATE, ParameterDirection.Input);//допрацювати перевірку
                                    cmd.Parameters.Add("Bplace_", OracleDbType.Varchar2, BPLACE, ParameterDirection.Input);
                                    cmd.Parameters.Add("Teld_", OracleDbType.Varchar2, PHONENUMBER_MOB, ParameterDirection.Input);
                                    cmd.Parameters.Add("Telw_", OracleDbType.Varchar2, PHONENUMBER_MOB, ParameterDirection.Input);
                               
                                    cmd.ExecuteNonQuery();


                                    cmd.Parameters.Clear();
                                    cmd.CommandText = @"KL.setCustomerElement";
                                    
                                    cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                                    cmd.Parameters.Add("Tag_", OracleDbType.Varchar2, "K013", ParameterDirection.Input);
                                    cmd.Parameters.Add("Val_", OracleDbType.Varchar2, '5', ParameterDirection.Input);
                                    cmd.Parameters.Add("Otd_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                                   
                                    cmd.ExecuteNonQuery();
                                  
                                    cmd.Parameters.Clear();
                                    cmd.CommandText = @"KL.setCustomerElement";
                                    
                                    cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                                    cmd.Parameters.Add("Tag_", OracleDbType.Varchar2, "SN_FN", ParameterDirection.Input);
                                    cmd.Parameters.Add("Val_", OracleDbType.Varchar2, FIRSTNAME , ParameterDirection.Input);
                                    cmd.Parameters.Add("Otd_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                                   
                                    cmd.ExecuteNonQuery();
                                  
                                    cmd.Parameters.Clear();
                                    cmd.CommandText = @"KL.setCustomerElement";
                                    
                                    cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                                    cmd.Parameters.Add("Tag_", OracleDbType.Varchar2, "SN_LN", ParameterDirection.Input);
                                    cmd.Parameters.Add("Val_", OracleDbType.Varchar2, LASTNAME, ParameterDirection.Input);
                                    cmd.Parameters.Add("Otd_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                                   
                                    cmd.ExecuteNonQuery();
                                  
                
                                       }
                                       catch (System.Exception e)
                                    {
                                        this.ResultCode = 2;
                                        this.ResultDescription = String.Format("Помилка при створенні клієнта: {0}", e.Message);
                                    }
                                    finally
                                    {
                                        con.Close();
                                        con.Dispose();
                                    }


            }
            catch (System.Exception e)
            {
                this.ResultCode = 3;
                this.ResultDescription = String.Format("Помилка при створенні клієнта: {0}", e.Message);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }


    public class NewBPK
    {
        private Int64 RNK;
        private String BRANCH;
        private String PRODUCT_CODE;
        private int TERM;
        private int? LIMIT;
        private String F_NAME;
        private String L_NAME;
        private String DM_MNAME;
        private String WORK;
        private String OFFICE;
        private String WORKDATE;
        private int? SALARYPROECT;
        private String BRANCHISSUE;
        
        public String NLS;
        public String ACC;
        public String KV;
        
        public Int32 ResultCode;
        public String ResultDescription;

        private static string Translate( string str )
        {
            String out_str;
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            //DBLogger.Info("Translate FIO" + str, "BPK_service");
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = @"select BARS.f_translate_kmu( :p_str) out_str from dual";
                cmd.Parameters.Add("p_str", OracleDbType.Varchar2, str, ParameterDirection.Input);
               
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    out_str = (String)rdr["out_str"];
                    //DBLogger.Info("Translate FIO" + out_str, "BPK_service");
                    return out_str;

                   
                }
                else
                {
                    out_str = str;
                    //DBLogger.Info("Translate FIO" + out_str, "BPK_service");
                    return out_str;
                }
            }
            catch (System.Exception e)
            {
               // DBLogger.Info("Помилка при транслітерації" + e.Message, "BPK_service");
                return str;
               
            }
            finally
            {
                con.Close();
                con.Dispose();
                
            }
            
        }
        

        public NewBPK(
         Int64 RNK,
         String BRANCH,
         String PRODUCT_CODE,
         int TERM,
         int? LIMIT,
         String F_NAME,
         String L_NAME,
         String DM_MNAME,
         String WORK,
         String OFFICE,
         String WORKDATE,
         int? SALARYPROECT,
         String BRANCHISSUE)
        {
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                //cmd.CommandText = @"select 2600||to_char(round(DBMS_RANDOM.VALUE(1,1000),0),'0999')||to_char(round(DBMS_RANDOM.VALUE(1,10000),0),'09999') nls from dual";
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "BARS_OW.OPEN_CARD";
                cmd.Parameters.Add("P_RNK", OracleDbType.Decimal, RNK, ParameterDirection.Input);
                cmd.Parameters.Add("P_NLS", OracleDbType.Varchar2, null, ParameterDirection.Input);
                cmd.Parameters.Add("P_CARDCODE", OracleDbType.Varchar2, PRODUCT_CODE, ParameterDirection.Input);
                cmd.Parameters.Add("P_BRANCH", OracleDbType.Varchar2, BRANCH, ParameterDirection.Input);
                cmd.Parameters.Add("P_EMBFIRSTNAME", OracleDbType.Varchar2, Translate(F_NAME).ToUpper(), ParameterDirection.Input);
                cmd.Parameters.Add("P_EMBLASTNAME", OracleDbType.Varchar2, Translate(L_NAME).ToUpper(), ParameterDirection.Input);
                cmd.Parameters.Add("P_SECNAME", OracleDbType.Varchar2, DM_MNAME, ParameterDirection.Input);
                cmd.Parameters.Add("P_WORK", OracleDbType.Varchar2, WORK, ParameterDirection.Input);
                cmd.Parameters.Add("P_OFFICE", OracleDbType.Varchar2, OFFICE, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(WORKDATE)) cmd.Parameters.Add("P_WDATE", OracleDbType.Date, DateTime.ParseExact(WORKDATE, "yyyy.MM.dd", CultureInfo.InvariantCulture), ParameterDirection.Input);
                else cmd.Parameters.Add("P_WDATE", OracleDbType.Date, null, ParameterDirection.Input);
              //  cmd.Parameters.Add("P_WDATE", OracleDbType.Date, (String.IsNullOrEmpty(WORKDATE))? null : (DateTime.ParseExact(WORKDATE, "yyyy.MM.dd", CultureInfo.InvariantCulture)), ParameterDirection.Input);
                cmd.Parameters.Add("P_SALARYPROECT", OracleDbType.Decimal, SALARYPROECT, ParameterDirection.Input);
                cmd.Parameters.Add("P_TERM", OracleDbType.Decimal, TERM, ParameterDirection.Input);
                cmd.Parameters.Add("P_BRANCHISSUE", OracleDbType.Varchar2, BRANCHISSUE, ParameterDirection.Input);
                cmd.Parameters.Add("P_ND", OracleDbType.Decimal, null, ParameterDirection.Output);
                cmd.Parameters.Add("P_REQID", OracleDbType.Decimal, null, ParameterDirection.Output);
                
                cmd.ExecuteNonQuery();
                

                Decimal? ND;
                object P_ND = cmd.Parameters["P_ND"].Value;

                ND = (P_ND == null || ((OracleDecimal)P_ND).IsNull) ? (Decimal?)null : ((OracleDecimal)P_ND).Value;
                //DBLogger.Info("Номер ND картки" + ND.ToString(), "BPK_service");
                
                this.ResultDescription += String.Format("Створено картку ND ={0}", ND.ToString());

                                try
                                {
                                    cmd.CommandType = CommandType.Text;
                                    cmd.Parameters.Clear();
                                    cmd.CommandText = @"select t1.nls, to_char(T1.acc) acc, to_char(T1.kv) kv  from BARS.ACCOUNTS t1, BARS.W4_ACC t2 where T1.ACC = T2.ACC_PK and T2.ND = :p_nd";
                                    cmd.Parameters.Add("p_nd", OracleDbType.Decimal, ND, ParameterDirection.Input);
                                    //cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, MFO, ParameterDirection.Input);

                                    OracleDataReader rdr = cmd.ExecuteReader();
                                    if (rdr.Read())
                                    {
                                        this.NLS = (String)rdr["nls"];
                                        this.ACC = (String)rdr["acc"];
                                        this.KV = (String)rdr["kv"];
                                    }
                                    else
                                    {

                                        this.ResultCode = 1;
                                        this.ResultDescription += String.Format("Рахунок клієнта з номером запиту {0} не знайдено", ND.ToString() );
                                    }
                                }
                                catch (System.Exception e)
                                {
                                    //DBLogger.Info("Помилка при створенні картки" + e.Message, "BPK_service");
                                    this.ResultCode = 2;
                                    this.ResultDescription += String.Format("Помилка при створенні рахунку: {0}", e.Message);
                                }
                                finally
                                {
                                    con.Close();
                                    con.Dispose();
                                }
               
            }
            catch (System.Exception e)
            {
                //DBLogger.Info("Помилка при створенні картки" + e.Message, "BPK_service");
                this.ResultCode = 3;
                this.ResultDescription += String.Format("Помилка при створенні рахунку: {0}", e.Message);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
     public class NewClientResult
    {
        public DateTime ResultDate;
        public String ServiceName;
        public Int32 ResultCode;
        public String ResultDescription;
        

        public NewClient ResultNewClient;

        public NewClientResult()
        {
            this.ResultDate = DateTime.Now;
            this.ServiceName = "CRM Exchange";
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;
        }
    }
    
    public class NewBPKResult
    {
        public DateTime ResultDate;
        public String ServiceName;
        public Int32 ResultCode;
        public String ResultDescription;


        public NewBPK ResultNewBPK;

        public NewBPKResult()
        {
            this.ResultDate = DateTime.Now;
            this.ServiceName = "CRM Exchange";
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;
        }
    }

    /// <summary>
    /// Сервис для интеграции с задачей BPK
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class BPKService : Bars.BarsWebService
    {
        # region Константы
        public const String XMLVersion = "1.0";
        public const String XMLEncoding = "UTF-8";
        public const String DateFormat = "yyyy.MM.dd";
        public const String DateTimeFormat = "yyyy.MM.dd HH:mm:ss";
        public const String NumberFormat = "######################0.00##";
        public const String DecimalSeparator = ".";
        # endregion

        # region Конструкторы
        public BPKService()
        {
        }
        # endregion

        # region Публичные свойства
        public WsHeader WsHeaderValue;
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
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        public String OpenClient(Int64 USER_ID,
         String BRANCH,
         String LASTNAME,
         String FIRSTNAME,
         String MIDDLENAME,
         int GENDER,
         int RESIDENT,
         String BIRTHDATE,
         String BPLACE,
         String OKPO,
         String PHONENUMBER_MOB,
         String E_MAIL,
         String DATEIN,
         String DATEMOD,
         String DATECLOSE,
         int OPER_TYPE,
         int CLIENTTYPE,
         String ENGLASTNAME,
         String ENGFIRSTNAME,
         String COUNTRY,
         String WORK,
         String OFFICE,
         String DATE_W,
         String K060,
         String K013,
         String K070,
         String K080,
         String K110,
         String K050,
         String K051,
         String COMPANYNAME,
         String SHORTCOMPANYNAME,
         String ADDR1_CITYNAME,
         String ADDR1_PCODE,
         String ADDR1_DOMAIN,
         String ADDR1_REGION,
         String ADDR1_STREET,
         String ADDR2_CITYNAME,
         String ADDR2_PCODE,
         String ADDR2_DOMAIN,
         String ADDR2_REGION,
         String ADDR2_STREET,
         int TYPEDOC,
         String PASPSERIES,
         String PASPNUM,
         String PASPDATE,
         String PASPISSUER,
         int PRINSIDER,
         String PHOTODATE,
         int IS_SPECIAL_CLIENT, String CRMUserLogin, String CRMUserFIO)
        {
            NewClientResult res = new NewClientResult();

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
                if (isAuthenticated) LoginUser(userName);

                String Req = String.Format("USER_ID ={0}, BRANCH ={1}, LASTNAME ={2}, FIRSTNAME ={3}, MIDDLENAME ={4}, GENDER ={5}, RESIDENT ={6}, BIRTHDATE ={7}, BPLACE ={8}, OKPO ={9}, PHONENUMBER_MOB ={10}, E_MAIL ={11}, DATEIN ={12}, DATEMOD ={13}, DATECLOSE ={14}, OPER_TYPE ={15},", USER_ID.ToString(), BRANCH, LASTNAME,FIRSTNAME,MIDDLENAME,GENDER.ToString(),RESIDENT.ToString(),BIRTHDATE,BPLACE,OKPO,PHONENUMBER_MOB,E_MAIL,DATEIN,DATEMOD,DATECLOSE,OPER_TYPE.ToString());
                Req += String.Format(" CLIENTTYPE ={0}, ENGLASTNAME ={1}, ENGFIRSTNAME ={2}, COUNTRY ={3},  WORK ={4}, OFFICE ={5}, DATE_W ={6},  K060 ={7}, K013 ={8}, K070 ={9}, K080 ={10}, K110 ={11}, K050 ={12}, K051 ={13}, COMPANYNAME ={14}, SHORTCOMPANYNAME ={15}, ",CLIENTTYPE.ToString(), ENGLASTNAME , ENGFIRSTNAME , COUNTRY ,  WORK , OFFICE , DATE_W ,  K060 , K013 , K070 , K080 , K110 , K050,  K051 , COMPANYNAME , SHORTCOMPANYNAME);
                Req += String.Format(" ADDR1_CITYNAME ={0}, ADDR1_PCODE ={1}, ADDR1_DOMAIN ={2}, ADDR1_REGION ={3},ADDR1_STREET ={4}, ADDR2_CITYNAME ={5}, ADDR2_PCODE ={6}, ADDR2_DOMAIN ={7}, ADDR2_REGION ={8},ADDR2_STREET ={9},", ADDR1_CITYNAME, ADDR1_PCODE , ADDR1_DOMAIN , ADDR1_REGION ,ADDR1_STREET , ADDR2_CITYNAME , ADDR2_PCODE , ADDR2_DOMAIN , ADDR2_REGION ,ADDR2_STREET );
                Req += String.Format("TYPEDOC ={0}, PASPSERIES ={1}, PASPNUM ={2},PASPDATE ={3},PASPISSUER ={4}, PRINSIDER ={5}, PHOTODATE ={6}, IS_SPECIAL_CLIENT ={7}",TYPEDOC.ToString(), PASPSERIES, PASPNUM ,PASPDATE ,PASPISSUER, PRINSIDER.ToString(), PHOTODATE, IS_SPECIAL_CLIENT.ToString());
                //DBLogger.Info("Параметри запиту створення клієнта BPK_service " + Req, "BPK_service");
                // исключения не выбрасываются, а корректно обработываются
                res.ResultNewClient = new NewClient(USER_ID,
         BRANCH,
         LASTNAME,
         FIRSTNAME,
         MIDDLENAME,
         GENDER,
         RESIDENT,
         BIRTHDATE,
         BPLACE,
         OKPO,
         PHONENUMBER_MOB,
         E_MAIL,
         DATEIN,
         DATEMOD,
         DATECLOSE,
         OPER_TYPE,
         CLIENTTYPE,
         ENGLASTNAME, 
         ENGFIRSTNAME,
         COUNTRY,
         WORK,
         OFFICE,
         DATE_W,
         K060,
         K013,
         K070,
         K080,
         K110,
         K050,
         K051,
         COMPANYNAME,
         SHORTCOMPANYNAME,
         ADDR1_CITYNAME,
         ADDR1_PCODE,
         ADDR1_DOMAIN,
         ADDR1_REGION,
         ADDR1_STREET,
         ADDR2_CITYNAME,
         ADDR2_PCODE,
         ADDR2_DOMAIN,
         ADDR2_REGION,
         ADDR2_STREET,
         TYPEDOC,
         PASPSERIES,
         PASPNUM,
         PASPDATE,
         PASPISSUER,
         PRINSIDER,
         PHOTODATE,
         IS_SPECIAL_CLIENT);
            }
            catch (System.Exception e)
            {
                res.ResultCode = 1;
                res.ResultDescription = String.Format("Помилка авторизації: {0}", e.Message);
            }

            return new JavaScriptSerializer().Serialize(res);
        }
       

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        public String OpenBpk(
         Int64 RNK,
         String BRANCH,
         String PRODUCT_CODE,
         int TERM,
         int? LIMIT,
         String F_NAME,
         String L_NAME,
         String DM_MNAME,
         String WORK,
         String OFFICE,
         String WORKDATE,
         int? SALARYPROECT,
         String BRANCHISSUE,
         String CRMUserLogin, 
         String CRMUserFIO)
        {
            NewBPKResult bpk = new NewBPKResult();
            string res;
            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";
            
            // авторизация пользователя по хедеру
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
                if (isAuthenticated) LoginUser(userName);
                try
                {
                    //DBLogger.Info("UserName = " + userName + " password = " + password,"BPK_service");
                    String Req = String.Format("RNK ={0}, BRANCH ={1}, PRODUCT_CODE ={2}, TERM ={3}, LIMIT ={4}, F_NAME ={5}, L_NAME ={6}, DM_MNAME ={7}, WORK ={8}, OFFICE ={9}, WORKDATE ={10}, SALARYPROECT ={11}, BRANCHISSUE  ={12}", RNK.ToString(), BRANCH, PRODUCT_CODE, TERM.ToString(), LIMIT.ToString(), F_NAME, L_NAME, DM_MNAME, WORK, OFFICE, WORKDATE, SALARYPROECT.ToString(), BRANCHISSUE);
                    //DBLogger.Info("Параметри запиту створення картки " + Req, "BPK_service");
                    bpk.ResultNewBPK = new NewBPK(RNK, BRANCH, PRODUCT_CODE, TERM, LIMIT, F_NAME, L_NAME, DM_MNAME, WORK, OFFICE, WORKDATE, SALARYPROECT, BRANCHISSUE);
                    
                }
                catch (SystemException ex)
                {
                   // res = ex.Message;
                    //DBLogger.Info("Помилка при створенні картки" + ex.Message, "BPK_service");
                    return ex.Message;
                }

                // исключения не выбрасываются, а корректно обработываются
                //res= "True";
            }
            catch (System.Exception e)
            {
                return "False";
            }

           try
            {
                res = new JavaScriptSerializer().Serialize(bpk);
                return res;
            }
            catch (SystemException ex)
            { res = ex.Message;
            return res;
            }

           
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        public String CheckBpkStatus(Int64 ACC)
        {
            String res;

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
                if (isAuthenticated) LoginUser(userName);

                // исключения не выбрасываются, а корректно обработываются
                res= "True";
            }
            catch (System.Exception e)
            {
                res = "False";
            }
            
            return res;
        }
        # endregion
    }
}