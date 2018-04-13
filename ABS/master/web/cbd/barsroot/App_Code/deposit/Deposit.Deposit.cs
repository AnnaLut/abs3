using System;
using System.Web;
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using Bars.Web.Report;
using System.IO;
using System.Diagnostics;
using System.Collections;
using Bars.Exception;
using Bars.Classes;

/// <summary>
/// Клас для роботи з депозитним договором
/// </summary>
public class Deposit
{
    /// <summary>
    /// Идентификатор депозита
    /// </summary>
    public decimal ID;
    /// <summary>
    /// Номер депозитного договору
    /// </summary>
    public string Number;
    /// Цифровой код типа депозитного договора
    public decimal Type;
    /// Наименование типа депозитного договора
    public string TypeName;
    /// Дата заключения договора
    public DateTime Date;
    /// Дата начала депозита
    public DateTime BeginDate;
    /// <summary>
    /// Дата завершення депозиту
    /// </summary>
    public DateTime EndDate;
    /// <summary>
    /// Сума договору
    /// </summary>
    public decimal Sum;
    /// <summary>
    /// 
    /// </summary>
    public decimal Sum_cent;
    /// <summary>
    /// 
    /// </summary>
    public decimal Sum_denom;
    /// <summary>
    /// Фактична сума на депозитному рахунку - в грн
    /// </summary>
    public decimal dpt_f_sum;
    /// <summary>
    /// Планова сума на депозитному рахунку - в грн
    /// </summary>
    public decimal dpt_p_sum;
    /// <summary>
    /// Фактична сума на рахунку відсотків - в грн
    /// </summary>
    public decimal perc_f_sum;
    /// <summary>
    /// Планова сума на рахунку відсотків - в грн
    /// </summary>
    public decimal perc_p_sum;
    /// <summary>
    /// Валюта договора (код)
    /// </summary>
    public decimal Currency;
    /// <summary>
    /// Валюта договора (назва)
    /// </summary>
    public string CurrencyName;
    /// <summary>
    /// Валюта договора (ISO)
    /// </summary>
    public string CurrencyISO;
    /// <summary>
    /// Код депозитного рахунку
    /// </summary>
    public decimal dpt_acc;
    /// Депозитний рахунок
    public string dpt_nls;
    /// Найменування депозитного рахунку
    public string dpt_nls_nms;
    /// <summary>
    /// Код рахунку відсотків
    /// </summary>
    public decimal perc_acc;
    /// Рахунок відсотків
    public string perc_nls;
    /// Найменування рахунку відсотків
    public string perc_nls_nms;
    /// <summary>
    /// Признак внесения суммы наличными в кассу
    /// </summary>
    public bool IsCashSum;
    /// <summary>
    /// Признак капитализации процентов
    /// </summary>
    public bool IntCap;
    /// <summary>
    /// Ознака відкриття технічного рахунку
    /// </summary>
    public bool GetTechAcc;
    /// Действующая процентная ставка
    public decimal RealIntRate;
    /// Комментарий к договору
    public string Comment;
    /// ФИО Получателя процентов
    public string IntReceiverName;
    /// Идентификационный код получателя процентов
    public string IntReceiverOKPO;
    /// Счет для перечисления процентов
    public string IntReceiverAccount;
    /// МФО счета для перечисления процентов
    public string IntReceiverMFO;
    /// Номер картки для перерахунку відсотків
    public string IntReceiverCARDN;
    /// МФО счета для перечисления процентов
    public string RestReceiverName;
    /// <summary>
    /// Возврат депозита: Идентификационный код получателя
    /// </summary>
    public string RestReceiverOKPO;
    /// <summary>
    /// Возврат депозита: МФО счета получателя
    /// </summary>
    public string RestReceiverMFO;
    /// <summary>
    /// Возврат депозита: счет получателя
    /// </summary>
    public string RestReceiverAccount;
    /// <summary>
    /// Повернення депозиту: Номер картки
    /// </summary>
    public string RestReceiverCARDN;
    /// <summary>
    /// Состояние договора
    /// </summary>
    public decimal State;
    /// Имя текстового файла контракта
    public string ContractTextFile;
    /// <summary>
    /// відсотки (1 - можна виплачувати, 0 - не можна)
    /// </summary>
    public decimal fl_int_payoff;
    /// <summary>
    /// 1 - безготівка, 0 - готівка
    /// </summary>
    public string dpt_nocash;
    /// <summary>
    /// Тривалість депозиту в місяцях
    /// </summary>
    public decimal? dpt_duration_months;
    /// <summary>
    /// Тривалість депозиту в днях
    /// </summary>
    public decimal? dpt_duration_days;
    /// <summary>
    /// Авансова виплата відсотків
    /// </summary>
    public decimal? fl_avans_payoff;
    /// <summary>
    /// Список дод. параметрів депозитного договору
    /// </summary>
    public ArrayList DptField;
    /// <summary>
    /// Клиент (клас)
    /// </summary>
    public Client Client;

    /// <summary>
    /// Конструктор класса
    /// </summary>
    public Deposit()
    {
        // Класс клиента
        this.Client = new Client();
        this.DptField = new ArrayList();
        // 
        this.Clear();
        this.ContractTextFile = string.Empty;
    }

    /// <summary>
    /// Конструктор
    /// </summary>
    /// <param name="dpt_id">Номер депозита</param>
    public Deposit(Decimal dpt_id)
    {
        // Класс клиента
        this.Client = new Client();
        this.DptField = new ArrayList();
        // 
        this.Clear();
        this.ContractTextFile = string.Empty;

        this.ID = dpt_id;

        this.ReadFromDatabase();
    }

    /// <summary>
    /// Конструктор
    /// </summary>
    /// <param name="dpt_id">Номер депозита</param>
    /// <param name="other">ознака роботи з депозитом іншого підрозділу</param>
    public Deposit(Decimal dpt_id, Boolean other)
    {
        // Класс клиента
        this.Client = new Client();
        this.DptField = new ArrayList();
        // 
        this.Clear();
        this.ContractTextFile = string.Empty;

        this.ID = dpt_id;

        // this.ReadFromDatabase_EX(true, other);
        this.ReadFromDatabaseExt(true, other, true);
    }

    /// <summary>
    /// Метод очистки параметров депозита
    /// </summary>
    public void Clear()
    {
        this.Clear(true);
    }

    /// <summary>
    /// Метод очищення параметрів депозиту
    /// </summary>
    /// <param name="ClearClient">Очистка даних клієнта</param>
    public void Clear(Boolean ClearClient)
    {
        // Сбрасываем состояние
        if (ClearClient)
        {
            Client.Clear();
        }

        //
        this.Type = decimal.MinValue;
        this.TypeName = string.Empty;
        this.Number = string.Empty;
        this.Date = DateTime.MinValue;
        this.Currency = decimal.MinValue;
        this.CurrencyName = string.Empty;
        this.CurrencyISO = string.Empty;
        this.Sum = decimal.MinValue;
        this.Sum_denom = decimal.MinValue;
        this.dpt_f_sum = decimal.MinValue;
        this.dpt_p_sum = decimal.MinValue;
        this.perc_f_sum = decimal.MinValue;
        this.perc_p_sum = decimal.MinValue;
        this.IsCashSum = true;
        this.IntCap = false;
        this.RealIntRate = decimal.MinValue;
        this.Comment = string.Empty;
        this.IntReceiverName = string.Empty;
        this.IntReceiverOKPO = string.Empty;
        this.IntReceiverAccount = string.Empty;
        this.IntReceiverMFO = string.Empty;
        this.IntReceiverCARDN = string.Empty;
        this.RestReceiverName = string.Empty;
        this.RestReceiverOKPO = string.Empty;
        this.RestReceiverAccount = string.Empty;
        this.RestReceiverMFO = string.Empty;
        this.RestReceiverCARDN = string.Empty;
        this.dpt_acc = decimal.MaxValue;
        this.dpt_nls = string.Empty;
        this.dpt_nls_nms = string.Empty;
        this.perc_acc = decimal.MaxValue;
        this.perc_nls = string.Empty;
        this.perc_nls_nms = string.Empty;
        this.State = decimal.MinValue;
        this.fl_int_payoff = 0;
        this.dpt_nocash = "0";
        this.dpt_duration_days = null;
        this.dpt_duration_months = null;
        this.fl_avans_payoff = null;
        this.DptField.Clear();
    }
    /// <summary>
    /// Запис договору в базу
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void WriteToDatabase()
    {
        if (this.Date == DateTime.MinValue)
            throw new DepositException("Не вказано дату заключення договору!");

        HttpContext ctx = HttpContext.Current;
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь начал запись в базу депозитного договора для клиента №"
                + this.Client.ID.ToString(), "deposit");

            // Для чогось при створенні деп.договору вносилися зміни в картку клієнта???
            // Client.WriteToDatabase();

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            
            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Создаем договор
            DBLogger.Debug("Началась регистрация депозитного договора для клиента №"
                + this.Client.ID.ToString(), "deposit");
            
            WriteContract(connect);
            
            DBLogger.Debug("Депозитный договор был успешно зарегистрирован под номером "
                + this.ID.ToString(), "deposit");
            
            // Запис додаткових реквізитів
            WriteDptField(connect);
            DBLogger.Debug("Доп.реквизиты депозитного договора №"
                + this.ID.ToString() + " были успешно записаны в базу.", "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Запис дод. реквізитів депозитного
    /// договору в базу
    /// </summary>
    /// <param name="connect">конект</param>
    public void WriteDptField(OracleConnection connect)
    {
        OracleCommand cmdFillDptParams = new OracleCommand();
        cmdFillDptParams.Connection = connect;

        cmdFillDptParams.CommandText = "BEGIN dpt.fill_dptparams( :p_dptid, :p_tag, :p_val); END;";

        DepositField dpt_field;

        for (int i = 0; i < this.DptField.Count; i++)
        {
            dpt_field = (DepositField)this.DptField[i];
            if (dpt_field.Val == String.Empty)
                continue;
            cmdFillDptParams.Parameters.Clear();
            cmdFillDptParams.Parameters.Add("p_dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmdFillDptParams.Parameters.Add("p_tag", OracleDbType.Varchar2, dpt_field.Tag, ParameterDirection.Input);
            cmdFillDptParams.Parameters.Add("p_val", OracleDbType.Varchar2, dpt_field.Val, ParameterDirection.Input);

            cmdFillDptParams.ExecuteNonQuery();
        }

        cmdFillDptParams.Dispose();
    }
    /// <summary>
    /// Создание депозита в базе данных
    /// </summary>
    /// <param name="connect">соединение</param>
    private void WriteContract(OracleConnection connect)
    {
        // Формируем запрос на создание
        OracleCommand cmdCreateContract = new OracleCommand();
        cmdCreateContract.Connection = connect;

        cmdCreateContract.CommandText =
           " begin dpt_web.create_deposit(                       " +
           " :TypeCode, :ClientCode, :ContractNum, :ContractSum, " +
           " :NoCash, :ContractDate, :IntRcpName, :IntRcpIDCode, " +
           " :IntRcpAcc, :IntRcpMFO, :TechAcc, :RestRcpName,     " +
           " :RestRcpIDCode, :RestRcpAcc, :RestRcpMFO, :Comment, " +
           " :DptID, gl.bdate, :p_duration, :p_duration_days);   " +
           " end; ";

        Decimal getTechAcc = this.GetTechAcc ? 1 : 0;
        Decimal NoCash = this.IsCashSum ? 0 : 1;

        // Привязываем переменные
        cmdCreateContract.Parameters.Add("TypeCode", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("ClientCode", OracleDbType.Decimal, this.Client.ID, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("ContractNum", OracleDbType.Varchar2, this.Number, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("ContractSum", OracleDbType.Decimal, this.Sum_cent, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("NoCash", OracleDbType.Decimal, NoCash, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("ContractDate", OracleDbType.Date, this.Date, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("IntRcpName", OracleDbType.Varchar2, this.IntReceiverName, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("IntRcpIDCode", OracleDbType.Varchar2, this.IntReceiverOKPO, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("IntRcpAcc", OracleDbType.Varchar2, this.IntReceiverAccount, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("IntRcpMFO", OracleDbType.Varchar2, this.IntReceiverMFO, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("TechAcc", OracleDbType.Decimal, getTechAcc, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("RestRcpName", OracleDbType.Varchar2, this.RestReceiverName, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("RestRcpIDCode", OracleDbType.Varchar2, this.RestReceiverOKPO, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("RestRcpAcc", OracleDbType.Varchar2, this.RestReceiverAccount, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("RestRcpMFO", OracleDbType.Varchar2, this.RestReceiverMFO, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("Comment", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("DptID", OracleDbType.Decimal, this.ID, ParameterDirection.Output);
        cmdCreateContract.Parameters.Add("p_duration", OracleDbType.Decimal, this.dpt_duration_months, ParameterDirection.Input);
        cmdCreateContract.Parameters.Add("p_duration_days", OracleDbType.Decimal, this.dpt_duration_days, ParameterDirection.Input);
        // Выполняем
        cmdCreateContract.ExecuteNonQuery();
        // Читаем выходные параметры
        this.ID = Convert.ToDecimal(Convert.ToString(cmdCreateContract.Parameters["DptID"].Value));

        this.State = 9;
        cmdCreateContract.Dispose();

        if (!String.IsNullOrEmpty(Bars.Metals.DepositMetals.TagValue()))
        {
            //OracleCommand cmdInsertDepositwParam = connect.CreateCommand();
            //cmdInsertDepositwParam.CommandText = "insert into dpt_depositw(dpt_id,tag,value) values(:dpt_id,'METAL',:value)";
            //cmdInsertDepositwParam.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            //cmdInsertDepositwParam.Parameters.Add("value", OracleDbType.Varchar2, Bars.Metals.DepositMetals.TagValue(), ParameterDirection.Input);
            //cmdInsertDepositwParam.ExecuteNonQuery();
            //cmdInsertDepositwParam.Dispose();

            this.DptField.Add(new DepositField("METAL", Bars.Metals.DepositMetals.TagValue()));
        }

        Bars.Metals.DepositMetals.ClearData();

        #region UPB
        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            OracleCommand cmdInsertParam = connect.CreateCommand();
            cmdInsertParam.CommandText = "insert into dpt_depositw values(:dpt_id,'NFINE','0')";
            cmdInsertParam.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmdInsertParam.ExecuteNonQuery();
            cmdInsertParam.Dispose();

            OracleCommand cmdGetAcc = connect.CreateCommand();
            cmdGetAcc.CommandText = "select a1.acc,a2.acc " +
                "from dpt_deposit d, saldo a1,int_accn i,saldo a2 " +
                "where d.deposit_id = :dpt_id and d.acc = a1.acc and d.acc = i.acc and i.acra = a2.acc";
            cmdGetAcc.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

            OracleDataReader rdr = cmdGetAcc.ExecuteReader();
            if (!rdr.Read())
                throw new DepositException("Не вдалося знайти рахунки по депозитному договору №" + this.ID.ToString());

            Decimal d_acc = Decimal.MinValue;
            Decimal p_acc = Decimal.MinValue;

            if (!rdr.IsDBNull(0))
                d_acc = rdr.GetOracleDecimal(0).Value;
            if (!rdr.IsDBNull(1))
                p_acc = rdr.GetOracleDecimal(1).Value;

            if (!rdr.IsClosed)rdr.Close();
            rdr.Dispose();

            cmdGetAcc.Dispose();

            OracleCommand cmdInsertPsevdoMFO = connect.CreateCommand();
            cmdInsertPsevdoMFO.CommandText = "begin " +
                "INSERT INTO BANK_ACC(ACC,MFO) VALUES (:acc,(select (select decode(tobo, null, kf, tobo) from accounts where acc=:accn)); " +
                "exception when DUP_VAL_ON_INDEX " +
                "then null; " +
                "end; ";
            cmdInsertPsevdoMFO.Parameters.Add("acc", OracleDbType.Decimal, d_acc, ParameterDirection.Input);
            cmdInsertPsevdoMFO.Parameters.Add("accn", OracleDbType.Decimal, d_acc, ParameterDirection.Input);
            cmdInsertPsevdoMFO.ExecuteNonQuery();

            cmdInsertPsevdoMFO.Parameters.Clear();
            cmdInsertPsevdoMFO.Parameters.Add("acc", OracleDbType.Decimal, p_acc, ParameterDirection.Input);
            cmdInsertPsevdoMFO.Parameters.Add("accn", OracleDbType.Decimal, p_acc, ParameterDirection.Input);
            cmdInsertPsevdoMFO.ExecuteNonQuery();
            cmdInsertPsevdoMFO.Dispose();
        }
        #endregion
    }
    /// <summary>
    /// Запись в базу сформированого текста депозитного договора
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void AddContractText(HttpContext ctx, String[] _templates)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь начал запись в базу текста депозитного договора №"
                + this.ID.ToString(), "deposit");

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            
            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            WriteContractText(connect, ctx, _templates);

            DBLogger.Debug("Пользователь успешно записал в базу текст депозитного договора №"
                + this.ID.ToString(), "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Запись в базу сформированого текста депозитного договора
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void AddContractText(HttpContext ctx)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь начал запись в базу текста депозитного договора №"
                + this.ID.ToString(), "deposit");

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            
            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            WriteContractText(connect, ctx);

            DBLogger.Debug("Пользователь успешно записал в базу текст депозитного договора №"
                + this.ID.ToString(), "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Запись в базу сформированого текста депозитного договора
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void CreateProlongateText()
    {
        HttpContext ctx = HttpContext.Current;

        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь начал запись в базу текста депозитного договора №"
                + this.ID.ToString(), "deposit");

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            
            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            /// Формуємо відсоткову ставку
            if (BankType.GetCurrentBank() == BANKTYPE.PRVX ||
                     BankType.GetCurrentBank() == BANKTYPE.SBER)
            {
                Decimal dummy = Decimal.MinValue;
                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "begin dpt_bonus.set_bonus_rate_web(:p_dptid,trunc(sysdate),:newRate); end;";
                cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmd.Parameters.Add("newRate", OracleDbType.Decimal, dummy, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }

            OracleCommand cmdSelTemplate = new OracleCommand();
            cmdSelTemplate.Connection = connect;
            cmdSelTemplate.CommandText = "select id from dpt_vidd_scheme where vidd = :vidd and flags = :flag";
            cmdSelTemplate.Parameters.Add("vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
            cmdSelTemplate.Parameters.Add("flag", OracleDbType.Decimal, 1, ParameterDirection.Input);
            string template = (string)cmdSelTemplate.ExecuteScalar();

            RtfReporter rep = new RtfReporter(ctx);
            rep.RoleList = "reporter,dpt_role,cc_doc";
            rep.ContractNumber = (long)this.ID;
            rep.TemplateID = template;
            OracleClob repText = new OracleClob(connect);

            try
            {
                rep.Generate();

                StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));
                char[] text = null;
                String str = sr.ReadToEnd();
                sr.Close();
                text = str.ToCharArray();

                File.Delete(rep.ReportFile);

                repText.Write(text, 0, text.Length);

                OracleCommand cmdInsDoc = connect.CreateCommand();
                cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdInsDoc.ExecuteNonQuery();

                cmdInsDoc.CommandText = "begin dpt_web.prolongation_create_text(:p_id,:p_nd,:p_text); end;";
                cmdInsDoc.Parameters.Add("p_id", OracleDbType.Varchar2, template, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("p_nd", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("p_text", OracleDbType.Clob, repText, ParameterDirection.Input);
                cmdInsDoc.ExecuteNonQuery();
                cmdInsDoc.Dispose();
            }
            finally
            {
                repText.Close();
                repText.Dispose();

                rep.DeleteReportFiles();
            }

            DBLogger.Debug("Формирование текста депозитного договора №"
                + this.ID.ToString() + " прошло успешно.", "deposit");

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Создание текста договора в базе данных
    /// </summary>
    /// <param name="connect">соединение</param>
    /// <param name="ctx">контекст</param>
    private void WriteContractText(OracleConnection connect, HttpContext ctx)
    {
        DBLogger.Debug("Формирование текста депозитного договора №" +
            this.ID.ToString() + " началось.", "deposit");

        /// Формуємо відсоткову ставку
        if (BankType.GetCurrentBank() == BANKTYPE.PRVX ||
                     BankType.GetCurrentBank() == BANKTYPE.SBER)
        {
            Decimal dummy = Decimal.MinValue;
            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_bonus.set_bonus_rate_web(:p_dptid,sysdate,:newRate); end;";
            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmd.Parameters.Add("newRate", OracleDbType.Decimal, dummy, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }

        decimal mainContractFlag = 0;

        OracleCommand cmdSelTemplate = new OracleCommand();
        cmdSelTemplate.Connection = connect;
        cmdSelTemplate.CommandText = "select id from dpt_vidd_scheme where vidd = :vidd and flags = :flag";
        cmdSelTemplate.Parameters.Add("vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
        cmdSelTemplate.Parameters.Add("flag", OracleDbType.Decimal, 1, ParameterDirection.Input);
        string template = (string)cmdSelTemplate.ExecuteScalar();

        RtfReporter rep = new RtfReporter(ctx);
        rep.RoleList = "reporter,dpt_role,cc_doc";
        rep.ContractNumber = (long)this.ID;
        rep.TemplateID = template;
        OracleClob repText = new OracleClob(connect);

        try
        {
            rep.Generate();

            StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));
            char[] text = null;
            String str = sr.ReadToEnd();
            sr.Close();
            text = str.ToCharArray();

            File.Delete(rep.ReportFile);

            repText.Write(text, 0, text.Length);

            OracleCommand cmdInsDoc = connect.CreateCommand();
            Bars.Oracle.Connection conn = new Connection();

            cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdInsDoc.ExecuteNonQuery();

            cmdInsDoc.CommandText = "begin dpt_web.create_text(:template, :dptid, :adds, :txt); end;";
            cmdInsDoc.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
            cmdInsDoc.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmdInsDoc.Parameters.Add("adds", OracleDbType.Decimal, mainContractFlag, ParameterDirection.Input);
            cmdInsDoc.Parameters.Add("txt", OracleDbType.Clob, repText, ParameterDirection.Input);
            cmdInsDoc.ExecuteNonQuery();
            cmdInsDoc.Dispose();
        }
        finally
        {
            repText.Close();
            repText.Dispose();

            rep.DeleteReportFiles();
        }

        DBLogger.Debug("Формирование текста депозитного договора №"
            + this.ID.ToString() + " прошло успешно.", "deposit");
    }
    /// <summary>
    /// Создание текста договора в базе данных
    /// </summary>
    /// <param name="connect">соединение</param>
    /// <param name="ctx">контекст</param>
    public static void WriteContractTextExt(Decimal dpt_id, Decimal flag_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();


            OracleCommand cmdSelTemplate = new OracleCommand();
            cmdSelTemplate.Connection = connect;
            cmdSelTemplate.CommandText = @"select id from dpt_vidd_scheme s, dpt_deposit d 
                where d.deposit_id = :dpt_id and s.vidd = d.vidd and s.flags = :flag";
            cmdSelTemplate.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmdSelTemplate.Parameters.Add("flag", OracleDbType.Decimal, flag_id, ParameterDirection.Input);
            string template = (string)cmdSelTemplate.ExecuteScalar();

            RtfReporter rep = new RtfReporter(HttpContext.Current);
            rep.RoleList = "reporter,dpt_role,cc_doc";
            rep.ContractNumber = (long)dpt_id;
            rep.TemplateID = template;
            OracleClob repText = new OracleClob(connect);

            try
            {
                rep.Generate();

                StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));
                char[] text = null;
                String str = sr.ReadToEnd();
                sr.Close();
                text = str.ToCharArray();

                File.Delete(rep.ReportFile);

                repText.Write(text, 0, text.Length);

                OracleCommand cmdInsDoc = connect.CreateCommand();
                Bars.Oracle.Connection conn = new Connection();

                cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdInsDoc.ExecuteNonQuery();

                cmdInsDoc.CommandText = "begin dpt_web.create_text(:template, :dptid, :adds, :txt); end;";
                cmdInsDoc.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("adds", OracleDbType.Decimal, -1, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("txt", OracleDbType.Clob, repText, ParameterDirection.Input);
                cmdInsDoc.ExecuteNonQuery();
                cmdInsDoc.Dispose();
            }
            finally
            {
                repText.Close();
                repText.Dispose();

                rep.DeleteReportFiles();
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// Создание текста договора в базе данных
    ///	---------УПБ---------
    /// </summary>
    /// <param name="connect">соединение</param>
    /// <param name="ctx">контекст</param>
    private void WriteContractText(OracleConnection connect, HttpContext ctx, String[] _templates)
    {
        DBLogger.Debug("Формирование текста депозитного договора №" +
            this.ID.ToString() + " началось.", "deposit");

        decimal mainContractFlag = 0;

        foreach (String template in _templates)
        {
            RtfReporter rep = new RtfReporter(ctx);
            rep.RoleList = "reporter,dpt_role,cc_doc";
            rep.ContractNumber = (long)this.ID;
            rep.TemplateID = template;
            OracleClob repText = new OracleClob(connect);

            try
            {
                OracleCommand cmdCkSign = connect.CreateCommand();
                cmdCkSign.CommandText = "select nvl(state,0) from cc_docs " +
                    "where nd=:dpt_id and adds=0 and id=:template";
                cmdCkSign.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmdCkSign.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                String result = Convert.ToString(cmdCkSign.ExecuteScalar());

                if (result == "2")
                {
                    throw new DepositException("Текст депозитного договору №" +
                        this.ID.ToString() + " (шаблон " + template +
                        ") вже підписано! Формувати його повторно заборонено!");
                }
                if (result == "1")
                {
                    /// Повторне формування
                    /// спочатку видаляємо попередній
                    OracleCommand cmdDelPrevDpt = connect.CreateCommand();
                    cmdDelPrevDpt.CommandText = "delete from cc_docs " +
                        "where nd=:dpt_id and adds=0 and state=1 and id=:template";
                    cmdDelPrevDpt.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                    cmdDelPrevDpt.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                    cmdDelPrevDpt.ExecuteNonQuery();
                }

                rep.Generate();

                StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));
                char[] text = null;
                String str = sr.ReadToEnd();
                sr.Close();
                text = str.ToCharArray();

                File.Delete(rep.ReportFile);

                repText.Write(text, 0, text.Length);

                OracleCommand cmdInsDoc = connect.CreateCommand();
                Bars.Oracle.Connection conn = new Connection();

                cmdInsDoc.CommandText = conn.GetSetRoleCommand("REPORTER");
                cmdInsDoc.ExecuteNonQuery();
                cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdInsDoc.ExecuteNonQuery();
                cmdInsDoc.CommandText = conn.GetSetRoleCommand("CC_DOC");
                cmdInsDoc.ExecuteNonQuery();

                cmdInsDoc.CommandText = "begin dpt_web.create_text(:template, :dptid, :adds, :txt); end;";
                cmdInsDoc.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("adds", OracleDbType.Decimal, mainContractFlag, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("txt", OracleDbType.Clob, repText, ParameterDirection.Input);
                cmdInsDoc.ExecuteNonQuery();
                cmdInsDoc.Dispose();
            }
            finally
            {
                repText.Close();
                repText.Dispose();

                rep.DeleteReportFiles();
            }
        }

        DBLogger.Debug("Формирование текста депозитного договора №" +
            this.ID.ToString() + " прошло успешно.", "deposit");
    }
    /// <summary>
    /// Проверка существования текста договора в базе
    /// </summary>
    /// <param name="ctx">контекст</param>
    /// <returns>существует или нет</returns>
    public bool ContractTextExists(HttpContext ctx)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Проверка сформированости текста депозитного договора №" +
                this.ID.ToString(), "deposit");

            //Client.WriteToDatabase(ctx);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            
            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCheckDptContract = new OracleCommand();
            cmdCheckDptContract.Connection = connect;
            cmdCheckDptContract.CommandText = "select nd from cc_docs where nd=:dpt_id and adds=0";
            cmdCheckDptContract.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

            OracleDataReader rdr = cmdCheckDptContract.ExecuteReader();

            if (!rdr.Read())
            {
                DBLogger.Debug("Текст депозитного договора №" + this.ID.ToString() +
                    " не сформирован.",
                    "deposit");
                return false;
            }

            Decimal nd = Decimal.MinValue;

            if (!rdr.IsDBNull(0))
                nd = Decimal.Parse(Convert.ToString(rdr.GetOracleDecimal(0).Value));

            if (nd != this.ID)
            {
                DBLogger.Debug("Текст депозитного договора №" + this.ID.ToString() +
                    " не сформирован.", "deposit");
                return false;
            }

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            DBLogger.Debug("Текст депозитного договора №" + this.ID.ToString() +
                " уже сформирован.", "deposit");
            return true;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    
    /// <summary>
    /// Формуємо текст додатк. угоди і збегігаємо в БД (CC_DOCS)
    /// </summary>
    public decimal WriteAddAgreement(String agr_uid, String par_template)
    {
        OracleConnection connect = new OracleConnection();
        Decimal add_id = Decimal.MinValue;

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            
            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetDopNum = connect.CreateCommand();
            cmdGetDopNum.CommandText = "select agrmnt_num " +
                "from v_dpt_agreements " +
                "where agrmnt_id = :agr_uid";
            cmdGetDopNum.Parameters.Add("agr_uid", OracleDbType.Decimal, agr_uid, ParameterDirection.Input);

            add_id = Convert.ToDecimal(cmdGetDopNum.ExecuteScalar().ToString());

            String template = Convert.ToString(HttpContext.Current.Session["DPTPRINT_TEMPLATE"]);

            if (String.IsNullOrEmpty(template)) template = par_template;

            DBLogger.Debug("Формирование доп. соглашения (тип = " +
                Convert.ToString(HttpContext.Current.Session["DPTPRINT_AGRID"]) + ") №" + add_id.ToString() +
                " по депозитному договору №" + this.ID.ToString() + " началось.",
                "deposit");

            RtfReporter rep = new RtfReporter(HttpContext.Current);
            rep.RoleList = "reporter,dpt_role,cc_doc";

            rep.ContractNumber = Convert.ToInt64(agr_uid);
            rep.TemplateID = template;
            OracleClob repText = new OracleClob(connect);

            try
            {
                rep.Generate();

                StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));

                char[] text = null;
                String str = sr.ReadToEnd();
                sr.Close();
                text = str.ToCharArray();

                File.Delete(rep.ReportFile);

                repText.Write(text, 0, text.Length);

                OracleCommand cmdInsDoc = connect.CreateCommand();

                cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdInsDoc.ExecuteNonQuery();

                cmdInsDoc.CommandText = "begin dpt_web.create_text(:template, :dptid, :adds, :txt); end;";
                cmdInsDoc.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("adds", OracleDbType.Decimal, add_id, ParameterDirection.Input);
                cmdInsDoc.Parameters.Add("txt", OracleDbType.Clob, repText, ParameterDirection.Input);
                cmdInsDoc.ExecuteNonQuery();
                cmdInsDoc.Dispose();
            }
            finally
            {
                repText.Close();
                repText.Dispose();

                rep.DeleteReportFiles();
            }

            DBLogger.Debug("Формирование доп. соглашения (тип = " +
                Convert.ToString(HttpContext.Current.Session["DPTPRINT_AGRID"]) + ") №" + add_id.ToString() +
                " по депозитному договору №" + this.ID.ToString() + " успешно завершилось.",
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        return add_id;
    }
    /// <summary>
    /// Процедура конвертации BIN -> HEX
    /// </summary>
    /// <param name="filename">Имя файла</param>
    private void ToHex(string filename)
    {
        Process proc = Process.Start("ToHex.exe", filename);
        bool flagTerm = proc.WaitForExit(15000);
        if (!flagTerm)
        {
            proc.Kill();
            throw new Exception("Процесс 'ToHex.exe' не завершил работу в отведенное время (15 сек)");
        }
    }
    /// <summary>
    /// Процедура конвертации HEX -> BIN
    /// </summary>
    /// <param name="filename">Имя файла</param>
    private void ToBin(string filename)
    {
        Process proc = Process.Start("ToBin.exe", filename);
        bool flagTerm = proc.WaitForExit(15000);
        if (!flagTerm)
        {
            proc.Kill();
            throw new Exception("Процесс 'ToBin.exe' не завершил работу в отведенное время (15 сек)");
        }
    }
    /// <summary>
    /// Процедура розпаковки файла
    /// </summary>
    /// <param name="filename">имя файла</param>
    /// <param name="extractPath">розпакованый</param>
    private void Unpack(string filename, string extractPath)
    {
        string args = "-extract -over=all -path=specify -nofix -silent -NoZipExtension "
            + filename + " " + extractPath;
        ProcessStartInfo psinfo = new ProcessStartInfo("pkzip25.exe", args);
        psinfo.UseShellExecute = false;
        psinfo.RedirectStandardError = true;
        Process proc = Process.Start(psinfo);
        string strError = proc.StandardError.ReadToEnd();
        bool flagTerm = proc.WaitForExit(15000);
        if (!flagTerm)
        {
            proc.Kill();
            throw new Exception(
                "Процесс 'pkzip25.exe' не завершил работу в отведенное время (15 сек)");
        }
        int nExitCode = proc.ExitCode;
        if (0 != nExitCode)
        {
            throw new Exception(
                "Процесс 'pkzip25.exe' аварийно завершил работу. Код " + nExitCode + "."
                + "Описание ошибки: " + strError);
        }
    }
    /// <summary>
    /// Процедура упаковки файла
    /// </summary>
    /// <param name="fileName">имя файла</param>
    /// <param name="archiveName">запакованый</param>
    private void Pack(string fileName, string archiveName)
    {
        string args = "-add " + archiveName + " " + fileName;
        ProcessStartInfo psinfo = new ProcessStartInfo("pkzip25.exe", args);
        psinfo.UseShellExecute = false;
        psinfo.RedirectStandardError = true;
        Process proc = Process.Start(psinfo);
        string strError = proc.StandardError.ReadToEnd();
        bool flagTerm = proc.WaitForExit(15000);
        if (!flagTerm)
        {
            proc.Kill();
            throw new Exception(
                "Процесс 'pkzip25.exe' не завершил работу в отведенное время (15 сек)");
        }
        int nExitCode = proc.ExitCode;
        if (0 != nExitCode)
        {
            throw new Exception(
                "Процесс 'pkzip25.exe' аварийно завершил работу. Код " + nExitCode + "."
                + "Описание ошибки: " + strError);
        }
    }
    /// <summary>
    /// Читанння договору з БД (тільки для активних договорів)
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void ReadFromDatabase()
    {
        ReadFromDatabaseExt(true, false, false);
    }

    /// <summary>
    /// Читання з БД параметрів депозитного договору
    /// </summary>
    /// <param name="active">Ознака активності договору (чи відкритий)</param>
    /// <param name="other">Ознака роботи з договором іншого підрозділу</param>
    public void ReadFromDatabase_EX(bool active, bool other)
    {
        ReadFromDatabaseExt(active, other, false);
    }
    
    /// <summary>
    /// Читання з БД параметрів договору
    /// </summary>
    /// <param name="active">Ознака активності договору (чи відкритий)</param>
    /// <param name="other">Ознака роботи з договором іншого підрозділу</param>
    /// <param name="all">Всі активні депозити (для режиму ReadOnly)</param>
    public void ReadFromDatabaseExt(bool active, bool other, bool all)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Чтение из базы депозитного договора №" + this.ID.ToString() + " началось.",
                "deposit");

            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdDepositInfo = connect.CreateCommand();

            cmdDepositInfo.CommandText = @"SELECT CUST_ID,VIDD_CODE,VIDD_NAME,DPT_NUM,DPT_DAT,DAT_BEGIN,DAT_END,DPT_COMMENTS,
                INTRCP_NAME,INTRCP_IDCODE,INTRCP_ACC,INTRCP_MFO,DPTRCP_NAME,DPTRCP_IDCODE,DPTRCP_ACC,DPTRCP_MFO,
                RATE,DPT_STATUS,DPT_CURID,DPT_CURNAME,DPT_CURCODE,DPT_CUR_DENOM,DPT_AMOUNT,
                DPT_SALDO,DPT_SALDO_PL,INT_SALDO,INT_SALDO_PL,
                DPT_ACCID,DPT_ACCNUM,DPT_ACCNAME,INT_ACCID,INT_ACCNUM,INT_ACCNAME, DPT_NOCASH ";
            
            if (active)
            {
                if (all)
                {
                    cmdDepositInfo.CommandText += " ,fl_int_payoff,fl_avans_payoff from v_dpt_portfolio_all_active ";
                }
                else
                {
                    if (other)
                        cmdDepositInfo.CommandText += ", fl_int_payoff, fl_avans_payoff from v_dpt_portfolio_other ";
                    else
                        cmdDepositInfo.CommandText += ", fl_int_payoff, fl_avans_payoff from v_dpt_portfolio_active ";
                }
            }
            else
            {
                cmdDepositInfo.CommandText += ", 0, 0 from v_dpt_portfolio ";
            }

            cmdDepositInfo.CommandText += " where DPT_ID = :dptid ";

            cmdDepositInfo.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

            // Читаем результаты запроса
            OracleDataReader rdr = cmdDepositInfo.ExecuteReader();
            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    this.Client.ID = rdr.GetOracleDecimal(0).Value;
                if (!rdr.IsDBNull(1))
                    this.Type = rdr.GetOracleDecimal(1).Value;
                if (!rdr.IsDBNull(2))
                    this.TypeName = rdr.GetOracleString(2).Value;
                if (!rdr.IsDBNull(3))
                    this.Number = rdr.GetOracleString(3).Value;
                if (!rdr.IsDBNull(4))
                    this.Date = rdr.GetOracleDate(4).Value;
                if (!rdr.IsDBNull(5))
                    this.BeginDate = rdr.GetOracleDate(5).Value;
                if (!rdr.IsDBNull(6))
                    this.EndDate = rdr.GetOracleDate(6).Value;
                if (!rdr.IsDBNull(7))
                    this.Comment = rdr.GetOracleString(7).Value;

                if (!rdr.IsDBNull(8))
                    this.IntReceiverName = rdr.GetOracleString(8).Value;
                if (!rdr.IsDBNull(9))
                    this.IntReceiverOKPO = rdr.GetOracleString(9).Value;
                if (!rdr.IsDBNull(10))
                    this.IntReceiverAccount = rdr.GetOracleString(10).Value;
                if (!rdr.IsDBNull(11))
                    this.IntReceiverMFO = rdr.GetOracleString(11).Value;
                if (!rdr.IsDBNull(12))
                    this.RestReceiverName = rdr.GetOracleString(12).Value;
                if (!rdr.IsDBNull(13))
                    this.RestReceiverOKPO = rdr.GetOracleString(13).Value;
                if (!rdr.IsDBNull(14))
                    this.RestReceiverAccount = rdr.GetOracleString(14).Value;
                if (!rdr.IsDBNull(15))
                    this.RestReceiverMFO = rdr.GetOracleString(15).Value;

                if (!rdr.IsDBNull(16))
                    this.RealIntRate = rdr.GetOracleDecimal(16).Value;
                if (!rdr.IsDBNull(17))
                    this.State = rdr.GetOracleDecimal(17).Value;
                if (!rdr.IsDBNull(18))
                    this.Currency = rdr.GetOracleDecimal(18).Value;
                if (!rdr.IsDBNull(19))
                    this.CurrencyName = rdr.GetOracleString(19).Value;
                if (!rdr.IsDBNull(20))
                    this.CurrencyISO = rdr.GetOracleString(20).Value;
                if (!rdr.IsDBNull(21))
                    this.Sum_denom = rdr.GetOracleDecimal(21).Value;
                else
                    throw new DepositException("Для договору №" + this.ID + " відсутній опис валюти");

                if (!rdr.IsDBNull(22))
                    this.Sum = rdr.GetOracleDecimal(22).Value / this.Sum_denom;
                if (!rdr.IsDBNull(23))
                    this.dpt_f_sum = rdr.GetOracleDecimal(23).Value / this.Sum_denom;
                if (!rdr.IsDBNull(24))
                    this.dpt_p_sum = rdr.GetOracleDecimal(24).Value / this.Sum_denom;
                if (!rdr.IsDBNull(25))
                    this.perc_f_sum = rdr.GetOracleDecimal(25).Value / this.Sum_denom;
                else
                    this.perc_f_sum = 0;
                if (!rdr.IsDBNull(26))
                    this.perc_p_sum = rdr.GetOracleDecimal(26).Value / this.Sum_denom;
                else
                    this.perc_p_sum = 0;

                if (!rdr.IsDBNull(27))
                    this.dpt_acc = rdr.GetOracleDecimal(27).Value;
                if (!rdr.IsDBNull(28))
                    this.dpt_nls = rdr.GetOracleString(28).Value;
                if (!rdr.IsDBNull(29))
                    this.dpt_nls_nms = rdr.GetOracleString(29).Value;
                if (!rdr.IsDBNull(30))
                    this.perc_acc = rdr.GetOracleDecimal(30).Value;
                if (!rdr.IsDBNull(31))
                    this.perc_nls = rdr.GetOracleString(31).Value;
                if (!rdr.IsDBNull(32))
                    this.perc_nls_nms = rdr.GetOracleString(32).Value;
                if (!rdr.IsDBNull(33))
                {
                    this.dpt_nocash = rdr.GetOracleString(33).Value;
                    if (this.dpt_nocash == "1") 
                        this.IsCashSum = false;
                    else
                        this.IsCashSum = true;
                }
                if (!rdr.IsDBNull(34))
                    this.fl_int_payoff = rdr.GetOracleDecimal(34).Value;
                if (!rdr.IsDBNull(35))
                    this.fl_avans_payoff = rdr.GetOracleDecimal(35).Value;
            }
            else
                throw new DepositException("Не найден депозитный договор №" + ID);

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            // Читаем параметры клиента
            Client.ReadFromDatabase();

            DBLogger.Debug("Чтение из базы депозитного договора №" + this.ID.ToString() + " успешно завершилось.",
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Читання дод. реквізитів 
    /// депозитного договору з бази
    /// </summary>
    public void ReadDptField()
    {
        this.DptField.Clear();
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetDptFields = connect.CreateCommand();
            cmdGetDptFields.CommandText = "select vf.tag, vf.obz, df.name " +
                "from dpt_vidd_field vf, dpt_field df " +
                "where vf.tag=df.tag and vf.vidd=:vidd";
            cmdGetDptFields.Parameters.Add("vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);

            DepositField dpt_field;
            String tag, obz, name;
            OracleDataReader rdr = cmdGetDptFields.ExecuteReader();
            while (rdr.Read())
            {
                tag = String.Empty;
                obz = String.Empty;
                name = String.Empty;

                if (!rdr.IsDBNull(0))
                    tag = Convert.ToString(rdr.GetOracleString(0).Value);
                if (!rdr.IsDBNull(1))
                    obz = Convert.ToString(rdr.GetOracleDecimal(1).Value);
                if (!rdr.IsDBNull(2))
                    name = Convert.ToString(rdr.GetOracleString(2).Value);

                dpt_field = new DepositField(tag, name, obz);
                this.DptField.Add(dpt_field);
            }

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            OracleCommand cmdGetDepositW = connect.CreateCommand();
            cmdGetDepositW.CommandText = "select value from dpt_depositw where dpt_id=:dpt_id and tag=:tag";

            for (int i = 0; i < this.DptField.Count; i++)
            {
                DepositField dpf = (DepositField)this.DptField[i];

                cmdGetDepositW.Parameters.Clear();
                cmdGetDepositW.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmdGetDepositW.Parameters.Add("tag", OracleDbType.Varchar2, dpf.Tag, ParameterDirection.Input);

                dpf.Val = Convert.ToString(cmdGetDepositW.ExecuteScalar());
            }


            DBLogger.Debug("Доп.реквизиты депозитного договора №" + this.ID.ToString() + " были успешно вычитаны из базы.",
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Зміна інформації про рахунки контракту
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void UpdateContractAccounts(HttpContext ctx)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Обновление счетов выплаты депозитного договора №" + this.ID.ToString() + " началось.",
                "deposit");
            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdDepositUpdate = new OracleCommand();
            cmdDepositUpdate.Connection = connect;
            cmdDepositUpdate.CommandText = "begin " +
                "dpt_web.change_deposit_accounts( " +
                ":DptID, " +
                ":IntRcpName, " +
                ":IntRcpIDCode, " +
                ":IntRcpAcc, " +
                ":IntRcpMFO, " +
                ":RestRcpName, " +
                ":RestRcpIDCode, " +
                ":RestRcpAcc, " +
                ":RestRcpMFO, " +
                ":Comment); " +
                "end;";
            // Привязываем переменные
            cmdDepositUpdate.Parameters.Add("DptID", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("IntRcpName", OracleDbType.Varchar2, this.IntReceiverName, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("IntRcpIDCode", OracleDbType.Varchar2, this.IntReceiverOKPO, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("IntRcpAcc", OracleDbType.Varchar2, this.IntReceiverAccount, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("IntRcpMFO", OracleDbType.Varchar2, this.IntReceiverMFO, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("RestRcpName", OracleDbType.Varchar2, this.RestReceiverName, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("RestRcpIDCode", OracleDbType.Varchar2, this.RestReceiverOKPO, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("RestRcpAcc", OracleDbType.Varchar2, this.RestReceiverAccount, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("RestRcpMFO", OracleDbType.Varchar2, this.RestReceiverMFO, ParameterDirection.Input);
            cmdDepositUpdate.Parameters.Add("Comment", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);
            // Выполняем
            cmdDepositUpdate.ExecuteNonQuery();

            DBLogger.Debug("Обновление счетов выплаты депозитного договора №" + this.ID.ToString() + " успешно завершилось.",
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Получение файла с текстом договора
    /// </summary>
    /// <param name="ctx">контекст</param>
    /// <returns>Имя файла</returns>
    public string  CreateContractTextFile(HttpContext ctx)
    {
        OracleConnection connect = new OracleConnection();

        string TempDir = string.Empty;
        string TempFile = string.Empty;
        OracleClob clob = null;

        try
        {
            DBLogger.Debug("Пользователь дал запрос на чтение из базы текста депозитного договора №" + this.ID.ToString(),
                "deposit");

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            

            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            String mainDir = Path.GetTempPath() + "dir\\";
            if (!Directory.Exists(mainDir))
                Directory.CreateDirectory(mainDir);

            TempDir = mainDir + ctx.Session.SessionID;
            TempFile = TempDir + "\\report.rtf";

            OracleCommand cmdSelectContractText = new OracleCommand();
            cmdSelectContractText.Connection = connect;
            cmdSelectContractText.InitialLONGFetchSize = 1000000;

            if (ctx.Session["DPTPRINT_TEMPLATE"] == null)
            {
                cmdSelectContractText.CommandText = "select nd, text,id,version,adds from cc_docs where nd = :dptid and adds=0 order by version desc";
                cmdSelectContractText.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            }
            else
            {
                cmdSelectContractText.CommandText = "select nd, text,id,version,adds from cc_docs where nd = :dptid and id=:template and adds=0 order by version desc";
                cmdSelectContractText.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                cmdSelectContractText.Parameters.Add("template", OracleDbType.Varchar2, Convert.ToString(ctx.Session["DPTPRINT_TEMPLATE"]), ParameterDirection.Input);
            }
            // Читаем результаты
            OracleDataReader rdr = cmdSelectContractText.ExecuteReader();

            if (!rdr.Read())
                throw new Exception("Текст договору відсутній. Сформуйте текст договору.");

            Directory.CreateDirectory(TempDir);

            clob = rdr.GetOracleClob(1);
            char[] ContractText = clob.Value.ToCharArray();
            StreamWriter sw = new StreamWriter(TempFile, false, System.Text.Encoding.GetEncoding(1251));
            sw.Write(ContractText);
            sw.Close();

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            // Ищем файл RTF
            string[] reportfiles = Directory.GetFiles(TempDir, "report.rtf");
            if (reportfiles.Length < 1)
                throw new ApplicationException("Не знайдено файл договору!");

            DBLogger.Debug("Пользователь успешно вычитал из базы текст депозитного договора №" + this.ID.ToString(),
                "deposit");

            return reportfiles[0];
        }
        finally
        {
            if (clob != null)
            {
                clob.Close();
                clob.Dispose();
            }

            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Одержання верхнього колонтитула
    /// </summary>
    /// <param name="connect">конект до бази</param>
    /// <returns>Імя файлу</returns>
    public string CreateContractHeader(OracleConnection connect)
    {
        /// Поки не використовуємо
        return String.Empty;

        OracleCommand cmdSelTemplate = connect.CreateCommand();
        cmdSelTemplate.CommandText = "select id from dpt_vidd_scheme where vidd = :vidd and flags = :flag";
        cmdSelTemplate.Parameters.Add("vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
        cmdSelTemplate.Parameters.Add("flag", OracleDbType.Decimal, 1, ParameterDirection.Input);
        string template = (string)cmdSelTemplate.ExecuteScalar();

        RtfReporter rep = new RtfReporter(HttpContext.Current);
        rep.RoleList = "reporter,dpt_role,cc_doc";
        rep.ContractNumber = (long)this.ID;
        rep.TemplateID = template;

        string HeaderFile = string.Empty;

        try
        {
            rep.GenerateHeader();

            if (rep.HeaderFile == String.Empty)
                return String.Empty;

            String mainDir = Path.GetTempPath() + "dir\\";
            if (Directory.Exists(mainDir))
                Directory.Delete(mainDir, true);

            Directory.CreateDirectory(mainDir);

            HeaderFile = mainDir + "header.hdr";
            File.Copy(rep.HeaderFile, HeaderFile, true);
        }
        finally
        {
            rep.DeleteReportFiles();
        }

        return HeaderFile;
    }
    /// <summary>
    /// Одержання нижнього колонтитула
    /// </summary>
    /// <param name="connect">конект до бази</param>
    /// <returns>Імя файлу</returns>
    public string CreateContractFooter(OracleConnection connect)
    {
        /// Поки не використовуємо
         return String.Empty;

        //OracleCommand cmdSelTemplate = connect.CreateCommand();
        //cmdSelTemplate.CommandText = "select id from dpt_vidd_scheme where vidd = :vidd and flags = :flag";
        //cmdSelTemplate.Parameters.Add("vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
        //cmdSelTemplate.Parameters.Add("flag", OracleDbType.Decimal, 1, ParameterDirection.Input);
        //string template = (string)cmdSelTemplate.ExecuteScalar();

        //RtfReporter rep = new RtfReporter(HttpContext.Current);
        //rep.RoleList = "reporter,dpt_role,cc_doc";
        //rep.ContractNumber = (long)this.ID;
        //rep.TemplateID = template;

        //string FooterFile = string.Empty;

        //try
        //{
        //    rep.GenerateFooter();

        //    if (rep.FooterFile == String.Empty)
        //        return String.Empty;

        //    String mainDir = Path.GetTempPath() + "dir\\";
        //    if (Directory.Exists(mainDir))
        //        Directory.Delete(mainDir, true);

        //    Directory.CreateDirectory(mainDir);

        //    FooterFile = mainDir + "footer.hdr";
        //    File.Copy(rep.FooterFile, FooterFile, true);
        //}
        //finally
        //{
        //    rep.DeleteReportFiles();
        //}

        //return FooterFile;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="connect"></param>
    /// <returns></returns>
    public string CreateContractFooterText(OracleConnection connect)
    {
        OracleCommand cmdSelTemplate = connect.CreateCommand();
        cmdSelTemplate.CommandText = "select fio || ' - ' || to_char(sysdate,'dd/mm/yyyy hh:mi:ss') from staff where id = user_id";
        return Convert.ToString(cmdSelTemplate.ExecuteScalar());
    }
    /// <summary>
    /// Получение доп. соглашения
    /// </summary>
    /// <param name="ctx">контекст</param>
    /// <returns>имя текстового файла</returns>
    public string CreateAddAgreementTextFile(HttpContext ctx)
    {
        OracleConnection connect = new OracleConnection();

        string TempDir = string.Empty;
        string TempFile = string.Empty;

        Decimal add_num = Convert.ToDecimal(Convert.ToString(ctx.Session["DPTPRINT_AGRNUM"]));
        String template = Convert.ToString(ctx.Session["DPTPRINT_TEMPLATE"]);
        OracleClob clob = null;

        try
        {
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            String mainDir = Path.GetTempPath() + "dir\\";
            if (!Directory.Exists(mainDir))
                Directory.CreateDirectory(mainDir);

            TempDir = mainDir + ctx.Session.SessionID;
            TempFile = TempDir + "\\report.rtf";

            DBLogger.Debug("Пользователь дал запрос на чтение из базы текста доп. соглашения №" + add_num.ToString() +
                " для депозитного договора №" + this.ID.ToString(),
                "deposit");

            OracleCommand cmdSelectContractText = new OracleCommand();
            cmdSelectContractText.Connection = connect;
            cmdSelectContractText.InitialLONGFetchSize = 5000000;
            cmdSelectContractText.CommandText = "select nd, text,id,version,adds from cc_docs where nd = :dptid and adds = :adds and id = :id";
            cmdSelectContractText.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmdSelectContractText.Parameters.Add("adds", OracleDbType.Decimal, add_num, ParameterDirection.Input);
            cmdSelectContractText.Parameters.Add("id", OracleDbType.Varchar2, template, ParameterDirection.Input);
            // Читаем результаты
            OracleDataReader rdr = cmdSelectContractText.ExecuteReader();

            if (!rdr.Read())
                throw new ApplicationException("Текст додаткової угоди по договору відсутній. Сформуйте текст додаткової угоди.");

            Directory.CreateDirectory(TempDir);

            clob = rdr.GetOracleClob(1);
            char[] ContractText = clob.Value.ToCharArray();
            StreamWriter sw = new StreamWriter(TempFile, false, System.Text.Encoding.GetEncoding(1251));
            sw.Write(ContractText);
            sw.Close();

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (clob != null)
            {
                clob.Close();
                clob.Dispose();
            }

            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        string[] reportfiles = Directory.GetFiles(TempDir, "*.rtf");

        DBLogger.Debug("Пользователь успешно вычитал из базы текст доп. соглашения №" + add_num.ToString() +
            " для депозитного договора №" + this.ID.ToString(),
            "deposit");

        return reportfiles[0];
    }
    /// <summary>
    /// Очистка файлов контракта
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void ClearContractTextFile(HttpContext ctx)
    {
        bool success = false;
        try
        {
            Directory.Delete(Path.GetTempPath() + "dir\\", true);
            success = true;
        }
        catch
        {
            /// Давимо помилки при видаленні файлів з диска
            DBLogger.Warning("Тимчасові файли невдалося очистити!",
                "deposit");
        }

        if (success)
            DBLogger.Debug("Временные файлы были успешно очищены", "deposit");
    }
    /// <summary>
    /// Подписать контракт
    /// </summary>
    /// <param name="ctx">контекст</param>
    public void SignContract(HttpContext ctx)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь дал запрос на подписание депозитного договора №"
                + this.ID.ToString(), "deposit");
            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Формируем запрос
            OracleCommand cmdSignDeposit = new OracleCommand();
            cmdSignDeposit.Connection = connect;
            cmdSignDeposit.CommandText = "begin dpt_web.sign_deposit(:dptID); end;";
            cmdSignDeposit.Parameters.Add("dptID", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            // Выполяем запрос
            cmdSignDeposit.ExecuteNonQuery();

            DBLogger.Debug("Депозитный договор №" + this.ID.ToString() + " был успешно подписан",
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    public void SignContract(String template)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь дал запрос на подписание депозитного договора №"
                + this.ID.ToString() + ", шаблон = " + template, "deposit");

            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Формируем запрос
            OracleCommand cmdSignDeposit = new OracleCommand();
            cmdSignDeposit.Connection = connect;
            cmdSignDeposit.CommandText = "update cc_docs set state=2 " +
                "where id=:template and nd=:dpt_id and adds=0 and state=1";
            cmdSignDeposit.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
            cmdSignDeposit.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            // Выполяем запрос
            cmdSignDeposit.ExecuteNonQuery();

            DBLogger.Debug("Депозитный договор №" + this.ID.ToString() + " был успешно подписан",
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Проверка подписаности контракта
    /// </summary>
    /// <returns>подписан или нет</returns>
    public bool IsSign()
    {
        if (this.State == 0)
            return true;
        else
            return false;
    }
    /// <summary>
    /// Перевіряємо, чи по депозиту 
    /// є неопрацьовані запити
    /// </summary>
    /// <returns>true - є, false - немає</returns>
    public bool BonusRequestDone()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInsiderInfo = connect.CreateCommand();
            cmdGetInsiderInfo.CommandText = "select dpt_bonus.request_processing_done(:p_dptid) from dual";
            cmdGetInsiderInfo.Parameters.Add("p_dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

            String result = Convert.ToString(cmdGetInsiderInfo.ExecuteScalar());
            if (result == "Y")
            {
                DBLogger.Debug("По депозитному договору №"
                    + this.ID + " есть необработаные запросы.", "deposit");

                return true;
            }
            else
            {
                DBLogger.Debug("По депозитному договору №"
                    + this.ID + " нет необработаных запросов.", "deposit");

                return false;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static String GetDptNum(Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetDptNum = connect.CreateCommand();
            cmdGetDptNum.CommandText = @"select nd
              from dpt_deposit_clos d
             where d.deposit_id = :dpt_id
               and d.idupd      = (select max(d1.idupd) from dpt_deposit_clos d1
             where d1.deposit_id = d.deposit_id and d1.bdate <= bankdate)";
            cmdGetDptNum.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            return Convert.ToString(cmdGetDptNum.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public void ReverseAgreement(Decimal agr_uid)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();            

            //OracleCommand cmdSetRole = connect.CreateCommand();
            //cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            //cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdReverseAgreement = connect.CreateCommand();
            cmdReverseAgreement.CommandText = "begin dpt_web.p_reverse_agrement(:p_agr_id); end;";
            cmdReverseAgreement.Parameters.Add("p_agr_id", OracleDbType.Decimal, agr_uid, ParameterDirection.Input);

            cmdReverseAgreement.ExecuteNonQuery();

            DBLogger.Debug("Пользователь сторнировал доп. соглашение ид = " + agr_uid
                + " по депозитному договору №" + this.ID, "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    public void RollbackDeposit()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            Decimal NoCash = this.IsCashSum ? 0 : 1;

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_web.change_deposit_type(:p_dptid,:p_vidd,:p_amount,:p_nocash,0,:p_comment); end;";
            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmd.Parameters.Add("p_vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
            cmd.Parameters.Add("p_amount", OracleDbType.Decimal, this.Sum * this.Sum_denom, ParameterDirection.Input);
            cmd.Parameters.Add("p_nocash", OracleDbType.Decimal, NoCash, ParameterDirection.Input);
            cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            DBLogger.Debug("Пользователь изменил тип депозитного договора №"
                + this.ID, "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static bool BonusFixed(Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_bonus.bonus_fixed(:dpt_id) from dual";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return (res == "Y");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="ex"></param>
    public static void SaveException(System.Exception ex)
    {
        if (HttpContext.Current.Session != null)
        {
            HttpContext.Current.Session["AppError"] = ex;
        }
        else
        {
            string hash = HttpContext.Current.Request.UserAgent;
            hash += HttpContext.Current.Request.UserHostAddress;
            hash += HttpContext.Current.Request.UserHostName;

            string key = hash.GetHashCode().ToString();
            AppDomain.CurrentDomain.SetData(key, ex.Message);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="nls"></param>
    /// <param name="kv"></param>
    /// <returns>1 - cash, 0 - no or not exists</returns>   
    public static String AccountIsCash(String nls, String kv)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select IS_CASH_ACCOUNT(:NLS,:KV) from dual";
            cmd.Parameters.Add("NLS", OracleDbType.Varchar2, nls, ParameterDirection.Input);
            cmd.Parameters.Add("KV", OracleDbType.Decimal, kv, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public String GetRestTT()
    {
        String result = (this.RestReceiverMFO == BankType.GetOurMfo() ? 
            this.GetTT(DPT_OP.OP_23, CASH.NO) :
            this.GetTT(DPT_OP.OP_26, CASH.NO));

        if (AccountIsCard(this.RestReceiverMFO, this.RestReceiverAccount))
            //result = "TM3";
            result = this.GetTT(DPT_OP.OP_25, CASH.NO);

        return result;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public String GetIntTT()
    {
        String result = (this.IntReceiverMFO == BankType.GetOurMfo() ?
            this.GetTT(DPT_OP.OP_43, CASH.NO) :
            this.GetTT(DPT_OP.OP_46, CASH.NO));

        if (AccountIsCard(this.IntReceiverMFO, this.IntReceiverAccount))
            //result = "TM6";
            result = this.GetTT(DPT_OP.OP_45, CASH.NO);

        return result;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="mfo"></param>
    /// <param name="nls"></param>
    /// <returns></returns>
    public static bool AccountIsCard(String mfo, String nls)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_web.account_is_card(:mfo,:nls) from dual";
            cmd.Parameters.Add("mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input);
            cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return (res == "1");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    public static bool AccountIsCard(String nls)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_web.account_is_card(f_ourmfo,:nls) from dual";
            cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return (res == "1");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// перевірка на наявність зареєстрованих спадкоємців по депозиту
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static bool InheritedDeal(String dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_web.inherited_deal(:dpt_id) from dual";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return (res == "Y");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// перевірка на наявності депозиту в заставі по кредиту
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static bool Is_Pawn(String dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_web.dpt_is_pawn(:dpt_id) from dual";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            Int64 res = Convert.ToInt64(cmd.ExecuteScalar());

            return (res > 0);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
   
    
    /// <summary>
    /// розрахунок суми вкладу що належить вплатити спадкоємцю
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <param name="inherit_id"></param>
    /// <param name="acc_id"></param>
    /// <returns></returns>
    public static Decimal InheritRest(String dpt_id, String inherit_id, String acc_id, Decimal denom)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_web.inherit_rest(:dpt_id, :inherit_id, :acc_id) from dual";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmd.Parameters.Add("inherit_id", OracleDbType.Decimal, inherit_id, ParameterDirection.Input);
            cmd.Parameters.Add("acc_id", OracleDbType.Decimal, acc_id, ParameterDirection.Input);

            return (Convert.ToDecimal(Convert.ToString(cmd.ExecuteScalar())) / denom);          
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <param name="inherit_id"></param>
    /// <param name="acc_id"></param>
    /// <returns></returns>
    public static Decimal? InheritTax(String dpt_id, String inherit_id, Decimal denom)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt_web.get_inherit_tax(:dpt_id, :inherit_id) from dual";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmd.Parameters.Add("inherit_id", OracleDbType.Decimal, inherit_id, ParameterDirection.Input);

            String result = Convert.ToString(cmd.ExecuteScalar());

            if (String.IsNullOrEmpty(result))
                return null;
            else
                return (Convert.ToDecimal(result) / denom);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

    /// <summary>
    /// Ф-ція вирахування дати завершення депозитного договору(універсальна)
    /// </summary>
    /// <param name=""></param>
    /// <param name="p_vidd"></param>
    /// <returns></returns>
    public  DateTime? GetDateEnd(Decimal p_vidd)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select dpt.get_datend_uni(:p_datbeg, :p_mnthcnt, :p_dayscnt, :p_dptype , :p_custid ) from dual";
            cmd.Parameters.Add("p_datbeg", OracleDbType.Date, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_mnthcnt", OracleDbType.Decimal, 0, ParameterDirection.Input);
            cmd.Parameters.Add("p_dayscnt", OracleDbType.Decimal, 0, ParameterDirection.Input);
            cmd.Parameters.Add("p_dptype", OracleDbType.Decimal, p_vidd, ParameterDirection.Input);
            cmd.Parameters.Add("p_custid", OracleDbType.Decimal, this.Client.ID, ParameterDirection.Input);
           
            String result = Convert.ToString(cmd.ExecuteScalar());

            DBLogger.Info("dpt.get_datend_uni result =" + result, "deposit");

            if (String.IsNullOrEmpty(result))
                return null;
            else
                return (Convert.ToDateTime(result));
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="d_op"></param>
    /// <param name="c"></param>
    /// <returns></returns>
    public String GetTT(DPT_OP d_op, CASH c)
    {
        String tt = String.Empty;
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select op_type from v_dpt_vidd_tts where tt_id = :d_op and dpttype_id = :vidd and tt_cash = :tt_cash";
            cmd.Parameters.Add("d_op", OracleDbType.Decimal, d_op, ParameterDirection.Input);
            cmd.Parameters.Add("vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);
            cmd.Parameters.Add("tt_cash", OracleDbType.Decimal, c, ParameterDirection.Input);

            tt = Convert.ToString(cmd.ExecuteScalar());

            DBLogger.Debug("Для депозитного договора №" + this.ID + " была выбрана операция " + tt, "deposit");

            return tt;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="d_op"></param>
    /// <param name="t"></param>
    /// <returns></returns>
    public String GetTechTT(DPT_OP d_op, TECH_TYPE t)
    {
        String tt = String.Empty;
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            if (t == TECH_TYPE.TT_COMISS)
                cmd.CommandText = "select tt_comiss from v_techacc_operations where op_id = :d_op";
            else if (this.Currency == 980)
                cmd.CommandText = "select tt_main_nc from v_techacc_operations where op_id = :d_op";
            else
                cmd.CommandText = "select tt_main_fc from v_techacc_operations where op_id = :d_op";

            cmd.Parameters.Add("d_op", OracleDbType.Decimal, d_op, ParameterDirection.Input);

            tt = Convert.ToString(cmd.ExecuteScalar());

            DBLogger.Debug("Для депозитного договора №" + this.ID + " была выбрана операция " + tt, "deposit");

            return tt;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public Decimal GetViddMinSum()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select nvl(v.dpt_minsum * t.denom,0) from v_dpt_type v, tabval t where v.dpt_type = :dpt_vidd and V.CURRENCY_CODE = t.kv";
            cmd.Parameters.Add("dpt_vidd", OracleDbType.Decimal, this.Type, ParameterDirection.Input);

            return (Convert.ToDecimal(Convert.ToString(cmd.ExecuteScalar())));
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// Перевірка допустимості використання банківської операції для коду депозитної операції
    /// </summary>
    /// <param name="tt_"></param>
    /// <returns></returns>
    public static bool CheckTT(Decimal tt_id, String tt_, Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            
            cmd.CommandText = @"select count(*)
                from v_dpt_vidd_tts t, dpt_deposit d 
                where d.deposit_id = :dpt_id and d.vidd = t.dpttype_id
                and tt_id = :tt_id and op_type = :tt ";

            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmd.Parameters.Add("tt_id", OracleDbType.Decimal, tt_id, ParameterDirection.Input);
            cmd.Parameters.Add("tt", OracleDbType.Varchar2, tt_, ParameterDirection.Input);

            return (Convert.ToDecimal(Convert.ToString(cmd.ExecuteScalar())) > 0);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }
    /// <summary>
    /// Нарахування відсотків "наперед" по авансовому вкладу
    /// </summary>
    /// <param name="tt_"></param>
    /// <returns></returns>
    public static void MakeAvans(Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect= OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin dpt_web.advance_makeint (:p_dpt_id); end;";
            cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="tt_"></param>
    /// <returns></returns>
    public static void RefuseExtention(Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin dpt_web.fix_extcancel (:p_dptid); end;";
            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
   
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="d_op"></param>
    /// <param name="t"></param>
    /// <returns></returns>
    public static String GetDptTT(DPT_OP d_op, Decimal kv)
    {
        String tt = String.Empty;
        OracleConnection connect = new OracleConnection();

        OracleDataReader rdr = null;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select tt_main_nc, tt_main_fc from v_dpt_operations where op_id = :d_op";

            cmd.Parameters.Add("d_op", OracleDbType.Decimal, d_op, ParameterDirection.Input);

            rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (kv == (Decimal)DPT_KV.UAH)
                    tt = rdr.GetOracleString(0).Value;
                else
                    tt = rdr.GetOracleString(1).Value;
            }

            return tt;
        }
        finally
        {
            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static Decimal GetDptKv(Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select kv from dpt_deposit where deposit_id = :dpt_id";

            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            return Convert.ToDecimal(Convert.ToString(cmd.ExecuteScalar()));
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// определения вклада до востребования
    /// </summary>
    /// <param name="dpt_id">Ід депозиту</param>
    /// <returns>возвращает 1 - для текущих и пенсионных вкладов, 0 - для срочных вкладов</returns>
    public static bool IsDemandDpt(Decimal dpt_id)
    {
        Boolean _IsDemandDpt = false;
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select dpt_web.is_demandpt (:p_dptid) from dual";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            _IsDemandDpt = (Convert.ToString(cmd.ExecuteScalar()) == "0" ? false : true);

            return _IsDemandDpt;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static bool Close(Decimal dpt_id)
    {
        bool result = false;

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select dpt_web.closing_permitted (:dptid, 9) from dual";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            result = (Convert.ToDecimal(cmd.ExecuteScalar()) == 1 ? true : false);

            if (result)
            {
                cmd.Parameters.Clear();

                cmd.CommandText = "begin dpt_web.mark_to_close(:p_dptid); end;";

                cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                cmd.ExecuteNonQuery();                
            }

            return result;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    
    /// <summary>
    /// Донарахування %% при виплаті після завершення по системну дату
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    public static Decimal ChargeInterest(Decimal dpt_id)
    {
        return ChargeInterest(dpt_id, null);
    }
    
    /// <summary>
    /// Донарахування %% при виплаті після завершення по системну дату
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <param name="is_payoff"></param>
    public static Decimal ChargeInterest(Decimal dpt_id, Decimal? is_payoff)
    {
        if (BankType.GetDptBankType() == BANKTYPE.UPB)
            return 0;
        else
        {
            OracleConnection connect = new OracleConnection();
            Decimal return_sum = 0;

            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "dpt_charge_interest";

                cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_sum", OracleDbType.Decimal, return_sum, ParameterDirection.Output);
                cmd.Parameters.Add("is_payoff", OracleDbType.Decimal, is_payoff, ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                if (String.IsNullOrEmpty(Convert.ToString(cmd.Parameters["p_sum"].Value)) ||
                    Convert.ToString(cmd.Parameters["p_sum"].Value) == "null")
                    return_sum = 0;
                else
                {
                    try
                    {
                        return_sum = Convert.ToDecimal(Convert.ToString(cmd.Parameters["p_sum"].Value));
                    }
                    catch (InvalidCastException)
                    {
                        return_sum = 0;
                    }
                }

                return return_sum;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                    connect.Close(); connect.Dispose();
            }
        }
    }
    /// <summary>
    /// Донарахування %% по депозиту
    /// </summary>
    /// <param name="dpt_id"></param>
    public static void CheckCardPayoff(String payoff_type, String nls_a, Decimal kv, Decimal dpt_id, String tt )
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select op_type
                from v_dpt_vidd_tts t, dpt_deposit d 
                where d.deposit_id = :dpt_id and d.vidd = t.dpttype_id
                and tt_id in (";
            if (payoff_type == "D")
                cmd.CommandText += ((int)DPT_OP.OP_25).ToString() + ") ";
            else if (payoff_type == "P")
                cmd.CommandText += ((int)DPT_OP.OP_45).ToString() + ") ";                    

            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);            

            if (Convert.ToString(cmd.ExecuteScalar()) == tt)
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "select dpt_web.get_payoffcardacc('P', :nlsa, :kv) from dual";
                cmd.Parameters.Add("nlsa",OracleDbType.Varchar2, nls_a, ParameterDirection.Input);
                cmd.Parameters.Add("kv", OracleDbType.Decimal, kv, ParameterDirection.Input);

                String result = Convert.ToString(cmd.ExecuteScalar());

                if (String.IsNullOrEmpty(result))
                    throw new DepositException("По вкладу id=" + dpt_id + " відсутній картковий рахунок");
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// проверка допустимости возврата суммы вклада и процентов
    /// </summary>
    /// <param name="dpt_id"></param>
    public static void VerifyReturn(Decimal dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select dpt_web.verify_depreturn(:p_dptid, bankdate) from dual";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            cmd.ExecuteScalar();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// подтверждение запроса на отказ вкладчика от переоформления вклада 
    /// </summary>
    public static void VerifyExtention(Decimal dpt_id, VERIFY_STATUS status, String reason)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin dpt_web.verify_extcancel (:p_dptid, :p_state, :p_reason); end;";
            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_state", OracleDbType.Decimal, status, ParameterDirection.Input);
            cmd.Parameters.Add("p_reason", OracleDbType.Varchar2, reason, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

    /// <summary>
    /// Краткая проверка депозита на пополняемость
    /// </summary>
    /// <param name="dpt">депозит</param>
    /// <returns>возможно или нет пополнение</returns>
    public bool AddPaymentEnabled()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select o.tt from DPT_TTS_VIDD v, OP_RULES o, DPT_DEPOSIT d 
                where v.vidd = d.vidd and v.tt = o.tt and o.TAG = 'DPTOP' and o.val = '1' 
                and o.tt like 'DP%'   and d.deposit_id = :dpt_id";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

            /// Якщо не дозволено поповнення
            if (String.IsNullOrEmpty(Convert.ToString(cmd.ExecuteScalar())))
                return false;

            DBLogger.Debug("Вид депозитного договора № " + this.ID.ToString() + " допускает операцию пополнения.", "deposit");

            return true;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Проверка наличия первичного взноса на депозитном счету
    /// </summary>
    /// <param name="dpt">Депозит</param>
    /// <returns>сделан\не сделан</returns>
    public bool IS_FIRST_PAYMENT_DONE()
    {
        /// Якщо внесок безготівковий
        /// то не чекаємо коли його зроблять
        if (!this.IsCashSum) return true;

        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            
            OracleCommand cmdDepositInfo = new OracleCommand();
            cmdDepositInfo.Connection = connect;
            cmdDepositInfo.CommandText = "select a.ostb from dpt_deposit d, accounts a where d.deposit_id=:dpt_id and d.acc=a.acc";
            cmdDepositInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

            Decimal sum = Convert.ToDecimal(cmdDepositInfo.ExecuteScalar());

            if (Math.Abs(sum) >= this.Sum)
                return true;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
        return false;
    }
    
    /// <summary>
    /// Заповнення реквізитів повернення вкладу та %% даними карткового рахунка клієнта
    /// </summary>
    public Decimal SetDefaultReceiver()
    {
        Decimal quantity = 0;

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            
            connect = conn.GetUserConnection();

            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = @" select count(acc) from ACCOUNTS 
                where NLS like '2625%' and RNK = :p_rnk and KV = :p_kv and DAZS is Null ";

            cmdSQL.Parameters.Add("p_rnk", OracleDbType.Decimal, Client.ID, ParameterDirection.Input);
            cmdSQL.Parameters.Add("p_kv", OracleDbType.Decimal, this.Currency, ParameterDirection.Input);

            OracleDataReader rdr = cmdSQL.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    quantity = rdr.GetOracleDecimal(0).Value;
            }

            // якщо рах. 2625 в клієнта тільки один
            if (quantity == 1)
            {
                cmdSQL.CommandText = @"select NLS, NMS from ACCOUNTS 
                    where NLS like '2625%' and RNK = :p_rnk and KV = :p_kv and DAZS is Null ";
                
                rdr = cmdSQL.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        this.RestReceiverAccount = rdr.GetOracleString(0).Value;

                    if (!rdr.IsDBNull(1))
                        this.RestReceiverName = rdr.GetOracleString(1).Value;

                    // 
                    this.RestReceiverMFO = BankType.GetOurMfo();
                    this.RestReceiverOKPO = Client.Code;

                    // якщо вклад без капіталізації то виплата %% теж на рах.2625
                    if (this.IntCap == false)
                    {
                        this.IntReceiverMFO = this.RestReceiverMFO;
                        this.IntReceiverOKPO = this.RestReceiverOKPO;
                        this.IntReceiverAccount = this.RestReceiverAccount;
                        this.IntReceiverName = this.RestReceiverName;
                    }
                }
            }

            return quantity;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    public static Decimal GetProductCode(Decimal TypeCode)
    {
        Decimal Product_Code = 0;

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select TYPE_ID from DPT_VIDD where VIDD = :p_vidd";

            cmd.Parameters.Add("p_vidd", OracleDbType.Decimal, TypeCode, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    Product_Code = rdr.GetOracleDecimal(0).Value;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }

        return Product_Code;
    }
}
/// <summary>
/// Клас для роботи з дод. параметрами 
/// депозитного договору
/// (dpt_field)
/// </summary>
public class DepositField
{
    /// <summary>
    /// Таг дод. реквізита
    /// </summary>
    public String Tag;
    /// <summary>
    /// Найменування
    /// </summary>
    public String Nmk;
    /// <summary>
    /// Значення
    /// </summary>
    public String Val;
    /// <summary>
    /// Обовязковість
    /// </summary>
    public String Req;
    /// <summary>
    /// Конструктор
    /// </summary>
    /// <param name="_Tag">Таг</param>
    /// <param name="_Nmk">Найменування</param>
    /// <param name="Req">Обовязковість</param>
    public DepositField(String _Tag, String _Nmk, String _Req)
    {
        Tag = _Tag;
        Nmk = _Nmk;
        Req = _Req;
        Val = String.Empty;
    }
    /// <summary>
    /// Конструктор
    /// </summary>
    /// <param name="_Tag">Тег</param>
    /// <param name="_Val">Значення</param>
    public DepositField(String _Tag, String _Val)
    {
        Tag = _Tag;
        Nmk = String.Empty;
        Req = String.Empty;
        Val = _Val;
    }
}

/// <summary>
/// Клас для роботи з Додатковими Угодами (ДУ) до депозитного договору
/// </summary>
public class DepositAgreement
{
    /// <summary>
    /// Реєстрація додаткової угоди в БД
    /// </summary>
    /// <param name="DepositID">Ідентифікатор депозитного договору</param>
    /// <param name="AgreementCode">Код ДУ</param>
    /// <param name="CustomerRNK">РНК особи, що заключає дод. угоду (довірена особа або власник договору)</param>
    /// <param name="TrusteeRNK">РНК третьої особи, що реєструється по депозиту</param>
    /// <param name="TrusteeID"></param>
    /// <param name="TransferDPT">Реквізити рах. повернення депозиту</param>
    /// <param name="TransferINT">Реквізити рах. виплати відсотків</param>
    /// <param name="DatBegin"></param>
    /// <param name="DatEnd"></param>
    /// <param name="ComissRef">Референс операції утримання комісії</param>
    /// <param name="ComissReqID">Референс запиту на відміну комісії</param>
    /// <returns>Ідентифікатор Додаткової Угоди</returns>
    public static decimal Create( decimal DepositID, decimal AgreementCode, decimal CustomerRNK,
        decimal TrusteeRNK, decimal? TrusteeID, 
        string TransferDPT, string TransferINT, DateTime? DatBegin, DateTime? DatEnd, 
        decimal? ComissRef, decimal? ComissReqID )
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();
            
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dpt_web.create_agreement";
            cmd.BindByName = true;

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
            cmd.Parameters.Add("p_agrmnttype", OracleDbType.Decimal, AgreementCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_initcustid", OracleDbType.Decimal, CustomerRNK, ParameterDirection.Input);
            cmd.Parameters.Add("p_trustcustid", OracleDbType.Decimal, TrusteeRNK, ParameterDirection.Input);
            cmd.Parameters.Add("p_trustid", OracleDbType.Decimal, TrusteeID, ParameterDirection.Input);
            cmd.Parameters.Add("p_transferdpt", OracleDbType.Clob, TransferDPT, ParameterDirection.Input);
            cmd.Parameters.Add("p_transferint", OracleDbType.Clob, TransferINT, ParameterDirection.Input);
            cmd.Parameters.Add("p_datbegin", OracleDbType.Date, DatBegin, ParameterDirection.Input);
            cmd.Parameters.Add("p_datend", OracleDbType.Date, DatEnd, ParameterDirection.Input);

            // ***
            cmd.Parameters.Add("p_amountcash", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_amountcashless", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_ratereqid", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_ratedate", OracleDbType.Date, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomcount", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_docref", OracleDbType.Decimal, null, ParameterDirection.Input);

            cmd.Parameters.Add("p_comissref", OracleDbType.Decimal, ComissRef, ParameterDirection.Input);
            cmd.Parameters.Add("p_comissreqid", OracleDbType.Decimal, ComissReqID, ParameterDirection.Input);
            
            cmd.Parameters.Add("p_agrmntid", OracleDbType.Decimal, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            decimal AgreementID = ((OracleDecimal)cmd.Parameters["p_agrmntid"].Value).Value;

            DBLogger.Debug("Користувач створив ДУ #" + AgreementID.ToString() + " з кодом " + 
                AgreementCode.ToString() + " до депозитного договору #" + DepositID.ToString(), "deposit");
            
            return AgreementID;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Реєстрація додаткової угоди в БД
    /// </summary>
    /// <param name="DepositID">Ідентифікатор депозитного договору</param>
    /// <param name="AgreementCode">Код ДУ</param>
    /// <param name="CustomerRNK">РНК особи, що заключає дод. угоду (довірена особа або власник договору)</param>
    /// <param name="TrusteeRNK">РНК третьої особи, що реєструється по депозиту</param>
    /// <param name="TrusteeID"></param>
    /// <param name="TransferDPT">Реквізити рах. повернення депозиту</param>
    /// <param name="TransferINT">Реквізити рах. виплати відсотків</param>
    /// <param name="DatBegin"></param>
    /// <param name="DatEnd"></param>
    /// <param name="ComissRef">Референс операції утримання комісії</param>
    /// <param name="ComissReqID">Референс запиту на відміну комісії</param>
    /// <param name="Denomcount">Параметри доступу по довіреності</param>
    /// <param name="Denomamount">Сумма коштів, доступна по довіреності</param>
    /// <returns>Ідентифікатор Додаткової Угоди</returns>
    public static decimal Create(decimal DepositID, decimal AgreementCode, decimal CustomerRNK,
        decimal TrusteeRNK, decimal? TrusteeID,
        string TransferDPT, string TransferINT, DateTime? DatBegin, DateTime? DatEnd,
        decimal? ComissRef, decimal? ComissReqID, decimal? Denomcount, decimal? Denomamount)
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dpt_web.create_agreement";
            cmd.BindByName = true;

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
            cmd.Parameters.Add("p_agrmnttype", OracleDbType.Decimal, AgreementCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_initcustid", OracleDbType.Decimal, CustomerRNK, ParameterDirection.Input);
            cmd.Parameters.Add("p_trustcustid", OracleDbType.Decimal, TrusteeRNK, ParameterDirection.Input);
            cmd.Parameters.Add("p_trustid", OracleDbType.Decimal, TrusteeID, ParameterDirection.Input);
            cmd.Parameters.Add("p_transferdpt", OracleDbType.Clob, TransferDPT, ParameterDirection.Input);
            cmd.Parameters.Add("p_transferint", OracleDbType.Clob, TransferINT, ParameterDirection.Input);
            cmd.Parameters.Add("p_datbegin", OracleDbType.Date, DatBegin, ParameterDirection.Input);
            cmd.Parameters.Add("p_datend", OracleDbType.Date, DatEnd, ParameterDirection.Input);

            // ***
            cmd.Parameters.Add("p_amountcash", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_amountcashless", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_ratereqid", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_ratedate", OracleDbType.Date, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, Denomamount, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomcount", OracleDbType.Decimal, Denomcount, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmd.Parameters.Add("p_docref", OracleDbType.Decimal, null, ParameterDirection.Input);

            cmd.Parameters.Add("p_comissref", OracleDbType.Decimal, ComissRef, ParameterDirection.Input);
            cmd.Parameters.Add("p_comissreqid", OracleDbType.Decimal, ComissReqID, ParameterDirection.Input);

            cmd.Parameters.Add("p_agrmntid", OracleDbType.Decimal, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            decimal AgreementID = ((OracleDecimal)cmd.Parameters["p_agrmntid"].Value).Value;

            DBLogger.Debug("Користувач створив ДУ #" + AgreementID.ToString() + " з кодом " +
                AgreementCode.ToString() + " до депозитного договору #" + DepositID.ToString(), "deposit");

            return AgreementID;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Сума доступна до зняття довіреною особою
    /// </summary>
    /// <param name="DepositID">Ідентифікатор депозитного договору</param>
    /// <param name="TrusteeRNK">РНК довіреної особи</param>
    /// <returns></returns>
    public static Decimal GetAllowedAmount(Decimal DepositID, Decimal TrusteeRNK)
    {
        String flags = String.Empty;

        Decimal AllowedAmount = 0;

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select LPAD(to_char(da.DENOM_COUNT),4,'0'), da.DENOM_AMOUNT
                                  from DPT_AGREEMENTS da
                                 inner join DPT_TRUSTEE dt on (dt.id = da.trustee_id and dt.dpt_id = da.dpt_id)    
                                 where da.dpt_id = :p_dptid
                                   and da.agrmnt_type = 12
                                   and da.agrmnt_state = 1
                                   and da.date_end > TRUNC( SYSDATE ) 
                                   and dt.typ_tr = 'T'
                                   and dt.rnk_tr = :p_rnk 
                                   and dt.fl_act = 1";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, TrusteeRNK, ParameterDirection.Input);
            
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    flags = rdr.GetOracleString(0).Value;
                }

                if (!rdr.IsDBNull(1))
                {
                    // Якщо надано доступ на отримання коштів по завершенні або достроково
                    if (flags.Substring(1, 1).Equals("1") || flags.Substring(2, 1).Equals("1"))
                    {
                        AllowedAmount = rdr.GetOracleDecimal(1).Value;
                    }
                    else
                        throw new DepositException("Довіреній особі не надано право отримання коштів по договору!");
                }
            }
            else
                throw new DepositException("Не знайдено діючої ДУ про довіренісь на клієнта з РНК=" + TrusteeRNK.ToString());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }

        return AllowedAmount;
    }

    /// <summary>
    /// Доступні довіреній особі операції із договором
    /// </summary>
    /// <param name="DepositID">Ідентифікатор депозитного договору</param>
    /// <param name="TrusteeRNK">РНК довіреної особи</param>
    /// <param name="AllowedFlag1">Право отримувати виписки по депозиту</param>
    /// <param name="AllowedFlag2">Право отримати кошти по заершенні договору</param>
    /// <param name="AllowedFlag3">Право достроково розірвати договір</param>
    /// <param name="AllowedFlag4"></param>
    /// <param name="AllowedFlag5"></param>
    /// <param name="AllowedFlag5"></param>
    /// <param name="AllowedFlag6"></param>
    /// <param name="AllowedFlag7"></param>
    /// <param name="AllowedFlag8"></param>
    public static void GetAllowedFlags(
        Decimal DepositID, 
        Decimal TrusteeRNK,
        out Boolean? AllowedFlag1,
        out Boolean? AllowedFlag2, 
        out Boolean? AllowedFlag3,
        out Boolean? AllowedFlag4,
        out Boolean? AllowedFlag5,
        out Boolean? AllowedFlag6,
        out Boolean? AllowedFlag7,
        out Boolean? AllowedFlag8)
    {
        AllowedFlag1 = false;
        AllowedFlag2 = false;
        AllowedFlag3 = false;
        AllowedFlag4 = false;
        AllowedFlag5 = false;
        AllowedFlag6 = false;
        AllowedFlag7 = false;
        AllowedFlag8 = false;
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select LPAD(to_char(da.DENOM_COUNT),8,'0') from DPT_AGREEMENTS da
                                    inner join DPT_TRUSTEE dt on (dt.id = da.trustee_id and dt.dpt_id = da.dpt_id)    
                                    where da.dpt_id = :p_dptid
                                    and da.agrmnt_type = 12
                                    and da.agrmnt_state = 1
                                    and nvl(da.date_end,trunc(sysdate+1)) > TRUNC( SYSDATE )
                                    and dt.typ_tr = 'T'
                                    and dt.rnk_tr = :p_rnk 
                                    and dt.fl_act = 1";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, TrusteeRNK, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    String flags = rdr.GetOracleString(0).Value;

                    AllowedFlag1 = flags.Substring(0, 1).Equals("1");
                    AllowedFlag2 = flags.Substring(1, 1).Equals("1");
                    AllowedFlag3 = flags.Substring(2, 1).Equals("1");
                    AllowedFlag4 = flags.Substring(3, 1).Equals("1");
                    AllowedFlag5 = flags.Substring(4, 1).Equals("1");
                    AllowedFlag6 = flags.Substring(5, 1).Equals("1");
                    AllowedFlag7 = flags.Substring(6, 1).Equals("1");
                    AllowedFlag8 = flags.Substring(7, 1).Equals("1");
                }
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }
}

public enum DPT_OP
{
    /// <summary>
    /// Первинний внесок на деп.рахунок
    /// </summary>
    OP_0 = 0,
    /// <summary>
    /// Поповнення депозитного рахунку
    /// </summary>
    OP_1 = 1,
    /// <summary>
    /// Зняття з депозитного рахунку
    /// </summary>
    //OP_2 = 2, (не викор.)
    /// <summary>
    /// Виплата готівки з рах.нарах.%%
    /// </summary>
    OP_3 = 3,
    /// <summary>
    /// Перерахування безготівкою з рах.нарах.%%
    /// </summary>
    //OP_4 = 4, (не викор.)
    /// <summary>
    /// Перерахування коштів на інш.депозит
    /// </summary>
    OP_5 = 5,
    /// <summary>
    /// Штрафні операції
    /// </summary>
    OP_6 = 6,
    /// <summary>
    /// Викуп центів
    /// </summary>
    OP_7 = 7,
    /// <summary>
    /// Часткове зняття зі вкладу
    /// </summary>
    OP_8 = 8,
    /// <summary>
    /// Перерахування депозиту на картковий рах.
    /// </summary>
    OP_25 = 25,
    /// <summary>
    /// Перерахування відсотків на картковий рах.
    /// </summary>
    OP_45 = 45,   
    /// <summary>
    /// Повернення депозиту (готівкою)
    /// </summary>
    OP_21 = 21,
    /// <summary>
    /// Повернення депозиту (внутрібанк)
    /// </summary>
    OP_23 = 23,
    /// <summary>
    /// Повернення депозиту (міжбанк)
    /// </summary>
    OP_26 = 26,
    /// ---------------------------------------
    /// <summary>
    /// Виплата депозиту та відсотків на БПК
    /// </summary>
    OP_33 = 33,
    /// <summary>
    /// <summary>
    /// Виплата депозиту та відсотків на БПК (DKR) BRSMAIN-2689 Pavlenko 29/07/2014
    /// </summary>
    OP_34 = 34,
    /// <summary>
    /// <summary>
    /// Виплата валютного депозиту та відсотків в грн на кассу/2620 (сума більше/менше 150 000)  
    /// </summary>
    OP_35 = 35,
    /// <summary>
    /// Виплата відсотків (внутрібанк)
    /// </summary>
    OP_43 = 43,
    /// <summary>
    /// Виплата відсотків міжбанк
    /// </summary>
    OP_46 = 46,
    /// ---------------------------------------
    /// <summary>
    /// Техн.рах: Відкриття рахунку
    /// </summary>
    OP_195 = 195,
    /// <summary>
    /// Техн.рах: Поповнення готівкою
    /// </summary>
    OP_196 = 196,
    /// <summary>
    /// Техн.рах: Поповнення в ін.вал.безгот.
    /// </summary>
    OP_197 = 197,
    /// <summary>
    /// Техн.рах: Поповнення в ін.вал.безгот.
    /// </summary>
    OP_198 = 198,
    /// <summary>
    /// Техн.рах: Перерах.в нац.вал.(міжбанк)
    /// </summary>
    OP_199 = 199,
    /// <summary>
    /// Техн.рах: Перерах.в ін.вал.(міжбанк)
    /// </summary>
    OP_200 = 200,
    /// <summary>
    /// Техн.рах: Перерах.в нац.вал.(внутр.)
    /// </summary>
    OP_201 = 201,
    /// <summary>
    /// Техн.рах: Перерах.в ін.вал.(внутр.)
    /// </summary>
    OP_202 = 202,
    /// <summary>
    /// Техн.рах: Виплата готівкою
    /// </summary>
    OP_203 = 203
}

public enum CASH
{
    NO = 0,
    YES = 1
}

public enum TECH_TYPE
{
    TT_MAIN = 0,
    TT_COMISS = 1
}

public enum DPT_KV
{
    USD = 840,
    EUR = 978,
    UAH = 980,
    XAU = 959
}

public enum VERIFY_STATUS
{
    STORNO = -1,
    VISA = 1
}
