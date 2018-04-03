using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;
using Bars.Logger;
using System.IO;
using System.Globalization;
using Bars.Web.Report;
using Bars.Classes;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

namespace clientregister
{
    /// <summary>
    /// Результат регистрации
    /// </summary>
    public class RegistrationResult
    {
        public String RegType; /* Reg, ReReg */
        public String Status = "OK"; /* OK, ERROR */
        public String ErrorMessage = "";
        public Decimal Rnk;
        public String ResultText
        {
            get
            {
                switch (Status)
                {
                    case "OK":
                        return String.Format("Клієнта РНК={0} успішно {1}", Rnk, (RegType == "REG" ? "зареєстровано" : "збережено"));
                    case "ERROR":
                        return String.Format("Помилки при {0}: {1}", (RegType == "REG" ? "реєстрації" : "збереженні"), ErrorMessage);
                    default:
                        return String.Empty;
                }
            }
        }

        public RegistrationResult(String RegType)
        {
            this.RegType = RegType;
        }
        public RegistrationResult()
        {
        }
    }
    /// <summary>
    /// Результат валидации
    /// </summary>
    public class ValidationResult
    {
        public String Code;
        public String Text;
        public String Param;

        public ValidationResult(String Code, String Text)
        {
            this.Code = Code;
            this.Text = Text;
        }
        public ValidationResult(String Code)
            : this(Code, String.Empty)
        {
        }
        public ValidationResult()
        {
        }
    }

    /// <summary>
    /// Умолчательные значения эк. нормативов
    /// </summary>
    public class DefEkNorm
    {
        public String ISE;
        public String FS;
        public String VED;
        public String OE;
        public String K050;
        public String SED;

        public DefEkNorm()
        {
        }
    }
    /// <summary>
    /// Запись таблицы Codecagent
    /// </summary>
    public class CodecagentRecord
    {
        public Decimal CODCAGENT;
        public Decimal REZID;
        public String NAME;
        public CodecagentRecord()
        {
        }
        public CodecagentRecord(Decimal CODCAGENT, Decimal REZID, String NAME)
        {
            this.CODCAGENT = CODCAGENT;
            this.REZID = REZID;
            this.NAME = NAME;
        }
    }
    /// <summary>
    /// Запись таблицы Tgr
    /// </summary>
    public class TgrRecord
    {
        public Decimal TGR;
        public String NAME;
        public TgrRecord()
        {
        }
        public TgrRecord(Decimal TGR, String NAME)
        {
            this.TGR = TGR;
            this.NAME = NAME;
        }
    }
    /// <summary>
    /// Запись таблицы Country
    /// </summary>
    public class CountryRecord
    {
        public Decimal COUNTRY;
        public String NAME;
        public CountryRecord()
        {
        }
        public CountryRecord(Decimal COUNTRY, String NAME)
        {
            this.COUNTRY = COUNTRY;
            this.NAME = NAME;
        }
    }

    /// <summary>
    /// Строка доп. реквизита 
    /// </summary>
    public class CustAttrRecord
    {
        public string Tag;
        public string Value;
        public string Isp;
    }

    /// <summary>
    /// Строка значения уровня риска
    /// </summary>
    public class CustRiskRecord
    {
        public string Id;
        public int Value;
    }

    /// <summary>
    /// Вебсервис
    /// </summary>
    [ScriptService]
    public class defaultWebService : Bars.BarsWebService
    {
        public CultureInfo cinfo;

        public defaultWebService()
        {
            InitializeComponent();
        }

        #region Component Designer generated code

        //Required by the Web Services Designer 
        private IContainer components = null;

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #endregion

        /// <summary>
        /// Транслитерация наименования клиента
        /// </summary>
        /// <param name="txt">ФИО клиента кирилицей</param>
        [WebMethod(EnableSession = true)]
        public String TranslateKMU(String txt)
        {
            String res = String.Empty;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select f_translate_kmu(:p_txt) from dual";
            cmd.Parameters.Add("p_txt", OracleDbType.Varchar2, txt, ParameterDirection.Input);

            try
            {
                if (con.State != ConnectionState.Open) con.Open();
                res = Convert.ToString(cmd.ExecuteScalar());
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        /// <summary>
        /// Необходим для печати договора
        /// </summary>
        /// <param name="rnk">РНК клиента</param>
        /// <param name="templateID">Код шаблона</param>
        [WebMethod(EnableSession = true)]
        public string GetFileForPrint(string rnk, string templateID, string adds)
        {
            string fileName = string.Empty;
            RtfReporter rep = new RtfReporter(Context);
            rep.RoleList = "reporter,cc_doc";
            rep.ContractNumber = Convert.ToInt64(rnk);

            rep.TemplateID = templateID;
            if (!string.IsNullOrEmpty(adds))
                rep.ADDS = Convert.ToInt64(adds);
            rep.Generate();
            fileName = rep.ReportFile;

            return fileName;
        }
        /// <summary>
        /// Вычитка Характеристика клиента (К010)
        /// </summary>
        /// <param name="CType">Тип клиента</param>
        /// <param name="val">возврат кодовых значений</param>
        /// <param name="txt">возврат текстовых значений</param>
        [WebMethod(EnableSession = true)]
        public List<CodecagentRecord> GetCodecagentList(String CType, int rezId)
        {
            List<CodecagentRecord> res = new List<CodecagentRecord>();

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select codcagent, rezid, name from codcagent ";
            switch (CType)
            {
                case "person":
                    cmd.CommandText += "where codcagent in (5, 6) and rezid=" + rezId + " ";
                    break;
                case "corp":
                    cmd.CommandText += "where codcagent in (3, 4, 7) and rezid=" + rezId + " ";
                    break;
                case "bank":
                    cmd.CommandText += "where codcagent in (1, 2, 9) and rezid=" + rezId + " ";
                    break;
            }
            cmd.CommandText += "order by codcagent";

            try
            {
                if (con.State != ConnectionState.Open) con.Open();

                OracleDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    res.Add(new CodecagentRecord(
                        Convert.ToDecimal(rdr["CODCAGENT"]),
                        Convert.ToDecimal(rdr["REZID"]),
                        Convert.ToString(rdr["NAME"])
                        ));
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        /// <summary>
        /// Тип гос реестра
        /// </summary>
        /// <param name="CType">Тип клиента</param>
        /// <param name="val">возврат кодовых значений</param>
        /// <param name="txt">возврат текстовых значений</param>
        [WebMethod(EnableSession = true)]
        public List<TgrRecord> GetTgrList(String CType)
        {
            List<TgrRecord> res = new List<TgrRecord>();

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select name, tgr from tgr ";
            switch (CType)
            {
                case "person":
                    break;
                case "corp":
                case "bank":
                    cmd.CommandText += "where tgr in (1, 3) ";
                    break;
            }

            try
            {
                if (con.State != ConnectionState.Open) con.Open();

                OracleDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    res.Add(new TgrRecord(
                        Convert.ToDecimal(rdr["TGR"]),
                        Convert.ToString(rdr["NAME"])
                        ));
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        /// <summary>
        /// Вычитка стран
        /// </summary>
        /// <param name="Rezid">Резидент/не резидент</param>
        /// <param name="val">возврат кодовых значений</param>
        /// <param name="txt">возврат текстовых значений</param>
        [WebMethod(EnableSession = true)]
        public List<CountryRecord> GetCountryList(Int32 Rezid)
        {
            List<CountryRecord> res = new List<CountryRecord>();

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select country, name from country where country " + (Rezid != 1 ? "not" : "") + " in (select nvl(min(val), 804) from params where par = 'COUNTRY') order by name";

            try
            {
                if (con.State != ConnectionState.Open) con.Open();

                OracleDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    res.Add(new CountryRecord(
                        Convert.ToDecimal(rdr["COUNTRY"]),
                        Convert.ToString(rdr["NAME"])
                        ));
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        /// <summary>
        /// Проверка наличия указаного ОКПО
        /// </summary>
        /// <param name="args">Строка для проверки</param>
        /// <returns>Строка или ОК или Неверный код ОКПО</returns>
        [WebMethod(EnableSession = true)]
        public ValidationResult ValidateOkpo(String OKPO)
        {
            ValidationResult res = new ValidationResult("OK");

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select rnk from customer where okpo = :p_okpo and rownum = 1";
            cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, OKPO, ParameterDirection.Input);

            try
            {
                if (con.State != ConnectionState.Open) con.Open();

                Object tmpObj = cmd.ExecuteScalar();
                if (tmpObj != null)
                {
                    res.Code = "ERROR";
                    res.Text = "Клієнт з таким ІПН вже існує! Відкрити картку?";
                    res.Param = Convert.ToString(tmpObj);
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }

        /// <summary>
        /// проверить доступ к редактированию даного контрагент
        /// </summary>
        /// <param name="OKPO"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string CheckAccess(String RNK)
        {
            string res = string.Empty;
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = "select count(rnk) from v_tobo_cust_fm where rnk=:p_rnk and branch=sys_context('bars_context', 'user_branch')";
            cmd.Parameters.Add("p_rnk", OracleDbType.Varchar2, RNK, ParameterDirection.Input);

            try
            {
                if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
                    res = "2";
                else
                    res = "3";
            }
            /*catch { 
                // на всякий случай давим ошибку и не даем редактировать
                res = "3";
            }*/
            finally
            {
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }

            return res;
        }

        /// <summary>
        /// Проверка наличия указаного документа
        /// </summary>
        [WebMethod(EnableSession = true)]
        public ValidationResult ValidateDocument(Decimal Type, String Series, String Number)
        {
            ValidationResult res = new ValidationResult("OK");

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = @"select c.rnk, c.nmk, decode(c.date_off, null, 0, 1) as closed
                                  from customer c
                                 where c.rnk in (select p.rnk
                                                   from person p
                                                  where p.passp = :p_type
                                                    and translate(upper(p.ser),
                                                                  'ABCEHIKMOPTXY',
                                                                  'АВСЕНІКМОРТХУ') =
                                                        translate(upper(:p_series),
                                                                  'ABCEHIKMOPTXY',
                                                                  'АВСЕНІКМОРТХУ')
                                                    and upper(p.numdoc) = :p_number)
                                 order by c.date_off nulls first, c.rnk";
            cmd.Parameters.Add("p_type", OracleDbType.Decimal, Type, ParameterDirection.Input);
            cmd.Parameters.Add("p_series", OracleDbType.Varchar2, Series, ParameterDirection.Input);
            cmd.Parameters.Add("p_number", OracleDbType.Varchar2, Number, ParameterDirection.Input);

            try
            {
                if (con.State != ConnectionState.Open) con.Open();

                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    res.Code = "ERROR";
                    res.Text = String.Format("Клієнт з такими серією та номером паспорту вже зареєстрований (РНК {0}, ПІБ {1})! Відкрити картку?", rdr["rnk"], rdr["nmk"]);
                    res.Param = Convert.ToString(rdr["rnk"]);
                }
            }
            catch (System.Exception e)
            {

            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        /// <summary>
        /// Поиск коментария по числовому значению поля ISE
        /// </summary>
        /// <param name="val">Числовое значение</param>
        /// <returns>Коментарий</returns>
        [WebMethod(EnableSession = true)]
        public string GetIseCom(string val)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("pise", OracleDbType.Varchar2, val, ParameterDirection.Input);
                command.CommandText = "SELECT trim(NAME), trim(ISE) FROM ISE WHERE ISE = :pise";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            string res = "Not found";
            if (dt.Rows.Count > 0)
                res = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();

            return res;
        }
        /// <summary>
        /// Полный список Ise
        /// </summary>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        [WebMethod(EnableSession = true)]
        public void GetIseList(out string[] val, out string[] txt)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.CommandText = "SELECT trim(NAME), trim(ISE) FROM ISE";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count];
            txt = new string[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                val[i] = dt.Rows[i].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i].ItemArray.GetValue(0).ToString().Trim();
            }
        }
        /// <summary>
        /// Поиск коментария по числовому значению поля FS
        /// </summary>
        /// <param name="val">Числовое значение</param>
        /// <returns>Коментарий</returns>
        [WebMethod(EnableSession = true)]
        public string GetFsCom(string val, string CType, decimal Codcagent)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("pfs", OracleDbType.Varchar2, val, ParameterDirection.Input);

                if (CType == "person")
                {
                    string fs = "'10'";
                    if ((Codcagent + 2) % 2 == 0)
                        fs += ",'00'";
                    command.CommandText = "SELECT NAME, FS FROM FS WHERE FS in (" + fs + ") and (D_CLOSE is null or D_CLOSE > bankdate) and FS=:pfs";
                }
                else command.CommandText = "SELECT trim(NAME), trim(FS) FROM FS WHERE FS=:pfs";

                adapter.Fill(dt);
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            string res = "Not found";
            if (dt.Rows.Count > 0)
                res = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();

            return res;
        }
        /// <summary>
        /// Полный список FS
        /// </summary>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        [WebMethod(EnableSession = true)]
        public void GetFsList(out string[] val, out string[] txt, string CType)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                if (CType == "person") command.CommandText = "SELECT NAME, FS FROM FS WHERE FS = '10' and (D_CLOSE is null or D_CLOSE > bankdate)";
                else command.CommandText = "SELECT trim(NAME), trim(FS) FROM FS";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count];
            txt = new string[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                val[i] = dt.Rows[i].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i].ItemArray.GetValue(0).ToString().Trim();
            }
        }
        /// <summary>
        /// Поиск коментария по числовому значению поля VED
        /// </summary>
        /// <param name="val">Числовое значение</param>
        /// <param name="txt">Стринговое значение</param>
        /// <param name="oelist">Список oelist(перечислен через запятую)</param>
        [WebMethod(EnableSession = true)]
        public void GetVedCom(string val, out string txt, out string oelist)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("pved", OracleDbType.Varchar2, val, ParameterDirection.Input);
                command.CommandText = "SELECT trim(NAME), trim(OELIST) FROM VED WHERE VED = :pved";

                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            txt = "Not found";
            oelist = "";
            if (dt.Rows.Count > 0)
            {
                txt = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();
                oelist = dt.Rows[0].ItemArray.GetValue(1).ToString().Trim();
            }
        }
        /// <summary>
        /// Полный список VED
        /// </summary>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        /// <param name="oelist">аут параметр - списки oelist</param>
        [WebMethod(EnableSession = true)]
        public void GetVedList(out string[] val, out string[] txt, out string[] oelist)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.CommandText = "SELECT trim(NAME), trim(VED), trim(OELIST) FROM VED";

                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count];
            txt = new string[dt.Rows.Count];
            oelist = new string[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                val[i] = dt.Rows[i].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i].ItemArray.GetValue(0).ToString().Trim();
                oelist[i] = dt.Rows[i].ItemArray.GetValue(2).ToString().Trim();
            }
        }
        /// <summary>
        /// Поиск коментария по числовому значению поля OE
        /// </summary>
        /// <param name="val">Числовое значение</param>
        /// <returns>Коментарий</returns>
        [WebMethod(EnableSession = true)]
        public string GetOeCom(string val, string vedVal)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                string filter = GetOESQL(vedVal);
                if (filter != "")
                    command.CommandText = "SELECT trim(NAME), trim(OE) FROM OE WHERE (" + filter + ") and OE=:poe";
                else
                    command.CommandText = "SELECT trim(NAME), trim(OE) FROM OE WHERE OE=:poe";

                command.Parameters.Add("poe", OracleDbType.Varchar2, val, ParameterDirection.Input);

                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            string res = "Not found";
            if (dt.Rows.Count > 0)
                res = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();

            return res;
        }
        [WebMethod(EnableSession = true)]
        public string GetOESQL(string ved)
        {
            string res = "";

            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("pved", OracleDbType.Varchar2, ved, ParameterDirection.Input);
                command.CommandText = "SELECT trim(OELIST) FROM VED WHERE VED = :pved";

                adapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    string[] tmp = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim().Split(',');

                    for (int i = 0; i < tmp.Length; i++)
                    {
                        if (tmp[i].Replace(":", "") == tmp[i])
                        {
                            res += ((res == "") ? ("") : (" or ")) + "OE='" + tmp[i] + "'";
                        }
                        else
                        {

                            string a = tmp[i].Split(':').GetValue(0).ToString();
                            string b = tmp[i].Split(':').GetValue(1).ToString();

                            res += ((res == "") ? ("") : (" or ")) + "OE between '" + a + "' and '" + b + "'";
                        }
                    }
                    res += ((res == "") ? ("") : (" or ")) + " OE = '00000' or OE = '99999' ";
                }
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            return res;
        }
        /// <summary>
        /// Полный список допустимых Ое
        /// </summary>
        /// <param name="oelist">Разрешенные Ое(через запятую или null)</param>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        [WebMethod(EnableSession = true)]
        public void GetOeList(string oelist, out string[] val, out string[] txt)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                if (oelist != null)
                {
                    string filter = "";
                    string[] tmp = oelist.Trim().Split(',');

                    for (int i = 0; i < tmp.Length; i++)
                    {
                        if (tmp[i].Replace(":", "") == tmp[i])
                        {
                            filter += ((filter == "") ? ("") : (" or ")) + "OE='" + tmp[i] + "'";
                        }
                        else
                        {

                            string a = tmp[i].Split(':').GetValue(0).ToString();
                            string b = tmp[i].Split(':').GetValue(1).ToString();

                            filter += ((filter == "") ? ("") : (" or ")) + "OE between '" + a + "' and '" + b + "'";
                        }
                    }

                    command.CommandText = "SELECT trim(NAME), trim(OE) FROM OE WHERE OE = '00000' or " + filter;
                }
                else
                    command.CommandText = "SELECT trim(NAME), trim(OE) FROM OE";

                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count];
            txt = new string[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                val[i] = dt.Rows[i].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i].ItemArray.GetValue(0).ToString().Trim();
            }
        }
        /// <summary>
        /// Поиск коментария по числовому значению поля K050
        /// </summary>
        /// <param name="val">Числовое значение</param>
        /// <returns>Коментарий</returns>
        [WebMethod(EnableSession = true)]
        public string GetK050Com(string val)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("p_k050", OracleDbType.Char, val, ParameterDirection.Input);
                command.CommandText = @"select trim(k050.name), trim(k050.k050)
                                          from sp_k050 k050
                                         where k050.k050 = :p_k050
                                           and length(trim(k050.k050)) = 3
                                           and (k050.d_close is null or k050.d_close > bankdate)
                                         order by k050.k050";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            string res = "Not found";
            if (dt.Rows.Count > 0)
                res = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();

            return res;
        }
        /// <summary>
        /// Полный список K050
        /// </summary>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        [WebMethod(EnableSession = true)]
        public void GetK050List(out string[] val, out string[] txt)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.CommandText = @"select trim(k050.name), trim(k050.k050)
                                          from sp_k050 k050
                                         where length(trim(k050.k050)) = 3
                                           and (k050.d_close is null or k050.d_close > bankdate)
                                         order by k050.k050";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count];
            txt = new string[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                val[i] = dt.Rows[i].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i].ItemArray.GetValue(0).ToString().Trim();
            }
        }
        /// <summary>
        /// Получение дефолтных значений экономических нормативов
        /// </summary>
        [WebMethod(EnableSession = true)]
        public DefEkNorm GetDefEkNorm()
        {
            DefEkNorm res = new DefEkNorm();

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = @"select p050.k050, p070.k070, p080.k080, p090.k090, p110.k110, p051.k051
                                      from (select min(val) as k050 from params where par = 'CUSTK050') p050,
                                           (select min(val) as k070 from params where par = 'CUSTK070') p070,
                                           (select min(val) as k080 from params where par = 'CUSTK080') p080,
                                           (select min(val) as k090 from params where par = 'CUSTK090') p090,
                                           (select min(val) as k110 from params where par = 'CUSTK110') p110,
                                           (select min(val) as k051 from params where par = 'CUSTK051') p051";

                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.ISE = rdr["k070"] == DBNull.Value ? (String)null : (String)rdr["k070"];
                        res.FS = rdr["k080"] == DBNull.Value ? (String)null : (String)rdr["k080"];
                        res.VED = rdr["k110"] == DBNull.Value ? (String)null : (String)rdr["k110"];
                        res.OE = rdr["k090"] == DBNull.Value ? (String)null : (String)rdr["k090"];
                        res.K050 = rdr["k050"] == DBNull.Value ? (String)null : (String)rdr["k050"];
                        res.SED = rdr["k051"] == DBNull.Value ? (String)null : (String)rdr["k051"];
                    }
                }
            }
            finally
            {
                con.Close();
            }

            return res;
        }

        /// <summary>
        /// Поиск значения sed по параметру k050
        /// </summary>
        /// <param name="k050">Значение k050</param>
        /// <returns>значения sed</returns>
        [WebMethod(EnableSession = true)]
        public string CalcSedValue(string k050)
        {
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();

                // устанавливаем роль
                cmd.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CUSTREG");
                cmd.ExecuteNonQuery();

                cmd.Parameters.Add("p_k050", OracleDbType.Char, k050, ParameterDirection.Input);
                cmd.CommandText = @"select trim(k050.k051)
                                          from sp_k050 k050
                                         where k050.k050 = :p_k050
                                           and length(trim(k050.k050)) = 3
                                           and (k050.d_close is null or k050.d_close > bankdate)
                                         order by k050.k050";

                String res = Convert.ToString(cmd.ExecuteScalar());
                if (String.IsNullOrEmpty(res)) res = "Not found";
                return res;
            }
            finally
            {
                con.Close();
            }
        }
        /// <summary>
        /// Поиск коментария по числовому значению поля SED
        /// </summary>
        /// <param name="val">Числовое значение</param>
        /// <returns>Коментарий</returns>
        [WebMethod(EnableSession = true)]
        public string GetSedCom(string val)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("psed", OracleDbType.Char, val, ParameterDirection.Input);
                command.CommandText = "SELECT trim(NAME), trim(SED) FROM SED WHERE SED = :psed";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            string res = "Not found";
            if (dt.Rows.Count > 0)
                res = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();

            return res;
        }
        /// <summary>
        /// Полный список Sed
        /// </summary>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        [WebMethod(EnableSession = true)]
        public void GetSedList(out string[] val, out string[] txt)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.CommandText = "SELECT trim(NAME), trim(SED) FROM SED";
                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count];
            txt = new string[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                val[i] = dt.Rows[i].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i].ItemArray.GetValue(0).ToString().Trim();
            }
        }
        /// <summary>
        /// Районная НИ
        /// </summary>
        /// <param name="C_reg">Код областной НИ</param>
        /// <param name="val">аут параметр - числовые значения</param>
        /// <param name="txt">аут параметр - строковые значения</param>
        [WebMethod(EnableSession = true)]
        public void GetC_dstList(string C_reg, out string[] val, out string[] txt)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("pC_reg", OracleDbType.Decimal, decimal.Parse(C_reg), ParameterDirection.Input);
                command.CommandText = "SELECT trim(NAME_STI), trim(C_DST) FROM SPR_REG WHERE C_REG = :pC_reg ORDER BY C_DST";

                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            val = new string[dt.Rows.Count + 1];
            txt = new string[dt.Rows.Count + 1];

            val[0] = "";
            txt[0] = "";

            for (int i = 1; i < dt.Rows.Count + 1; i++)
            {
                val[i] = dt.Rows[i - 1].ItemArray.GetValue(1).ToString().Trim();
                txt[i] = dt.Rows[i - 1].ItemArray.GetValue(0).ToString().Trim();
            }
        }
        /// <summary>
        /// Поиск наименования банка по его МФО
        /// </summary>
        /// <param name="val">МФО</param>
        /// <returns>Нименование банка или предупреждение, что оно не найдено</returns>
        [WebMethod(EnableSession = true)]
        public string GetMfoCom(string val)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            DataTable dt = new DataTable("result");

            try
            {
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = command;


                // устанавливаем роль
                command.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                command.ExecuteNonQuery();

                command.Parameters.Add("pmfo", OracleDbType.Varchar2, val, ParameterDirection.Input);
                command.CommandText = "SELECT trim(NB), trim(MFO) FROM BANKS WHERE MFO = :pmfo";

                adapter.Fill(dt);
            }
            catch (Exception e)
            {
                SaveExeption(e);
                throw e;
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            string res = "Наименование банка не найдено!!!";
            if (dt.Rows.Count > 0)
                res = dt.Rows[0].ItemArray.GetValue(0).ToString().Trim();

            return res;
        }




        /// <summary>
        /// Валидачи параметров клиента
        /// </summary>
        [WebMethod(EnableSession = true)]
        public ValidationResult ValidateClient(Client cl)
        {
            ValidationResult res = new ValidationResult("OK");

            // проверка наименования клиента по фин. мониторингу
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "kl.checkFM";
            cmd.Parameters.Add("pNmk", OracleDbType.Varchar2, cl.NMK, ParameterDirection.Input);
            cmd.Parameters.Add("pNmkk", OracleDbType.Varchar2, cl.NMKK, ParameterDirection.Input);
            cmd.Parameters.Add("pNmkv", OracleDbType.Varchar2, cl.NMKV, ParameterDirection.Input);
            cmd.Parameters.Add("pIdTr", OracleDbType.Decimal, ParameterDirection.Output);

            try
            {
                if (con.State != ConnectionState.Open) con.Open();

                cmd.ExecuteNonQuery();

                OracleDecimal tmp = (OracleDecimal)cmd.Parameters["pIdTr"].Value;
                if (!tmp.IsNull && tmp.Value > 0)
                {
                    res.Code = "ALERT";
                    res.Text = "Одне з найменувань клієнта схоже на найменування зі списку террористів. Продовжити реєстрацію/оновлення реквізитів клієнта?";
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }

        /// <summary>
        /// Регистрация клиента
        /// </summary>
        /// <returns>Сообщение о регистрации</returns>
        [WebMethod(EnableSession = true)]
        public RegistrationResult Register(string EditType, string ReadOnly, string BANKDATE, string Par_EN, string CUSTTYPE, string DATE_ON, string DATE_OFF, string ID, string ND, string NMK, string NMKV, string NMKK, string ADR, String fullADR, string fullADRMORE, string CODCAGENT, string COUNTRY, string PRINSIDER, string TGR, string STMT, string OKPO, string SAB, string BC, string TOBO, string PINCODE, string RNlPres, string C_REG, string C_DST, string ADM, string TAXF, string RGADM, string RGTAX, string DATET, string DATEA, string NEkPres, string ISE, string FS, string VED, string OE, string K050, string SED, string MFO, string ALT_BIC, string BIC, string RATING, string KOD_B, string DAT_ND, string NUM_ND, string RUK, string BUH, string TELR, string TELB, string NMKU, string fullACCS, string E_MAIL, string TEL_FAX, string SEAL_ID, string RCFlPres, string PASSP, string SER, string NUMDOC, string ORGAN, string PDATE, string BDAY, string BPLACE, string SEX, string TELD, string TELW, string DOV, string BDOV, string EDOV, string ISP, string NOTES, string CRISK, string MB, string ADR_ALT, string NOM_DOG, string LIM_KASS, string LIM, string NOMPDV, string RNKP, string NOTESEC, string TrustEE, string DopRekv, bool custAttrCheck, List<CustAttrRecord> custAttrList, List<CustRiskRecord> custRiskList)
        {
            cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";

            Client MyClient = new Client(EditType, ReadOnly, BANKDATE, Par_EN, CUSTTYPE, DATE_ON, DATE_OFF, ID, ND, NMK, NMKV, NMKK, ADR, fullADR, fullADRMORE, CODCAGENT, COUNTRY, PRINSIDER, TGR, STMT, OKPO, SAB, BC, TOBO, PINCODE, RNlPres, C_REG, C_DST, ADM, TAXF, RGADM, RGTAX, DATET, DATEA, NEkPres, ISE, FS, VED, OE, K050, SED, MFO, ALT_BIC, BIC, RATING, KOD_B, DAT_ND, NUM_ND, RUK, BUH, TELR, TELB, NMKU, fullACCS, E_MAIL, TEL_FAX, SEAL_ID, RCFlPres, PASSP, SER, NUMDOC, ORGAN, PDATE, BDAY, BPLACE, SEX, TELD, TELW, DOV, BDOV, EDOV, ISP, NOTES, CRISK, MB, ADR_ALT, NOM_DOG, LIM_KASS, LIM, NOMPDV, RNKP, NOTESEC, TrustEE, DopRekv);

            RegistrationResult res = new RegistrationResult(MyClient.EditType);
            bool txCommited = false;

            try
            {
                InitOraConnection(Context);
                SetRole("WR_CUSTREG");

                BeginTransaction();
                try
                {
                    WriteMainRekvToDatabase(MyClient);
                    WritefullAdrToDatabase(MyClient);

                    WriteRnkRekvToDatabase(MyClient);
                    WriteDopRekvToDatabase(MyClient, custAttrList, custAttrCheck, custRiskList);
                    if (MyClient.CUSTTYPE == "person") WritePersonToDatabase(MyClient);
                    else if (MyClient.CUSTTYPE == "corp")
                    {
                        WriteCorpToDatabase(MyClient);
                        WriteCorpAccsFromDatabase(MyClient);
                    }
                    else if (MyClient.CUSTTYPE == "bank") WriteBankToDatabase(MyClient);

                    CommitTransaction();
                    txCommited = true;

                    if (ID != string.Empty)
                    {
                        ClearParameters();
                        SetParameters("p_rnk", DB_TYPE.Decimal, Convert.ToDecimal(ID), DIRECTION.Input);
                        SQL_PROCEDURE("p_after_edit_client");
                    }

                    DBLogger.Info(String.Format("Клиент РНК={0} успешно заведен.", MyClient.ID.ToString()), "ClientRegister");
                }
                catch (System.Exception e)
                {
                    res.Status = "ERROR";
                    res.ErrorMessage = e.Message;
                    string objJSON = (new JavaScriptSerializer()).Serialize(MyClient);
                    DBLogger.Error("ClientClass:\n" + objJSON + "\n" + e.Message + "\n" + e.StackTrace, "ClientRegister");
                }
                finally
                {
                    if (!txCommited)
                    {
                        RollbackTransaction();
                        DBLogger.Error(res.ResultText, "ClientRegister");
                    }
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            if (txCommited)
                res.Rnk = Convert.ToDecimal(MyClient.ID);

            return res;
        }
        /// <summary>
        /// Процедура возвращает объект по строке и по типу
        /// </summary>
        /// <param name="type">тип</param>
        /// <param name="val">строковое значение</param>
        /// <returns></returns>
        private object GetParamObj(string type, string val)
        {
            object res = null;
            if (val.Trim() != string.Empty)
            {
                switch (type)
                {
                    case "Dec":
                        if (val.Trim() == "null") return null;
                        res = Convert.ToDecimal(val.Trim(), cinfo);
                        break;
                    case "Str":
                        res = val.Trim();
                        break;
                    case "Chr":
                        res = val.Trim();
                        break;
                    case "Dat":
                        res = Convert.ToDateTime(val, cinfo);
                        break;
                    default: res = null;
                        break;
                }
            }

            return res;
        }
        /// <summary>
        /// Процедура создания нового или обновления параметров существующего
        /// </summary>
        private void WriteMainRekvToDatabase(Client MyClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", MyClient.ID), DIRECTION.InputOutput);
            SetParameters("pCusttype", DB_TYPE.Decimal, GetParamObj("Dec", ((MyClient.CUSTTYPE == "bank") ? ("1") : (((MyClient.CUSTTYPE == "corp") ? ("2") : ("3"))))), DIRECTION.Input);
            SetParameters("pNd", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.ND), DIRECTION.Input);
            SetParameters("pNmk", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NMK), DIRECTION.Input);
            SetParameters("pNmkv", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NMKV), DIRECTION.Input);
            SetParameters("pNmkk", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NMKK), DIRECTION.Input);
            SetParameters("pAdr", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.ADR), DIRECTION.Input);
            SetParameters("pCodcagent", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.CODCAGENT), DIRECTION.Input);
            SetParameters("pCountry", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.COUNTRY), DIRECTION.Input);
            SetParameters("pPrinsider", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.PRINSIDER), DIRECTION.Input);
            SetParameters("pTgr", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.TGR), DIRECTION.Input);
            SetParameters("pOkpo", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.OKPO), DIRECTION.Input);
            SetParameters("pStmt", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.STMT), DIRECTION.Input);
            SetParameters("pSab", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.SAB), DIRECTION.Input);
            SetParameters("pDateOn", DB_TYPE.Date, GetParamObj("Dat", MyClient.DATE_ON), DIRECTION.Input);
            SetParameters("pTaxf", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.TAXF), DIRECTION.Input);
            SetParameters("pCReg", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.C_REG), DIRECTION.Input);
            SetParameters("pCDst", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.C_DST), DIRECTION.Input);
            SetParameters("pAdm", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.ADM), DIRECTION.Input);
            SetParameters("pRgTax", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.RGTAX), DIRECTION.Input);
            SetParameters("pRgAdm", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.RGADM), DIRECTION.Input);
            SetParameters("pDateT", DB_TYPE.Date, GetParamObj("Dat", MyClient.DATET), DIRECTION.Input);
            SetParameters("pDateA", DB_TYPE.Date, GetParamObj("Dat", MyClient.DATEA), DIRECTION.Input);
            SetParameters("pIse", DB_TYPE.Char, GetParamObj("Chr", MyClient.ISE), DIRECTION.Input);
            SetParameters("pFs", DB_TYPE.Char, GetParamObj("Chr", MyClient.FS), DIRECTION.Input);
            SetParameters("pOe", DB_TYPE.Char, GetParamObj("Chr", MyClient.OE), DIRECTION.Input);
            SetParameters("pVed", DB_TYPE.Char, GetParamObj("Chr", MyClient.VED), DIRECTION.Input);
            // SetParameters("pK050", DB_TYPE.Char, GetParamObj("Chr", MyClient.K050), DIRECTION.Input);
            SetParameters("pSed", DB_TYPE.Char, GetParamObj("Chr", MyClient.SED), DIRECTION.Input);
            SetParameters("pNotes", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NOTES), DIRECTION.Input);
            SetParameters("pNotesec", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NOTESEC), DIRECTION.Input);
            SetParameters("pCRisk", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.CRISK), DIRECTION.Input);
            SetParameters("pPincode", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.PINCODE), DIRECTION.Input);
            SetParameters("pRnkP", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.RNKP), DIRECTION.Input);
            SetParameters("pLim", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.LIM), DIRECTION.Input);
            SetParameters("pNomPDV", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.NOMPDV), DIRECTION.Input);
            SetParameters("pMB", DB_TYPE.Char, GetParamObj("Chr", MyClient.MB), DIRECTION.Input);
            SetParameters("pBC", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.BC), DIRECTION.Input);
            SetParameters("pTobo", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TOBO), DIRECTION.Input);
            SetParameters("pIsp", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.ISP), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setCustomerAttr(:pRnk, :pCusttype, :pNd, :pNmk, :pNmkv, :pNmkk, :pAdr, :pCodcagent, :pCountry, :pPrinsider, :pTgr, :pOkpo, :pStmt, :pSab, :pDateOn, :pTaxf, :pCReg, :pCDst, :pAdm, :pRgTax, :pRgAdm, :pDateT, :pDateA, :pIse, :pFs, :pOe, :pVed, :pSed, :pNotes, :pNotesec, :pCRisk, :pPincode, :pRnkP, :pLim, :pNomPDV, :pMB, :pBC, :pTobo, :pIsp); end;");

            MyClient.ID = GetParameter("pRnk").ToString();

            // процедура установки экономических показателей клиента
            ClearParameters();
            SetParameters("p_rnk", DB_TYPE.Int64, GetParamObj("Dec", MyClient.ID), DIRECTION.InputOutput);
            SetParameters("p_k070", DB_TYPE.Char, GetParamObj("Chr", MyClient.ISE), DIRECTION.Input);
            SetParameters("p_k080", DB_TYPE.Char, GetParamObj("Chr", MyClient.FS), DIRECTION.Input);
            SetParameters("p_k110", DB_TYPE.Char, GetParamObj("Chr", MyClient.VED), DIRECTION.Input);
            SetParameters("p_k090", DB_TYPE.Char, GetParamObj("Chr", MyClient.OE), DIRECTION.Input);
            SetParameters("p_k050", DB_TYPE.Char, GetParamObj("Chr", MyClient.K050), DIRECTION.Input);
            SetParameters("p_k051", DB_TYPE.Char, GetParamObj("Chr", MyClient.SED), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setCustomerEN(:p_rnk, :p_k070, :p_k080, :p_k110, :p_k090, :p_k050, :p_k051); end;");
        }
        /// <summary>
        /// Запись таблицы довереных лиц
        /// </summary>
        private void WriteTrusteeToDatabase(Client MyClient)
        {
            DataSet ds = new DataSet();

            // выбираем все старые записи
            ClearParameters();
            SetParameters("pRnk", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.ID), DIRECTION.Input);
            ds = SQL_SELECT_dataset(@"SELECT	ID 
										FROM TRUSTEE 
										WHERE rnk = :pRnk");
            ArrayList TrusteeOld = new ArrayList();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                TrusteeOld.Add(ds.Tables[0].Rows[i].ItemArray.GetValue(0).ToString());

            string[] TrusteeList = new string[0];
            // определяем удаленные записи
            if (MyClient.TrustEE.Trim() != string.Empty)
            {
                TrusteeList = MyClient.TrustEE.Split(';');
                for (int i = 0; i < TrusteeList.Length; i++)
                {
                    string[] TrusteeItems = TrusteeList[i].Split(',');
                    TrusteeOld.Remove(TrusteeItems[0]);
                }
            }

            // удаляем старые записи
            for (int i = 0; i < TrusteeOld.Count; i++)
            {
                ClearParameters();
                SetParameters("pId", DB_TYPE.Decimal, GetParamObj("Dec", TrusteeOld[i].ToString()), DIRECTION.Input);
                SQL_NONQUERY(@"begin kl.delCustomerTrustee(:pId); end;");
            }

            // теперь добовляем или обновляем старые записи
            for (int i = 0; i < TrusteeList.Length; i++)
            {
                string[] TrusteeItems = TrusteeList[i].Split(',');

                ClearParameters();
                SetParameters("pId", DB_TYPE.Decimal, GetParamObj("Dec", TrusteeItems[0]), DIRECTION.Input);
                SetParameters("pRnk", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.ID), DIRECTION.Input);
                SetParameters("pFio", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[1]), DIRECTION.Input);
                SetParameters("pPasport", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[3]), DIRECTION.Input);
                SetParameters("pBDate", DB_TYPE.Date, GetParamObj("Dat", TrusteeItems[4]), DIRECTION.Input);
                SetParameters("pEDate", DB_TYPE.Date, GetParamObj("Dat", TrusteeItems[5]), DIRECTION.Input);
                SetParameters("pDocument", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[6]), DIRECTION.Input);
                SetParameters("pNotary_name", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[7]), DIRECTION.Input);
                SetParameters("pNotary_region", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[8]), DIRECTION.Input);
                SetParameters("pTrust_regnum", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[9]), DIRECTION.Input);
                SetParameters("pTrust_regdat", DB_TYPE.Date, GetParamObj("Dat", TrusteeItems[10]), DIRECTION.Input);
                SetParameters("pOkpo", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[11]), DIRECTION.Input);
                SetParameters("pDoc_type", DB_TYPE.Decimal, GetParamObj("Dec", TrusteeItems[2]), DIRECTION.Input);
                SetParameters("pDoc_serial", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[12]), DIRECTION.Input);
                SetParameters("pDoc_number", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[13]), DIRECTION.Input);
                SetParameters("pDoc_date", DB_TYPE.Date, GetParamObj("Dat", TrusteeItems[14]), DIRECTION.Input);
                SetParameters("pDoc_issuer", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[15]), DIRECTION.Input);
                SetParameters("pBirthday", DB_TYPE.Date, GetParamObj("Dat", TrusteeItems[16]), DIRECTION.Input);
                SetParameters("pBirthplace", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[17]), DIRECTION.Input);
                SetParameters("pTypeId", DB_TYPE.Decimal, GetParamObj("Dec", TrusteeItems[18]), DIRECTION.Input);
                SetParameters("pDocTypeId", DB_TYPE.Varchar2, GetParamObj("Dec", TrusteeItems[20]), DIRECTION.Input);
                SetParameters("pPosition", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[22]), DIRECTION.Input);
                SetParameters("pFirstName", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[23]), DIRECTION.Input);
                SetParameters("pMiddleName", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[24]), DIRECTION.Input);
                SetParameters("pLastName", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[25]), DIRECTION.Input);
                SetParameters("pSex", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[26]), DIRECTION.Input);
                SetParameters("pTel", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[28]), DIRECTION.Input);
                SetParameters("pSignPrivs", DB_TYPE.Varchar2, GetParamObj("Dec", TrusteeItems[29]), DIRECTION.Input);
                SetParameters("pNameR", DB_TYPE.Varchar2, GetParamObj("Str", TrusteeItems[30]), DIRECTION.Input);
                SetParameters("pSignId", DB_TYPE.Varchar2, GetParamObj("Dec", TrusteeItems[31]), DIRECTION.Input);

                SQL_NONQUERY(@"begin kl.setCustomerTrustee(:pId, :pRnk, :pFio, :pPasport, :pBDate, :pEDate, :pDocument, :pNotary_name, :pNotary_region, :pTrust_regnum, :pTrust_regdat, :pOkpo, :pDoc_type, :pDoc_serial, :pDoc_number, :pDoc_date, :pDoc_issuer, :pBirthday, :pBirthplace, :pTypeId, :pDocTypeId, :pPosition, :pFirstName, :pMiddleName, :pLastName, :pSex, :pTel, :pSignPrivs, :pNameR, :pSignId); end;");
            }
        }
        /// <summary>
        /// Допреквизиты
        /// </summary>
        public void WriteDopRekvToDatabase(Client MyClient, List<CustAttrRecord> custAttrs, bool checkReq, List<CustRiskRecord> custRisks)
        {
            for (int i = 0; i < custAttrs.Count; i++)
            {
                ClearParameters();

                SetParameters("pRnk", DB_TYPE.Decimal, MyClient.ID, DIRECTION.Input);
                SetParameters("pTag", DB_TYPE.Varchar2, custAttrs[i].Tag, DIRECTION.Input);
                SetParameters("pVal", DB_TYPE.Varchar2, custAttrs[i].Value, DIRECTION.Input);
                SetParameters("pOtd", DB_TYPE.Decimal, custAttrs[i].Isp, DIRECTION.Input);

                SQL_PROCEDURE("kl.setCustomerElement");
            }

            string errMsg = string.Empty;
            // вставка дефолтных значений 
            ClearParameters();
            SetParameters("rnk", DB_TYPE.Decimal, MyClient.ID, DIRECTION.Input);
            SQL_Reader_Exec(@"select c.custtype, cf.tag, sqlval, cf.opt, cf.name, cfc.name, c.sed, cca.rezid
                                      from customer_field cf, customer c, customer_field_codes cfc, codcagent cca
                                     where ((cf.B = 1 and c.custtype = 1) or (cf.U = 1 and c.custtype = 2) or
                                           (cf.F = 1 and c.custtype = 3))
                                       and cf.code=cfc.code 
                                       and not_to_edit = 0
                                       and c.rnk = :rnk
                                       and CCA.CODCAGENT=C.CODCAGENT
                                       and (sqlval is not null or cf.opt=1)
                                       and not exists (select value
                                              from customerw
                                             where rnk = c.rnk
                                               and tag = cf.tag)");

            while (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();
                Decimal custtype = Convert.ToDecimal(reader[0]);
                string tag = Convert.ToString(reader[1]);
                string sqlVal = Convert.ToString(reader[2]);
                string opt = Convert.ToString(reader[3]);
                string reqName = Convert.ToString(reader[4]);
                string tabName = Convert.ToString(reader[5]);
                Decimal sed = Convert.ToDecimal(reader[6]);
                Decimal rezId = Convert.ToDecimal(reader[7]);
                string defVal = string.Empty;
                try
                {
                    ClearParameters();
                    /*
                     Для получения значений приявязаных к типу или номеру клиента,
                     в селекте вожножно использование след. макросов: 
                     :CUSTTYPE - тип клиента (значения 1,2,3)
                     :RNK - РНК клиента (значения целые числа)
                     :SPD – признак ФО-СПД (значения 1 (СПД), 0 (не СПД))
                     :REZID – резидентность (значения 1 (резидент), 2 (нерезидент))
                     значение подставляется простой заменой текста
                     */
                    defVal = string.Empty;
                    if (!string.IsNullOrEmpty(sqlVal))
                    {
                        string nSPD;
                        if (custtype == 3 && sed == 91) nSPD = "1";
                        else nSPD = "0";

                        sqlVal = sqlVal.Replace(":CUSTTYPE", custtype.ToString()).Replace(":RNK", MyClient.ID.ToString());
                        sqlVal = sqlVal.Replace(":SPD", nSPD.ToString()).Replace(":REZID", rezId.ToString());
                        defVal = Convert.ToString(SQL_SELECT_scalar("select (" + sqlVal + ") val from dual"));

                        SetParameters("Rnk_", DB_TYPE.Decimal, MyClient.ID, DIRECTION.Input);
                        SetParameters("Tag_", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                        SetParameters("Val_", DB_TYPE.Varchar2, defVal, DIRECTION.Input);
                        SetParameters("Otd_", DB_TYPE.Decimal, 0, DIRECTION.Input);
                        SQL_PROCEDURE("kl.setCustomerElement");
                    }

                    if (checkReq && opt.Equals("1") && string.IsNullOrEmpty(defVal))
                    {
                        errMsg += " - " + reqName + "(у блоці - [" + tabName + "])" + System.Environment.NewLine;
                    }
                }
                catch { }
            }
            SQL_Reader_Close();

            if (!string.IsNullOrEmpty(errMsg))
                throw new Bars.Exception.BarsException("не заповнено дод. реквізит(и): \n" + errMsg);

            // Фин. мониторинг
            for (int i = 0; i < custRisks.Count; i++)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, MyClient.ID, DIRECTION.Input);
                SetParameters("RiskId", DB_TYPE.Varchar2, custRisks[i].Id, DIRECTION.Input);
                SetParameters("Val", DB_TYPE.Varchar2, custRisks[i].Value, DIRECTION.Input);
                SQL_PROCEDURE("kl.set_customer_risk");
            }
            if (custRisks.Count > 0)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, MyClient.ID, DIRECTION.Input);
                SQL_PROCEDURE("fm_set_rizik");
            }
        }
        /// <summary>
        /// Метод записывает параметры в таблицу rnk_rekv
        /// </summary>
        public void WriteRnkRekvToDatabase(Client MyClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", MyClient.ID), DIRECTION.InputOutput);
            SetParameters("pLimKass", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.LIM_KASS), DIRECTION.Input);
            SetParameters("pAdrAlt", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.ADR_ALT), DIRECTION.Input);
            SetParameters("pNomDog", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NOM_DOG), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setCustomerRekv(:pRnk, :pLimKass, :pAdrAlt, :pNomDog); end;");
        }
        /// <summary>
        /// Метод записывает параметры клиента-физ.лица в базу данных
        /// </summary>
        public void WritePersonToDatabase(Client MyClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", MyClient.ID), DIRECTION.InputOutput);
            SetParameters("pSex", DB_TYPE.Char, GetParamObj("Chr", MyClient.SEX), DIRECTION.Input);
            SetParameters("pPassp", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.PASSP), DIRECTION.Input);
            SetParameters("pSer", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.SER), DIRECTION.Input);
            SetParameters("pNumdoc", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NUMDOC), DIRECTION.Input);
            SetParameters("pPDate", DB_TYPE.Date, GetParamObj("Dat", MyClient.PDATE), DIRECTION.Input);
            SetParameters("pOrgan", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.ORGAN), DIRECTION.Input);
            SetParameters("pBDay", DB_TYPE.Date, GetParamObj("Dat", MyClient.BDAY), DIRECTION.Input);
            SetParameters("pBPlace", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.BPLACE), DIRECTION.Input);
            SetParameters("pTelD", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TELD), DIRECTION.Input);
            SetParameters("pTelW", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TELW), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setPersonAttr(:pRnk, :pSex, :pPassp, :pSer, :pNumdoc, :pPDate, :pOrgan, :pBDay, :pBPlace, :pTelD, :pTelW); end;");
        }

        /// <summary>
        /// Метод записывает параметры клиента-юр.лица в базу данных
        /// </summary>
        public void WriteCorpToDatabase(Client MyClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", MyClient.ID), DIRECTION.InputOutput);
            SetParameters("pNmku", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.NMKU), DIRECTION.Input);
            SetParameters("pRuk", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.RUK), DIRECTION.Input);
            SetParameters("pTelR", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TELR), DIRECTION.Input);
            SetParameters("pBuh", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.BUH), DIRECTION.Input);
            SetParameters("pTelB", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TELB), DIRECTION.Input);
            SetParameters("pTELFAX", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TEL_FAX), DIRECTION.Input);
            SetParameters("pEMAIL", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.E_MAIL), DIRECTION.Input);
            SetParameters("pSEALID", DB_TYPE.Int32, GetParamObj("Str", MyClient.SEAL_ID), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setCorpAttr(:pRnk, :pNmku, :pRuk, :pTelR, :pBuh, :pTelB, :pTELFAX, :pEMAIL, :pSEALID); end;");
        }

        public void WriteCorpAccsFromDatabase(Client MyClient)
        {
            DataSet ds = new DataSet();

            // выбираем все старые записи
            ClearParameters();
            SetParameters("pRnk", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.ID), DIRECTION.Input);
            ds = SQL_SELECT_dataset(@"SELECT ID FROM CORPS_ACC WHERE rnk = :pRnk");
            ArrayList ACCSOld = new ArrayList();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                ACCSOld.Add(ds.Tables[0].Rows[i].ItemArray.GetValue(0).ToString());

            string[] ACCSList = new string[0];
            // определяем удаленные записи
            if (MyClient.fullACCS.Trim() != string.Empty)
            {
                ACCSList = MyClient.fullACCS.Split(';');
                for (int i = 0; i < ACCSList.Length; i++)
                {
                    string[] ACCSItems = ACCSList[i].Split(',');
                    ACCSOld.Remove(ACCSItems[0]);
                }
            }

            // удаляем старые записи
            for (int i = 0; i < ACCSOld.Count; i++)
            {
                ClearParameters();
                SetParameters("pId", DB_TYPE.Decimal, GetParamObj("Dec", ACCSOld[i].ToString()), DIRECTION.Input);
                SQL_NONQUERY(@"begin kl.delCorpAcc(:pId); end;");
            }

            // теперь добовляем или обновляем старые записи
            for (int i = 0; i < ACCSList.Length; i++)
            {
                string[] ACCSItems = ACCSList[i].Split(',');

                ClearParameters();
                SetParameters("pRnk", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.ID), DIRECTION.Input);
                SetParameters("pId", DB_TYPE.Decimal, GetParamObj("Dec", ACCSItems[0]), DIRECTION.Input);
                SetParameters("pMFO", DB_TYPE.Varchar2, GetParamObj("Str", ACCSItems[1]), DIRECTION.Input);
                SetParameters("pNLS", DB_TYPE.Varchar2, GetParamObj("Str", ACCSItems[2]), DIRECTION.Input);
                SetParameters("pKV", DB_TYPE.Decimal, GetParamObj("Dec", ACCSItems[3]), DIRECTION.Input);
                SetParameters("pCOMM", DB_TYPE.Varchar2, GetParamObj("Str", ACCSItems[4]), DIRECTION.Input);

                SQL_NONQUERY(@"begin kl.setCorpAcc(:pRnk, :pId, :pMFO, :pNLS, :pKV, :pCOMM); end;");
            }
        }

        /// <summary>
        /// Метод записывает параметры клиента-банк в базу данных
        /// </summary>
        public void WriteBankToDatabase(Client MyClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", MyClient.ID), DIRECTION.InputOutput);
            SetParameters("pMfo", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.MFO), DIRECTION.Input);
            SetParameters("pBic", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.BIC), DIRECTION.Input);
            SetParameters("pBicAlt", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.ALT_BIC), DIRECTION.Input);
            SetParameters("pRating", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.RATING), DIRECTION.Input);
            SetParameters("pKod_b", DB_TYPE.Int64, GetParamObj("Dec", MyClient.KOD_B), DIRECTION.InputOutput);
            SetParameters("pRuk", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.RUK), DIRECTION.Input);
            SetParameters("pTelR", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TELR), DIRECTION.Input);
            SetParameters("pBuh", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.BUH), DIRECTION.Input);
            SetParameters("pTelB", DB_TYPE.Varchar2, GetParamObj("Str", MyClient.TELB), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setBankAttr(:pRnk, :pMfo, :pBic, :pBicAlt, :pRating, :pKod_b, :pRuk, :pTelR, :pBuh, :pTelB); end;");
        }
        /// <summary>
        /// Записываем полный адрес клиента в базу
        /// </summary>

        public void SetCustomerAddress(OracleCommand cmd, Decimal RNK, Int32 type_id, Decimal Country, CustomerAddress.Address adr)
        {
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "kl.setCustomerAddressByTerritory";
            cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            cmd.Parameters.Add("TypeId_", OracleDbType.Decimal, type_id, ParameterDirection.Input);
            cmd.Parameters.Add("Country_", OracleDbType.Decimal, Country, ParameterDirection.Input);
            cmd.Parameters.Add("Zip_", OracleDbType.Varchar2, adr.zip, ParameterDirection.Input);
            cmd.Parameters.Add("Domain_", OracleDbType.Varchar2, adr.domain, ParameterDirection.Input);
            cmd.Parameters.Add("Region_", OracleDbType.Varchar2, adr.region, ParameterDirection.Input);
            cmd.Parameters.Add("Locality_", OracleDbType.Varchar2, adr.locality, ParameterDirection.Input);
            cmd.Parameters.Add("Address_", OracleDbType.Varchar2, adr.address, ParameterDirection.Input);
            cmd.Parameters.Add("TerritoryId_", OracleDbType.Decimal, adr.territory_id, ParameterDirection.Input);
            cmd.ExecuteNonQuery();
        }
        public void DelCustomerAddress(OracleCommand cmd, Decimal RNK, Int32 type_id)
        {
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from customer_address ca where ca.rnk = :p_rnk and ca.type_id = :p_type_id";
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            cmd.Parameters.Add("p_type_id", OracleDbType.Decimal, type_id, ParameterDirection.Input);
            cmd.ExecuteNonQuery();
        }
        public void WritefullAdrToDatabase(Client MyClient)
        {
            using (OracleCommand cmd = this.GetOraConnection().CreateCommand())
            {
                // не записываем пустой адрес
                if (MyClient.fullADR.type1.filled || MyClient.fullADR.type2.filled || MyClient.fullADR.type3.filled)
                {
                    // смотрим включена ли новая схема адресов
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select count(*) from all_objects where object_name = 'CUSTOMER_ADDRESS' and object_type = 'TABLE'";
                    Boolean isNewAdrScheme = Convert.ToDecimal(cmd.ExecuteScalar()) == 1;

                    //-- адрес в доп реквизиты
                    string[] AdrVals = { MyClient.fullADR.type1.zip, MyClient.fullADR.type1.domain, MyClient.fullADR.type1.region, MyClient.fullADR.type1.locality, MyClient.fullADR.type1.address };
                    string[] Tags = { "FGIDX", "FGOBL", "FGDST", "FGTWN", "FGADR" };

                    for (int i = 0; i < Tags.Length; i++)
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "kl.setCustomerElement";
                        cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, Convert.ToDecimal(MyClient.ID), ParameterDirection.Input);
                        cmd.Parameters.Add("Tag_", OracleDbType.Varchar2, Tags[i], ParameterDirection.Input);
                        cmd.Parameters.Add("Val_", OracleDbType.Varchar2, AdrVals[i], ParameterDirection.Input);
                        cmd.Parameters.Add("Otd_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                        cmd.ExecuteNonQuery();
                    }

                    //-- адрес в таблицу CUSTOMER_ADDRESS
                    if (isNewAdrScheme)
                    {
                        if (MyClient.fullADR.type1.filled)
                            SetCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 1, Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type1);
                        else
                            DelCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 1);
                        if (MyClient.fullADR.type2.filled)
                            SetCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 2, Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type2);
                        else
                            DelCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 2);
                        if (MyClient.fullADR.type3.filled)
                            SetCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 3, Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type3);
                        else
                            DelCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 3);
                    }
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public int CheckSPValue(string tag, string tabname, string value)
        {
            int result = 0;
            InitOraConnection();
            try
            {
                SetRole("WR_CUSTREG");
                SetParameters("colVal", DB_TYPE.Varchar2, value, DIRECTION.Input);
                result = Convert.ToInt32(SQL_SELECT_scalar("select count(*) from " + tabname + " where " + tag + "=:colVal"));
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

    }
}
