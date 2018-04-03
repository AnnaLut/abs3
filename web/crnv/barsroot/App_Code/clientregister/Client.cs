﻿using System;
using System.Data;
using System.Web;
using System.Globalization;
using Bars.Oracle;
using Bars.Classes;
using Oracle;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace clientregister
{
    public static class Common
    {
        private static CultureInfo _cinfo;
        public static CultureInfo cinfo
        {
            get
            {
                if (_cinfo == null) _cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                _cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                _cinfo.DateTimeFormat.DateSeparator = ".";

                return _cinfo;
            }
        }
    }

    public class CustomerAddress
    {
        public class Address
        {
            public Boolean filled = false;
            public String zip;
            public String domain;
            public String region;
            public String locality;
            public String address;
            public Decimal? territory_id;

            public Address()
            {
            }
            public Address(String zip, String domain, String region, String locality, String address, Decimal? territory_id)
            {
                this.filled = true;
                this.zip = zip;
                this.domain = domain;
                this.region = region;
                this.locality = locality;
                this.address = address;
                this.territory_id = territory_id;
            }
        }

        public Address type1;
        public Address type2;
        public Address type3;

        public CustomerAddress()
        {
            this.type1 = new Address();
            this.type2 = new Address();
            this.type3 = new Address();
        }
    }

    /// <summary>
    /// Класс для работы с клиентом
    /// </summary>
    public class Client : System.Object
    {
        public string EditType = "";		// Reg, ReReg, View - для чего открыто приложение
        public string ReadOnly = "false";	// Правка разрешена\запрещена
        public string ReadOnlyMode = "0";	// Тип ограничения функционала
        public string BANKDATE = "";		// Банковская дата
        public string Par_EN = "";			// Обязательное заполнение эк. нормативов

        public string CUSTTYPE = "";        // Тип клиента (person,corp,bank)

        // Осн. рквизиты
        public string DATE_ON = "";			// Дата регистрации
        public string DATE_OFF = "";		// Дата закрытия
        public string ID = "";				// Идентификатор
        public string ND = "";				// Номер договора
        public string NMK = "";			// Наименование или ФИО
        public string NMKV = "";           // Наименование (межд.)
        public string NMKK = "";           // Наименование (краткое)
        public string ADR = "";            // Адрес клиента
        public CustomerAddress fullADR = new CustomerAddress();        // Полний адрес клиента
        public string fullADRMORE = "";    // Дополнительные адреса (для юр лиц)
        public string CODCAGENT = "";      // Характеристика клиента (К010)
        public string COUNTRY = "";		// Цифровой код страны
        public string PRINSIDER = "";      // Признак инсайдера (К060)
        public string TGR = "";			// Тип гос. реестра
        public string STMT = "";			// Вид выписки
        public string OKPO = "";			// Идентификационный код
        public string SAB = "";			// Эликтронный код клиента
        public string BC = "";				// Признак не является клиентом банка (1)
        public string TOBO = "";			// ТОБО отделения
        public string PINCODE = "";		// Неизвесное поле(неисп.)


        // Рекв. налогопл.
        public string RNlPres = "";		// Рекв. налогопл. заполнены\не заполнены
        public string C_REG = "";			// Областная НИ
        public string C_DST = "";			// Районная НИ
        public string ADM = "";			// Адм. орган регистрации
        public string TAXF = "";			// Налоговый код (К050)
        public string RGADM = "";			// Рег. номер в Адм.
        public string RGTAX = "";			// Рег. номер в НИ
        public string DATET = "";			// Дата рег. в НИ
        public string DATEA = "";			// Дата рег. в Адм.

        // Экономические нормативы
        public string NEkPres = "";		// Экономические нормативы заполнены\не заполнены
        public string ISE = "";			// Инст. сек. экономики (К070)
        public string FS = "";				// Форма собственности (К080)
        public string VED = "";			// Вид эк. деятельности (К110)
        public string OE = "";				// Отрасль экономики (К090)
        public string K050 = "";			// Форма хозяйствования (К050)
        public string SED = "";			// Форма хозяйствования (К051)

        // Реквизиты клиента
        // -----(банк)-----
        public string MFO = "";				// Код банка - МФО
        public string ALT_BIC = "";			// Альтернативный 
        public string BIC = "";				// ВІС
        public string RATING = "";			// Рейтинг банка
        public string KOD_B = "";			// Для 1ПБ
        public string DAT_ND = "";			// Неизвесная дата
        public string NUM_ND = "";			// Номер геню. соглашения (неисп.)  
        // --(банк/юр.лицо)--
        public string RUK = "";				// Руководитель
        public string BUH = "";				// Гл. бухгалтер банка
        public string TELR = "";			// Телефон руководителя
        public string TELB = "";			// Телефон гл. бухгалтера
        // -----(юр.лицо)-----
        public string NMKU = "";			// Наименование по уставу
        public string fullACCS = "";		// Счета контрагента Юр.Лица
        public string E_MAIL = "";			// EMAIL
        public string TEL_FAX = "";			// Факс
        public string SEAL_ID = "";			// Ид. графического образа печати
        /*public string MAINMFO = "";		// Реквизиты в другом банке - МФО
        public string MAINNLS = "";			// Реквизиты в другом банке - ЛС
        public string MFONEW = "";			// Новые реквизиты - МФО
        public string NLSNEW = "";			// Новые реквизиты - ЛС*/
        // -----(физ.лицо)-----
        public string RCFlPres = "";		// Реквизиты клиента физ.лицо заполнены\не заполнены
        public string PASSP = "";			// Вид документа
        public string SER = "";				// Серия
        public string NUMDOC = "";			// Номер док.
        public string ORGAN = "";			// Кем выдан
        public string PDATE = "";			// Когда выдан
        public string BDAY = "";			// Дата рождения
        public string BPLACE = "";			// Место рождения
        public string SEX = "";				// Пол
        public string TELD = "";			// Телефон 1
        public string TELW = "";			// Телефон 2
        public string DOV = "";				// |
        public string BDOV = "";			// |Неизвесные поля(неисп.)
        public string EDOV = "";			// |

        // Доп информация
        public string ISP = "";			// Менеджер клиента (ответ. исполнитель)
        public string NOTES = "";		// Примечание
        public string CRISK = "";		// Класс заемщика
        public string MB = "";			// Принадлежность малому бизнесу
        public string ADR_ALT = "";		// Альтнрнативный адрес
        public string NOM_DOG = "";		// № дог. за сопровождение
        public string LIM_KASS = "";	// Лимит кассы
        public string LIM = "";			// Лимит на активніе операции
        public string NOMPDV = "";		// № в реестре плательщиков ПДВ
        public string RNKP = "";		// регистрационный № холдинга
        public string NOTESEC = "";		// Примечание для службы безопасности
        public string TrustEE = "";		// таблица довереных лиц

        // Доп реквизиты
        public string DopRekv = "";			// таблица доп реквизитов
//**************
        public string DopRekv_SN_LN = ""; //таблиця CUSTOMERW параметр SN_LN
        public string DopRekv_SN_FN = ""; //таблиця CUSTOMERW параметр SN_FN
        public string DopRekv_SN_MN = ""; //таблиця CUSTOMERW параметр SN_MN
        public string DopRekv_SN_4N = ""; //таблиця CUSTOMERW параметр SN_4N
//**************

        /// <summary>
        /// Методы использующиеся для получения каких либо данных
        /// Используеться в приложении регистрации клиента
        /// </summary>
        public class GetLists
        {
            //таблица довереных лиц
            public static DataTable GetTrusteeTable(HttpContext ctx, string ID)
            {
                // Сохраняем идентификатор
                decimal ClientID = decimal.Parse(ID);

                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                OracleConnection connect = conn.GetUserConnection();
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

                    command.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);
                    command.CommandText = @"SELECT t.ID, 
													t.FIO, 
													t.PASPORT as PASPORT, 
													to_char(t.BDATE,'dd.MM.yyyy') as BDATE, 
													to_char(t.EDATE,'dd.MM.yyyy') as EDATE, 
													t.DOCUMENT, 
													t.NOTARY_NAME, 
													t.NOTARY_REGION, 
													t.TRUST_REGNUM, 
													to_char(t.TRUST_REGDAT,'dd.MM.yyyy') as TRUST_REGDAT, 
													t.OKPO, 
													t.DOC_TYPE, 
													t.DOC_SERIAL, 
													t.DOC_NUMBER, 
													to_char(t.DOC_DATE,'dd.MM.yyyy') as DOC_DATE, 
													t.DOC_ISSUER, 
													to_char(t.BIRTHDAY,'dd.MM.yyyy') as BIRTHDAY, 
													t.BIRTHPLACE,
													t.TYPE_ID,
													tt.NAME,
													t.DOCUMENT_TYPE_ID,
													tdt.NAME as NAME_DOC,
													t.POSITION,
													t.FIRST_NAME,
													t.MIDDLE_NAME,
													t.LAST_NAME,
													t.SEX as SEX_ID,
													s.NAME as SEX,
													t.TEL,
													t.SIGN_PRIVS,
													t.NAME_R,
													t.SIGN_ID 
													FROM TRUSTEE t, TRUSTEE_TYPE tt, TRUSTEE_DOCUMENT_TYPE tdt, SEX s 
													WHERE rnk = :rnk 
													and t.TYPE_ID = tt.ID 
													and t.DOCUMENT_TYPE_ID = tdt.ID 
													and t.SEX = s.ID";

                    adapter.Fill(dt);
                    adapter.Dispose();
                }
                finally
                {
                    connect.Close();
                    connect.Dispose();
                }

                return dt;
            }
            //таблица счетов котрагента - юрлица
            public static DataTable GetACCSTable(HttpContext ctx, string ID)
            {
                // Сохраняем идентификатор
                decimal ClientID = decimal.Parse(ID);

                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                OracleConnection connect = conn.GetUserConnection(ctx);
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

                    command.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);
                    command.CommandText = "SELECT ID, MFO, NLS, KV, COMMENTS FROM CORPS_ACC WHERE RNK = :rnk";

                    adapter.Fill(dt);
                    adapter.Dispose();
                }
                finally
                {
                    connect.Close();
                    connect.Dispose();
                }

                return dt;
            }
            //таблица адресов котрагента - юрлица
            public static DataTable GetADRTable(HttpContext ctx, string ID)
            {
                // Сохраняем идентификатор
                decimal ClientID = decimal.Parse(ID);

                IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
                OracleConnection connect = conn.GetUserConnection();
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

                    command.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);
                    command.CommandText = @"SELECT a.TYPE_ID, ta.NAME, a.COUNTRY, a.ZIP, a.DOMAIN, a.REGION, a.LOCALITY, a.ADDRESS 
											FROM CUSTOMER_ADDRESS a, CUSTOMER_ADDRESS_TYPE ta
											WHERE a.RNK = :rnk and a.TYPE_ID <> 1 and a.TYPE_ID = ta.ID";

                    adapter.Fill(dt);
                    adapter.Dispose();
                }
                finally
                {
                    connect.Close();
                    connect.Dispose();
                }

                return dt;
            }
            // Проверка ОКПО
            public static string V_OKPO(System.Web.HttpContext Context, string OKPO)
            {
                string okp = "";

                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;
                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.Parameters.Add("pOkpo", OracleDbType.Varchar2, OKPO, ParameterDirection.Input);
                    cmd.CommandText = "SELECT V_OKPO(:pOkpo) " +
                        "FROM dual";

                    OracleDataReader MyReader = cmd.ExecuteReader();
                    if (MyReader.Read())
                    {
                        okp = MyReader.GetString(0);
                    }
                    else okp = string.Empty;
                    MyReader.Close();
                    MyReader.Dispose();
                }
                finally
                {
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return okp;
            }
            // Банковская дата
            public static DateTime GetBankDate(System.Web.HttpContext Context)
            {
                DateTime MyDate = new DateTime();
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;
                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT bankdate_g FROM dual";
                }
                finally
                {
                    OracleDataReader MyReader = cmd.ExecuteReader();
                    if (MyReader.Read())
                    {
                        MyDate = MyReader.GetDateTime(0);
                    }
                    else MyDate = DateTime.Now;
                    MyReader.Dispose();
                    MyReader.Close();
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return MyDate;
            }
            /// <summary>
            /// Признак инсайдера
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - признак 
            /// инсайдеда, value - его код</returns>
            public static ListItemCollection GetPrinsiderList(System.Web.HttpContext Context)
            {
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;

                DataTable dt = new DataTable();
                ListItemCollection MyList = new ListItemCollection();

                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(NAME), trim(PRINSIDER) FROM PRINSIDER";

                    adapter.Fill(dt);
                }
                finally
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                        MyItem.Value = dt.Rows[i].ItemArray[1].ToString();
                        MyItem.Text = dt.Rows[i].ItemArray[0].ToString();

                        MyList.Add(MyItem);
                    }
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return MyList;
            }
            /// <summary>
            /// Код безбалансового отделения
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - признак 
            /// инсайдеда, value - его код</returns>
            public static ListItemCollection GetTOBOList(System.Web.HttpContext Context)
            {
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;

                DataTable dt = new DataTable();
                ListItemCollection MyList = new ListItemCollection();

                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(NAME), trim(TOBO) FROM V_TOBO_SUBTREE";

                    adapter.Fill(dt);
                }
                finally
                {
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                    MyItem.Value = dt.Rows[i].ItemArray[1].ToString();
                    MyItem.Text = dt.Rows[i].ItemArray[0].ToString();

                    MyList.Add(MyItem);
                }

                return MyList;
            }
            /// <summary>
            /// Вид выписки
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - вид 
            /// выписки, value - его код</returns>
            public static ListItemCollection GetStmtList(System.Web.HttpContext Context)
            {
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;

                DataTable dt = new DataTable();
                ListItemCollection MyList = new ListItemCollection();

                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(NAME), trim(STMT) FROM STMT";

                    adapter.Fill(dt);
                }
                finally
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                        MyItem.Text = dt.Rows[i].ItemArray[0].ToString();
                        MyItem.Value = dt.Rows[i].ItemArray[1].ToString();

                        MyList.Add(MyItem);
                    }
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return MyList;
            }
            /// <summary>
            /// Областная НИ
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - название 
            /// областной НИ, value - ее код</returns>
            public static ListItemCollection GetC_regList(System.Web.HttpContext Context)
            {
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;

                DataTable dt = new DataTable();
                ListItemCollection MyList = new ListItemCollection();

                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(NAME_REG), trim(C_REG) FROM SPR_OBL ORDER BY C_REG";

                    adapter.Fill(dt);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                        MyItem.Text = dt.Rows[i].ItemArray[0].ToString();
                        MyItem.Value = dt.Rows[i].ItemArray[1].ToString();

                        MyList.Add(MyItem);
                    }
                }
                finally
                {
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return MyList;
            }
            /// <summary>
            /// Параметр который определяет обязательно ли заполнять эк.нормативы
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <param name="client">Тип клиента(CType). В зависимосте от типа клиента этот параметр
            /// имеет разные названия</param>
            /// <returns>стринговое значение параметра</returns>
            public static string GetPar_EN(System.Web.HttpContext Context, string client)
            {
                string Par_EN = "-1";

                string c = "F";
                if (client == "corp") c = "U";
                else if (client == "bank") c = "B";

                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;
                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(VAL) " +
                        "FROM PARAMS " +
                        "WHERE PAR = 'EN_" + c + "'";

                    OracleDataReader MyReader = cmd.ExecuteReader();
                    if (MyReader.Read())
                    {
                        Par_EN = MyReader.GetString(0);
                    }
                    MyReader.Close();
                    MyReader.Dispose();
                }
                finally
                {
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return Par_EN;
            }
            /// <summary>
            /// Вид документа
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - вид 
            /// документа, value - его код</returns>
            public static ListItemCollection GetPasspList(System.Web.HttpContext Context)
            {
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;

                DataTable dt = new DataTable();
                ListItemCollection MyList = new ListItemCollection();

                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(NAME), trim(PASSP) FROM PASSP";

                    adapter.Fill(dt);

                    System.Web.UI.WebControls.ListItem MyItem1 = new ListItem();
                    MyItem1.Value = "";
                    MyItem1.Text = "";

                    MyList.Add(MyItem1);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                        MyItem.Value = dt.Rows[i].ItemArray[1].ToString();
                        MyItem.Text = dt.Rows[i].ItemArray[0].ToString();

                        MyList.Add(MyItem);
                    }
                }
                finally
                {
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return MyList;
            }

            /// <summary>
            /// Пол клиента
            /// </summary>
            /// <returns>коллекция у елементов которой значение text - пол, 
            /// value - его код(формируется без обращения к базе)</returns>
            public static ListItemCollection GetSexList()
            {
                ListItemCollection MyList = new ListItemCollection();
                string[] Sex = { "Неопределен", "Мужской", "Женский" };

                for (int i = 0; i < 3; i++)
                {
                    System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                    MyItem.Value = i.ToString();
                    MyItem.Text = Sex[i];

                    MyList.Add(MyItem);
                }

                return MyList;
            }

            /// <summary>
            /// Класс заемщика
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - класс 
            /// заемщика, value - его код</returns>
            public static ListItemCollection GetCRiskList(System.Web.HttpContext Context)
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand(); ;

                ListItemCollection list = new ListItemCollection();
                try
                {
                    cmd.CommandText = "select fin, name from stan_fin order by fin";
                    OracleDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        ListItem item = new ListItem(Convert.ToString(rdr["name"]), Convert.ToString(rdr["fin"]));
                        list.Add(item);
                    }
                    rdr.Close();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }

                return list;
            }

            /// <summary>
            /// Принадлежность малому бизнесу (К140)
            /// </summary>
            /// <param name="Context">контекст даного сеанса приложения</param>
            /// <returns>коллекция у елементов которой значение text - принадлежность 
            /// малому бизнесу (К140), value - его код</returns>
            public static ListItemCollection GetK140List(System.Web.HttpContext Context)
            {
                IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();

                OracleCommand cmd = new OracleCommand();
                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                cmd.Connection = con;

                DataTable dt = new DataTable();

                ListItemCollection MyList = new ListItemCollection();

                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT trim(TXT), trim(K140) FROM KL_K140";

                    adapter.Fill(dt);

                    System.Web.UI.WebControls.ListItem MyItem1 = new ListItem();
                    MyItem1.Value = "";
                    MyItem1.Text = "";

                    MyList.Add(MyItem1);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        System.Web.UI.WebControls.ListItem MyItem = new ListItem();
                        MyItem.Value = dt.Rows[i].ItemArray[1].ToString();
                        MyItem.Text = dt.Rows[i].ItemArray[0].ToString();

                        MyList.Add(MyItem);
                    }
                }
                finally
                {
                    adapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return MyList;
            }
            /// <summary>
            /// Печать анкет клиентов по истории изменений параметров клиентов
            /// </summary>
            /// <returns>0 или 1</returns>
            public static string GetPar_CUSTPRNT()
            {
                string par_value = "0";

                IOraConnection icon = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                OracleConnection con = icon.GetUserConnection();
                OracleCommand cmd = new OracleCommand();
                cmd.Connection = con;
                try
                {
                    cmd.CommandText = icon.GetSetRoleCommand("WR_CUSTREG");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT nvl(min(to_number(val)),0) " +
                        "FROM PARAMS " +
                        "WHERE PAR = 'CUSTPRNT'";
                    par_value = Convert.ToString(cmd.ExecuteScalar());

                }
                finally
                {
                    cmd.Dispose();
                    con.Close();
                    con.Dispose();
                }
                return par_value;
            }
        }

        //Методы класса-----------------------------------------


        /// <summary>
        /// Конструктор класса
        /// </summary>
        public Client()
        {
        }
        public Client(string p_EditType, string p_ReadOnly, string p_BANKDATE, string p_Par_EN, string p_CUSTTYPE, string p_DATE_ON, string p_DATE_OFF, string p_ID, string p_ND, string p_NMK, string p_NMKV, string p_NMKK, string p_ADR, string p_fullADR, string p_fullADRMORE, string p_CODCAGENT, string p_COUNTRY, string p_PRINSIDER, string p_TGR, string p_STMT, string p_OKPO, string p_SAB, string p_BC, string p_TOBO, string p_PINCODE, string p_RNlPres, string p_C_REG, string p_C_DST, string p_ADM, string p_TAXF, string p_RGADM, string p_RGTAX, string p_DATET, string p_DATEA, string p_NEkPres, string p_ISE, string p_FS, string p_VED, string p_OE, string p_K050, string p_SED, string p_MFO, string p_ALT_BIC, string p_BIC, string p_RATING, string p_KOD_B, string p_DAT_ND, string p_NUM_ND, string p_RUK, string p_BUH, string p_TELR, string p_TELB, string p_NMKU, string p_fullACCS, string p_E_MAIL, string p_TEL_FAX, string p_SEAL_ID, string p_RCFlPres, string p_PASSP, string p_SER, string p_NUMDOC, string p_ORGAN, string p_PDATE, string p_BDAY, string p_BPLACE, string p_SEX, string p_TELD, string p_TELW, string p_DOV, string p_BDOV, string p_EDOV, string p_ISP, string p_NOTES, string p_CRISK, string p_MB, string p_ADR_ALT, string p_NOM_DOG, string p_LIM_KASS, string p_LIM, string p_NOMPDV, string p_RNKP, string p_NOTESEC, string p_TrustEE, string p_DopRekv)
        {
            EditType = p_EditType;		// Reg, ReReg, View - для чего открыто приложение
            ReadOnly = p_ReadOnly;	// Правка разрешена\запрещена
            BANKDATE = p_BANKDATE;		// Банковская дата
            Par_EN = p_Par_EN;			// Обязательное заполнение эк. нормативов

            CUSTTYPE = p_CUSTTYPE;        // Тип клиента (person,corp,bank)

            // Осн. рквизиты
            DATE_ON = p_DATE_ON;			// Дата регистрации
            DATE_OFF = p_DATE_OFF;		// Дата закрытия
            ID = p_ID;				// Идентификатор
            ND = p_ND;				// Номер договора
            NMK = p_NMK;			// Наименование или ФИО
            NMKV = p_NMKV;           // Наименование (межд.)
            NMKK = p_NMKK;           // Наименование (краткое)
            ADR = p_ADR;            // Адрес клиента
            fullADR = (new JavaScriptSerializer()).Deserialize<CustomerAddress>(p_fullADR);        // Полний адрес клиента
            fullADRMORE = p_fullADRMORE;// Дополнительные адреса (для юр лиц)
            CODCAGENT = p_CODCAGENT;      // Характеристика клиента (К010)
            COUNTRY = p_COUNTRY;		// Цифровой код страны
            PRINSIDER = p_PRINSIDER;      // Признак инсайдера (К060)
            TGR = p_TGR;			// Тип гос. реестра
            STMT = p_STMT;			// Вид выписки
            OKPO = p_OKPO;			// Идентификационный код
            SAB = p_SAB;			// Эликтронный код клиента
            BC = p_BC;				// Признак не является клиентом банка (1)
            TOBO = p_TOBO;			// ТОБО отделения
            PINCODE = p_PINCODE;		// Неизвесное поле(неисп.)


            // Рекв. налогопл.
            RNlPres = p_RNlPres;		// Рекв. налогопл. заполнены\не заполнены
            C_REG = p_C_REG;			// Областная НИ
            C_DST = p_C_DST;			// Районная НИ
            ADM = p_ADM;			// Адм. орган регистрации
            TAXF = p_TAXF;			// Налоговый код (К050)
            RGADM = p_RGADM;			// Рег. номер в Адм.
            RGTAX = p_RGTAX;			// Рег. номер в НИ
            DATET = p_DATET;			// Дата рег. в НИ
            DATEA = p_DATEA;			// Дата рег. в Адм.

            // Экономические нормативы
            NEkPres = p_NEkPres;		// Экономические нормативы заполнены\не заполнены
            ISE = p_ISE;			// Инст. сек. экономики (К070)
            FS = p_FS;				// Форма собственности (К080)
            VED = p_VED;			// Вид эк. деятельности (К110)
            OE = p_OE;				// Отрасль экономики (К090)
            K050 = p_K050;			// Форма хозяйствования (К050)
            SED = p_SED;			// Форма хозяйствования (К051)

            // Реквизиты клиента
            // -----(банк)-----
            MFO = p_MFO;			// Код банка - МФО
            ALT_BIC = p_ALT_BIC;			// Альтернативный 
            BIC = p_BIC;			// ВІС
            RATING = p_RATING;			// Рейтинг банка
            KOD_B = p_KOD_B;			// Для 1ПБ
            DAT_ND = p_DAT_ND;			// Неизвесная дата
            NUM_ND = p_NUM_ND;			// Номер геню. соглашения (неисп.)  
            // --(банк/юр.лицо)--
            RUK = p_RUK;			// Руководитель
            BUH = p_BUH;			// Гл. бухгалтер банка
            TELR = p_TELR;			// Телефон руководителя
            TELB = p_TELB;			// Телефон гл. бухгалтера
            // -----(юр.лицо)-----
            NMKU = p_NMKU;			// Наименование по уставу
            fullACCS = p_fullACCS;	// Счета контрагента Юр.Лица
            E_MAIL = p_E_MAIL;		// EMAIL
            TEL_FAX = p_TEL_FAX;		// Факс
            SEAL_ID = p_SEAL_ID;		// Ид. графического образа печати
            // -----(физ.лицо)-----
            RCFlPres = p_RCFlPres;		// Реквизиты клиента физ.лицо заполнены\не заполнены
            PASSP = p_PASSP;			// Вид документа
            SER = p_SER;			// Серия
            NUMDOC = p_NUMDOC;			// Номер док.
            ORGAN = p_ORGAN;			// Кем выдан
            PDATE = p_PDATE;			// Когда выдан
            BDAY = p_BDAY;			// Дата рождения
            BPLACE = p_BPLACE;			// Место рождения
            SEX = p_SEX;			// Пол
            TELD = p_TELD;			// Телефон 1
            TELW = p_TELW;			// Телефон 2
            DOV = p_DOV;			// |
            BDOV = p_BDOV;			// |Неизвесные поля(неисп.)
            EDOV = p_EDOV;			// |

            // Доп информация
            ISP = p_ISP;			// Менеджер клиента (ответ. исполнитель)
            NOTES = p_NOTES;			// Примечание
            CRISK = p_CRISK;			// Класс заемщика
            MB = p_MB;				// Принадлежность малому бизнесу
            ADR_ALT = p_ADR_ALT;		// Альтнрнативный адрес
            NOM_DOG = p_NOM_DOG;		// № дог. за сопровождение
            LIM_KASS = p_LIM_KASS;		// Лимит кассы
            LIM = p_LIM;			// Лимит на активніе операции
            NOMPDV = p_NOMPDV;			// № в реестре плательщиков ПДВ
            RNKP = p_RNKP;			// регистрационный № холдинга
            NOTESEC = p_NOTESEC;		// Примечание для службы безопасности
            TrustEE = p_TrustEE;		// таблица довереных лиц

            // Доп реквизиты
            DopRekv = p_DopRekv;			// таблица доп реквизитов
        }
        // Вычитка
        /// <summary>
        /// Метод получает параметры клиента из базы данных
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        public void ReadFromDatabase(HttpContext ctx, HttpApplicationState apl)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                cmdSetRole.ExecuteNonQuery();

                // Формируем запрос
                OracleCommand cmdReadClientData = new OracleCommand();
                cmdReadClientData.Connection = connect;
                cmdReadClientData.CommandText = @"SELECT	TGR,
															CUSTTYPE,
															COUNTRY,
															NMK,
															NMKV,
															NMKK,
															CODCAGENT,
															PRINSIDER,
															OKPO,
															ADR,
															SAB,
															TAXF,
															C_REG,
															C_DST,
															RGTAX,
															to_char(DATET,'dd.MM.yyyy') as DATET,
															ADM,
															to_char(DATEA,'dd.MM.yyyy') as DATEA,
															STMT,
															to_char(DATE_ON,'dd.MM.yyyy') as DATE_ON,
															to_char(DATE_OFF,'dd.MM.yyyy') as DATE_OFF,
															NOTES,
															NOTESEC,
															CRISK,
															PINCODE,
															ND,
															RNKP,
															ISE,
															FS,
															OE,
															VED,
                                                            K050,
															SED,
															LIM,
															NOMPDV,
															MB,
															RGADM,
															NVL(BC, 0) as BC,
															TOBO,
															ISP 
												FROM CUSTOMER 
												WHERE rnk = :rnk";

                cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                // Читаем результаты запроса
                Oracle.DataAccess.Client.OracleDataAdapter adpt = new OracleDataAdapter(cmdReadClientData);
                DataTable dt = new DataTable("result");
                adpt.Fill(dt);
                adpt.Dispose();
                cmdReadClientData.Dispose();
                if (dt.Rows.Count > 0)
                {
                    object[] DataRow = dt.Rows[0].ItemArray;
                    DataColumnCollection DataCols = dt.Columns;

                    TGR = DataRow.GetValue(DataCols.IndexOf("TGR")).ToString();
                    CUSTTYPE = DataRow.GetValue(DataCols.IndexOf("CUSTTYPE")).ToString();
                    switch (CUSTTYPE)
                    {
                        case "1":
                            CUSTTYPE = "bank";
                            break;
                        case "2":
                            CUSTTYPE = "corp";
                            break;
                        case "3":
                            CUSTTYPE = "person";
                            break;
                    }

                    COUNTRY = DataRow.GetValue(DataCols.IndexOf("COUNTRY")).ToString();
                    NMK = DataRow.GetValue(DataCols.IndexOf("NMK")).ToString();
                    NMKV = DataRow.GetValue(DataCols.IndexOf("NMKV")).ToString();
                    NMKK = DataRow.GetValue(DataCols.IndexOf("NMKK")).ToString();
                    CODCAGENT = DataRow.GetValue(DataCols.IndexOf("CODCAGENT")).ToString();
                    PRINSIDER = DataRow.GetValue(DataCols.IndexOf("PRINSIDER")).ToString();
                    OKPO = DataRow.GetValue(DataCols.IndexOf("OKPO")).ToString();
                    ADR = DataRow.GetValue(DataCols.IndexOf("ADR")).ToString();
                    SAB = DataRow.GetValue(DataCols.IndexOf("SAB")).ToString();
                    TAXF = DataRow.GetValue(DataCols.IndexOf("TAXF")).ToString();
                    C_REG = DataRow.GetValue(DataCols.IndexOf("C_REG")).ToString();
                    C_DST = DataRow.GetValue(DataCols.IndexOf("C_DST")).ToString();
                    RGTAX = DataRow.GetValue(DataCols.IndexOf("RGTAX")).ToString();
                    DATET = DataRow.GetValue(DataCols.IndexOf("DATET")).ToString();
                    ADM = DataRow.GetValue(DataCols.IndexOf("ADM")).ToString();
                    DATEA = DataRow.GetValue(DataCols.IndexOf("DATEA")).ToString();
                    STMT = DataRow.GetValue(DataCols.IndexOf("STMT")).ToString();
                    DATE_ON = DataRow.GetValue(DataCols.IndexOf("DATE_ON")).ToString();
                    DATE_OFF = DataRow.GetValue(DataCols.IndexOf("DATE_OFF")).ToString();
                    NOTES = DataRow.GetValue(DataCols.IndexOf("NOTES")).ToString();
                    NOTESEC = DataRow.GetValue(DataCols.IndexOf("NOTESEC")).ToString();
                    CRISK = DataRow.GetValue(DataCols.IndexOf("CRISK")).ToString();
                    PINCODE = DataRow.GetValue(DataCols.IndexOf("PINCODE")).ToString();
                    ND = DataRow.GetValue(DataCols.IndexOf("ND")).ToString();
                    RNKP = DataRow.GetValue(DataCols.IndexOf("RNKP")).ToString();
                    ISE = DataRow.GetValue(DataCols.IndexOf("ISE")).ToString();
                    FS = DataRow.GetValue(DataCols.IndexOf("FS")).ToString();
                    OE = DataRow.GetValue(DataCols.IndexOf("OE")).ToString();
                    VED = DataRow.GetValue(DataCols.IndexOf("VED")).ToString();
                    K050 = DataRow.GetValue(DataCols.IndexOf("K050")).ToString();
                    SED = DataRow.GetValue(DataCols.IndexOf("SED")).ToString();
                    LIM = DataRow.GetValue(DataCols.IndexOf("LIM")).ToString();
                    NOMPDV = DataRow.GetValue(DataCols.IndexOf("NOMPDV")).ToString();
                    MB = DataRow.GetValue(DataCols.IndexOf("MB")).ToString();
                    RGADM = DataRow.GetValue(DataCols.IndexOf("RGADM")).ToString();
                    BC = DataRow.GetValue(DataCols.IndexOf("BC")).ToString();
                    TOBO = DataRow.GetValue(DataCols.IndexOf("TOBO")).ToString();
                    ISP = DataRow.GetValue(DataCols.IndexOf("ISP")).ToString();
                }
                else
                {
                    throw new Exception("Запрашиваемый клиент недоступен");
                }
            }
            finally
            {
                if (connect.State == ConnectionState.Open)
                    connect.Close();
                connect.Dispose();
            }







            ReadfullADR();

            ReadFIO_dopRekv();

            if (CUSTTYPE != string.Empty && CUSTTYPE == "bank")
                ReadBankFromDatabase(ctx);
            else if (CUSTTYPE != string.Empty && CUSTTYPE == "corp")
            {
                ReadCorpFromDatabase(ctx);
                ReadCorpAccsFromDatabase(ctx);
            }
            else if (CUSTTYPE != string.Empty && CUSTTYPE == "person")
                ReadPersonFromDatabase(ctx);

            ReadRnk_RekvFromDatabase(ctx);

            ReadTrusteeFromDatabase(ctx, apl);

            //ReadDop_RekvFromDatabase(ctx);
        }

        /// <summary>
        /// Вычитывает ФИО клиента-персоны с таблицы CUSTOMERW
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadFIO_dopRekv()
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(this.ID), ParameterDirection.Input);
                cmd.CommandText = "select tag, trim(value) as value from customerw where rnk = :p_rnk and tag in ('SN_LN', 'SN_FN', 'SN_MN', 'SN_4N')";

                OracleDataReader rdr = cmd.ExecuteReader();
                CustomerAddress.Address adr = new CustomerAddress.Address();
                while (rdr.Read())
                {
                    switch ((String)rdr["tag"])
                    {
                        case "SN_LN":
                            DopRekv_SN_LN = rdr["value"] == DBNull.Value ? String.Empty : (String)rdr["value"];// (String)rdr["value"];
                            break;
                        case "SN_FN":
                            DopRekv_SN_FN = rdr["value"] == DBNull.Value ? String.Empty : (String)rdr["value"];// (String)rdr["value"];
                            break;
                        case "SN_MN":
                            DopRekv_SN_MN = rdr["value"] == DBNull.Value ? String.Empty : (String)rdr["value"];// (String)rdr["value"];
                            break;
                        case "SN_4N":
                            DopRekv_SN_4N = rdr["value"] == DBNull.Value ? String.Empty : (String)rdr["value"];// (String)rdr["value"];
                            break;
                        default:
                            break;
                    }
                }
                rdr.Close();
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
 
        }      

        /// <summary>
        /// Вычитывает полный адрес клиента-персоны
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadfullADR()
        {
            CustomerAddress ca = new CustomerAddress();

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                // определяем какая схема адресов установлена на базе
                cmd.Parameters.Clear();
                cmd.CommandText = "SELECT count(*) FROM ALL_OBJECTS WHERE OBJECT_NAME = 'CUSTOMER_ADDRESS' and OBJECT_TYPE = 'TABLE'";
                bool isNewAdrScheme = Convert.ToBoolean(cmd.ExecuteScalar());

                // новая схема адресов
                if (isNewAdrScheme)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(this.ID), ParameterDirection.Input);
                    cmd.CommandText = "select type_id, zip, domain, region, locality, address, territory_id from customer_address ca where ca.rnk = :p_rnk order by ca.type_id";

                    OracleDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        CustomerAddress.Address adr = new CustomerAddress.Address(
                                    rdr["zip"] != DBNull.Value ? (String)rdr["zip"] : String.Empty,
                                    rdr["domain"] != DBNull.Value ? (String)rdr["domain"] : String.Empty,
                                    rdr["region"] != DBNull.Value ? (String)rdr["region"] : String.Empty,
                                    rdr["locality"] != DBNull.Value ? (String)rdr["locality"] : String.Empty,
                                    rdr["address"] != DBNull.Value ? (String)rdr["address"] : String.Empty,
                                    rdr["territory_id"] != DBNull.Value ? (Decimal)rdr["territory_id"] : (Decimal?)null);

                        switch (Convert.ToInt16(rdr["type_id"]))
                        {
                            case 1:
                                ca.type1 = adr;
                                break;
                            case 2:
                                ca.type2 = adr;
                                break;
                            case 3:
                                ca.type3 = adr;
                                break;
                            default:
                                break;
                        }
                    }
                    rdr.Close();
                }

                // если в новой схеме записей нету
                if (!ca.type1.filled && !ca.type2.filled && !ca.type3.filled)
                {
                    //--- старая схема адресов
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(this.ID), ParameterDirection.Input);
                    cmd.CommandText = "select tag, trim(value) as value from customerw where rnk = :p_rnk and tag in ('FGIDX', 'FGOBL', 'FGDST', 'FGTWN', 'FGADR')";

                    OracleDataReader rdr = cmd.ExecuteReader();
                    CustomerAddress.Address adr = new CustomerAddress.Address();
                    while (rdr.Read())
                    {
                        switch ((String)rdr["tag"])
                        {
                            case "FGIDX":
                                adr.zip = (String)rdr["value"];
                                break;
                            case "FGOBL":
                                adr.domain = (String)rdr["value"];
                                break;
                            case "FGDST":
                                adr.region = (String)rdr["value"];
                                break;
                            case "FGTWN":
                                adr.locality = (String)rdr["value"];
                                break;
                            case "FGADR":
                                adr.address = (String)rdr["value"];
                                break;
                            default:
                                break;
                        }
                    }
                    rdr.Close();

                    adr.filled = true;
                    ca.type1 = adr;
                }
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }

            this.fullADR = ca;
        }
        /// <summary>
        /// Метод получает параметры клиента-банк из базы данных
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadBankFromDatabase(HttpContext ctx)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                cmdSetRole.ExecuteNonQuery();

                // Формируем запрос
                OracleCommand cmdReadClientData = new OracleCommand();
                cmdReadClientData.Connection = connect;
                cmdReadClientData.CommandText = @"SELECT 	MFO, 
															ALT_BIC, 
															BIC, 
															RATING, 
															KOD_B, 
															DAT_ND, 
															RUK, 
															BUH, 
															TELR, 
															TELB 
												FROM CUSTBANK 
												WHERE rnk = :rnk";
                /*RNK    
MFO    
ALT_BIC
BIC    
RATING 
KOD_B  
DAT_ND 
RUK    
TELR   
BUH    
TELB   
NUM_ND */

                cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                // Читаем результаты запроса
                Oracle.DataAccess.Client.OracleDataAdapter adpt = new OracleDataAdapter(cmdReadClientData);
                DataTable dt = new DataTable("result");
                adpt.Fill(dt);
                adpt.Dispose();
                cmdReadClientData.Dispose();
                if (dt.Rows.Count > 0)
                {
                    object[] DataRow = dt.Rows[0].ItemArray;
                    DataColumnCollection DataCols = dt.Columns;

                    MFO = DataRow.GetValue(DataCols.IndexOf("MFO")).ToString();
                    ALT_BIC = DataRow.GetValue(DataCols.IndexOf("ALT_BIC")).ToString();
                    BIC = DataRow.GetValue(DataCols.IndexOf("BIC")).ToString();
                    RATING = DataRow.GetValue(DataCols.IndexOf("RATING")).ToString();
                    KOD_B = DataRow.GetValue(DataCols.IndexOf("KOD_B")).ToString();
                    DAT_ND = DataRow.GetValue(DataCols.IndexOf("DAT_ND")).ToString();
                    //				NUM_ND = DataRow.GetValue(DataCols.IndexOf("NUM_ND")).ToString();
                    RUK = DataRow.GetValue(DataCols.IndexOf("RUK")).ToString();
                    BUH = DataRow.GetValue(DataCols.IndexOf("BUH")).ToString();
                    TELR = DataRow.GetValue(DataCols.IndexOf("TELR")).ToString();
                    TELB = DataRow.GetValue(DataCols.IndexOf("TELB")).ToString();
                }
            }
            finally
            {
                if (connect.State == ConnectionState.Open)
                    connect.Close();
                connect.Dispose();
            }
        }

        /// <summary>
        /// Метод получает параметры клиента-юр.лица из базы данных
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadCorpFromDatabase(HttpContext ctx)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                cmdSetRole.ExecuteNonQuery();
                cmdSetRole.Dispose();
                // Формируем запрос
                OracleCommand cmdReadClientData = new OracleCommand();
                cmdReadClientData.Connection = connect;
                cmdReadClientData.CommandText = @"SELECT 	RUK, 
															BUH, 
															TELR, 
															TELB, 
															NMKU, 
															TEL_FAX, 
															E_MAIL, 
															SEAL_ID " +
                    /*, 															
                    DOV, 
                    BDOV, 
                    EDOV */
                                                @"FROM CORPS 
												WHERE rnk = :rnk";

                cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                // Читаем результаты запроса
                Oracle.DataAccess.Client.OracleDataAdapter adpt = new OracleDataAdapter(cmdReadClientData);
                DataTable dt = new DataTable("result");
                adpt.Fill(dt);
                adpt.Dispose();
                cmdReadClientData.Dispose();
                if (dt.Rows.Count > 0)
                {
                    object[] DataRow = dt.Rows[0].ItemArray;
                    DataColumnCollection DataCols = dt.Columns;

                    RUK = DataRow.GetValue(DataCols.IndexOf("RUK")).ToString();
                    BUH = DataRow.GetValue(DataCols.IndexOf("BUH")).ToString();
                    TELR = DataRow.GetValue(DataCols.IndexOf("TELR")).ToString();
                    TELB = DataRow.GetValue(DataCols.IndexOf("TELB")).ToString();
                    NMKU = DataRow.GetValue(DataCols.IndexOf("NMKU")).ToString();
                    TEL_FAX = DataRow.GetValue(DataCols.IndexOf("TEL_FAX")).ToString();
                    E_MAIL = DataRow.GetValue(DataCols.IndexOf("E_MAIL")).ToString();
                    SEAL_ID = DataRow.GetValue(DataCols.IndexOf("SEAL_ID")).ToString();
                    /*DOV = DataRow.GetValue(DataCols.IndexOf("DOV")).ToString();
                    BDOV = DataRow.GetValue(DataCols.IndexOf("BDOV")).ToString();
                    EDOV = DataRow.GetValue(DataCols.IndexOf("EDOV")).ToString();*/
                    DOV = "";
                    BDOV = "";
                    EDOV = "";
                }
            }
            finally
            {
                if (connect.State == ConnectionState.Open)
                    connect.Close();
                connect.Dispose();
            }
        }

        /// <summary>
        /// Метод получает все счета клиента-юр.лица из базы данных
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadCorpAccsFromDatabase(HttpContext ctx)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                cmdSetRole.ExecuteNonQuery();
                cmdSetRole.Dispose();

                // Формируем запрос
                OracleCommand cmdReadClientData = new OracleCommand();
                cmdReadClientData.Connection = connect;
                cmdReadClientData.CommandText = @"SELECT ID, MFO, NLS, KV, COMMENTS FROM CORPS_ACC WHERE RNK = :rnk";

                cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                // Читаем результаты запроса
                Oracle.DataAccess.Client.OracleDataAdapter adpt = new OracleDataAdapter(cmdReadClientData);
                DataTable dt = new DataTable("result");
                adpt.Fill(dt);
                adpt.Dispose();
                cmdReadClientData.Dispose();

                this.fullACCS = string.Empty;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    this.fullACCS += ((i == 0) ? ("") : (";"));
                    for (int j = 0; j < dt.Rows[i].ItemArray.Length; j++)
                    {
                        this.fullACCS += ((j == 0) ? ("") : (",")) + dt.Rows[i].ItemArray.GetValue(j).ToString().Replace(";", "тк.зпт").Replace(",", "зпт");
                    }
                }
            }
            finally
            {
                if (connect.State == ConnectionState.Open)
                    connect.Close();
                connect.Dispose();
            }
        }

        /// <summary>
        /// Метод получает параметры клиента-физ.лица из базы данных
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadPersonFromDatabase(HttpContext ctx)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                cmdSetRole.ExecuteNonQuery();
                cmdSetRole.Dispose();

                // Формируем запрос
                OracleCommand cmdReadClientData = new OracleCommand();
                cmdReadClientData.Connection = connect;
                cmdReadClientData.CommandText = @"select p.passp,
                                                           p.ser,
                                                           p.numdoc,
                                                           p.organ,
                                                           to_char(p.pdate, 'dd.mm.yyyy') as pdate,
                                                           to_char(p.bday, 'dd.mm.yyyy') as bday,
                                                           p.bplace,
                                                           p.sex,
                                                           p.teld,
                                                           p.telw,
                                                           p.dov,
                                                           p.bdov,
                                                           p.edov
                                                      from person p
                                                     where p.rnk = :p_rnk";

                cmdReadClientData.Parameters.Add("p_rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                // Читаем результаты запроса
                OracleDataReader odr = cmdReadClientData.ExecuteReader();

                if (odr.Read())
                {
                    PASSP = Convert.ToString(odr["passp"]);
                    SER = Convert.ToString(odr["ser"]);
                    NUMDOC = Convert.ToString(odr["numdoc"]);
                    ORGAN = Convert.ToString(odr["organ"]);
                    PDATE = Convert.ToString(odr["pdate"]);
                    BDAY = Convert.ToString(odr["bday"]);
                    BPLACE = Convert.ToString(odr["bplace"]);
                    SEX = Convert.ToString(odr["sex"]);
                    TELD = Convert.ToString(odr["teld"]);
                    TELW = Convert.ToString(odr["telw"]);
                    DOV = Convert.ToString(odr["dov"]);
                    BDOV = Convert.ToString(odr["bdov"]);
                    EDOV = Convert.ToString(odr["edov"]);
                }

            }
            finally
            {
                if (connect.State == ConnectionState.Open)
                    connect.Close();
                connect.Dispose();
            }
        }
        
        /// <summary>
        /// Метод получает параметры из таблицы rnk_rekv
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadRnk_RekvFromDatabase(HttpContext ctx)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                // Устанавливаем роль
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("WR_CUSTREG");
                cmdSetRole.ExecuteNonQuery();
                cmdSetRole.Dispose();

                // Формируем запрос
                OracleCommand cmdReadClientData = new OracleCommand();
                cmdReadClientData.Connection = connect;
                cmdReadClientData.CommandText = @"	SELECT LIM_KASS, ADR_ALT, NOM_DOG 
													FROM RNK_REKV 
													WHERE rnk = :rnk";

                cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                // Читаем результаты запроса
                Oracle.DataAccess.Client.OracleDataAdapter adpt = new OracleDataAdapter(cmdReadClientData);
                DataTable dt = new DataTable("result");
                adpt.Fill(dt);
                adpt.Dispose();
                if (dt.Rows.Count > 0)
                {
                    object[] DataRow = dt.Rows[0].ItemArray;
                    DataColumnCollection DataCols = dt.Columns;

                    LIM_KASS = DataRow.GetValue(DataCols.IndexOf("LIM_KASS")).ToString();
                    ADR_ALT = DataRow.GetValue(DataCols.IndexOf("ADR_ALT")).ToString();
                    NOM_DOG = DataRow.GetValue(DataCols.IndexOf("NOM_DOG")).ToString();
                }
                cmdReadClientData.Dispose();
            }
            finally
            {
                if (connect.State == ConnectionState.Open)
                    connect.Close();
                connect.Dispose();
            }
        }

        /// <summary>
        /// Метод получает таблицу с данными про довереных лиц
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadTrusteeFromDatabase(HttpContext ctx, HttpApplicationState apl)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            /*
             * Таблица довереных лиц вычитываеться прямо на странице дов. лица
             */
            this.TrustEE = string.Empty;
        }

        /// <summary>
        /// Метод получает таблицу с данными про довереных лиц
        /// </summary>
        /// <param name="ctx">Контекст приложения</param>
        private void ReadDop_RekvFromDatabase(HttpContext ctx)
        {
            // Сохраняем идентификатор
            decimal ClientID = decimal.Parse(this.ID);

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();
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

                command.CommandText = @"SELECT F.TAG AS TAG, W.VALUE AS VAL, decode(BYISP,1,(	SELECT OTD 
	   		 		 		   		 		 		 											FROM OTD_USER 
																								WHERE USERID = getcurrentuserid and PR = 1 and ROWNUM = 1 
	   		 		 		   		 		 		 												UNION 
																								SELECT OTD 
																								FROM OTD_USER WHERE USERID = getcurrentuserid and ROWNUM = 1 and NOT EXISTS(SELECT OTD 
																																											FROM OTD_USER 
																																											WHERE USERID = getcurrentuserid and PR = 1 and ROWNUM = 1)),0) as BYISP 
											FROM	(SELECT * FROM CUSTOMER_FIELD WHERE F = 1) F, 
													(SELECT * FROM CUSTOMERW WHERE RNK = :prnk AND (ISP = 0 OR (ISP in ( SELECT OTD FROM OTD_USER WHERE USERID = getcurrentuserid )) )) W  
											WHERE F.TAG = W.TAG(+) and W.VALUE is not null 
											ORDER BY NAME";

                command.Parameters.Add(":prnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

                adapter.Fill(dt);
                adapter.Dispose();
                command.Dispose();
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            this.DopRekv = string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                this.DopRekv += ((i == 0) ? ("") : (";"));
                for (int j = 0; j < dt.Rows[i].ItemArray.Length; j++)
                {
                    this.DopRekv += ((j == 0) ? ("") : (",")) + dt.Rows[i].ItemArray.GetValue(j);
                }
            }
        }

        /// <summary>
        /// Функция готовит строку для выполнения в javascript
        /// </summary>
        /// <returns>Строка с подставлеными параметрами клиента</returns>
        public string PrepareSetString()
        {
            string res = " SetParameters( ";
            res += "'" + EditType.Replace("'", "\"") + "', ";
            res += "'" + ReadOnly.Replace("'", "\"") + "', ";
            res += "'" + ReadOnlyMode.Replace("'", "\"") + "', ";
            res += "'" + BANKDATE.Replace("'", "\"") + "', ";
            res += "'" + Par_EN.Replace("'", "\"") + "', ";
            res += "'" + CUSTTYPE.Replace("'", "\"") + "', ";
            res += "'" + DATE_ON.Replace("'", "\"") + "', ";
            res += "'" + DATE_OFF.Replace("'", "\"") + "', ";
            res += "'" + ID.Replace("'", "\"") + "', ";
            res += "'" + ND.Replace("'", "\"").Replace("\\", "\\\\") + "', ";
            res += "'" + NMK.Replace("'", "\"") + "', ";
            res += "'" + NMKV.Replace("'", "\"") + "', ";
            res += "'" + NMKK.Replace("'", "\"") + "', ";
            res += "'" + ADR.Replace("'", "\"").Replace("\\", "\\\\") + "', ";
            res += "'" + Uri.EscapeUriString(new JavaScriptSerializer().Serialize(fullADR)) + "', ";
            res += "'" + fullADRMORE.Replace("'", "\"").Replace("\\", "\\\\") + "', ";
            res += "'" + CODCAGENT.Replace("'", "\"") + "', ";
            res += "'" + COUNTRY.Replace("'", "\"") + "', ";
            res += "'" + PRINSIDER.Replace("'", "\"") + "', ";
            res += "'" + TGR.Replace("'", "\"") + "', ";
            res += "'" + STMT.Replace("'", "\"") + "', ";
            res += "'" + OKPO.Replace("'", "\"") + "', ";
            res += "'" + SAB.Replace("'", "\"") + "', ";
            res += "'" + BC.Replace("'", "\"") + "', ";
            res += "'" + TOBO.Replace("'", "\"") + "', ";
            res += "'" + PINCODE.Replace("'", "\"") + "', ";
            res += "'" + RNlPres.Replace("'", "\"") + "', ";
            res += "'" + C_REG.Replace("'", "\"") + "', ";
            res += "'" + C_DST.Replace("'", "\"") + "', ";
            res += "'" + ADM.Replace("'", "\"") + "', ";
            res += "'" + TAXF.Replace("'", "\"") + "', ";
            res += "'" + RGADM.Replace("'", "\"") + "', ";
            res += "'" + RGTAX.Replace("'", "\"") + "', ";
            res += "'" + DATET.Replace("'", "\"") + "', ";
            res += "'" + DATEA.Replace("'", "\"") + "', ";
            res += "'" + NEkPres.Replace("'", "\"") + "', ";
            res += "'" + PINCODE.Replace("'", "\"") + "', ";
            res += "'" + RNlPres.Replace("'", "\"") + "', ";
            res += "'" + ISE.Replace("'", "\"") + "', ";
            res += "'" + FS.Replace("'", "\"") + "', ";
            res += "'" + VED.Replace("'", "\"") + "', ";
            res += "'" + OE.Replace("'", "\"") + "', ";
            res += "'" + K050.Replace("'", "\"") + "', ";
            res += "'" + SED.Replace("'", "\"") + "', ";
            res += "'" + MFO.Replace("'", "\"") + "', ";
            res += "'" + ALT_BIC.Replace("'", "\"") + "', ";
            res += "'" + BIC.Replace("'", "\"") + "', ";
            res += "'" + RATING.Replace("'", "\"") + "', ";
            res += "'" + KOD_B.Replace("'", "\"") + "', ";
            res += "'" + DAT_ND.Replace("'", "\"") + "', ";
            res += "'" + NUM_ND.Replace("'", "\"") + "', ";
            res += "'" + RUK.Replace("'", "\"").Replace("\\", "\\\\") + "', ";
            res += "'" + BUH.Replace("'", "\"") + "', ";
            res += "'" + TELR.Replace("'", "\"") + "', ";
            res += "'" + TELB.Replace("'", "\"") + "', ";
            res += "'" + NMKU.Replace("'", "\"") + "', ";
            res += "'" + fullACCS.Replace("'", "\"") + "', ";
            res += "'" + TEL_FAX.Replace("'", "\"") + "', ";
            res += "'" + E_MAIL.Replace("'", "\"") + "', ";
            res += "'" + SEAL_ID.Replace("'", "\"") + "', ";
            res += "'" + RCFlPres.Replace("'", "\"") + "', ";
            res += "'" + PASSP.Replace("'", "\"") + "', ";
            res += "'" + SER.Replace("'", "\"") + "', ";
            res += "'" + NUMDOC.Replace("'", "\"") + "', ";
            res += "'" + ORGAN.Replace("'", "\"") + "', ";
            res += "'" + PDATE.Replace("'", "\"") + "', ";
            res += "'" + BDAY.Replace("'", "\"") + "', ";
            res += "'" + BPLACE.Replace("'", "\"") + "', ";
            res += "'" + SEX.Replace("'", "\"") + "', ";
            res += "'" + TELD.Replace("'", "\"") + "', ";
            res += "'" + TELW.Replace("'", "\"") + "', ";
            res += "'" + DOV.Replace("'", "\"") + "', ";
            res += "'" + BDOV.Replace("'", "\"") + "', ";
            res += "'" + EDOV.Replace("'", "\"") + "', ";
            res += "'" + ISP.Replace("'", "\"") + "', ";
            res += "'" + NOTES.Replace("'", "\"") + "', ";
            res += "'" + CRISK.Replace("'", "\"") + "', ";
            res += "'" + MB.Replace("'", "\"") + "', ";
            res += "'" + ADR_ALT.Replace("'", "\"") + "', ";
            res += "'" + NOM_DOG.Replace("'", "\"") + "', ";
            res += "'" + LIM_KASS.Replace("'", "\"") + "', ";
            res += "'" + LIM.Replace("'", "\"") + "', ";
            res += "'" + NOMPDV.Replace("'", "\"") + "', ";
            res += "'" + RNKP.Replace("'", "\"") + "', ";
            res += "'" + NOTESEC.Replace("'", "\"") + "', ";
            res += "'" + TrustEE.Replace("'", "\"") + "', ";
            res += "'" + DopRekv.Replace("'", "\"") + "', ";
            res += "'" + DopRekv_SN_LN.Replace("'", "\"") + "', ";
            res += "'" + DopRekv_SN_FN.Replace("'", "\"") + "', ";
            res += "'" + DopRekv_SN_MN.Replace("'", "\"") + "', ";
            res += "'" + DopRekv_SN_4N.Replace("'", "\"") + "'); ";
            res = res.Replace("\r\n", " ");

            return res;
        }

    }
}

