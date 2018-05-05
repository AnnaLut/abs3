using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.IO;
using System.Web.Services;
using System;
using System.Web.UI.WebControls;
using Bars;
using BarsWeb.Core.Infrastructure;
using System.Web.Http;
using BarsWeb.Core.Logger;
using Ninject;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using BarsWeb.Infrastructure.Helpers;

namespace CustomerList
{
    public class CustService : BarsWebService
    {
        #region Fields
        string base_role = "wr_custlist";
        int rowsLimit = 2000;
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        #endregion // Fields

        #region Properties
        public ICdmRepository _cdmRepo
        {
            get
            {
                var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
                var kernel = ninjectKernel.GetKernel();
                return kernel.Get<ICdmRepository>();
            }
        }
        private string[] SessionDataDateArr
        {
            set
            {
                Session["ShowHistory"] = value;
            }
        }
        #endregion // Properties

        #region Constructor
        public CustService()
        {
            InitializeComponent();
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
        }
        #endregion // Constructor

        #region Component Designer generated code
        private IContainer components = null;

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

        #region WebMethods
        [WebMethod(EnableSession = true)]
        public string ExportExcel(string[] data, bool? forceExecute = null)
        {
            try
            {
                InitOraConnection(Context);
                string rnk = data[9];
                string type = data[10];
                string nd = data[11];
                string nls = data[13];
                string lcv = data[14];
                string Dat1_url = data[15];
                string Dat2_url = data[16];
                string cp_ref = data[17];
                string title = string.Empty;
                string table = string.Empty;
                string where = string.Empty;

                string sql = GetSqlTemplate(data);

                Dictionary<string, object> excelArgs = new Dictionary<string, object>();

                string localBD = Convert.ToString(Session["LocalBDate"]);
                if (type == "0")
                {
                    //SetRole(base_role);
                    SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);

                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    where = "a.rnk=:rnk";

                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";
                }
                else if (type == "1")
                {
                    //SetRole("WR_USER_ACCOUNTS_LIST");
                    if (localBD == "1")
                        table = "WEB_SAL";
                    else
                        table = "WEB_SAL_LITE";
                }
                else if (type == "2")
                {
                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                    {
                        table = "V_TOBO_ACCOUNTS_LITE";
                    }
                    sql += ", a.R013 R013, a.OKPO \"ЄДРПОУ\"";
                }
                else if (type == "3")
                {
                    ///SetRole("WR_ND_ACCOUNTS");
                    SetParameters("nd", DB_TYPE.Decimal, nd, DIRECTION.Input);
                    table = "V_ND_ACCOUNTS";
                    where = "a.nd=:nd";
                }
                else if (type == "4")
                {
                    SetRole("WR_DEPOSIT_U");
                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=" + rnk + ""))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    table = "V_ACCOUNTS ";
                    where = "a.acc in(" + data[12] + ")";
                }
                else if (type == "5")
                {
                    SetRole(base_role);

                    table = "V_ACCOUNTS ";
                }
                else if (type == "6")
                {
                    SetRole(base_role);
                    SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
                    SetParameters("lcv", DB_TYPE.Varchar2, lcv, DIRECTION.Input);
                    table = "V_ACCOUNTS";
                    where = @"a.accc  in(select acc from accounts where nls=:nls
                            and kv = (select kv from tabval where lcv = :lcv))";

                }
                else if (type == "7")
                {
                    string stmt = Convert.ToString(SQL_SELECT_scalar("select pul.Get_Mas_Ini_Val ('WACC') stmt from dual "));
                    SetRole(base_role);
                    table = "V_ACCOUNTS";
                    if (String.IsNullOrEmpty(stmt) || stmt == null)
                    {
                        where = "1=0";
                    }
                    else
                    {
                        where = stmt;
                    }

                }
                else if (type == "8")
                {
                    SetRole("WR_TOBO_ACCOUNTS_LIST");
                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";

                    DateTime Dat1 = DateTime.ParseExact(Dat1_url, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                    DateTime Dat2 = DateTime.ParseExact(Dat2_url, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);

                    if (data[18] == "1")
                    {
                        ///Вхідний залишок (екв.)
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    }

                    //dos
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                    if (data[18] == "1")
                    {
                        ///Обороти Дебет (екв.)
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                    }

                    //kos
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                    if (data[18] == "1")
                    {
                        ///Обороти Кредит (екв.)
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                    }

                    //Out
                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                    if (data[18] == "1")
                    {
                        ///Вих.залишок (екв.)
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                    }

                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                    if (data[18] == "1")
                    {
                        ///Факт. залишок (екв.)
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                        ///План. залишок (екв.)
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                    }

                    sql = "a.acc \"Ід. рах.\"," +
                    "a.nls \"Номер рахунку\"," +
                    "a.lcv \"Вал.\"," +
                    "a.nms \"Найменування рах.\"," +
                    "a.daos \"Дата відкриття\"," +
                    "(fost_h(a.acc,:Dat1) + fdos(a.acc,:Dat1,:Dat1) - fkos(a.acc,:Dat1,:Dat1))/a.denom \"Вхідн.залишок\"," +
                    ((data[18] == "1") ? "gl.p_icurval(a.kv, fost_h(a.acc, :Dat1) + fdos(a.acc, :Dat1, :Dat1) - fkos(a.acc, :Dat1, :Dat1), :Dat1)/a.denom \"Вхідн. залишок (екв.)\" /*OSTEQ*/ ," : "") +
                    "fdos(a.acc,:Dat1,:Dat2)/a.denom \"Обороти Дебет\"," +
                    ((data[18] == "1") ? "fdosq_d(a.acc, :Dat1, :Dat2)/a.denom \"Обороти Дебет (екв.)\" /*DOSEQ*/ ," : "") +
                    "fkos(a.acc,:Dat1,:Dat2)/a.denom \"Обороти Кредит\"," +
                    ((data[18] == "1") ? "fkosq_d(a.acc, :Dat1, :Dat2)/a.denom \"Обороти Кредит (екв.)\" /*KOSEQ*/ ," : "") +
                    "fost_h(a.acc,:Dat2)/a.denom \"Вих.залишок\"," +
                    /*((data[18] == "1") ? "(select case when a.kv <> 980 then gl.p_icurval(a.kv, ostf + dos - kos, sa.fdat) else ost + dos - kos end " +
                               "  from saldoa sa " +
                               "  where sa.acc = a.acc " +
                               "  and sa.fdat = least(:Dat2, bankdate))/a.denom \"Вих. залишок (екв.)\"  ," : "") + */

                    ((data[18] == "1") ? "(case when a.kv <> 980 then gl.p_icurval(a.kv, fost_h(a.acc, :Dat2), :Dat2) else fost_h(a.acc, :Dat2) end) " +
                               "/a.denom \"Вих. залишок (екв.)\"," : "") +

                    "a.denom \"Ден.\"," +
                    "a.blkd \"Блок Дебет\"," +
                    "a.blkk \"Блок Кредит\"," +
                    //"a.OSTC/a.denom \"Фактичний залишок\"," +
                    "fost_h(a.acc,:Dat2)/a.denom \"Фактичний залишок\"," +
                    ((data[18] == "1") ? "gl.p_icurval (a.kv, fost(a.acc,LEAST (:Dat2, bankdate)), LEAST ( :Dat2, bankdate))/a.denom  \"Фактичний залишок (екв.)\"," : "") +
                    "a.ostb/a.denom  \"План.залишок\"," +
                    ((data[18] == "1") ? "gl.p_icurval (a.kv, a.ostb, LEAST ( :Dat2, bankdate))/a.denom \"План. залишок (екв.)\" /*OSTBEQ*/ ," : "") +
                    " DECODE(a.DAZS,NULL,1,2) MOD," +
                    "a.rnk \"РНК клієнта\"," +
                    "a.fio \"ФІО\"," +
                    "DECODE(a.pap,'1','A','2','П','3','А/П') \"Акт Пас\"," +
                    "a.tip \"Тип рахунку\"," +
                    "a.dapp \"Дата ост. руху\"," +
                    "a.dazs \"Дата закриття\"," +
                    "a.tobo \"Відділення\"," +
                    "a.ob22 \"об22\"," +
                    "a.VID \"Вид\", a.acc, a.kv";

                    if (Session["prev_acc_data"] != null)
                    {
                        var dataPrev = (string[])Session["prev_acc_data"];
                        if (string.IsNullOrEmpty(data[0]))
                            data[0] = dataPrev[0];
                        data[1] = dataPrev[1];
                    }
                }
                else if (type == "9")
                {
                    SetRole(base_role);
                    table = "V_CP_ACCOUNTS ";
                }
                else if (type == "10")
                {
                    SetRole(base_role);
                    table = "V_ACCOUNTS ";
                }
                else if (type == "11")
                {
                    SetRole(base_role);
                    table = "V_ACCOUNTS ";
                }

                //Добавление колонки по процентной ставке
                if (data[21] == "1")
                {
                    sql += ", a.INTACCN \"%% Ставка\" " +
                           ", a.MDATE \"Планова дата погашення\"";
                }

                string selStatement = BuildSelectStatementForTable(sql, table + " a", where, data, false);
                string query = selStatement;
                string replaceExp = sql;
                query = query.Replace("a.rnk RNK,", "a.rnk RNK,a.kv,");
                if (query.Contains(":Dat1"))
                {
                    query = query.Replace(":Dat1", "to_date('" + Dat1_url + "', 'DD.MM.YYYY')");
                    replaceExp = replaceExp.Replace(":Dat1", "to_date('" + Dat1_url + "', 'DD.MM.YYYY')");
                    excelArgs.Add("Dat1", Dat1_url);
                }
                if (query.Contains(":Dat2"))
                {
                    query = query.Replace(":Dat2", "to_date('" + Dat2_url + "', 'DD.MM.YYYY')");
                    replaceExp = replaceExp.Replace(":Dat2", "to_date('" + Dat2_url + "', 'DD.MM.YYYY')");
                    excelArgs.Add("Dat2", Dat2_url);
                }
                Session["SQL_CURRENCY"] = "select distinct t.acc, t.kv from (" + query + ") t";
                ///////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////

                int rowsCount = 0;

                if (false == forceExecute && (rowsCount = GetRowsCount(query, replaceExp)) > rowsLimit)
                {
                    return rowsCount.ToString();
                }

                if (!string.IsNullOrEmpty(data[3]))
                {
                    selStatement = AppendSorting(data, selStatement, "a");
                    query = AppendSorting(data, query, "a");
                }

                DataSet ds = SQL_SELECT_dataset(selStatement);

                excelArgs.Add("query", query);

                return CreateExcelFile(ds, excelArgs);
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        private static string AppendSorting(string[] data, string query, string tabAlias)
        { 
            System.Text.StringBuilder queryBuilder = new System.Text.StringBuilder();
            queryBuilder.AppendFormat("{0} ORDER BY {1}.", query, tabAlias);
            
            var sortParams = data[3].Split(' ');
            //sortParams[0] is field and sortParams[1] is asc|desc
            switch (sortParams[0])
            {
                case "DAOS_SORT":
                    queryBuilder.Append("daos");
                    break;
                case "DAZS_SORT":
                    queryBuilder.Append("dazs");
                    break;
                case "DAPP_SORT":
                    queryBuilder.Append("dapp");
                    break;
                default:
                    queryBuilder.Append(sortParams[0]);
                    break;
            }
            queryBuilder.AppendFormat(" {0}", sortParams[1]);

            return queryBuilder.ToString();
        }

        [WebMethod(EnableSession = true)]
        public string ShowCustomersAndAccountsExcelExport(string[] data, bool? forceExecute = null)
        {
            try
            {
                InitOraConnection(Context);
                SetRole(base_role);
                string fields = "DISTINCT " +
                                "a.rnk \"Реєстр.Номер\"," +
                                "a.okpo \"ЕДРПОУ \\ іден. код\"," +
                                "a.nd \"Номер документа\"," +
                                "a.custtypename \"Тип контрагента\"," +
                                "DECODE(TRIM(a.sed),'91','V','') \"Підпр.\"," +
                                "a.nmk \"Найменування\"," +
                                "a.DATE_ON as \"Дата реєстрації\"," +
                                "a.DATE_OFF as \"Дата закриття\"," +
                                "a.branch \"Код безбаланс. відділення\""; //+
                                                                          //"decode(a.branch,sys_context('bars_context', 'user_branch'),1,0) branch_owner,"+
                                                                          //"req_type,"+
                                                                          //"req_status";

                string table = string.Empty;
                if (data.Length >= 22 && data[21] == "restriction")
                {
                    table = "V_TOBO_CUST_RSTN  a";
                }
                else
                {
                    table = "V_TOBO_CUST" + data[10] + " a";
                }


                if (false == forceExecute)
                {
                    int rowsCount = 0;
                    string query = BuildSelectStatementForTable(fields, table, "", data, false);
                    rowsCount = GetRowsCount(query, fields);

                    if (rowsCount > rowsLimit)
                    {
                        return rowsCount.ToString();
                    }
                }

                DataSet ds = GetFullDataSetForTable(fields, table, "", data);

                return CreateExcelFile(ds);
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] GetData(string[] data)
        {
            try
            {
                InitOraConnection(Context);
                SetRole(base_role);
                string query = @"DISTINCT
                                a.rnk RNK,
                                a.okpo OKPO,
                                a.nd ND,
                                a.custtypename NAME,
                                DECODE(TRIM(a.sed),'91','V','') B,
                                a.nmk NMK,
                                a.DATE_ON as DAT_ON, 
                                a.DATE_OFF as DAT_OFF,
                                a.branch BRANCH,
                                decode(a.branch,sys_context('bars_context', 'user_branch'),1,0) branch_owner,
                                req_type,
                                req_status";

                if (data.Length >= 22 && data[21] == "restriction")
                {
                    return BindTableWithNewFilter(query, "V_TOBO_CUST_RSTN  a", "", data);
                }
                return BindTableWithNewFilter(query, "V_TOBO_CUST" + data[10] + " a", "", data);
            }
            finally
            {
                DisposeOraConnection();
            }
        }


        [WebMethod(EnableSession = true)]
        public string CloseCustomer(string rnk)
        {
            try
            {
                InitOraConnection(Context);
                SetRole(base_role);

                ClearParameters();
                SetParameters("p_rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                int count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) FROM accounts a, cust_acc ca WHERE a.acc=ca.acc and ca.rnk=:p_rnk and a.dazs is null").ToString());
                if (count != 0)
                    return "У клиента в наличии " + count + " незакрытых счетов!";
                int countTrustee = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(t.rnk) FROM dpt_trustee t WHERE t.fl_act > 0 and rnk_tr=:p_rnk").ToString());
                if (countTrustee != 0)
                    return "Клиент выступает доверенным лицом в депозитном модуле!";
                DateTime date = Convert.ToDateTime(SQL_SELECT_scalar("SELECT date_on FROM customer WHERE rnk=:p_rnk"), cinfo);
                ClearParameters();
                DateTime bdate = Convert.ToDateTime(SQL_SELECT_scalar("SELECT bankdate FROM dual"), cinfo);
                if (bdate < date)
                    return "Клиент не может быть закрыт датой (" + bdate.ToShortDateString() + "), меньшей даты открытия (" + date.ToShortDateString() + ").";
                SetParameters("date_off", DB_TYPE.Date, bdate, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SQL_NONQUERY("UPDATE customer SET date_off=:date_off WHERE rnk=:rnk");

                if (IsUseBpkValidation())
                {
                    try
                    {
                        ClearParameters();
                        var kf = Convert.ToString(SQL_SELECT_scalar("SELECT f_ourmfo FROM dual"));
                        _cdmRepo.SendCloseCard(kf, Convert.ToDecimal(rnk), bdate.ToString("yyyy-MM-dd"));
                    }
                    catch (Exception e)
                    {
                        DbLoggerConstruct.NewDbLogger().Error("Помилка передачі даних про закриття клієнта rnk=" + rnk +
                            " до ЄБК:" + (e.InnerException == null ? e.Message : e.InnerException.Message), "ClientRegister");
                    }
                }

                return "";
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public string ResurectCustomer(string rnk)
        {
            try
            {
                InitOraConnection(Context);
                SetRole(base_role);
                string d = Convert.ToString(SQL_SELECT_scalar("SELECT date_off FROM customer WHERE rnk=" + rnk));
                if (d == "") return "Клиент не закрыт!";
                DateTime date = Convert.ToDateTime(d, cinfo);
                DateTime bdate = Convert.ToDateTime(SQL_SELECT_scalar("SELECT bankdate FROM dual"), cinfo);
                if (bdate < date)
                    return "Клиент не может быть перерегистрирован датой (" + bdate.ToShortDateString() + "), меньшей даты открытия (" + date.ToShortDateString() + ").";
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SQL_NONQUERY("UPDATE customer SET date_off=NULL WHERE rnk=:rnk");
                ClearParameters();
                SetParameters("p_rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SQL_NONQUERY("BEGIN fm_set_rizik(:p_rnk); END;");
                ClearParameters();
                return "";
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] ShowHistory(string[] data)
        {
            object[] obj = new object[5];
            string rnk = data[9];
            string date1 = data[10];
            string date2 = data[11];
            string Mode = data[12];
            string type = data[13];
            string role = base_role;
            try
            {
                InitOraConnection(Context);
                switch (type)
                {
                    case "0":
                        role = "wr_custlist";
                        break;
                    case "1":
                        role = "WR_USER_ACCOUNTS_LIST";
                        break;
                    case "2":
                        role = "WR_TOBO_ACCOUNTS_LIST";
                        break;
                    case "3":
                        role = "WR_ND_ACCOUNTS";
                        break;
                    case "4":
                        role = "WR_DEPOSIT_U";
                        break;
                    case "5":
                        role = "WR_USER_ACCOUNTS_LIST";
                        break;
                    default:
                        role = "wr_custlist";
                        break;
                }

                SetRole(role);
                if (date1 == "" || date2 == "")
                {
                    ArrayList reader = SQL_reader("select TO_CHAR(bankdate,'DD.MM.YYYY'),TO_CHAR(ADD_MONTHS(bankdate,-1),'DD.MM.YYYY') from dual");
                    date2 = Convert.ToString(reader[0]);
                    date1 = Convert.ToString(reader[1]);
                }
                SetParameters("mode", DB_TYPE.Decimal, Mode, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SetParameters("date1", DB_TYPE.Date, Convert.ToDateTime(date1, cinfo), DIRECTION.Input);
                SetParameters("date2", DB_TYPE.Date, Convert.ToDateTime(date2, cinfo), DIRECTION.Input);
                SQL_NONQUERY("BEGIN p_acchist(:mode,:rnk,:date1,:date2); END;");
                ClearParameters();
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);

                //Изправления отображения 1й колонки названия параметра для пользователей и счетов
                string s_fields = "upper(t.tabname) TABNAME,h.valold OLD, h.valnew NEW, TO_CHAR(h.dat,'DD/MM/YYYY HH24:mm:ss') DAT, h.isp USR, s.fio FIO";
                string colmn_cust = "h.parname PAR, ";
                //string colmn_acc = "c.semantic PAR, "; //old parameter

                object[] temp = BindTableWithFilter(colmn_cust + s_fields, "meta_tables t, meta_columns c, tmp_acchist h, staff$base s", "h.iduser=user_id AND h.acc=:rnk AND h.tabid=t.tabid AND t.tabid=c.tabid AND h.colid=c.colid AND h.isp=s.logname", "c.semantic", data);
                obj[0] = temp[0];
                obj[1] = temp[1];
                obj[2] = date1;
                obj[3] = date2;
                ClearParameters();
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                if (Mode == "2")
                    obj[4] = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"));
                else
                    obj[4] = Convert.ToString(SQL_SELECT_scalar("select '(ACC '||acc||') '|| nls || '(' || kv || ')'||' ' ||nms from accounts where acc=:rnk"));
                return obj;
            }

            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] GetCustAcc(string[] data)
        {
            object[] obj = new object[3];
            try
            {
                InitOraConnection(Context);
                string rnk = data[9];
                string type = data[10];
                string nd = data[11];
                string nls = data[13];
                string lcv = data[14];
                string Dat1_url = data[15];
                string Dat2_url = data[16];
                string cp_ref = data[17];
                string title = string.Empty;
                string table = string.Empty;
                string where = string.Empty;

                string sql = "DECODE(a.DAZS,NULL,1,2) MOD," +
                    "a.acc ACC," +
                    "a.nls NLS," +
                    "a.nlsalt NLSALT," +
                    "a.nbs NBS," +
                    "a.lcv LCV," +
                    "a.rnk RNK," +
                    "a.nms NMS," +
                    "to_char(a.daos,'DD.MM.YYYY') DAOS," +
                    "DECODE(a.pap,'1','A','2','П','3','А/П') PAP," +
                    "a.fio FIO," +
                    "a.tip TIP," +
                    "TO_CHAR(a.dapp,'DD.MM.YYYY') DAPP," +
                    "to_char(a.dazs,'DD.MM.YYYY') DAZS," +
                    "a.tobo TOBO," +
                    "a.ost OST," +
                    "a.dos DOS," +
                    "a.kos KOS," +
                    "a.ostc OSTC," +
                    "a.denom as DIG," +
                    "a.blkd as BLKD," +
                    "a.blkk as BLKK," +
                    "a.ostb OSTB," +
                    "a.ob22 OB22," +
                    "a.VID VID," +
                    @"(SELECT CASE
                        WHEN((SELECT COUNT(VALUE)
                                FROM V_CUSTOMERW
                                WHERE RNK = a.rnk AND tag IN('DEATH', 'DTDIE')) = 2)
                        THEN
                            1
                        ELSE
                            0
                        END
                    FROM DUAL) AS IS_DEAD," +
                    "a.daos as DAOS_SORT," +
                    "a.dapp as DAPP_SORT," +
                    "a.dazs as DAZS_SORT";

                // eq
                if (data[18] == "1")
                {
                    sql += @", gl.p_icurval(a.kv, fost_h(a.acc, bankdate) + fdos(a.acc, bankdate, bankdate) -
                                    fkos(a.acc, bankdate, bankdate), bankdate) OSTEQ," +
                               "  fdosq_d(a.acc, bankdate, bankdate) DOSEQ," +
                               "  fkosq_d(a.acc, bankdate, bankdate) KOSEQ," +
                               "  (select case when a.kv <> 980 then gl.p_icurval(a.kv, ostf + dos - kos, sa.fdat) else ost + dos - kos end " +
                               "  from saldoa sa " +
                               "  where sa.acc = a.acc " +
                               "  and sa.fdat = bankdate) OSTNEXTEQ," +
                               "  gl.p_icurval(a.kv, a.ostc, bankdate) OSTCEQ," +
                               "  gl.p_icurval(a.kv, a.ostb, bankdate) OSTBEQ";

                }

                string localBD = Convert.ToString(Session["LocalBDate"]);
                if (type == "0")
                {
                    SetRole(base_role);
                    SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);

                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    where = "a.rnk=:rnk";

                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";
                }
                else if (type == "1")
                {
                    SetRole("WR_USER_ACCOUNTS_LIST");
                    if (localBD == "1")
                        table = "WEB_SAL";
                    else
                        table = "WEB_SAL_LITE";
                }
                else if (type == "2")
                {
                    Session["prev_acc_data"] = data;
                    SetRole("WR_TOBO_ACCOUNTS_LIST");
                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";

					if (!string.IsNullOrEmpty(rnk))
						where += " and rnk = " + rnk;
					if (!string.IsNullOrEmpty(nd))
						where += string.Format(" and acc in ( select acc from nd_acc where nd = {0} ) ", nd);

					sql += ", a.R013, a.OKPO";
				}
                else if (type == "3")
                {
                    table = "V_ND_ACCOUNTS";
                    SetRole("WR_ND_ACCOUNTS");
                    SetParameters("nd", DB_TYPE.Decimal, nd, DIRECTION.Input);
					where = " a.nd=:nd ";
                    if (!string.IsNullOrEmpty(rnk))
                    {
                        SetParameters("p_rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                        where += " and a.rnk = :p_rnk ";
                    }
                }
				else if (type == "4")
                {
                    SetRole("WR_DEPOSIT_U");
                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=" + rnk + ""))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    table = "V_ACCOUNTS ";
                    where = "a.acc in(" + data[12] + ")";
                }
                else if (type == "5")
                {
                    SetRole(base_role);

                    table = "V_ACCOUNTS ";
                }
                else if (type == "6")
                {
                    SetRole(base_role);
                    SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
                    SetParameters("lcv", DB_TYPE.Varchar2, lcv, DIRECTION.Input);
                    table = "V_ACCOUNTS";
                    where = @"a.accc  in(select acc from accounts where nls=:nls
                            and kv = (select kv from tabval where lcv = :lcv))";

                }
                else if (type == "7")
                {
                    string stmt = Convert.ToString(SQL_SELECT_scalar("select pul.Get_Mas_Ini_Val ('WACC') stmt from dual "));
                    SetRole(base_role);
                    table = "V_ACCOUNTS";
                    if (String.IsNullOrEmpty(stmt) || stmt == null)
                    {
                        where = "1=0";
                    }
                    else
                    {
                        where = stmt;
                    }

                }
                else if (type == "8")
                {
                    SetRole("WR_TOBO_ACCOUNTS_LIST");
                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";

                    DateTime Dat1 = DateTime.ParseExact(Dat1_url, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                    DateTime Dat2 = DateTime.ParseExact(Dat2_url, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    //dos
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                    //kos
                    SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                    //Out
                    SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                    sql = "DECODE(a.DAZS,NULL,1,2) MOD," +
                    "a.acc ACC," +
                    "a.nls NLS," +
                    "a.lcv LCV," +
                    "a.rnk RNK," +
                    "a.nms NMS," +
                    "to_char(a.daos,'DD.MM.YYYY') DAOS," +
                    "DECODE(a.pap,'1','A','2','П','3','А/П') PAP," +
                    "a.fio FIO," +
                    "a.tip TIP," +
                    "TO_CHAR(a.dapp,'DD.MM.YYYY') DAPP," +
                    "to_char(a.dazs,'DD.MM.YYYY') DAZS," +
                    "a.tobo TOBO," +
                    "(fost_h(a.acc,:Dat1) + fdos(a.acc,:Dat1,:Dat1) - fkos(a.acc,:Dat1,:Dat1)) OST," +
                    "fdos(a.acc,:Dat1,:Dat2) DOS," +
                    "fkos(a.acc,:Dat1,:Dat2) KOS," +
                    "fost_h(a.acc,:Dat2) OSTC," +
                    "a.denom as DIG," +
                    "a.blkd as BLKD," +
                    "a.blkk as BLKK," +
                    "a.ostb OSTB," +
                    "a.ob22 OB22," +
                    "a.VID VID," +
                    "a.daos as DAOS_SORT," +
                    "a.dapp as DAPP_SORT," +
                    "a.dazs as DAZS_SORT";
                    if (data[18] == "1")
                    {
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);

                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);

                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                        SetParameters("dat1", DB_TYPE.Date, Dat1, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);
                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                        SetParameters("dat2", DB_TYPE.Date, Dat2, DIRECTION.Input);

                        sql += @", gl.p_icurval(a.kv, fost_h(a.acc, :Dat1) + fdos(a.acc, :Dat1, :Dat1) -
                                    fkos(a.acc, :Dat1, :Dat1), :Dat1) OSTEQ," +
                               "  fdosq_d(a.acc, :Dat1, :Dat2) DOSEQ," +
                               "  fkosq_d(a.acc, :Dat1, :Dat2) KOSEQ," +
                               "  (select case when a.kv <> 980 then gl.p_icurval(a.kv, ostf + dos - kos, sa.fdat) else ost + dos - kos end " +
                               "  from saldoa sa " +
                               "  where sa.acc = a.acc " +
                               "  and sa.fdat = least(:Dat2, bankdate)) OSTNEXTEQ," +
                               @" gl.p_icurval (a.kv, fost(a.acc,LEAST (:Dat2, bankdate)), LEAST ( :Dat2, bankdate)) OSTCEQ,
                                  gl.p_icurval (a.kv, a.ostb, LEAST ( :Dat2, bankdate)) OSTBEQ ";
                    }
                    if (Session["prev_acc_data"] != null)
                    {
                        var dataPrev = (string[])Session["prev_acc_data"];
                        if (string.IsNullOrEmpty(data[0]))
                            data[0] = dataPrev[0];
                        data[1] = dataPrev[1];
                    }
                    if (!string.IsNullOrEmpty(rnk))
                        where += " and rnk = " + rnk;
					if (!string.IsNullOrEmpty(nd))
						where += string.Format(" and acc in ( select acc from nd_acc where nd = {0} ) ", nd);
                    sql += ", a.R013, a.OKPO";
                }
                else if (type == "9")
                {
                    SetRole(base_role);
                    table = "V_CP_ACCOUNTS ";
                    //SetParameters("cp_ref", DB_TYPE.Decimal, cp_ref, DIRECTION.Input);
                    //where = data[1];// "a.acc in(select cp_acc from cp_accounts where cp_ref=:cp_ref)";
                }
                else if (type == "10")
                {
                    SetRole(base_role);
                    table = "V_ACCOUNTS ";
                }
                else if (type == "11")
                {
                    SetRole(base_role);
                    table = "V_ACCOUNTS ";
                }

                //Добавление колонки по процентной ставке
                if (data[21] == "1")
                {
                    sql += ", a.INTACCN INTACCN, to_char(a.MDATE,'DD.MM.YYYY') MDATE , a.MDATE MDATE_SORT";
                }

                string query = BuildSelectStatementForTable(sql, table + " a", where, data, false);

                query = query.Replace("a.rnk RNK,", "a.rnk RNK,a.kv,");
                if (query.Contains(":Dat1"))
                    query = query.Replace(":Dat1", "to_date('" + Dat1_url + "', 'DD.MM.YYYY')");
                if (query.Contains(":Dat2"))
                    query = query.Replace(":Dat2", "to_date('" + Dat2_url + "', 'DD.MM.YYYY')");

                Session["SQL_CURRENCY"] = "select distinct t.acc, t.kv from (" + query + ") t";

                obj = BindTableWithNewFilter(sql, table + " a ", where, data, new LogParams { CallerName = "CustService.GetCustAcc" });

                obj[2] = title;
                return obj;
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public string total_currency()
        {

            return "";
        }

        [WebMethod(EnableSession = true)]
        public object[] GetDataHistory(string[] data)
        {
            InitOraConnection(Context);
            //object[] result = new object[4];
            string[] result = new string[4];
            try
            {
                string type = data[13];
                string role = string.Empty;
                string table = string.Empty;
                switch (type)
                {
                    case "0":
                        role = "wr_custlist";
                        table = "V_TOBO_ACCOUNTS";
                        break;
                    case "1":
                        role = "WR_USER_ACCOUNTS_LIST";
                        table = "WEB_SAL";
                        break;
                    case "2":
                        role = "WR_TOBO_ACCOUNTS_LIST";
                        table = "V_TOBO_ACCOUNTS";
                        break;
                    case "3":
                        role = "WR_ND_ACCOUNTS";
                        table = "V_ND_ACCOUNTS";
                        break;
                    case "4":
                        role = "WR_DEPOSIT_U";
                        table = "V_ACCOUNTS";
                        break;
                    default:
                        role = "wr_custlist";
                        table = "V_TOBO_ACCOUNTS";
                        break;
                }

                SetRole(role);

                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                cinfo.DateTimeFormat.DateSeparator = ".";

                DateTime srtDate = Convert.ToDateTime(data[11].Trim(), cinfo);
                DateTime endDate = Convert.ToDateTime(data[12].Trim(), cinfo);
                long acc = Convert.ToInt64(data[10].Trim(), cinfo);

                string filter = " FDAT BETWEEN :srtDate and :endDate and ACC = :pacc ";

                ClearParameters();
                SetParameters("pacc", DB_TYPE.Int64, acc, DIRECTION.Input);

                string sql = "SELECT NLS,'№'||NLS||'('||LCV||')' FROM " + table + " WHERE ACC = :pacc";
                ArrayList reader = SQL_reader(sql);
                if (reader.Count == 0)
                    throw new Exception("История данного счета недоступна текущему пользователю.");
                string title = Resources.customerlist.GlobalResources.titleHistory + " " + Convert.ToString(reader[1]);
                string nls = Convert.ToString(reader[0]);

                ClearParameters();
                SetParameters("srtDate", DB_TYPE.Date, srtDate, DIRECTION.Input);
                SetParameters("endDate", DB_TYPE.Date, endDate, DIRECTION.Input);
                SetParameters("pacc", DB_TYPE.Int64, acc, DIRECTION.Input);

                object[] xml = BindTableWithFilter(@" a.acc,
                                                    (select power(10, t.dig)
                                                       from tabval t
                                                      where t.kv = (select ac.kv from accounts ac where ac.acc = a.acc)) as dig,
                                                    to_char(a.fdat, 'dd.mm.yyyy') as ch_fdat,
                                                    a.ostf as ch_ostf,
                                                    a.dos as ch_dos,
                                                    a.kos as ch_kos,
                                                    (a.ostf + a.kos - a.dos) as ch_ost ", "saldoa a", filter, data);

                result[0] = xml[0].ToString();
                result[1] = xml[1].ToString();
                result[2] = title;
                result[3] = nls;
                SessionDataDateArr = result;

            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public string ReanimAcc(string acc)
        {
            string result = "Счет ";
            try
            {
                InitOraConnection(Context);
                SetRole(base_role);
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                if (Convert.ToString(SQL_SELECT_scalar("SELECT c.date_off FROM customer c, cust_acc b WHERE c.rnk=b.rnk AND b.acc=:acc")) != "")
                {
                    return result + "не может быть восстановлен, так как закрыт контрагент";
                }
                string dat1 = Convert.ToString(SQL_SELECT_scalar("select TO_CHAR(bankdate,'DD.MM.YYYY') from dual"));
                string dat2 = Convert.ToString(SQL_SELECT_scalar("SELECT TO_CHAR(DAZS,'DD.MM.YYYY') FROM accounts WHERE acc=:acc"));
                if ((dat2 == "") || (dat1 != dat2))
                {
                    return result + "не может быть восстановлен, так как не был закрыт вообще или закрыт не сегодня.";
                }
                var sql = @"select
                                value
                            from
                                accountsw
                            where
                                acc = :acc
                                and tag = 'RESERVED'";
                var isReserved = Convert.ToString(SQL_SELECT_scalar(sql)) == "1";
                if (isReserved)
                {
                    return "Рахунок не може бути відновлений, так як являється зарезервованим.";
                }

                SQL_NONQUERY("UPDATE accounts SET dazs=NULL WHERE acc=:acc AND dazs IS NOT NULL");
                result += "восстановлен!";
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public int ReRegistr(string acc, string rnk_old, string rnk_new)
        {
            try
            {
                InitOraConnection(Context);
                SetRole(base_role);
                DateTime d1 = Convert.ToDateTime(SQL_SELECT_scalar("SELECT DAOS FROM accounts where acc=" + acc), cinfo);
                DateTime d2 = Convert.ToDateTime(SQL_SELECT_scalar("SELECT bankdate FROM dual"), cinfo);
                if (d1 == d2)
                    return SQL_NONQUERY("BEGIN accreg.changeAccountOwner(" + acc + "," + rnk_old + "," + rnk_new + ");END;");
                else
                    return 0;
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        #endregion // WebMethods

        #region Private Methods
        private string GetSqlTemplate(string[] data)
        {
            string sqlStr = " a.tobo \"Відділення\", a.OB22 \"ОБ22\", a.nls || '(' || a.kv || ')' \"Номер рахунку\" ," +
			        "a.nlsalt \"Альт. номер рахунку\"," +
                    "a.nbs \"Баланс. рахунок\"," +
                    "a.lcv \"Валюта\"," +
                    "a.nms \"Найменування рах.\"," +
                    "a.daos \"Дата відкриття\"," +
                            (data.Length >= 26 && "1" == data[25] ?
                            (
                                "decode(sign(a.ost), 1, 0, -1, -1*a.ost, 0)/a.denom  \"Вхідний залишок Дебет\"," +
                                ((data[18] == "1") ? " decode(sign(a.ost), 1, 0, -1, gl.p_icurval(a.kv, (-1*a.ost + decode(greatest(a.dapp, nvl(a.dapp, a.dappq)),bankdate, a.dos, 0) - decode(greatest(a.dapp, nvl(a.dapp, a.dappq)),bankdate, a.kos, 0)), bankdate), 0)/a.denom  \"Вхідний залишок Дебет (екв)\", " : " ") +
                                "decode(sign(a.ost), -1, 0, 1, a.ost, 0)/a.denom  \"Вхідний залишок Кредит\"," +
                                ((data[18] == "1") ? " decode(sign(a.ost), -1, 0, 1, gl.p_icurval(a.kv, (a.ost + decode(greatest(a.dapp, nvl(a.dapp, a.dappq)),bankdate, a.dos, 0) - decode(greatest(a.dapp, nvl(a.dapp, a.dappq)),bankdate, a.kos, 0)), bankdate), 0)/a.denom  \"Вхідний залишок Кредит (екв)\", " : " ")
                            ) : "a.ost/a.denom \"Вхідний залишок\", " + ((data[18] == "1") ? "gl.p_icurval(a.kv, (a.ost + decode(greatest(a.dapp, nvl(a.dapp, a.dappq)), bankdate, a.dos, 0) - decode(greatest(a.dapp, nvl(a.dapp, a.dappq)), bankdate, a.kos, 0)), bankdate)/a.denom  \"Вхідний залишок (екв)\", " : " ")) +
                            "a.dos/100 \"Обороти Дебет\"," +
                             ((data[18] == "1") ? " gl.p_icurval(a.kv, decode(greatest(a.dapp, nvl(a.dapp, a.dappq)), bankdate, a.dos, 0), bankdate)/a.denom  \"Обороти Дебет (екв)\", " : " ") +
                            "a.kos/100 \"Обороти Кредит\"," +
                             ((data[18] == "1") ? " gl.p_icurval(a.kv, decode(greatest(a.dapp, nvl(a.dapp, a.dappq)), bankdate, a.kos, 0), bankdate)/a.denom   \"Обороти Кредит (екв)\", " : " ") +
                            //"a.ostc/100 \"Фактичний залишок\"," +
                            (data.Length >= 26 && "1" == data[25] ?
                            (
                                "decode(sign(a.ostc), 1, 0, -1, -1*a.ostc, 0)/a.denom  \"Фактичний залишок Дебет\"," +
                                ((data[18] == "1") ? "decode(sign(a.ostc), 1, 0, -1, gl.p_icurval(a.kv, -1*a.ostc, bankdate), 0)/a.denom  \"Фактичний залишок Дебет(екв)\"," : " ") +
                                "decode(sign(a.ostc), -1, 0, 1, a.ostc, 0)/a.denom   \"Фактичний залишок Кредит\"," +
                                ((data[18] == "1") ? "decode(sign(a.ostc), -1, 0, 1, gl.p_icurval(a.kv, a.ostc, bankdate), 0)/a.denom   \"Фактичний залишок Кредит(екв)\"," : " ")
                            ) : "a.ostc/a.denom \"Фактичний залишок\", " + ((data[18] == "1") ? "gl.p_icurval(a.kv, a.ostc, bankdate)/a.denom  \"Фактичний залишок (екв)\"," : " ")) +
                            //"a.ostb/100 \"Плановий залишок\"," +
                            (data.Length >= 26 && "1" == data[25] ?
                            (
                                "decode(sign(a.ostb), 1, 0, -1, -1*a.ostb, 0)/a.denom  \"Плановий залишок Дебет\"," +
                                ((data[18] == "1") ? " decode(sign(a.ostb), 1, 0, -1, gl.p_icurval(a.kv, -1*a.ostb, bankdate), 0)/a.denom  \"Плановий залишок Дебет (екв)\", " : " ") +
                                "decode(sign(a.ostb), -1, 0, 1, a.ostb, 0)/a.denom   \"Плановий залишок Кредит\"," +
                                ((data[18] == "1") ? " decode(sign(a.ostb), -1, 0, 1,  gl.p_icurval(a.kv, a.ostb, bankdate), 0)/a.denom  \"Плановий залишок Кредит (екв)\", " : " ")
                            ) : "a.ostb/a.denom \"Плановий залишок\", " + ((data[18] == "1") ? "gl.p_icurval(a.kv, a.ostb, bankdate)/a.denom  \"Плановий залишок (екв)\"," : " ")) +
                    "a.dazs \"Дата закриття\"," +
                    "a.dapp \"Дата ост. руху\"," +
                    "a.rnk \"РНК клієнта\"," +
                    "a.fio \"ФІО\"," +
                    "DECODE(a.pap,'1','A','2','П','3','А/П') \"Акт Пас\"," +
                    " a.kv, a.acc," +
                    "a.tip \"Тип рахунку\"";
            return sqlStr;
        }

        private static string CreateExcelFile(DataSet ds, Dictionary<string, object> args=null )
        {
            #region Using ExcelHelper
            List<string> moneyWildcards = new List<string> { "оборот", "кредит", "дебет", "залишок", "сума" };

            List<int> moneyColumns = new List<int>();
            for (int i = 0, max = ds.Tables[0].Columns.Count; i < max; i++)
            {
                foreach (var mw in moneyWildcards)
                {
                    if (ds.Tables[0].Columns[i].Caption.ToLower().Contains(mw.ToLower()))
                    {
                        moneyColumns.Add(i + 1);
                    }
                }
            }

            var rep = new RegisterCountsDPARepository();
            var userInf = rep.GetPrintHeader();

            string fileXls = Path.GetTempFileName() + ".xls";


            List<Dictionary<string, object>> res = new List<Dictionary<string, object>>();

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                Dictionary<string, object> row = new Dictionary<string, object>();
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    string key = ds.Tables[0].Columns[j].Caption;
                    var value = ds.Tables[0].Rows[i][j];
                    row[key] = value;
                }
                res.Add(row);
            }

            List<string[]> fileContentHat = new List<string[]>();
            for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
            {
                string[] caption = new string[] { ds.Tables[0].Columns[i].ColumnName, ds.Tables[0].Columns[i].Caption };
                if (null!=args)
                {
                    switch (caption[1])
                    {
                        case "Вхідн.залишок":
                            caption[1] += " " + args["Dat1"];
                            break;
                        case "Вих.залишок":
                            caption[1] += " " + args["Dat2"];
                            break;
                        default:
                            break;
                    }
                }
                fileContentHat.Add(caption);
            }

            List<TableInfo> tableInfo = new List<TableInfo>();
            for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
            {
                string colDataType = string.Empty;
                int excelRowNum = i + 1;
                if (moneyColumns.Contains(excelRowNum))
                {
                    colDataType = "Money";
                }
                else
                {
                    colDataType = ds.Tables[0].Columns[i].DataType.FullName;
                }

                tableInfo.Add(new TableInfo(ds.Tables[0].Columns[i].ColumnName, ds.Tables[0].Columns[i].MaxLength, colDataType, ds.Tables[0].Columns[i].AllowDBNull));
            }

            List<string> hat = new List<string>
                {
                    "АТ 'ОЩАДБАНК'",
                    "Користувач:" + userInf.USER_NAME,
                    "Дата: " + userInf.DATE.ToString("dd'.'MM'.'yyyy") + " Час: " + userInf.DATE.Hour + ":" + userInf.DATE.Minute + ":" + userInf.DATE.Second
                };
            var excel = new ExcelHelpers<List<Dictionary<string, object>>>(res, fileContentHat, tableInfo, null, hat, args == null ? "" : Convert.ToString(args["query"]));

            using (MemoryStream ms = excel.ExportToMemoryStream())
            {
                ms.Position = 0;
                File.WriteAllBytes(fileXls, ms.ToArray());
            }
            #endregion

            return fileXls;
        }

        private int GetRowsCount(string sqlQueryString, string fields)
        {
            string countQuery = sqlQueryString.Replace(fields, "count(1)");

            int rowsAmount;
            int.TryParse(SQL_SELECT_scalar(countQuery).ToString(), out rowsAmount);

            return rowsAmount;
        }

        private bool IsUseBpkValidation()
        {
            return true;
        }

        #endregion // Private Methods
    }
}
