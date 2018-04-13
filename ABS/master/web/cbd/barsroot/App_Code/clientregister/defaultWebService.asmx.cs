using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq.Dynamic;
using System.Web.Mvc;
using System.Web.Services;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;
using Bars.Logger;
using System.Globalization;
using Bars.Web.Report;
using Bars.Classes;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

using System.Linq;

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
        public string Status { get; set; }
        public string Message { get; set; }

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
    /// Строка значения репутации клиента
    /// </summary>
    public class CustReptRecord
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

        private bool IsNeedConfirmChanges()
        {
            return barsroot.ServicesClass.GetGlobalParam("CUST_CLV") == "1";
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
        //------------Валідація телефону-----------------
        //todo: зробити по людскі

        CacParams _cacParams = new CacParams
        {
            CellPhoneConfirmation = true,
            MobileBankQueue = true
        };
        public class ConfirmPhone
        {
            public int Rnk { get; set; }
            public string Phone { get; set; }
            public string Secret { get; set; }
        }


        private ValidationResult ValidateCellPhone(string phone)
        {
            var result = new ValidationResult("OK");
            if (string.IsNullOrEmpty(phone))
            {
                result.Code = "ERROR";
                result.Text += "Невказано телефон. ";
            }

            return result;
        }

        private List<ConfirmPhone> GetConfirmPhoneList()
        {
            var sesionList = Session["ConfirmCellPhoneList"];
            if (sesionList == null)
            {
                Session["ConfirmCellPhoneList"] = new List<ConfirmPhone>();
            }

            return (List<ConfirmPhone>)Session["ConfirmCellPhoneList"];
        }

        [WebMethod(EnableSession = true)]
        public ValidationResult ConfirmCellPhone(int rnk, string phone, string code)
        {
            var result = new ValidationResult("OK")
            {
                Status = "OK"
            };
            if (string.IsNullOrEmpty(phone))
            {
                result.Status = "ERRER";
                result.Message += "Невказано телефон. ";

                result.Code = result.Status;
                result.Text += result.Message;
                return result;
            }
            if (string.IsNullOrEmpty(code))
            {
                result.Status = "ERROR";
                result.Message += "Невказано код підтвердження. ";

                result.Code = result.Status;
                result.Text += result.Message;
                return result;
            }

            var confirmPhoneList = GetConfirmPhoneList();
            var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phone && i.Rnk == rnk);
            if (curentPhone == null)
            {
                result.Status = "ERROR";
                result.Message += "Вказаному клієнту(" + rnk + ") на № " + phone + " не відправлявся код підтвердження.";

                result.Code = result.Status;
                result.Text += result.Message;
                return result;
            }
            if (curentPhone.Secret != code)
            {
                result.Status = "ERROR";
                result.Message += "Невірно вказано код підтвердження.";

                result.Code = result.Status;
                result.Text += result.Message;
                return result;
            }
            try
            {
                WriteConfirmedCellPhone(rnk, phone);
                confirmPhoneList.Remove(curentPhone);
                if (_cacParams.MobileBankQueue)
                {
                    AppendCustomerToQueue(rnk, phone);
                }
            }
            catch (Exception e)
            {
                result.Status = "ERROR";
                result.Message = e.InnerException == null ? e.Message : e.InnerException.Message;

                result.Code = result.Status;
                result.Text += result.Message;
                return result;
            }


            return result;
        }

        private void WriteConfirmedCellPhone(int rnk, string phone)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.Parameters.Add("p_phone", OracleDbType.Varchar2, phone, ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.CommandText = "update person set cellphone = :p_phone ,cellphone_confirmed = 1 where rnk = :p_rnk";
            try
            {
                if (con.State != ConnectionState.Open) con.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                con.Dispose();
            }

        }

        private void AppendCustomerToQueue(int rnk, string phone)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("p_phone", OracleDbType.Varchar2, phone, ParameterDirection.Input);

            cmd.CommandText = @"begin 
                                   mbm_mgr.append_cust_to_queue(:p_rnk,:p_phone) ;
                                end;";
            try
            {
                if (con.State != ConnectionState.Open) con.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                con.Dispose();
            }
        }

        [WebMethod(EnableSession = true)]
        public ValidationResult ConfirmCellPhoneSendSms(int rnk, string phone)
        {
            var result = new ValidationResult("OK")
            {
                Status = "OK"
            };
            var valid = ValidateCellPhone(phone);
            if (valid.Status == "ERROR")
            {
                return valid;
            }

            var confirmPhoneList = GetConfirmPhoneList();
            var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phone && i.Rnk == rnk);
            if (curentPhone == null)
            {
                curentPhone = new ConfirmPhone
                {
                    Rnk = rnk,
                    Phone = phone,
                    Secret = GetSecret(rnk, phone)
                };
                var smsStatus = SendSms(phone, "You secure code is " + curentPhone.Secret);

                if (!string.IsNullOrEmpty(smsStatus.ErrorMessage))
                {
                    result.Status = "ERROR";
                    result.Message = "Не вдалося відправити СМС (" + smsStatus.ErrorMessage + ")";
                    return result;
                }
                confirmPhoneList.Add(curentPhone);
            }

            return result;
        }

        private string GetSecret(int rnk, string phone)
        {
            var randObj = new Random((int)DateTime.Now.Ticks & 0x0000FFFF);
            return "12341234"; //string.Format("{0:F8}", randObj.NextDouble());
        }

        private SMSInfo SendSms(string phone, string message)
        {
            var smsProvider = new send_sms();
            return smsProvider.Send(phone, message);
        }

        /*public List<Parameter> GetParametersList()
        {
            var sql = "select * from cac_params";
        }*/

        public class Parameter
        {
            public string Name { get; set; }
            public string Value { get; set; }
            public string Description { get; set; }
        }

        public class CacParams
        {
            public bool CellPhoneConfirmation { get; set; }
            public bool MobileBankQueue { get; set; }
        }

        //----------------------------------------------------------

        /// <summary>
        /// Проверка наличия указаного ОКПО
        /// </summary>
        /// <param name="OKPO">Строка для проверки</param>
        /// <returns>Строка или ОК или Неверный код ОКПО</returns>
        [WebMethod(EnableSession = true)]
        public ValidationResult ValidateOkpo(String OKPO)
        {
            ValidationResult res = new ValidationResult("OK");

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = @"select * from
                                    (select 
                                        c.rnk, 
                                        c.nmk, 
                                        c.date_off 
                                    from 
                                        customer c 
                                    where 
                                        okpo = :p_okpo 
                                    order by c.date_off desc)
                                where rownum = 1";
            cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, OKPO, ParameterDirection.Input);

            try
            {
                if (con.State != ConnectionState.Open) con.Open();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        var dateClose = Convert.ToString(rdr["date_off"]);
                        res.Code = "ERROR";
                        res.Param = "{rnk:" + Convert.ToString(rdr["rnk"]) + ",dateClose:'" + dateClose + "'}";
                        res.Text = String.Format(
                                    "Клієнт з таким ІПН вже зареєстрований (РНК {0}, ПІБ {1}){2}! Відкрити картку{3}?",
                                    rdr["rnk"],
                                    rdr["nmk"],
                                    string.IsNullOrEmpty(dateClose) ? "" : ", закритий датою: " + dateClose.Split(' ')[0],
                                    string.IsNullOrEmpty(dateClose) ? "" : " та перереєструвати закритого клієнта");
                    }
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
        /// Проверка наличия указаного моб. тел.
        /// </summary>
        /// <param name="rnk"></param>
        /// <param name="phone">Строка для проверки</param>
        /// <returns>Строка или ОК или Неверный телефон</returns>
        [WebMethod(EnableSession = true)]
        public ValidationResult ValidateMobilePhone(decimal rnk, string phone)
        {
            ValidationResult res = new ValidationResult("OK");

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = @"select
                                    c.rnk,
                                    c.branch
                                from 
                                    (select 
                                        rnk 
                                     from 
                                        customerw 
                                     where tag = 'MPNO'
                                        and value = :p_telm 
                                        and rnk != :p_rnk
                                        and rownum = 1 ) w,
                                    customer c
                                where 
                                    C.DATE_OFF is null
                                    and W.RNK = c.rnk";
            cmd.Parameters.Add("p_telm", OracleDbType.Varchar2, phone, ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

            try
            {
                if (con.State != ConnectionState.Open) con.Open();
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        res.Code = "ERROR";
                        res.Param = "{rnk:" + Convert.ToString(rdr["rnk"]) + ",branch:'" + Convert.ToString(rdr["branch"]) + "'}";
                        res.Text = String.Format(
                                    "Клієнт з таким мобільним телефоном вже зареєстрований (РНК {0}, відділення {1})",
                                    rdr["rnk"],
                                    rdr["branch"]);
                    }
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
        /// <param name="RNK"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string CheckAccess(String RNK)
        {
            string res;
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = "select count(rnk) from v_tobo_cust_fm where rnk=:p_rnk and branch=sys_context('bars_context', 'user_branch')";
            cmd.Parameters.Add("p_rnk", OracleDbType.Varchar2, RNK, ParameterDirection.Input);

            try
            {
                res = Convert.ToInt32(cmd.ExecuteScalar()) > 0 ? "2" : "3";
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

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = @"select c.rnk, c.nmk, c.date_off
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
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        var dateClose = Convert.ToString(rdr["date_off"]);
                        res.Code = "ERROR";
                        res.Param = "{rnk:" + Convert.ToString(rdr["rnk"]) + ",dateClose:'" + dateClose + "'}";
                        res.Text = String.Format(
                                    "Клієнт з такими серією та номером паспорту вже зареєстрований (РНК: {0}, ПІБ: {1}){2}! Відкрити картку{3}?",
                                    rdr["rnk"],
                                    rdr["nmk"],
                                    string.IsNullOrEmpty(dateClose) ? "" : ", закритий датою: " + dateClose.Split(' ')[0],
                                    string.IsNullOrEmpty(dateClose) ? "" : " та перереєструвати закритого клієнта?");
                    }
                }
            }
            catch (Exception e)
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
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();

                // устанавливаем роль
                cmd.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CUSTREG");
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
        public RegistrationResult Register(
            string EditType,
            string ReadOnly,
            string BANKDATE,
            string Par_EN,
            string CUSTTYPE,
            string DATE_ON,
            string DATE_OFF,
            string ID,
            string ND,
            string NMK,
            string NMKV,
            string NMKK,
            string ADR,
            string fullADR,
            string fullADRMORE,
            string CODCAGENT,
            string COUNTRY,
            string PRINSIDER,
            string TGR,
            string STMT,
            string OKPO,
            string SAB,
            string BC,
            string TOBO,
            string PINCODE,
            string RNlPres,
            string C_REG,
            string C_DST,
            string ADM,
            string TAXF,
            string RGADM,
            string RGTAX,
            string DATET,
            string DATEA,
            string NEkPres,
            string ISE,
            string FS,
            string VED,
            string OE,
            string K050,
            string SED,
            string MFO,
            string ALT_BIC,
            string BIC,
            string RATING,
            string KOD_B,
            string DAT_ND,
            string NUM_ND,
            string RUK,
            string BUH,
            string TELR,
            string TELB,
            string NMKU,
            string fullACCS,
            string E_MAIL,
            string TEL_FAX,
            string SEAL_ID,
            string RCFlPres,
            string PASSP,
            string SER,
            string NUMDOC,
            string ORGAN,
            string PDATE,
            string BDAY,
            string BPLACE,
            string SEX,
            string TELD,
            string TELW,
            /*string DOV, string BDOV, string EDOV,*/
            string ISP,
            string NOTES,
            string CRISK,
            string MB,
            string ADR_ALT,
            string NOM_DOG,
            string LIM_KASS,
            string LIM,
            string NOMPDV,
            string RNKP,
            string NOTESEC,
            string TrustEE,
            string nRezidCode,
            string DopRekv,
            bool custAttrCheck,
            List<CustAttrRecord> custAttrList,
            List<CustRiskRecord> custRiskList,
            List<CustReptRecord> custReptList)
        {
            cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";

            //bug: при передачі пустого поля з ІЕ 8 на ХР без режиму сумісності передається слово "null" замість ""
            if (SAB == "null")
            {
                SAB = "";
            }

            Client myClient = new Client(EditType, ReadOnly, BANKDATE, Par_EN, CUSTTYPE, DATE_ON, DATE_OFF, ID, ND, NMK, NMKV, NMKK, ADR, fullADR, fullADRMORE, CODCAGENT, COUNTRY, PRINSIDER, TGR, STMT, OKPO, SAB, BC, TOBO, PINCODE, RNlPres, C_REG, C_DST, ADM, TAXF, RGADM, RGTAX, DATET, DATEA, NEkPres, ISE, FS, VED, OE, K050, SED, MFO, ALT_BIC, BIC, RATING, KOD_B, DAT_ND, NUM_ND, RUK, BUH, TELR, TELB, NMKU, fullACCS, E_MAIL, TEL_FAX, SEAL_ID, RCFlPres, PASSP, SER, NUMDOC, ORGAN, PDATE, BDAY, BPLACE, SEX, TELD, TELW, /*DOV, BDOV, EDOV,*/ ISP, NOTES, CRISK, MB, ADR_ALT, NOM_DOG, LIM_KASS, LIM, NOMPDV, RNKP, NOTESEC, TrustEE, nRezidCode, DopRekv);

            RegistrationResult res = new RegistrationResult(myClient.EditType);
            bool txCommited = false;

            try
            {
                InitOraConnection(Context);
                SetRole("WR_CUSTREG");

                BeginTransaction();
                try
                {
                    if ((myClient.EditType.ToLower() == "reg" || string.IsNullOrEmpty(myClient.EditType))
                        && myClient.CUSTTYPE.ToLower() == "person"
                        && myClient.SED.Trim() != "91")
                    {
                        //перевірка чи існує клієнт в базі
                        if (GetGlobalParam("CUST_VERIFI_EXIST", "") == "1")
                        {
                            var verify = VerifyExistingClient(myClient);
                            if (verify.Status == "ERROR")
                            {
                                return verify;
                            }
                        }
                    }

                    WriteMainRekvToDatabase(myClient);
                    WritefullAdrToDatabase(myClient);

                    if (myClient.EditType.ToLower() != "reg" && myClient.DATE_ON != "")
                    {
                        WriteRnkRekvToDatabase(myClient);
                    }

                    WriteDopRekvToDatabase(myClient,
                                            custAttrList,
                                            custAttrCheck,
                                            custRiskList,
                                            custReptList);
                    if (myClient.CUSTTYPE == "person") WritePersonToDatabase(myClient);
                    else if (myClient.CUSTTYPE == "corp")
                    {
                        WriteCorpToDatabase(myClient);
                        WriteCorpAccsFromDatabase(myClient);
                    }
                    else if (myClient.CUSTTYPE == "bank") WriteBankToDatabase(myClient);

                    CommitTransaction();
                    txCommited = true;

                    if (myClient.ID != string.Empty)
                    {
                        ClearParameters();
                        SetParameters("p_rnk", DB_TYPE.Decimal, Convert.ToDecimal(myClient.ID), DIRECTION.Input);
                        SQL_PROCEDURE("p_after_edit_client");
                    }

                    DBLogger.Info(String.Format("Клиент РНК={0} успешно заведен.", myClient.ID), "ClientRegister");
                }
                catch (Exception e)
                {
                    res.Status = "ERROR";
                    res.ErrorMessage = e.Message;
                    string objJSON = (new JavaScriptSerializer()).Serialize(myClient);
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
                res.Rnk = Convert.ToDecimal(myClient.ID);

            return res;
        }
        /// <summary>
        /// перевірити наявність зареєстрованого олієнта 
        /// </summary>
        /// <param name="client">данні клієнта</param>
        /// <returns></returns>
        public RegistrationResult VerifyExistingClient(Client client)
        {
            var result = new RegistrationResult();
            using (OracleCommand cmd = GetOraConnection().CreateCommand())
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, (string.IsNullOrEmpty(client.ID) ? "0" : client.ID), ParameterDirection.Input);
                cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, client.OKPO, ParameterDirection.Input);
                cmd.Parameters.Add("p_passp", OracleDbType.Decimal, client.PASSP, ParameterDirection.Input);
                cmd.Parameters.Add("p_ser", OracleDbType.Varchar2, client.SER, ParameterDirection.Input);
                cmd.Parameters.Add("p_numdoc", OracleDbType.Varchar2, client.NUMDOC, ParameterDirection.Input);
                cmd.CommandText = @"select 
                                        c.* 
                                    from 
                                        customer c, 
                                        person p 
                                    where 
                                        c.rnk = p.rnk 
                                        and c.date_off is null
                                        and c.sed !='91'
                                        and c.rnk <> :p_rnk
                                        and c.okpo= :p_okpo
                                        and P.PASSP = :p_passp
                                        and P.SER = :p_ser
                                        and P.NUMDOC = :p_numdoc
                                    order by 
                                        c.date_on desc";
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    result.Status = "ERROR";
                    var clientData = string.Format("ОКПО: {0}, Серія док.: {1}, № док.: {2}", client.OKPO, client.SER, client.NUMDOC);
                    result.ErrorMessage = string.Format("Клієнт з такими даними\n ({0}) вже зареєстрований під РНК - ({1})!!!\n" +
                                                            "Змініть введені дані або скористайтесь відкритою карткою клієнта!",
                                                         clientData, reader["RNK"]);
                    DBLogger.Error(
                        string.Format("ClientClass:\n Спроба повторної реєстрації клієнта з данними\n({0})", clientData),
                        "ClientRegister");
                }

            }

            return result;
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
        private void WriteMainRekvToDatabase(Client myClient)
        {
            ClearParameters();
            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", myClient.ID), DIRECTION.InputOutput);
            SetParameters("pCusttype", DB_TYPE.Decimal, GetParamObj("Dec", ((myClient.CUSTTYPE == "bank") ? ("1") : (((myClient.CUSTTYPE == "corp") ? ("2") : ("3"))))), DIRECTION.Input);
            SetParameters("pNd", DB_TYPE.Varchar2, GetParamObj("Str", myClient.ND), DIRECTION.Input);
            SetParameters("pNmk", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NMK), DIRECTION.Input);
            SetParameters("pNmkv", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NMKV), DIRECTION.Input);
            SetParameters("pNmkk", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NMKK), DIRECTION.Input);
            SetParameters("pAdr", DB_TYPE.Varchar2, GetParamObj("Str", myClient.ADR), DIRECTION.Input);
            SetParameters("pCodcagent", DB_TYPE.Decimal, GetParamObj("Dec", myClient.CODCAGENT), DIRECTION.Input);
            SetParameters("pCountry", DB_TYPE.Decimal, GetParamObj("Dec", myClient.COUNTRY), DIRECTION.Input);
            SetParameters("pPrinsider", DB_TYPE.Decimal, GetParamObj("Dec", myClient.PRINSIDER), DIRECTION.Input);
            SetParameters("pTgr", DB_TYPE.Decimal, GetParamObj("Dec", myClient.TGR), DIRECTION.Input);
            SetParameters("pOkpo", DB_TYPE.Varchar2, GetParamObj("Str", myClient.OKPO), DIRECTION.Input);
            SetParameters("pStmt", DB_TYPE.Decimal, GetParamObj("Dec", myClient.STMT), DIRECTION.Input);
            SetParameters("pSab", DB_TYPE.Varchar2, GetParamObj("Str", myClient.SAB), DIRECTION.Input);
            SetParameters("pDateOn", DB_TYPE.Date, GetParamObj("Dat", myClient.DATE_ON), DIRECTION.Input);
            SetParameters("pTaxf", DB_TYPE.Decimal, GetParamObj("Dec", myClient.TAXF), DIRECTION.Input);
            SetParameters("pCReg", DB_TYPE.Decimal, GetParamObj("Dec", myClient.C_REG), DIRECTION.Input);
            SetParameters("pCDst", DB_TYPE.Decimal, GetParamObj("Dec", myClient.C_DST), DIRECTION.Input);
            SetParameters("pAdm", DB_TYPE.Varchar2, GetParamObj("Str", myClient.ADM), DIRECTION.Input);
            SetParameters("pRgTax", DB_TYPE.Varchar2, GetParamObj("Str", myClient.RGTAX), DIRECTION.Input);
            SetParameters("pRgAdm", DB_TYPE.Varchar2, GetParamObj("Str", myClient.RGADM), DIRECTION.Input);
            SetParameters("pDateT", DB_TYPE.Date, GetParamObj("Dat", myClient.DATET), DIRECTION.Input);
            SetParameters("pDateA", DB_TYPE.Date, GetParamObj("Dat", myClient.DATEA), DIRECTION.Input);
            SetParameters("pIse", DB_TYPE.Char, GetParamObj("Chr", myClient.ISE), DIRECTION.Input);
            SetParameters("pFs", DB_TYPE.Char, GetParamObj("Chr", myClient.FS), DIRECTION.Input);
            SetParameters("pOe", DB_TYPE.Char, GetParamObj("Chr", myClient.OE), DIRECTION.Input);
            SetParameters("pVed", DB_TYPE.Char, GetParamObj("Chr", myClient.VED), DIRECTION.Input);
            // SetParameters("pK050", DB_TYPE.Char, GetParamObj("Chr", MyClient.K050), DIRECTION.Input);
            SetParameters("pSed", DB_TYPE.Char, GetParamObj("Chr", myClient.SED), DIRECTION.Input);
            SetParameters("pNotes", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NOTES), DIRECTION.Input);
            SetParameters("pNotesec", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NOTESEC), DIRECTION.Input);
            SetParameters("pCRisk", DB_TYPE.Decimal, GetParamObj("Dec", myClient.CRISK), DIRECTION.Input);
            SetParameters("pPincode", DB_TYPE.Varchar2, GetParamObj("Str", myClient.PINCODE), DIRECTION.Input);
            SetParameters("pRnkP", DB_TYPE.Decimal, GetParamObj("Dec", myClient.RNKP), DIRECTION.Input);
            SetParameters("pLim", DB_TYPE.Decimal, GetParamObj("Dec", myClient.LIM), DIRECTION.Input);
            SetParameters("pNomPDV", DB_TYPE.Decimal, GetParamObj("Dec", myClient.NOMPDV), DIRECTION.Input);
            SetParameters("pMB", DB_TYPE.Char, GetParamObj("Chr", myClient.MB), DIRECTION.Input);
            SetParameters("pBC", DB_TYPE.Decimal, GetParamObj("Dec", myClient.BC), DIRECTION.Input);
            SetParameters("pTobo", DB_TYPE.Varchar2, GetParamObj("Str", myClient.TOBO), DIRECTION.Input);
            SetParameters("pIsp", DB_TYPE.Decimal, GetParamObj("Dec", myClient.ISP), DIRECTION.Input);
            SetParameters("pNRezidCode", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NRezidCode), DIRECTION.Input);
            const string sqlCustomerAttr = @"begin kl.setCustomerAttr(
                                            :pRnk, 
                                            :pCusttype, 
                                            :pNd, 
                                            :pNmk, 
                                            :pNmkv, 
                                            :pNmkk,
                                            :pAdr,
                                            :pCodcagent,
                                            :pCountry,
                                            :pPrinsider,
                                            :pTgr,
                                            :pOkpo,
                                            :pStmt,
                                            :pSab,
                                            :pDateOn,
                                            :pTaxf,
                                            :pCReg,
                                            :pCDst,
                                            :pAdm,
                                            :pRgTax,
                                            :pRgAdm,
                                            :pDateT,
                                            :pDateA,
                                            :pIse,
                                            :pFs,
                                            :pOe,
                                            :pVed,
                                            :pSed, 
                                            :pNotes,
                                            :pNotesec,
                                            :pCRisk,
                                            :pPincode, 
                                            :pRnkP,
                                            :pLim,
                                            :pNomPDV,
                                            :pMB, 
                                            :pBC,
                                            :pTobo,
                                            :pIsp,
                                            :pNRezidCode
                                            {0} ); end;";
            var addParams = "";

            if (IsNeedConfirmChanges())
            {
                SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                addParams = ",:p_flag_visa";
            }

            SQL_NONQUERY(string.Format(sqlCustomerAttr, addParams));

            DBLogger.Info(String.Format("Клиент РНК={0} успешно заведен.p_flag_visa = {1} ", myClient.ID, IsNeedConfirmChanges()), "ClientRegister");

            myClient.ID = GetParameter("pRnk").ToString();

            // процедура установки экономических показателей клиента
            ClearParameters();
            SetParameters("p_rnk", DB_TYPE.Int64, GetParamObj("Dec", myClient.ID), DIRECTION.InputOutput);
            SetParameters("p_k070", DB_TYPE.Char, GetParamObj("Chr", myClient.ISE), DIRECTION.Input);
            SetParameters("p_k080", DB_TYPE.Char, GetParamObj("Chr", myClient.FS), DIRECTION.Input);
            SetParameters("p_k110", DB_TYPE.Char, GetParamObj("Chr", myClient.VED), DIRECTION.Input);
            SetParameters("p_k090", DB_TYPE.Char, GetParamObj("Chr", myClient.OE), DIRECTION.Input);
            SetParameters("p_k050", DB_TYPE.Char, GetParamObj("Chr", myClient.K050), DIRECTION.Input);
            SetParameters("p_k051", DB_TYPE.Char, GetParamObj("Chr", myClient.SED), DIRECTION.Input);
            const string sqlCustomerEn = "begin kl.setCustomerEN(:p_rnk, :p_k070, :p_k080, :p_k110, :p_k090, :p_k050, :p_k051 {0}); end;";
            if (IsNeedConfirmChanges())
            {
                SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                addParams = ",:p_flag_visa";
            }

            SQL_NONQUERY(string.Format(sqlCustomerEn, addParams));
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

        private int GetRezId(decimal codcagent)
        {
            int result;
            using (OracleCommand cmd = GetOraConnection().CreateCommand())
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_codagent", OracleDbType.Decimal, codcagent, ParameterDirection.Input);

                cmd.CommandText = @"select 
                                        rezid 
                                    from 
                                        codcagent 
                                    where 
                                        codcagent = :p_codagent";
                result = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return result;
        }

        /// <summary>
        /// Допреквизиты
        /// </summary>
        public void WriteDopRekvToDatabase(Client myClient,
                                            List<CustAttrRecord> custAttrs,
                                            bool checkReq,
                                            List<CustRiskRecord> custRisks,
                                            List<CustReptRecord> custReptList)
        {
            for (int i = 0; i < custAttrs.Count; i++)
            {
                if (custAttrs[i] != null)
                {
                    ClearParameters();

                    SetParameters("pRnk", DB_TYPE.Decimal, myClient.ID, DIRECTION.Input);
                    SetParameters("pTag", DB_TYPE.Varchar2, custAttrs[i].Tag, DIRECTION.Input);
                    SetParameters("pVal", DB_TYPE.Varchar2, custAttrs[i].Value, DIRECTION.Input);
                    SetParameters("pOtd", DB_TYPE.Decimal, 0, DIRECTION.Input);
                    if (IsNeedConfirmChanges())
                    {
                        SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                    }

                    SQL_PROCEDURE("kl.setCustomerElement");
                }

            }

            string errMsg = string.Empty;
            // вставка дефолтных значений 
            ClearParameters();
            SetParameters("rnk", DB_TYPE.Decimal, myClient.ID, DIRECTION.Input);

            string cs = myClient.CUSTTYPE.ToLower();
            int nRezId = GetRezId(Convert.ToDecimal(myClient.CODCAGENT)) ;
            int nSPD = (myClient.CUSTTYPE.ToLower() == "person" 
                &&  myClient.SED.Trim() == "91") ? 1 : 0;
            string sqlTail;
            if (cs == "bank")
                sqlTail = "cf.b";
            else if (cs == "corp")
                sqlTail = ((nRezId == 1) ? ("cf.u") : ("cf.u_nrez"));
            else
            {
                if (nRezId == 1)
                    if (nSPD == 1) sqlTail = "cf.f_spd";
                    else sqlTail = "cf.f";
                else
                    sqlTail = "cf.f_nrez";
            }
            var sqlTailUsed = string.Format("nvl({0}, 0) = 2 ", sqlTail);

            SQL_Reader_Exec(@"select 
                                c.custtype, 
                                cf.tag, 
                                sqlval, 
                                --cf.opt, 
                                decode(nvl(" + sqlTail + @",0),0,0,1,0,2,1) opt,
                                cf.name, 
                                cfc.name, 
                                c.sed, 
                                cca.rezid
                            from 
                                customer_field cf, 
                                customer c, 
                                customer_field_codes cfc, 
                                codcagent cca
                            where 
                                " + sqlTail + @" > 0
                                /*((cf.B > 0 and c.custtype = 1) 
                                    or (cf.U > 0 and c.custtype = 2) 
                                    or (cf.F > 0 and c.custtype = 3))*/
                                and cf.code=cfc.code 
                                and not_to_edit = 0
                                and c.rnk = :rnk
                                and CCA.CODCAGENT=C.CODCAGENT
                                and (sqlval is not null or /*cf.opt=1*/ " + sqlTailUsed + @")
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
                        string nSpd;
                        if (custtype == 3 && sed == 91) nSpd = "1";
                        else nSpd = "0";

                        sqlVal = sqlVal.Replace(":CUSTTYPE", Convert.ToString(custtype)).Replace(":RNK", myClient.ID);
                        sqlVal = sqlVal.Replace(":SPD", nSpd).Replace(":REZID", Convert.ToString(rezId));
                        defVal = Convert.ToString(SQL_SELECT_scalar("select (" + sqlVal + ") val from dual"));

                        SetParameters("Rnk_", DB_TYPE.Decimal, myClient.ID, DIRECTION.Input);
                        SetParameters("Tag_", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                        SetParameters("Val_", DB_TYPE.Varchar2, defVal, DIRECTION.Input);
                        SetParameters("Otd_", DB_TYPE.Decimal, 0, DIRECTION.Input);
                        if (IsNeedConfirmChanges())
                        {
                            SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                        }
                        SQL_PROCEDURE("kl.setCustomerElement");
                    }

                    if (checkReq && opt.Equals("1") && string.IsNullOrEmpty(defVal))
                    {
                        errMsg += " - " + reqName + "(у блоці - [" + tabName + "])" + Environment.NewLine;
                    }
                }
                catch { }
            }
            SQL_Reader_Close();

            if (!string.IsNullOrEmpty(errMsg))
                throw new Bars.Exception.BarsException("не заповнено дод. реквізит(и): \n" + errMsg);

            // Фин. мониторинг
            WriteRiskToDb(Convert.ToInt32(myClient.ID), custRisks);
            if (custRisks.Count > 0
                && ((myClient.EditType.ToLower() != "reg")
                        || (myClient.CUSTTYPE.ToLower() == "person"
                        && myClient.SED.Trim() != "91")))
            {
                WriteFmRizikToDb(Convert.ToInt32(myClient.ID));
            }
            //репутація
            WriteReptToDb(Convert.ToInt32(myClient.ID), custReptList);

            /*for (int i = 0; i < custRisks.Count; i++)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, myClient.ID, DIRECTION.Input);
                SetParameters("RiskId", DB_TYPE.Varchar2, custRisks[i].Id, DIRECTION.Input);
                SetParameters("Val", DB_TYPE.Varchar2, custRisks[i].Value, DIRECTION.Input);

                if (IsNeedConfirmChanges())
                {
                    SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                }
                SQL_PROCEDURE("kl.set_customer_risk");
            }
            if (custRisks.Count > 0)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, myClient.ID, DIRECTION.Input);
                SQL_PROCEDURE("fm_set_rizik");
            }*/
        }

        //зберегти ризики в базу
        public void WriteRiskToDb(int rnk, List<CustRiskRecord> custRiskList)
        {
            for (int i = 0; i < custRiskList.Count; i++)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SetParameters("RiskId", DB_TYPE.Varchar2, custRiskList[i].Id, DIRECTION.Input);
                SetParameters("Val", DB_TYPE.Varchar2, custRiskList[i].Value, DIRECTION.Input);

                if (IsNeedConfirmChanges())
                {
                    SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                }
                SQL_PROCEDURE("kl.set_customer_risk");
            }
        }

        public void WriteFmRizikToDb(int rnk)
        {
            ClearParameters();
            SetParameters("Rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
            SQL_PROCEDURE("fm_set_rizik");
        }

        //зберегти репутацію клієнта
        public void WriteReptToDb(int rnk, List<CustReptRecord> custReptList)
        {
            for (int i = 0; i < custReptList.Count; i++)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SetParameters("ReptId", DB_TYPE.Varchar2, custReptList[i].Id, DIRECTION.Input);
                SetParameters("Val", DB_TYPE.Varchar2, custReptList[i].Value, DIRECTION.Input);
                SQL_PROCEDURE("kl.set_customer_rept");
            }
            if (custReptList.Count > 0)
            {
                ClearParameters();
                SetParameters("Rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SQL_PROCEDURE("fm_set_rept");
            }
        }
        /// <summary>
        /// Метод записывает параметры в таблицу rnk_rekv
        /// </summary>
        public void WriteRnkRekvToDatabase(Client myClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", myClient.ID), DIRECTION.InputOutput);
            SetParameters("pLimKass", DB_TYPE.Decimal, GetParamObj("Dec", myClient.LIM_KASS), DIRECTION.Input);
            SetParameters("pAdrAlt", DB_TYPE.Varchar2, GetParamObj("Str", myClient.ADR_ALT), DIRECTION.Input);
            SetParameters("pNomDog", DB_TYPE.Varchar2, GetParamObj("Str", myClient.NOM_DOG), DIRECTION.Input);
            //todo:
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
            const string sql = "begin kl.setPersonAttr(:pRnk, :pSex, :pPassp, :pSer, :pNumdoc, :pPDate, :pOrgan, :pBDay, :pBPlace, :pTelD, :pTelW {0}); end;";
            var addParams = "";
            if (IsNeedConfirmChanges())
            {
                SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                addParams = ",:p_flag_visa";
            }

            SQL_NONQUERY(string.Format(sql, addParams));
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
            SetParameters("pSEALID", DB_TYPE.Int32, GetParamObj("Dec", MyClient.SEAL_ID), DIRECTION.Input);
            const string sql = "begin kl.setCorpAttr(:pRnk, :pNmku, :pRuk, :pTelR, :pBuh, :pTelB, :pTELFAX, :pEMAIL, :pSEALID {0}); end;";
            var addParams = "";
            if (IsNeedConfirmChanges())
            {
                SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                addParams = ",:p_flag_visa";
            }

            SQL_NONQUERY(string.Format(sql, addParams));
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
                const string sql = "begin kl.delCorpAcc(:pId {0}); end;";
                var addParams = "";
                if (IsNeedConfirmChanges())
                {
                    SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                    addParams = ",:p_flag_visa";
                }
                SQL_NONQUERY(string.Format(sql, addParams));
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

                const string sql = @"begin kl.setCorpAccEx(
                                                        :pRnk, 
                                                        :pId, 
                                                        :pMFO, 
                                                        :pNLS, 
                                                        :pKV, 
                                                        :pCOMM,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null
                                                        {0}); end;";
                var addParams = "";
                if (IsNeedConfirmChanges())
                {
                    SetParameters("p_flag_visa", DB_TYPE.Decimal, 1, DIRECTION.Input);
                    addParams = ",:p_flag_visa";
                }

                SQL_NONQUERY(string.Format(sql, addParams));
            }
        }

        /// <summary>
        /// Метод записывает параметры клиента-банк в базу данных
        /// </summary>
        public void WriteBankToDatabase(Client myClient)
        {
            ClearParameters();

            SetParameters("pRnk", DB_TYPE.Int64, GetParamObj("Dec", myClient.ID), DIRECTION.InputOutput);
            SetParameters("pMfo", DB_TYPE.Varchar2, GetParamObj("Str", myClient.MFO), DIRECTION.Input);
            SetParameters("pBic", DB_TYPE.Varchar2, GetParamObj("Str", myClient.BIC), DIRECTION.Input);
            SetParameters("pBicAlt", DB_TYPE.Varchar2, GetParamObj("Str", myClient.ALT_BIC), DIRECTION.Input);
            SetParameters("pRating", DB_TYPE.Varchar2, GetParamObj("Str", myClient.RATING), DIRECTION.Input);
            SetParameters("pKod_b", DB_TYPE.Int64, GetParamObj("Dec", myClient.KOD_B), DIRECTION.InputOutput);
            SetParameters("pRuk", DB_TYPE.Varchar2, GetParamObj("Str", myClient.RUK), DIRECTION.Input);
            SetParameters("pTelR", DB_TYPE.Varchar2, GetParamObj("Str", myClient.TELR), DIRECTION.Input);
            SetParameters("pBuh", DB_TYPE.Varchar2, GetParamObj("Str", myClient.BUH), DIRECTION.Input);
            SetParameters("pTelB", DB_TYPE.Varchar2, GetParamObj("Str", myClient.TELB), DIRECTION.Input);

            SQL_NONQUERY("begin kl.setBankAttr(:pRnk, :pMfo, :pBic, :pBicAlt, :pRating, :pKod_b, :pRuk, :pTelR, :pBuh, :pTelB); end;");
        }
        /// <summary>
        /// Записываем полный адрес клиента в базу
        /// </summary>

        public void SetCustomerAddress(OracleCommand cmd, Decimal RNK, Int32 type_id, Decimal Country, CustomerAddress.Address adr)
        {
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "kl.setFullCustomerAddress";
            cmd.Parameters.Add("p_Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            cmd.Parameters.Add("p_TypeId", OracleDbType.Decimal, type_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_Country", OracleDbType.Decimal, Country, ParameterDirection.Input);
            cmd.Parameters.Add("p_Zip", OracleDbType.Varchar2, adr.zip, ParameterDirection.Input);
            cmd.Parameters.Add("p_Domain", OracleDbType.Varchar2, adr.domain, ParameterDirection.Input);
            cmd.Parameters.Add("p_Region", OracleDbType.Varchar2, adr.region, ParameterDirection.Input);
            cmd.Parameters.Add("p_Locality", OracleDbType.Varchar2, adr.locality, ParameterDirection.Input);
            cmd.Parameters.Add("p_Address", OracleDbType.Varchar2, adr.address, ParameterDirection.Input);
            cmd.Parameters.Add("p_TerritoryId", OracleDbType.Decimal, adr.territory_id, ParameterDirection.Input);

            cmd.Parameters.Add("p_locality_type", OracleDbType.Decimal, adr.locality_type, ParameterDirection.Input);
            cmd.Parameters.Add("p_street_type", OracleDbType.Decimal, adr.street_type, ParameterDirection.Input);
            cmd.Parameters.Add("p_street", OracleDbType.Varchar2, adr.street, ParameterDirection.Input);
            cmd.Parameters.Add("p_home_type", OracleDbType.Decimal, adr.home_type, ParameterDirection.Input);
            cmd.Parameters.Add("p_home", OracleDbType.Varchar2, adr.home, ParameterDirection.Input);
            cmd.Parameters.Add("p_home_part_type", OracleDbType.Decimal, adr.homepart_type, ParameterDirection.Input);
            cmd.Parameters.Add("p_home_part", OracleDbType.Varchar2, adr.homepart, ParameterDirection.Input);
            cmd.Parameters.Add("p_room_type", OracleDbType.Decimal, adr.room_type, ParameterDirection.Input);
            cmd.Parameters.Add("p_room", OracleDbType.Varchar2, adr.room, ParameterDirection.Input);
            cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, adr.Comment, ParameterDirection.Input);

            if (IsNeedConfirmChanges())
            {
                cmd.Parameters.Add("p_flag_visa", OracleDbType.Decimal, 1, ParameterDirection.Input);
            }

            cmd.ExecuteNonQuery();

            /*cmd.Parameters.Clear();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = @"begin update customer_address set 
                                    locality_type=:LocalityType_, 
                                    street_type=:StreetType_, 
                                    street=:Street_, 
                                    home_type=:HomeType_,
                                    home=:Home_, 
                                    homepart_type=:HomePartType_, 
                                    homepart=:HomePart_,
                                    room_type=:RoomType_,
                                    room=:Room_
                                where rnk=:Rnk_ and type_id=:TypeId_;commit; end;";

            cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            cmd.Parameters.Add("TypeId_", OracleDbType.Decimal, type_id, ParameterDirection.Input);

            cmd.Parameters.Add("LocalityType_", OracleDbType.Decimal, adr.locality_type, ParameterDirection.Input);
            cmd.Parameters.Add("StreetType_", OracleDbType.Decimal, adr.street_type, ParameterDirection.Input);
            cmd.Parameters.Add("Street_", OracleDbType.Varchar2, adr.street, ParameterDirection.Input);
            cmd.Parameters.Add("HomeType_", OracleDbType.Decimal, adr.home_type, ParameterDirection.Input);
            cmd.Parameters.Add("Home_", OracleDbType.Varchar2, adr.home, ParameterDirection.Input);
            cmd.Parameters.Add("HomePartType_", OracleDbType.Decimal, adr.homepart_type, ParameterDirection.Input);
            cmd.Parameters.Add("HomePart_", OracleDbType.Varchar2, adr.homepart, ParameterDirection.Input);
            cmd.Parameters.Add("RoomType_", OracleDbType.Decimal, adr.room_type, ParameterDirection.Input);
            cmd.Parameters.Add("Room_", OracleDbType.Varchar2, adr.room, ParameterDirection.Input);
            
            cmd.ExecuteNonQuery();*/
        }

        public void SetCustomerAddressExtra(OracleCommand cmd, Decimal rnk, Int32 typeId, Decimal country, CustomerAddress.Address adr)
        {
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = @"update customer_address set 
                                    locality_type=:LocalityType_, 
                                    street_type=:StreetType_, 
                                    street=:Street_, 
                                    home_type=:HomeType_,
                                    home=:Home_, 
                                    homepart_type=:HomePartType_, 
                                    homepart=:HomePart_,
                                    room_type=:RoomType_,
                                    room=:Room_
                                where rnk=:p_rnk and type_id=:p_type_id";

            //cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, Convert.ToDecimal(RNK), ParameterDirection.Input);
            //cmd.Parameters.Add("TypeId_", OracleDbType.Decimal, Convert.ToDecimal(type_id), ParameterDirection.Input);

            cmd.Parameters.Add("LocalityType_", OracleDbType.Decimal, adr.locality_type, ParameterDirection.Input);
            cmd.Parameters.Add("StreetType_", OracleDbType.Decimal, adr.street_type, ParameterDirection.Input);
            cmd.Parameters.Add("Street_", OracleDbType.Varchar2, adr.street, ParameterDirection.Input);
            cmd.Parameters.Add("HomeType_", OracleDbType.Decimal, adr.home_type, ParameterDirection.Input);
            cmd.Parameters.Add("Home_", OracleDbType.Varchar2, adr.home, ParameterDirection.Input);
            cmd.Parameters.Add("HomePartType_", OracleDbType.Decimal, adr.homepart_type, ParameterDirection.Input);
            cmd.Parameters.Add("HomePart_", OracleDbType.Varchar2, adr.homepart, ParameterDirection.Input);
            cmd.Parameters.Add("RoomType_", OracleDbType.Decimal, adr.room_type, ParameterDirection.Input);
            cmd.Parameters.Add("Room_", OracleDbType.Varchar2, adr.room, ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("p_type_id", OracleDbType.Decimal, typeId, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }

        public void DelCustomerAddress(OracleCommand cmd, Decimal rnk, Int32 typeId)
        {
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from customer_address ca where ca.rnk = :p_rnk and ca.type_id = :p_type_id";
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("p_type_id", OracleDbType.Decimal, typeId, ParameterDirection.Input);
            cmd.ExecuteNonQuery();
        }

        /// <summary>
        /// Сохранение адреса в базу
        /// </summary>
        /// <param name="MyClient"></param>
        public void WritefullAdrToDatabase(Client MyClient)
        {
            //using (OracleCommand cmd = this.GetOraConnection().CreateCommand())
            //{
            // не записываем пустой адрес
            if (MyClient.fullADR.type1.filled || MyClient.fullADR.type2.filled || MyClient.fullADR.type3.filled)
            {
                Boolean isNewAdrScheme;
                // смотрим включена ли новая схема адресов
                using (OracleCommand cmd = this.GetOraConnection().CreateCommand())
                {
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText =
                        "select count(*) from all_objects where object_name = 'CUSTOMER_ADDRESS' and object_type = 'TABLE'";
                    isNewAdrScheme = Convert.ToDecimal(cmd.ExecuteScalar()) == 1;
                }
                //-- адрес в доп реквизиты
                string[] AdrVals = { MyClient.fullADR.type1.zip, MyClient.fullADR.type1.domain, MyClient.fullADR.type1.region, MyClient.fullADR.type1.locality, MyClient.fullADR.type1.address };
                string[] Tags = { "FGIDX", "FGOBL", "FGDST", "FGTWN", "FGADR" };

                for (int i = 0; i < Tags.Length; i++)
                {
                    ClearParameters();

                    SetParameters("pRnk", DB_TYPE.Decimal, GetParamObj("Dec", MyClient.ID), DIRECTION.Input);
                    SetParameters("pTag", DB_TYPE.Varchar2, GetParamObj("Str", Tags[i]), DIRECTION.Input);
                    SetParameters("pVal", DB_TYPE.Varchar2, GetParamObj("Str", AdrVals[i]), DIRECTION.Input);
                    SetParameters("pOtd", DB_TYPE.Decimal, GetParamObj("Dec", "0"), DIRECTION.Input);
                    if (IsNeedConfirmChanges())
                    {
                        SetParameters("p_flag_visa", DB_TYPE.Decimal, GetParamObj("Dec", "1"), DIRECTION.Input);
                    }
                    SQL_PROCEDURE("kl.setCustomerElement");

                    /*cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "kl.setCustomerElement";
                    cmd.Parameters.Add("Rnk_", OracleDbType.Decimal, Convert.ToDecimal(MyClient.ID), ParameterDirection.Input);
                    cmd.Parameters.Add("Tag_", OracleDbType.Varchar2, Tags[i], ParameterDirection.Input);
                    cmd.Parameters.Add("Val_", OracleDbType.Varchar2, AdrVals[i], ParameterDirection.Input);
                    cmd.Parameters.Add("Otd_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    if (IsNeedConfirmChanges())
                    {
                        cmd.Parameters.Add("p_flag_visa", OracleDbType.Decimal, 1, ParameterDirection.Input);
                    }

                    cmd.ExecuteNonQuery();*/
                }

                //-- адрес в таблицу CUSTOMER_ADDRESS
                if (isNewAdrScheme)
                {
                    using (OracleCommand cmd = GetOraConnection().CreateCommand())
                    {
                        if (MyClient.fullADR.type1.filled)
                        {
                            SetCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 1,
                                Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type1);
                            //SetCustomerAddressExtra(cmd, Convert.ToDecimal(MyClient.ID), 1,
                            //    Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type1);
                        }
                        else
                            DelCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 1);
                        if (MyClient.fullADR.type2.filled)
                        {
                            SetCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 2,
                                Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type2);
                            //SetCustomerAddressExtra(cmd, Convert.ToDecimal(MyClient.ID), 2,
                            //    Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type2);
                        }
                        else
                            DelCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 2);
                        if (MyClient.fullADR.type3.filled)
                        {
                            SetCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 3,
                                Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type3);
                            //SetCustomerAddressExtra(cmd, Convert.ToDecimal(MyClient.ID), 3,
                            //    Convert.ToDecimal(MyClient.COUNTRY), MyClient.fullADR.type3);
                        }
                        else
                            DelCustomerAddress(cmd, Convert.ToDecimal(MyClient.ID), 3);
                    }
                }
            }
            //}
        }

        [WebMethod(EnableSession = true)]
        public int CheckSPValue(string tag, string tabname, string value)
        {
            int result;
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
