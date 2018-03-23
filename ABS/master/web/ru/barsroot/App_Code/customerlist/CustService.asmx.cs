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

namespace CustomerList
{
    public class CustService : BarsWebService
    {
        string base_role = "wr_custlist";

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        public CustService()
        {
            InitializeComponent();
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
        }
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

        [WebMethod(EnableSession = true)]
        public string ExportExcel(string[] data)
        {
            try
            {
                InitOraConnection(Context);
                string rnk = data[9];
                string type = data[10];
                string nd = data[11];
                string title = string.Empty;
                string table = string.Empty;
                string where = string.Empty;

                string sql = "a.tobo \"Відділення\", a.OB22 \"ОБ22\", a.nls || '(' || a.kv || ')' \"Номер рахунку\" ," +
                    "a.lcv \"Валюта\"," +
                    "a.rnk \"РНК клієнта\"," +
                    "a.nms \"Найменування рах.\"," +
                    "a.daos \"Дата відкриття\"," +
                    "a.ost/100 \"Вхідний залишок\"," +
                    "a.dos/100 \"Обороти Дебет\"," +
                    "a.kos/100 \"Обороти Кредит\"," +
                    "a.ostc/100 \"Фактичний залишок\"," +
                    "a.ostb/100 \"Плановий залишок\"," +
                    "a.dazs \"Дата закриття\"," +
                    "TO_CHAR(a.dapp,'DD.MM.YYYY') \"Дата ост. руху\"," +
                    "DECODE(a.pap,'1','A','2','П','3','А/П') \"Акт Пас\"," +
                    "a.tip \"Тип рахунку\"";
                string localBD = Convert.ToString(Session["LocalBDate"]);
                if (type == "0")
                {
                    SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);

                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    where = "a.acc in (select acc from cust_acc where rnk=:rnk)";

                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";
                }
                else if (type == "1")
                {
                    if (localBD == "1")
                        table = "WEB_SAL";
                    else
                        table = "WEB_SAL_LITE";
                }
                else if (type == "2" || type == "8")
                {
                    if (localBD == "1")
                        table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";

                    if (Session["prev_acc_data"] != null && type == "8")
                    {
                        var dataPrev = (string[])Session["prev_acc_data"];
                        if (string.IsNullOrEmpty(data[0]))
                            data[0] = dataPrev[0];
                        data[1] = dataPrev[1];
                    }
                }
                else if (type == "3")
                {
                    SetParameters("nd", DB_TYPE.Decimal, nd, DIRECTION.Input);
                    table = "V_ND_ACCOUNTS";
                    where = "a.nd=:nd";
                }
                else if (type == "4")
                {
                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=" + rnk + ""))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    table = "V_ACCOUNTS ";
                    where = "a.acc in(" + data[12] + ")";
                }

                DataSet ds = GetFullDataSetForTable(sql, table + " a", where, data);

                var tw = new StringWriter();
                var hw = new System.Web.UI.HtmlTextWriter(tw);
                DataGrid dgGrid = new DataGrid();
                dgGrid.DataSource = ds.Tables[0];
                dgGrid.DataBind();
                dgGrid.RenderControl(hw);

                string fileXls = Path.GetTempFileName() + ".xls";
                using (StreamWriter sw = new StreamWriter(fileXls))
                    sw.WriteLine(tw.ToString());
                return fileXls;
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
                return BindTableWithNewFilter(@"DISTINCT
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
                                                req_status",
                                              "V_TOBO_CUST" + data[10] + " a", "", data);
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        private bool IsUseBpkValidation()
        {
            return true;
        }

        public ICdmRepository _cdmRepo
        {
            get
            {
                var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
                var kernel = ninjectKernel.GetKernel();
                return kernel.Get<ICdmRepository>();
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
                object[] temp = BindTableWithFilter("c.semantic PAR,upper(t.tabname) TABNAME,h.valold OLD, h.valnew NEW, TO_CHAR(h.dat,'DD/MM/YYYY') DAT, h.isp USR, s.fio FIO", "meta_tables t, meta_columns c, tmp_acchist h, staff$base s", "h.iduser=user_id AND h.acc=:rnk AND h.tabid=t.tabid AND t.tabid=c.tabid AND h.colid=c.colid AND h.isp=s.logname", "c.semantic", data);
                obj[0] = temp[0];
                obj[1] = temp[1];
                obj[2] = date1;
                obj[3] = date2;
                ClearParameters();
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                obj[4] = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"));
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

                Bars.WebServices.NewNbs ws = new Bars.WebServices.NewNbs();
                string a = "";
                if (ws.UseNewNbs())
                {
                    a = "('2620','2630')";
                }
                else
                {
                    a = "('2620','2630','2635')";
                }

                string sql = "DECODE(a.DAZS,NULL,1,2) MOD," +
                    "a.acc ACC," +
                    "a.nls NLS," +
                    "a.nlsalt NLSALT," +
                    "a.lcv LCV," +
                    "a.rnk RNK," +
                    "a.nms NMS," +
                    "to_char(a.daos,'DD.MM.YYYY') DAOS," +
                    "DECODE(a.pap,'1','A','2','П','3','А/П') PAP," +
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
                    "a.daos as DAOS_SORT," +
                    "a.dapp as DAPP_SORT," +
                    "a.dazs as DAZS_SORT," +
                    "(select okpo from V_CUSTOMER where RNK=a.rnk) AS OKPO," +
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
                    "case when a.nbs in " + a + " then acrn.fproc(a.acc) else null end PERCENT";

                // eq
                if (data[18] == "1")
                {
                    sql += ", gl.p_icurval(a.kv, (a.ostc + decode(greatest(a.dapp, nvl(a.dapp, a.dappq)),bankdate, a.dos, 0) - decode(greatest(a.dapp, nvl(a.dapp, a.dappq)),bankdate, a.kos, 0)), bankdate) OSTEQ, " +
                           "  gl.p_icurval(a.kv, decode(greatest(a.dapp, nvl(a.dapp, a.dappq)), bankdate, a.dos, 0), bankdate) DOSEQ," +
                           "  gl.p_icurval(a.kv, decode(greatest(a.dapp, nvl(a.dapp, a.dappq)), bankdate, a.kos, 0), bankdate) KOSEQ, " +
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
                    where = "a.acc in (select acc from cust_acc where rnk=:rnk)";

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
                }
                else if (type == "3")
                {
                    SetRole("WR_ND_ACCOUNTS");
                    SetParameters("nd", DB_TYPE.Decimal, nd, DIRECTION.Input);
                    table = "V_ND_ACCOUNTS";
                    where = "a.nd=:nd";
                }
                else if (type == "4")
                {
                    SetRole("WR_DEPOSIT_U");
                    if ((title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=" + rnk + ""))) == "")
                        throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
                    table = "V_ACCOUNTS";
                    where = "a.acc in(" + data[12] + ")";
                }
                else if (type == "5")
                {
                    SetRole(base_role);

                    table = "V_ACCOUNTS";
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
                    table = "V_CP_ACCOUNTS";
                    //SetParameters("cp_ref", DB_TYPE.Decimal, cp_ref, DIRECTION.Input);
                    //where = data[1];// "a.acc in(select cp_acc from cp_accounts where cp_ref=:cp_ref)";
                }
                else if (type == "10")
                {
                    SetRole(base_role);
                    table = "V_ACCOUNTS";
                }
                else if (type == "11")
                {
                    SetRole(base_role);
                    table = "V_ACCOUNTS_PREM";
                }

                string query = BuildSelectStatementForTable(sql, table + " a", where, data, false);
                query = query.Replace("RNK,", "RNK, a.kv,");
                if (query.Contains(":Dat1"))
                    query = query.Replace(":Dat1", "to_date('" + Dat1_url + "', 'DD.MM.YYYY')");
                if (query.Contains(":Dat2"))
                    query = query.Replace(":Dat2", "to_date('" + Dat2_url + "', 'DD.MM.YYYY')");

                Session["SQL_CURRENCY"] = "select distinct t.acc, t.kv from (" + query + ") t";


                obj = BindTableWithNewFilter(sql, table + " a", where, data);
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
            object[] result = new object[4];
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
                ArrayList reader = SQL_reader("SELECT NLS,'№'||NLS||'('||LCV||')' FROM " + table + " WHERE ACC = :pacc");
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
                result[0] = xml[0];
                result[1] = xml[1];
                result[2] = title;
                result[3] = nls;

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
    }
}
