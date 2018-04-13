using System;
using System.Data;
//using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Exception;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Web.Services;
using Bars.Classes;
using System.Globalization;
using Bars.Configuration;

public partial class safe_deposit_safedeposit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["safe_id"] == null ||
            (Request["custtype"] == null && Request["dpt_id"] == null))
            Response.Redirect("safeportfolio.aspx");

        if (!IsPostBack)
        {
            safe_deposit sdpt;

            if (Request["dpt_id"] == null)
            {
                sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
            }
            else
            {
                sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])),
                    Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));
                DAT_BEGIN.Enabled = false;
                DAT_END.Enabled = false;
                DEAL_DATE.Enabled = false;
                TERM.Enabled = false;
            }

            if (sdpt.deal_id != Decimal.MinValue)
                btSelectClient.Enabled = false;

            /// Юр чи фіз особа
            Decimal pcusttype = Decimal.MinValue;

            if (sdpt.custtype != Decimal.MinValue)
                pcusttype = sdpt.custtype;
            else if (Request["custtype"] != null)
                pcusttype = Convert.ToDecimal(Convert.ToString(Request["custtype"]));            

            /// Показуємо / ховаємо непотрібні дані
            SetCustType(pcusttype);

            InitLists(sdpt);
            FillControlsFromClass(sdpt);

            if (Request["rnk"] != null)
            {
                RNK.Value = Convert.ToString(Request["rnk"]);
                GetClient();
            }

            if (Request["deal_id"] != null)
                DEAL_REF.Text = Convert.ToString(Request["deal_id"]);
        }
        else if (!String.IsNullOrEmpty(RNK.Value))
            GetClient();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sdpt"></param>
    private void InitLists(safe_deposit sdpt)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN,BASIC_INFO");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterSafeType = new OracleDataAdapter();
            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "SELECT O_SK, NAME FROM SKRYNKA_TIP ORDER BY O_SK";
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            DataSet dsSafeType = new DataSet();
            adapterSafeType.Fill(dsSafeType);

            listSafeSize.DataSource = dsSafeType;
            listSafeSize.DataTextField = "NAME";
            listSafeSize.DataValueField = "O_SK";
            listSafeSize.DataBind();

            listSafeSize.SelectedIndex = listSafeSize.Items.IndexOf(listSafeSize.Items.FindByValue(sdpt.safe_type_id.ToString()));
            

            /// ТИП Сейфа НЕ МІНЯЄТЬСЯ
            listSafeSize.Enabled = false;

            adapterSafeType = new OracleDataAdapter();
            cmdSelectSafeType.Parameters.Clear();
            cmdSelectSafeType.CommandText = "select tariff, name from skrynka_tariff where o_sk = :o_sk order by tariff";
            cmdSelectSafeType.Parameters.Add("O_SK", OracleDbType.Decimal, sdpt.safe_type_id, ParameterDirection.Input);
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            dsSafeType = new DataSet();
            adapterSafeType.Fill(dsSafeType);

            listTarif.DataSource = dsSafeType;
            listTarif.DataTextField = "name";
            listTarif.DataValueField = "tariff";
            listTarif.DataBind();

            if (sdpt.tarif_id != Decimal.MinValue)
                listTarif.SelectedIndex = listTarif.Items.IndexOf(listTarif.Items.FindByValue(sdpt.tarif_id.ToString()));

            adapterSafeType = new OracleDataAdapter();
            cmdSelectSafeType.Parameters.Clear();
            cmdSelectSafeType.CommandText = "SELECT s.userid id, ss.fio fio " +
               "FROM skrynka_staff s, staff ss " +
               "WHERE s.tip=2 AND s.userid = ss.id";
            dsSafeType = new DataSet();
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            adapterSafeType.Fill(dsSafeType);

            BANK_TRUSTEE.DataSource = dsSafeType;
            BANK_TRUSTEE.DataTextField = "fio";
            BANK_TRUSTEE.DataValueField = "id";
            BANK_TRUSTEE.DataBind();

            if (sdpt.bank_trustee_id != Decimal.MinValue)
                BANK_TRUSTEE.SelectedIndex = BANK_TRUSTEE.Items.IndexOf(BANK_TRUSTEE.Items.FindByValue(sdpt.bank_trustee_id.ToString()));

            adapterSafeType = new OracleDataAdapter();
            cmdSelectSafeType.Parameters.Clear();
            cmdSelectSafeType.CommandText = "SELECT id, fio FROM staff WHERE  id = (select isp_mo from skrynka where n_sk = :N_SK )";
            cmdSelectSafeType.Parameters.Add("N_SK",OracleDbType.Decimal,sdpt.safe_id, ParameterDirection.Input);
            dsSafeType = new DataSet();
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            adapterSafeType.Fill(dsSafeType);

            SAFE_MAN.DataSource = dsSafeType;
            SAFE_MAN.DataTextField = "fio";
            SAFE_MAN.DataValueField = "id";
            SAFE_MAN.DataBind();

            if (sdpt.safe_man_id != Decimal.MinValue)
                SAFE_MAN.SelectedIndex = SAFE_MAN.Items.IndexOf(SAFE_MAN.Items.FindByValue(sdpt.safe_man_id.ToString()));

            cmdSelectSafeType.Dispose();
            adapterSafeType.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Видимість даних для відмовідного типу клієнта
    /// </summary>
    /// <param name="pcusttype">тип клієнта</param>
    private void SetCustType(Decimal pcusttype)
    {
        /// Юр. особа
        if (pcusttype == 2)
        {
            f_1.Visible = false;
            f_2.Visible = false;
            j_1.Visible = true;
           // lbShowTrustee.Text = "Представник юр.особи";

            BIRTH_PLACE.Visible = false;
            lbBirthPlace.Visible = false;

            lbBDATE.Visible = false;
            BDATE.Visible = false;

       /*     
              lbTrusteeAddress.Visible = false;
              TRUSTEE_ADDRESS.Visible = false;
              lbTrusteeBPlace.Visible = false;
              TRUSTEE_BPLACE.Visible = false;
              lbTrusteeBDay.Visible = false;
              TRUSTEE_BDAY.Visible = false;
              lbTrusteeNum.Visible = false;
              TRUSTEE_NUM.Visible = false;
              TRUSTEE_DAT_BEGIN.Visible = false;
              TRUSTEE_DAT_END.Visible = false;
          */   

         //       Label15.Visible = true;
         //       Label16.Visible = true;
         //       Label17.Visible = true;
         //       Label18.Visible = true;
                Label19.Visible = true;
                Label20.Visible = true;



        }
        /// Фіз. особа
        else if (pcusttype == 3)
        {
            f_1.Visible = true;
            f_2.Visible = true;
            j_1.Visible = false;
        }
        else
            throw new SafeDepositException("Не определен тип клиента!");

        CUSTTYPE.Value = Convert.ToString(pcusttype);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sdpt"></param>
    private void FillControlsFromClass(safe_deposit sdpt)
    {
        SAFE_ID.Text = Convert.ToString(sdpt.safe_id);
        SNUM.Text = sdpt.safe_num;
        NLS.Text = sdpt.nls;
        if (sdpt.mdate != DateTime.MinValue)
            MDATE.Text = sdpt.mdate.ToString("dd/MM/yyyy");
        else
            MDATE.Text = String.Empty;
        BAIL_SUM.Value = sdpt.bail_sum;
        OSTC.Value = sdpt.ostc / 100;

        if (sdpt.deal_id != Decimal.MinValue)
            DEAL_REF.Text = Convert.ToString(sdpt.deal_id);
        else
            DEAL_REF.Text = String.Empty;
        DEAL_NUM.Text = sdpt.deal_num;
        if (sdpt.deal_date != DateTime.MinValue)
            DEAL_DATE.Date = sdpt.deal_date;
        else
            DEAL_DATE.Date = DEAL_DATE.MinDate;
        if (sdpt.deal_start_date != DateTime.MinValue)
            DAT_BEGIN.Date = sdpt.deal_start_date;
        else
            DAT_BEGIN.Date = DAT_BEGIN.MinDate;
        if (sdpt.deal_end_date != DateTime.MinValue)
            DAT_END.Date = sdpt.deal_end_date;
        else
            DAT_END.Date = DAT_END.MinDate;
        TERM.Text = Convert.ToString(sdpt.deal_length);

        FIO.Text = sdpt.fio;

        if (sdpt.custtype != Decimal.MinValue)
            CUSTTYPE.Value = Convert.ToString(sdpt.custtype);

        if (sdpt.custtype == 3)
            OKPO.Text = sdpt.okpo;
        else if (sdpt.custtype == 2)
            JOKPO.Text = sdpt.okpo;
        else
        {
            OKPO.Text = String.Empty;
            JOKPO.Text = String.Empty;
        }

        DOC.Text = sdpt.doc;
        ISSUED.Text = sdpt.issued;
        NMK.Text = sdpt.NMK;
        NLSK.Text = sdpt.nlsk;
        MFO.Text = sdpt.mfok;

        BANK.Text = sdpt.bankk;
        ADDRESS.Text = sdpt.address;
        BIRTH_PLACE.Text = sdpt.birthplace;
        if (sdpt.birthdate != DateTime.MinValue)
            BDATE.Date = sdpt.birthdate;
        else
            BDATE.Date = BDATE.MinDate;
        TEL.Text = sdpt.phone;

        TRUSTEE_FIO.Text = sdpt.trustee_fio;
        TRUSTEE_OKPO.Text = sdpt.trustee_okpo;
        TRUSTEE_DOC.Text = sdpt.trustee_doc;
        TRUSTEE_ISSUED.Text = sdpt.trustee_issued;
        TRUSTEE_ADDRESS.Text = sdpt.trustee_address;
        TRUSTEE_BPLACE.Text = sdpt.trustee_birthplace;
        if (sdpt.trustee_birthdate != DateTime.MinValue)
            TRUSTEE_BDAY.Date = sdpt.trustee_birthdate;
        else
            TRUSTEE_BDAY.Date = TRUSTEE_BDAY.MinDate;
        TRUSTEE_NUM.Text = sdpt.trustee_deal_num;
        if (sdpt.trustee_deal_start != DateTime.MinValue)
            TRUSTEE_DAT_BEGIN.Date = sdpt.trustee_deal_start;
        else
            TRUSTEE_DAT_BEGIN.Date = TRUSTEE_DAT_BEGIN.MinDate;
        if (sdpt.trustee_deal_end != DateTime.MinValue)
            TRUSTEE_DAT_END.Date = sdpt.trustee_deal_end;
        else
            TRUSTEE_DAT_END.Date = TRUSTEE_DAT_END.MinDate;

        ACCOUNT_MAN.Text = sdpt.account_man;

        KEY_NUM.Text = sdpt.key_number;
        if (sdpt.key_count != Decimal.MinValue)
            KEYS_GIVEN.Text = Convert.ToString(sdpt.key_count);
        else
            KEYS_GIVEN.Text = String.Empty;

        RENTSUM.Value = sdpt.RENT_SUM/100;
        PDV.Value = sdpt.PDV / 100;
        DAY_TARIF.Value = sdpt.DAY_PAYMENT / 100;
        if (sdpt.DISCOUNT != Decimal.MinValue)
            DISCOUNT.Text = Convert.ToString(sdpt.DISCOUNT);
        if (sdpt.PENY != Decimal.MinValue)
            PENY.Text = Convert.ToString(sdpt.PENY);

        AMORT.Value = sdpt.AMORT_INCOME / 100;
        PLAN_PAY.Value = sdpt.PLAN_PAY / 100;
        P_LEFT.Value = sdpt.P_LEFT / 100;
        FLEFT.Value = sdpt.F_LEFT / 100;
        FACT_PAY.Value = sdpt.FACT_PAY / 100;
        F_PDV.Value = sdpt.NDS2 / 100;
        CUR_PERIOD.Value = sdpt.CUR_INCOME / 100;
        FUT_PERIOD.Value = sdpt.F_INCOME / 100;
        sos.Value = Convert.ToString(sdpt.sos);

        InitLists(sdpt);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sdpt"></param>
    private void FillClassFromControls(safe_deposit sdpt)
    {
        sdpt.deal_id = Convert.ToDecimal(DEAL_REF.Text);
        sdpt.bail_sum = BAIL_SUM.Value * 100;
        sdpt.safe_type_id = Convert.ToDecimal(listSafeSize.SelectedItem.Value);
        sdpt.safe_type_name = listSafeSize.SelectedItem.Text;

        sdpt.tarif_id = Convert.ToDecimal(listTarif.SelectedItem.Value);

        sdpt.deal_num = DEAL_NUM.Text;
        if (DEAL_DATE.Date != DEAL_DATE.MinDate)
            sdpt.deal_date = DEAL_DATE.Date;
        if (DAT_BEGIN.Date != DAT_BEGIN.MinDate)
            sdpt.deal_start_date = DAT_BEGIN.Date;
        if (DAT_END.Date != DAT_END.MinDate)
            sdpt.deal_end_date = DAT_END.Date;
        sdpt.deal_length = ((TimeSpan)(sdpt.deal_end_date - sdpt.deal_start_date)).Days; ;

        sdpt.fio = FIO.Text;
        sdpt.custtype = Convert.ToDecimal(CUSTTYPE.Value);

        if (sdpt.custtype == 3)
            sdpt.okpo = OKPO.Text;
        else
            sdpt.okpo = JOKPO.Text;
        sdpt.doc = DOC.Text;
        sdpt.issued = ISSUED.Text;
        sdpt.NMK = NMK.Text;
        sdpt.nlsk = NLSK.Text;
        sdpt.mfok = MFO.Text;
        sdpt.bankk = BANK.Text;
        sdpt.address = ADDRESS.Text;
        sdpt.birthplace = BIRTH_PLACE.Text;
        if (BDATE.Date != BDATE.MinDate)
            sdpt.birthdate = BDATE.Date;
        sdpt.phone = TEL.Text;

        sdpt.trustee_fio = TRUSTEE_FIO.Text;
        sdpt.trustee_okpo = TRUSTEE_OKPO.Text;
        sdpt.trustee_doc = TRUSTEE_DOC.Text;
        sdpt.trustee_issued = TRUSTEE_ISSUED.Text;
        sdpt.trustee_address = TRUSTEE_ADDRESS.Text;
        sdpt.trustee_birthplace = TRUSTEE_BPLACE.Text;

        if (TRUSTEE_BDAY.Date != TRUSTEE_BDAY.MinDate)
            sdpt.trustee_birthdate = TRUSTEE_BDAY.Date;
        sdpt.trustee_deal_num = TRUSTEE_NUM.Text;

        if (TRUSTEE_DAT_BEGIN.Date != TRUSTEE_DAT_BEGIN.MinDate)
            sdpt.trustee_deal_start = TRUSTEE_DAT_BEGIN.Date;
        if (TRUSTEE_DAT_END.Date != TRUSTEE_DAT_END.MinDate)
            sdpt.trustee_deal_end = TRUSTEE_DAT_END.Date;

        sdpt.account_man = ACCOUNT_MAN.Text;

        if (SAFE_MAN.SelectedItem != null)
        {
            sdpt.safe_man_id = Convert.ToDecimal(SAFE_MAN.SelectedItem.Value);
            sdpt.safe_man = SAFE_MAN.SelectedItem.Text;
        }

        sdpt.key_number = KEY_NUM.Text;
        if (!String.IsNullOrEmpty(KEYS_GIVEN.Text))
            sdpt.key_count = Convert.ToDecimal(KEYS_GIVEN.Text);

        if (BANK_TRUSTEE.SelectedItem != null)
        {
            sdpt.bank_trustee_id = Convert.ToDecimal(BANK_TRUSTEE.SelectedItem.Value);
            sdpt.bank_trustee = BANK_TRUSTEE.SelectedItem.Text;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        safe_deposit sdpt;

        if (isClosing.Value == "1")
        {
            isClosing.Value = null;
            sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
        }
        else if (Request["dpt_id"] == null)
            sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
        else
            sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])),
                Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        if (sdpt.deal_id == Decimal.MinValue)
            return;

        if (sdpt.deal_id != Decimal.MinValue)
            btSelectClient.Enabled = false;

        /// Юр чи фіз особа
        Decimal pcusttype = Decimal.MinValue;

        if (sdpt.custtype != Decimal.MinValue)
            pcusttype = sdpt.custtype;
        else if (Request["custtype"] != null)
            pcusttype = Convert.ToDecimal(Convert.ToString(Request["custtype"]));

        /// Показуємо / ховаємо непотрібні дані
        SetCustType(pcusttype);

        InitLists(sdpt);

        FillControlsFromClass(sdpt);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btSave_Click(object sender, EventArgs e)
    {
        /// Читаємо попередню інформацію
        safe_deposit sdpt;
        if (Request["dpt_id"] == null)
            sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
        else
            sdpt = new safe_deposit(Convert.ToDecimal(Convert.ToString(Request["safe_id"])),
                Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        /// Заповнюємо зміни
        FillClassFromControls(sdpt);
        /// Пишемо в базу
        sdpt.WriteToDataBase();

        btSelectClient.Enabled = false;

        btRefresh_Click(sender, e);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void  btCloseContract_Click(object sender, EventArgs e)
    {
        safe_deposit sdpt = new safe_deposit();
        sdpt.CloseDeal(Convert.ToDecimal(SAFE_ID.Text),Convert.ToDecimal(DEAL_REF.Text));
        isClosing.Value = "1";
        btRefresh_Click(sender, e);

        String message = "Договір успішно закрито!;";
        if (sos.Value == "1")
        {
            message += " Перевірте штрафні санкції!";
        }

        Response.Write("<script>alert('" + message + "');</script>");

    }
    /// <summary>
    /// 
    /// </summary>
    protected void listSafeSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterSafeType = new OracleDataAdapter();
            OracleCommand cmdSelectTarif = connect.CreateCommand();
            cmdSelectTarif.CommandText = "select tariff, name from skrynka_tariff where o_sk = :o_sk order by tariff";
            cmdSelectTarif.Parameters.Add("O_SK", OracleDbType.Decimal, listSafeSize.SelectedValue, ParameterDirection.Input);
            adapterSafeType.SelectCommand = cmdSelectTarif;
            DataSet dsSafeType = new DataSet();
            adapterSafeType.Fill(dsSafeType);

            listTarif.DataSource = dsSafeType;
            listTarif.DataTextField = "name";
            listTarif.DataValueField = "tariff";
            listTarif.DataBind();

            cmdSelectTarif.CommandText = "select nvl(s,0) from SKRYNKA_TIP where o_sk = :o_sk";

            BAIL_SUM.Value = Convert.ToDecimal(Convert.ToString(cmdSelectTarif.ExecuteScalar()));

            cmdSelectTarif.Dispose();
            adapterSafeType.Dispose();
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
    public void GetClient()
    {
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку
        if (String.IsNullOrEmpty(RNK.Value))
            return;
        
        Decimal rnk = Convert.ToDecimal(RNK.Value);
        RNK.Value = String.Empty;

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "BEGIN safe_deposit.GETCUSTOMER(:P_RNK, " +
                ":P_NMK,:P_CUSTTYPE,:P_OKPO,:P_DOCSERIAL,:P_DOCNUMBER,:P_DOCDATE, " +
                ":P_ISSUED,:P_ADDRESS,:P_BIRTHPLACE,:P_BIRTHDAY,:P_TEL); end;";

            cmd.Parameters.Add("safe_id", OracleDbType.Decimal, rnk, ParameterDirection.Input);

            OracleParameter P_NMK = cmd.Parameters.Add(":P_NMK", OracleDbType.Varchar2, 5000);
            P_NMK.Direction = ParameterDirection.Output;
            OracleParameter P_CUSTTYPE = cmd.Parameters.Add(":P_CUSTTYPE", OracleDbType.Decimal, ParameterDirection.Output);
            OracleParameter P_OKPO = cmd.Parameters.Add(":P_OKPO", OracleDbType.Varchar2, 5000);
            P_OKPO.Direction = ParameterDirection.Output;
            OracleParameter P_DOCSERIAL = cmd.Parameters.Add(":P_DOCSERIAL", OracleDbType.Varchar2, 5000);
            P_DOCSERIAL.Direction = ParameterDirection.Output;
            OracleParameter P_DOCNUMBER = cmd.Parameters.Add(":P_DOCNUMBER", OracleDbType.Varchar2, 5000);
            P_DOCNUMBER.Direction = ParameterDirection.Output;
            OracleParameter P_DOCDATE = cmd.Parameters.Add(":P_DOCDATE", OracleDbType.Varchar2, 5000);
            P_DOCDATE.Direction = ParameterDirection.Output;
            OracleParameter P_ISSUED = cmd.Parameters.Add(":P_ISSUED", OracleDbType.Varchar2, 5000);
            P_ISSUED.Direction = ParameterDirection.Output;
            OracleParameter P_ADDRESS = cmd.Parameters.Add(":P_ADDRESS", OracleDbType.Varchar2, 5000);
            P_ADDRESS.Direction = ParameterDirection.Output;
            OracleParameter P_BIRTHPLACE = cmd.Parameters.Add(":P_BIRTHPLACE", OracleDbType.Varchar2, 5000);
            P_BIRTHPLACE.Direction = ParameterDirection.Output;
            OracleParameter P_BIRTHDAY = cmd.Parameters.Add(":P_BIRTHDAY", OracleDbType.Varchar2, 5000);
            P_BIRTHDAY.Direction = ParameterDirection.Output;
            OracleParameter P_TEL = cmd.Parameters.Add(":P_TEL", OracleDbType.Varchar2, 5000);
            P_TEL.Direction = ParameterDirection.Output;

            cmd.ExecuteNonQuery();

            CUSTTYPE.Value = Convert.ToString(P_CUSTTYPE.Value);
 
            if (CUSTTYPE.Value == "3")
            {
                j_1.Visible = false;
                f_1.Visible = true;
                f_2.Visible = true;
                FIO.Text = Convert.ToString(P_NMK.Value);
                OKPO.Text = Convert.ToString(P_OKPO.Value);
                NMK.Text = String.Empty;
                JOKPO.Text = String.Empty;
                DOC.Text = Convert.ToString(P_DOCSERIAL.Value) + " " +
                    Convert.ToString(P_DOCNUMBER.Value);
                ISSUED.Text = Convert.ToString(P_DOCDATE.Value) + " " +
                    Convert.ToString(P_ISSUED.Value);
            }
            else
            {
                

                f_1.Visible = false;
                f_2.Visible = false;
                j_1.Visible = true;
                FIO.Text = String.Empty;
                OKPO.Text = String.Empty;
                NMK.Text = Convert.ToString(P_NMK.Value);
                JOKPO.Text = Convert.ToString(P_OKPO.Value);
               // lbShowTrustee.Text="Представник юр.особи";
                
                if ("NADRA" == Convert.ToString(ConfigurationSettings.AppSettings["Product.Spec"]) || (!IsPostBack))
                {
                cmd.CommandText = "select f_ourmfo from dual";
                MFO.Text = Convert.ToString(cmd.ExecuteScalar());

                cmd.CommandText = "select nls from accounts where rnk = "+ rnk + " and dazs is null and nbs = '2600' and tip = 'ODB' and rownum = 1 order by daos ";
                NLSK.Text = Convert.ToString(cmd.ExecuteScalar());

                }
            }

            ADDRESS.Text = Convert.ToString(P_ADDRESS.Value);
            BIRTH_PLACE.Text =  Convert.ToString(P_BIRTHPLACE.Value);

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            BDATE.Date = Convert.ToDateTime(Convert.ToString(P_BIRTHDAY.Value),cinfo);

            TEL.Text = Convert.ToString(P_TEL.Value);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    
    [WebMethod(EnableSession = true)]
    public static String CkDate(DateTime Dat_end)
    {
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку
        if (Dat_end == DateTime.MinValue)
            return String.Empty;

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"SELECT to_char(min(c.fdat),'dd/mm/yyyy')
              FROM (select to_date(to_char(:dfDAT2)) + num - 1 fdat from conductor c ) c
              WHERE not exists (select holiday from holiday where holiday = c.fdat)
                and c.fdat >= :dfDAT2";
            cmd.Parameters.Add("dfDAT2", OracleDbType.Date, Dat_end, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            safe_deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}