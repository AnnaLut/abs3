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
using Bars.Classes;

    /// <summary>
    /// Клас для роботи з депозитним договором
    /// </summary>
    public class SocialDeposit
    {
        /// <summary>
        /// Идентификатор депозита
        /// </summary>
        private decimal _ID;
        /// <summary>
        /// Цифровой код типа депозитного договора
        /// </summary>
        private decimal _Type;
        /// <summary>
        /// Наименование типа депозитного договора
        /// </summary>
        private string _TypeName;
        /// <summary>
        /// Номер договора
        /// </summary>
        private string _Number;
        /// <summary>
        /// Дата заключения договора
        /// </summary>
        private DateTime _Date;
        /// <summary>
        /// Дата начала депозита
        /// </summary>
        private DateTime _BeginDate;
        /// <summary>
        /// Дата завершения депозита
        /// </summary>
        private DateTime _EndDate;
        /// <summary>
        /// Сума договора
        /// </summary>
        private decimal _Sum;
        /// <summary>
        /// Валюта договора
        /// </summary>
        private decimal _Currency;
        /// <summary>
        /// Валюта договора (наименование)
        /// </summary>
        private string _CurrencyName;
        /// <summary>
        /// Валюта договора (ISO)
        /// </summary>
        private string _CurrencyISO;
        /// <summary>
        /// Признак внесения суммы наличными в кассу
        /// </summary>
        private bool _IsCashSum;
        /// <summary>
        /// Признак капитализации процентов
        /// </summary>
        private bool _IntCap;
        /// <summary>
        /// Ознака відкриття технічного рахунку
        /// </summary>
        private bool _GetTechAcc;
        /// <summary>
        /// Действующая процентная ставка
        /// </summary>
        private decimal _RealIntRate;
        /// <summary>
        /// Комментарий к договору
        /// </summary>
        private string _Comment;
        /// <summary>
        /// ФИО Получателя процентов
        /// </summary>
        private string _IntReceiverName;
        /// <summary>
        /// Идентификационный код получателя процентов
        /// </summary>
        private string _IntReceiverOKPO;
        /// <summary>
        /// Счет для перечисления процентов
        /// </summary>
        private string _IntReceiverAccount;
        /// <summary>
        /// МФО счета для перечисления процентов
        /// </summary>
        private string _IntReceiverMFO;
        /// <summary>
        /// МФО счета для перечисления процентов
        /// </summary>
        private string _RestReceiverName;
        /// <summary>
        /// Возврат депозита: Идентификационный код получателя
        /// </summary>
        private string _RestReceiverOKPO;
        /// <summary>
        /// Возврат депозита: счет получателя
        /// </summary>
        private string _RestReceiverAccount;
        /// <summary>
        /// Возврат депозита: МФО счета получателя
        /// </summary>
        private string _RestReceiverMFO;
        /// <summary>
        /// Состояние договора
        /// </summary>
        private decimal _State;
        /// <summary>
        /// Имя текстового файла контракта
        /// </summary>
        private string _ContractTextFile;
        /// <summary>
        /// Список дод. параметрів депозитного договору
        /// </summary>
        private ArrayList _DptField;
        /// <summary>
        /// Клиент 
        /// </summary>
        public Client Client;
        /// <summary>
        /// Орган соціального захисту
        /// </summary>
        private decimal _SocialAgancyID;
        private string _SocialAgancyName;
        /// <summary>
        /// Номер пенсійної справи
        /// </summary>
        private string _SocialNum;
        /// <summary>
        /// Номер технічного рахунку
        /// </summary>
        private string _SocialTechAcc;

        private string _SocialOutAcc;
        private string _SocialOutContractNum;

        public string SocialOutAcc
        {
            get { return this._SocialOutAcc; }
            set { this._SocialOutAcc = value; }
        }
        public string SocialOutContractNum
        {
            get { return this._SocialOutContractNum; }
            set { this._SocialOutContractNum = value; }
        }

        /// <summary>
        /// Идентификатор депозита
        /// </summary>
        public decimal ID
        {
            get { return this._ID; }
            set { this._ID = value; }
        }
        /// <summary>
        /// Орган соціального захисту
        /// </summary>
        public decimal SocialAgancyID
        {
            get { return this._SocialAgancyID; }
            set { this._SocialAgancyID = value; }
        }
        public string SocialAgancyName
        {
            get { return this._SocialAgancyName; }
            set { this._SocialAgancyName = value; }
        }
        /// <summary>
        /// Номер пенсійної справи
        /// </summary>
        public string SocialNum
        {
            get { return this._SocialNum; }
            set { this._SocialNum = value; }
        }
        /// <summary>
        /// Номер технічного рахунку
        /// </summary>
        public string SocialTechAcc
        {
            get { return this._SocialTechAcc; }
            set { this._SocialTechAcc = value; }
        }


        /// <summary>
        /// Цифровой код типа договора
        /// </summary>
        public decimal Type
        {
            get { return this._Type; }
            set { this._Type = value; }
        }

        /// <summary>
        /// Наименование типа договора
        /// </summary>
        public string TypeName
        {
            get { return this._TypeName; }
            set { this._TypeName = value; }
        }

        /// <summary>
        /// Номер договора
        /// </summary>
        public string Number
        {
            get { return this._Number; }
            set { this._Number = value; }
        }

        /// <summary>
        /// Дата заключения договора
        /// </summary>
        public DateTime Date
        {
            get { return this._Date; }
            set { this._Date = value; }
        }

        /// <summary>
        /// Валюта договора
        /// </summary>
        public decimal Currency
        {
            get { return this._Currency; }
            set { this._Currency = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public bool GetTechAcc
        {
            get { return this._GetTechAcc; }
            set { this._GetTechAcc = value; }
        }
        /// <summary>
        /// Валюта договора
        /// </summary>
        public string CurrencyName
        {
            get { return this._CurrencyName; }
            set { this._CurrencyName = value; }
        }

        /// <summary>
        /// Валюта договора (ISO)
        /// </summary>
        public string CurrencyISO
        {
            get { return this._CurrencyISO; }
            set { this._CurrencyISO = value; }
        }

        /// <summary>
        /// Дата начала депозита
        /// </summary>
        public DateTime BeginDate
        {
            get { return this._BeginDate; }
            set { this._BeginDate = value; }
        }

        /// <summary>
        /// Дата завершения депозита
        /// </summary>
        public DateTime EndDate
        {
            get { return this._EndDate; }
            set { this._EndDate = value; }
        }

        /// <summary>
        /// Сумма договора
        /// </summary>
        public decimal Sum
        {
            get { return this._Sum; }
            set { this._Sum = value; }
        }

        /// <summary>
        /// Признак наличного вноса в кассу
        /// </summary>
        public bool IsCashSum
        {
            get { return this._IsCashSum; }
            set { this._IsCashSum = value; }
        }

        /// <summary>
        /// Признак капитализации процентов 
        /// </summary>
        public bool IntCap
        {
            get { return this._IntCap; }
            set { this._IntCap = value; }
        }

        /// <summary>
        /// Действующая процентная ставка
        /// </summary>
        public decimal RealIntRate
        {
            get { return this._RealIntRate; }
            set { this._RealIntRate = value; }
        }

        /// <summary>
        /// Комментарий к договору
        /// </summary>
        public string Comment
        {
            get { return this._Comment; }
            set { this._Comment = value; }
        }

        /// <summary>
        /// Выплата процентов: ФИО получателя
        /// </summary>
        public string IntReceiverName
        {
            get { return this._IntReceiverName; }
            set { this._IntReceiverName = value; }
        }

        /// <summary>
        /// Выплата процентов: Идентификационный код получателя
        /// </summary>
        public string IntReceiverOKPO
        {
            get { return this._IntReceiverOKPO; }
            set { this._IntReceiverOKPO = value; }
        }

        /// <summary>
        /// Выплата процентов: Счет получателя
        /// </summary>
        public string IntReceiverAccount
        {
            get { return this._IntReceiverAccount; }
            set { this._IntReceiverAccount = value; }
        }

        /// <summary>
        /// Выплата процентов: МФО счета получателя
        /// </summary>
        public string IntReceiverMFO
        {
            get { return this._IntReceiverMFO; }
            set { this._IntReceiverMFO = value; }
        }

        /// <summary>
        /// Выплата депозита: ФИО получателя
        /// </summary>
        public string RestReceiverName
        {
            get { return this._RestReceiverName; }
            set { this._RestReceiverName = value; }
        }

        /// <summary>
        /// Выплата депозита: Идентификационный код получателя
        /// </summary>
        public string RestReceiverOKPO
        {
            get { return this._RestReceiverOKPO; }
            set { this._RestReceiverOKPO = value; }
        }

        /// <summary>
        /// Выплата депозита: Счет получателя
        /// </summary>
        public string RestReceiverAccount
        {
            get { return this._RestReceiverAccount; }
            set { this._RestReceiverAccount = value; }
        }

        /// <summary>
        /// Выплата депозита: МФО счета получателя
        /// </summary>
        public string RestReceiverMFO
        {
            get { return this._RestReceiverMFO; }
            set { this._RestReceiverMFO = value; }
        }

        /// <summary>
        /// Состояние депозита
        /// </summary>
        public decimal State
        {
            get { return this._State; }
            set { this._State = value; }
        }

        /// <summary>
        /// Список дод. параметрів депозитного договору
        /// </summary>
        public ArrayList DptField
        {
            get { return _DptField; }
            set { _DptField = value; }
        }
        /// <summary>
        /// Конструктор класса
        /// </summary>
        public SocialDeposit()
        {
            // Класс клиента
            this.Client = new Client();
            this.DptField = new ArrayList();
            // 
            this.Clear();
            this._ContractTextFile = string.Empty;
        }
        /// <summary>
        /// Метод очистки параметров депозита
        /// </summary>
        public void Clear()
        {
            // Сбрасываем состояние
            Client.Clear();
            //
            this.Type = decimal.MinValue;
            this.TypeName = string.Empty;
            this.Number = string.Empty;
            this.Date = DateTime.MinValue;
            this.Currency = decimal.MinValue;
            this.CurrencyName = string.Empty;
            this.CurrencyISO = string.Empty;
            this.Sum = decimal.MinValue;
            this.IsCashSum = true;
            this.IntCap = false;
            this.RealIntRate = decimal.MinValue;
            this.Comment = string.Empty;
            this.IntReceiverName = string.Empty;
            this.IntReceiverOKPO = string.Empty;
            this.IntReceiverAccount = string.Empty;
            this.IntReceiverMFO = string.Empty;
            this.RestReceiverName = string.Empty;
            this.RestReceiverOKPO = string.Empty;
            this.RestReceiverAccount = string.Empty;
            this.RestReceiverMFO = string.Empty;
            this.State = 0;
            this.DptField.Clear();
        }

        /// <summary>
        /// Запис договору в базу
        /// </summary>
        /// <param name="ctx">контекст</param>
        public void WriteToDatabase()
        {
            HttpContext ctx = HttpContext.Current;
            OracleConnection connect = new OracleConnection();

            try
            {
                DBLogger.Debug("Користувач почав запис депозитного договору для клієнта №"
                    + this.Client.ID.ToString(), "SocialDeposit");

                Client.WriteToDatabase();

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
                DBLogger.Debug("Почалась реєстрація депозитного договору для клиєнта №"
                    + this.Client.ID.ToString(), "SocialDeposit");
                WriteContract(connect);
                DBLogger.Debug("Депозитний договір бул успішно зареєстрований під номером "
                    + this.ID.ToString(), "SocialDeposit");
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
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

            cmdCreateContract.Parameters.Clear();
            cmdCreateContract.CommandType = CommandType.StoredProcedure;
            cmdCreateContract.CommandText = "dpt_social.create_contract";
            // Привязываем переменные
            cmdCreateContract.Parameters.Add("rnk", OracleDbType.Varchar2, this.Client.ID, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("type_id", OracleDbType.Varchar2, this.Type, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("agency_id", OracleDbType.Varchar2, this.SocialAgancyID, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("contract_num", OracleDbType.Varchar2, this.Number, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("contract_date", OracleDbType.Date, this.BeginDate, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("card_account", OracleDbType.Varchar2, this.SocialTechAcc, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("pension_num", OracleDbType.Varchar2, this.SocialNum, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("details", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);
            cmdCreateContract.Parameters.Add("acc", OracleDbType.Decimal, 0, ParameterDirection.Output);
            cmdCreateContract.Parameters.Add("contract_id", OracleDbType.Decimal, 0, ParameterDirection.Output);
            //cmdCreateContract.Parameters.Add("errmsg", OracleDbType.Varchar2, err, ParameterDirection.Output);
            
            // Выполняем
            cmdCreateContract.ExecuteNonQuery();
            // Читаем выходные параметры
            this.SocialOutAcc = Convert.ToString(cmdCreateContract.Parameters["acc"].Value);
            this.ID = Convert.ToDecimal(cmdCreateContract.Parameters["contract_id"].Value.ToString());

            cmdCreateContract.CommandType = CommandType.Text;
            cmdCreateContract.Parameters.Clear();
            cmdCreateContract.Parameters.Add("dpt_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            cmdCreateContract.CommandText = "select account_id,interest_id,account_number,interest_number from v_socialcontracts where contract_id=:dpt_id";
            OracleDataReader reader = cmdCreateContract.ExecuteReader();
            if(reader.Read())
            {
                this.RestReceiverName = Convert.ToString(reader.GetValue(0));
                this.IntReceiverName = Convert.ToString(reader.GetValue(1));
                this.RestReceiverAccount = Convert.ToString(reader.GetValue(2));
                this.IntReceiverAccount = Convert.ToString(reader.GetValue(3));
            }
            if (!reader.IsClosed) reader.Close();
            reader.Dispose();
            
            this.State = 9;
            cmdCreateContract.Dispose();
        }
        /// <summary>
        /// Запись в базу сформированого текста депозитного договора
        /// </summary>
        /// <param name="ctx">контекст</param>
        public void AddContractText(string[] _templates)
        {
            OracleConnection connect = new OracleConnection();
            try
            {
                DBLogger.Debug("Користувач розпочав формування пачки документів для договору №"
                    + this.ID.ToString(), "SocialDeposit");

                // Создаем соединение
                IOraConnection conn = (IOraConnection) HttpContext.Current.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД
                
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                decimal mainContractFlag = 0;

                foreach (string template in _templates)
                {
                    // Из шаблона создаем текст договора
                    RtfReporter rep = new RtfReporter(HttpContext.Current);
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
                        string result = Convert.ToString(cmdCkSign.ExecuteScalar());

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

                        // Формируем текст договора
                        rep.Generate();

                        StreamReader sr = new StreamReader(rep.ReportFile);
                        char[] text = null;
                        String str = sr.ReadToEnd();
                        sr.Close();
                        text = str.ToCharArray();

                        // Удаляем файл
                        File.Delete(rep.ReportFile);

                        // Пишем текст договора в БД
                        repText.Write(text, 0, text.Length);
                        OracleCommand cmdInsDoc = new OracleCommand();
                        Bars.Oracle.Connection mConn = new Connection();

                        cmdInsDoc.Connection = connect;
                        cmdInsDoc.CommandText = mConn.GetSetRoleCommand("REPORTER");
                        cmdInsDoc.ExecuteNonQuery();
                        cmdInsDoc.CommandText = mConn.GetSetRoleCommand("DPT_ROLE");
                        cmdInsDoc.ExecuteNonQuery();
                        cmdInsDoc.CommandText = mConn.GetSetRoleCommand("CC_DOC");
                        cmdInsDoc.ExecuteNonQuery();

                        cmdInsDoc.CommandText = "insert into cc_docs(id, nd, adds, text, version) values (:template, :dptid, :adds, :txt, sysdate)";
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
                DBLogger.Debug("Користувач завершив формування пачки документів для договору №" +
                    this.ID.ToString() + ".", "SocialDeposit");
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        /// <summary>
        /// Читанння договора з бази
        /// </summary>
        /// <param name="ctx">контекст</param>
        public void UpdateContarct(HttpContext ctx)
        {
            OracleConnection connect = new OracleConnection();
            try
            {
                DBLogger.Debug("Обновлення депозитного договору №" + this.ID.ToString() + " розпочалось.",
                    "SocialDeposit");

                // Создаем соединение
                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД
                

                // Устанавливаем роль
                OracleCommand cmd = new OracleCommand();
                cmd.Connection = connect;
                cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmd.ExecuteNonQuery();

                cmd.CommandText = "update social_contracts set "+
                                          "pension_num=:pension_num, " +
                                          "card_account=:card_accounts, "+
                                          "agency_id=:agency_id, "+
                                          "details=:details " +
                                          "where contract_id=:contract_id";
                cmd.Parameters.Add("pension_num", OracleDbType.Varchar2, this.SocialNum, ParameterDirection.Input);
                cmd.Parameters.Add("card_accounts", OracleDbType.Varchar2, this.SocialTechAcc, ParameterDirection.Input);
                cmd.Parameters.Add("agency_id", OracleDbType.Decimal, this.SocialAgancyID, ParameterDirection.Input);
                cmd.Parameters.Add("details", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);
                cmd.Parameters.Add("contract_id", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally 
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        public string CreateContractTextFile(HttpContext ctx)
        {
            OracleConnection connect = new OracleConnection();

            string TempDir = string.Empty;
            string TempFile = string.Empty;
            OracleClob clob = null;

            try
            {
                DBLogger.Debug("Пользователь дал запрос на чтение из базы текста депозитного договора №" + this.ID.ToString(),
                    "SocialDeposit");

                // Создаем соединение
                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД
                

                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                String mainDir = Path.GetTempPath() + "dir\\";
                if (!Directory.Exists(mainDir))
                    Directory.CreateDirectory(mainDir);

                TempDir = mainDir + ctx.Session.SessionID;
                TempFile = TempDir + "\\report.rtf";    

                // Запрос на чтение текста договора
                OracleCommand cmdSelectContractText = new OracleCommand();
                cmdSelectContractText.Connection = connect;
                cmdSelectContractText.InitialLONGFetchSize = 1000000;

                if (ctx.Request["template"] == null)
                {
                    cmdSelectContractText.CommandText = "select nd, text,id,version,adds from cc_docs where nd = :dptid and adds=0 order by version desc";
                    cmdSelectContractText.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                }
                else
                {
                    cmdSelectContractText.CommandText = "select nd, text,id,version,adds from cc_docs where nd = :dptid and id=:template and adds=0 order by version desc";
                    cmdSelectContractText.Parameters.Add("dptid", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
                    cmdSelectContractText.Parameters.Add("template", OracleDbType.Varchar2, Convert.ToString(ctx.Request["template"]), ParameterDirection.Input);
                }
                // Читаем результаты
                OracleDataReader rdr = cmdSelectContractText.ExecuteReader();

                if (!rdr.Read())
                    throw new Exception("ORA-20008:Договор не найден");

                // Сохраняем договор в файле
                Directory.CreateDirectory(TempDir);

                clob = rdr.GetOracleClob(1);
                char[] ContractText = clob.Value.ToCharArray();
                StreamWriter sw = new StreamWriter(TempFile);
                sw.Write(ContractText);
                sw.Close();

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();

            }
            finally
            {
                clob.Close();
                clob.Dispose();

                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            // Ищем файл RTF
            string[] reportfiles = Directory.GetFiles(TempDir, "*.rtf");

            DBLogger.Debug("Пользователь успешно вычитал из базы текст депозитного договора №" + this.ID.ToString(),
                "SocialDeposit");

            return reportfiles[0];
        }
        /// <summary>
        /// Процедура конвертации BIN -> HEX
        /// </summary>
        /// <param name="filename">Имя файла</param>
        public void ToHex(string filename)
        {
            Process proc = Process.Start("ToHex.exe", filename);
            bool flagTerm = proc.WaitForExit(15000);
            if (!flagTerm)
            {
                proc.Kill();
                throw new Exception("ORA-20002:Процесс 'ToHex.exe' не завершил работу в отведенное время (15 сек)");
            }
        }
        /// <summary>
        /// Процедура конвертации HEX -> BIN
        /// </summary>
        /// <param name="filename">Имя файла</param>
        public void ToBin(string filename)
        {
            Process proc = Process.Start("ToBin.exe", filename);
            bool flagTerm = proc.WaitForExit(15000);
            if (!flagTerm)
            {
                proc.Kill();
                throw new Exception("ORA-20003:Процесс 'ToBin.exe' не завершил работу в отведенное время (15 сек)");
            }
        }
        /// <summary>
        /// Процедура розпаковки файла
        /// </summary>
        /// <param name="filename">имя файла</param>
        /// <param name="extractPath">розпакованый</param>
        public void Unpack(string filename, string extractPath)
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
                    "ORA-20004:Процесс 'pkzip25.exe' не завершил работу в отведенное время (15 сек)");
            }
            int nExitCode = proc.ExitCode;
            if (0 != nExitCode)
            {
                throw new Exception(
                    "ORA-20005:Процесс 'pkzip25.exe' аварийно завершил работу. Код " + nExitCode + "."
                    + "Описание ошибки: " + strError);
            }
        }
        /// <summary>
        /// Процедура упаковки файла
        /// </summary>
        /// <param name="fileName">имя файла</param>
        /// <param name="archiveName">запакованый</param>
        public void Pack(string fileName, string archiveName)
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
                    "ORA-20006:Процесс 'pkzip25.exe' не завершил работу в отведенное время (15 сек)");
            }
            int nExitCode = proc.ExitCode;
            if (0 != nExitCode)
            {
                throw new Exception(
                    "ORA-20007:Процесс 'pkzip25.exe' аварийно завершил работу. Код " + nExitCode + "."
                    + "Описание ошибки: " + strError);
            }
        }
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
                    "SocialDeposit");
            }

            if (success)
                DBLogger.Debug("Временные файлы были успешно очищены", "SocialDeposit");
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ctx"></param>
        public void ReadFromDatabase(HttpContext ctx)
        {
			OracleConnection connect = new OracleConnection();

            try
            {
                // Создаем соединение
                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД
                

                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                // Запрос на чтение
                OracleCommand cmdDepositInfo = new OracleCommand();
                cmdDepositInfo.Connection = connect;
                cmdDepositInfo.CommandText = @"SELECT rnk 
                    FROM SOCIAL_CONTRACTS
                    WHERE contract_id = :id";
                cmdDepositInfo.Parameters.Add("id",OracleDbType.Decimal,this.ID,ParameterDirection.Input);

                this.Client.ID = Convert.ToDecimal(cmdDepositInfo.ExecuteScalar());
                               
                this.Client.ReadFromDatabase();
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
        /// <param name="ctx"></param>
        /// <returns></returns>
        public decimal WriteAddAgreement(HttpContext ctx)
        {
            return WriteAddAgreement(Convert.ToString(ctx.Request["agr_id"]),
                Convert.ToString(ctx.Request["template"]),null);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ctx"></param>
        /// <returns></returns>
        public decimal WriteAddAgreement(String agr_id, String template, String trust_id)
        {
            OracleConnection connect = new OracleConnection();
            Decimal add_id = Decimal.MinValue;
            HttpContext ctx = HttpContext.Current;

            try
            {
                // Создаем соединение
                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                // Открываем соединение с БД
                
                // Устанавливаем роль
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdGetDopNum = connect.CreateCommand();
                cmdGetDopNum.CommandText = "select nvl(max(adds),0) from cc_docs where nd = :nd";
                cmdGetDopNum.Parameters.Add("nd", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

                add_id = Convert.ToDecimal(cmdGetDopNum.ExecuteScalar().ToString()) + 1;

                DBLogger.Debug("Формирование доп. соглашения (тип = " +
                    agr_id + ") №" + add_id.ToString() +
                    " по депозитному договору №" + this.ID.ToString() + " началось.",
                    "SocialDeposit");

                RtfReporter rep = new RtfReporter(ctx);
                rep.RoleList = "reporter,dpt_role,cc_doc";

                if (trust_id != null)
                    rep.ContractNumber = Convert.ToInt64(trust_id);
                else
                    rep.ContractNumber = (long)this.ID;

                rep.TemplateID = template;
                OracleClob repText = new OracleClob(connect);

                try
                {
                    rep.Generate();

                    StreamReader sr = new StreamReader(rep.ReportFile);

                    char[] text = null;
                    String str = sr.ReadToEnd();
                    sr.Close();
                    text = str.ToCharArray();

                    File.Delete(rep.ReportFile);

                    repText.Write(text, 0, text.Length);

                    OracleCommand cmdInsDoc = connect.CreateCommand();

                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("REPORTER");
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("CC_DOC");
                    cmdInsDoc.ExecuteNonQuery();

                    cmdInsDoc.CommandText = "insert into cc_docs(id, nd, adds, text, version) values (:template, :dptid, :adds, :txt, sysdate)";
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
                    agr_id + ") №" + add_id.ToString() +
                    " по депозитному договору №" + this.ID.ToString() + " успешно завершилось.",
                    "SocialDeposit");
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
            return add_id;
        }
        /// <summary>
        /// Пишем доп. соглашение в базу
        /// </summary>
        /// <param name="ctx">контекст</param>
        public decimal WriteAddAgreement(HttpContext ctx, String[] _params)
        {
            OracleConnection connect = new OracleConnection();
            Decimal add_id = Decimal.MinValue;

            try
            {
                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                

                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdGetDopNum = connect.CreateCommand();
                cmdGetDopNum.CommandText = "select nvl(max(adds),0) from cc_docs where nd = :nd";
                cmdGetDopNum.Parameters.Add("nd", OracleDbType.Decimal, this.ID, ParameterDirection.Input);

                add_id = Convert.ToDecimal(cmdGetDopNum.ExecuteScalar().ToString()) + 1;

                string template = Convert.ToString(ctx.Request["template"]);

                DBLogger.Debug("Формирование доп. соглашения (тип = " +
                    Convert.ToString(ctx.Request["agr_id"]) + ") №" + add_id.ToString() +
                    " по депозитному договору №" + this.ID.ToString() + " началось.",
                    "SocialDeposit");

                // Из шаблона создаем текст договора
                RtfReporter rep = new RtfReporter(ctx);
                rep.RoleList = "reporter,dpt_role,cc_doc";

                if (_params[0] != null)
                    rep.ContractNumber = Convert.ToInt64(_params[0]);
                else
                    rep.ContractNumber = (long)this.ID;

                rep.TemplateID = template;
                OracleClob repText = new OracleClob(connect);

                try
                {
                    // Формируем текст договора
                    rep.Generate();

                    StreamReader sr = new StreamReader(rep.ReportFile);
                    char[] text = null;
                    String str = sr.ReadToEnd();
                    sr.Close();
                    text = str.ToCharArray();

                    // Удаляем файл
                    File.Delete(rep.ReportFile);

                    // Пишем текст договора в БД
                    repText.Write(text, 0, text.Length);

                    OracleCommand cmdInsDoc = connect.CreateCommand();

                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("REPORTER");
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("CC_DOC");
                    cmdInsDoc.ExecuteNonQuery();

                    cmdInsDoc.CommandText = "insert into cc_docs(id, nd, adds, text, version) values (:template, :dptid, :adds, :txt, sysdate)";
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
                    Convert.ToString(ctx.Request["agr_id"]) + ") №" + add_id.ToString() +
                    " по депозитному договору №" + this.ID.ToString() + " началось.",
                    "SocialDeposit");
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
            return add_id;
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

            Decimal add_num = Convert.ToDecimal(Convert.ToString(ctx.Request["agr_num"]));
            String template = Convert.ToString(ctx.Request["template"]);
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
                    "SocialDeposit");

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
                    throw new ApplicationException("ORA-20008:Договор не найден");

                Directory.CreateDirectory(TempDir);
                if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
                {
                    clob = rdr.GetOracleClob(1);
                    char[] ContractText = clob.Value.ToCharArray();
                    StreamWriter sw = new StreamWriter(TempFile);
                    sw.Write(ContractText);
                    sw.Close();
                }
                else
                {
                    OracleBinary blob = rdr.GetOracleBinary(1);
                    byte[] ContractText = blob.Value;
                    FileStream fs = File.Create(TempFile);
                    fs.Write(ContractText, 0, ContractText.Length);
                    fs.Close();
                }

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                clob.Close();
                clob.Dispose();

                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            string[] reportfiles = Directory.GetFiles(TempDir, "*.rtf");

            DBLogger.Debug("Пользователь успешно вычитал из базы текст доп. соглашения №" + add_num.ToString() +
                " для депозитного договора №" + this.ID.ToString(),
                "SocialDeposit");

            return reportfiles[0];
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
                cmdGetDptNum.CommandText = "select contract_number from v_socialcontracts where contract_id = :dpt_id";
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
        /// <param name="d_op"></param>
        /// <param name="t"></param>
        /// <returns></returns>
        public static String GetSocTT(DPT_OP d_op)
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
                
                cmd.CommandText = "select tt_main_nc from v_soc_operations where op_id = :d_op";

                cmd.Parameters.Add("d_op", OracleDbType.Decimal, d_op, ParameterDirection.Input);

                tt = Convert.ToString(cmd.ExecuteScalar());

                return tt;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                    connect.Close(); connect.Dispose();
            }
        }
 }


