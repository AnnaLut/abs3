using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

using Bars.UserControls;
using System.Linq;
using System.Collections.Generic;

public partial class credit_cck_zay : Bars.BarsPage
{
    # region Приватные свойства
    private String _ShowCustomerReferPattern = "ShowCustomerRefer({0}, '{1}', '{2}', '{3}'); return false;";
    private String _ShowBanksReferPattern = "ShowBanksRefer('{0}', '{1}'); return false;";
    private String _ShowDepositReferPattern = "ShowDepositRefer('{0}', '{1}', '{2}', '{3}', '{4}'); return false;";



    string[] _creditOrders = { "220263", "220353" };
    string[] _creditOrdersNew = { "220377", "220353" };
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Bars.WebServices.NewNbs ws = new Bars.WebServices.NewNbs();
        bool useNew = ws.UseNewNbs();
        _creditOrders = useNew ? _creditOrdersNew : _creditOrders;

        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
            // первичное отображение
            cbINS_CheckedChanged(cbINS, e);
            cbPAWN_CheckedChanged(cbPAWN, e);
            cbPAWNP_CheckedChanged(cbPAWNP, e);

            if (!useNew)
            {
                switch (Request.Params.Get("PROD"))
                {
                    case "220234":
                    //220365
                    case "220239":
                    //--
                    case "220325":
                    case "220330":
                        ConfigForm();
                        break;
                }
            }
            else
            {
                switch (Request.Params.Get("PROD"))
                {
                    case "220365":
                    case "220325":
                    case "220330":
                        ConfigForm();
                        break;
                }
            }
            creditOrderTitle.Visible = creditOrder.Visible = _creditOrders.Contains(Request.Params.Get("PROD"));
        }

        btnNo.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnNo.UniqueID, "");

    }

    private void ConfigForm()
    {
        lbDPT_ID.Visible = true;
        DPT_ID.Visible = true;
        btDepositReferDPT_ID.Visible = true;
        PAWN_DPTRNK.Visible = true;
        PAWN_DPTS.Visible = true;

        btCustomerReferPAWN_RNK.Visible = false;
        PAWN_RNK.Visible = false;
        PAWN_RNK.Enabled = false;
        PAWN_S.Visible = false;
    }

    protected void RNK_ValueChanged(object sender, EventArgs e)
    {
        Decimal? RNK = (sender as Bars.UserControls.TextBoxNumb).Value;
        String RNK_CtrlID = (sender as Control).ID;
        String BaseID = RNK_CtrlID.Substring(0, RNK_CtrlID.IndexOf("_") + 1);
        decimal? PRINSIDER;
        String parametrIns;

        if (!RNK.HasValue) return;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            //cmd.CommandText = "select okpo, nmk as fio, date_off, PRINSIDER from customer where rnk = :p_rnk";
            cmd.CommandText = @"
select c.okpo
, c.nmk as fio
, c.date_off
, c.Prinsider
, cw.value
from customer c 
left join customerw cw
on (c.rnk = cw.rnk
and cw.tag='INSFO')
where c.rnk = :p_rnk";

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (rdr["DATE_OFF"] == DBNull.Value)
                {
                    (FindControl(BaseID + "OKPO") as TextBox).Text = rdr["OKPO"] == DBNull.Value ? (String)null : (String)rdr["OKPO"];
                    (FindControl(BaseID + "FIO") as TextBox).Text = rdr["FIO"] == DBNull.Value ? (String)null : (String)rdr["FIO"];
                    PRINSIDER = rdr["PRINSIDER"] == DBNull.Value ? null : (decimal?)rdr["PRINSIDER"];
                    parametrIns = rdr["value"] == DBNull.Value ? null : (string)rdr["value"];

                    ///Перевірка на приналежність до пов’язаних з банком осіб та параметру «Ознака наявності анкети інсайдера»
                    if (PRINSIDER != 99 && (parametrIns == "0" || String.IsNullOrEmpty(parametrIns)))
                    {
                        ShowConfirmInsider();
                    }
                }
                else
                {
                    (sender as Bars.UserControls.TextBoxNumb).Value = (Decimal?)null;
                    (FindControl(BaseID + "OKPO") as TextBox).Text = "";
                    (FindControl(BaseID + "FIO") as TextBox).Text = "";

                    ShowError("Клієнт (" + RNK.ToString() + ") закритий");
                }

                if (!btSend.Enabled)
                {
                    UpdatePanelsEnable(true);
                }

            }
            else
            {
                (sender as Bars.UserControls.TextBoxNumb).Value = (Decimal?)null;
                (FindControl(BaseID + "OKPO") as TextBox).Text = "";
                (FindControl(BaseID + "FIO") as TextBox).Text = "";

                ShowError("Клієн (" + RNK.ToString() + ") не знайдений");
            }

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

















    /*protected void CC_ID_ValueChanged(object sender, EventArgs e)
    {
        String CC_ID = (sender as Bars.UserControls.TextBoxString).Value;
       // if (!String.IsNullOrEmpty(CC_ID)) return;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("p_ccid", OracleDbType.Varchar2, CC_ID, ParameterDirection.Input);
            cmd.CommandText = "select count(*) as cnt from cc_deal where cc_id = :p_ccid and sos < 15";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
              if ((Decimal)rdr["cnt"] > 0)
            	{
                   (sender as Bars.UserControls.TextBoxString).Value = (String)null;
                    ShowError("Номер договору існує (" + CC_ID.ToString() + ") введіть корректний номер");
            	}  
            }

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }*/


    protected void NBANK_ValueChanged(object sender, EventArgs e)
    {
        Decimal? NBANK = (sender as Bars.UserControls.TextBoxNumb).Value;
        if (!NBANK.HasValue) return;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, NBANK.ToString(), ParameterDirection.Input);
            cmd.CommandText = "select nb as name from banks where mfo = :p_mfo";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                NBANK_NAME.Text = rdr["NAME"] == DBNull.Value ? (String)null : (String)rdr["NAME"];
            }
            else
            {
                (sender as Bars.UserControls.TextBoxNumb).Value = (Decimal?)null;
                NBANK_NAME.Text = "";

                ShowError("Банк (" + NBANK.ToString() + ") не знайдений");
            }

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    protected void sumSDI_ValueChanged(object sender, EventArgs e)
    {
        if (!SDOG.Value.HasValue)
        {
            (sender as TextBoxDecimal).Value = (Decimal?)null;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "fill_sdog", "alert('Заповніть суму кредиту')", true);
        }

        if ((sender as TextBoxDecimal).Value.HasValue) CountSDI();
    }
    protected void prSDI_ValueChanged(object sender, EventArgs e)
    {
        if (!SDOG.Value.HasValue)
        {
            (sender as TextBoxDecimal).Value = (Decimal?)null;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "fill_sdog", "alert('Заповніть суму кредиту')", true);
        }

        if ((sender as TextBoxDecimal).Value.HasValue) CountSDI();
    }
    protected void cbINS_CheckedChanged(object sender, EventArgs e)
    {

        NBANK.Enabled = (sender as CheckBox).Checked;
        btBanksReferNBANK.Enabled = (sender as CheckBox).Checked;
        NBANK_NAMETitle.Enabled = (sender as CheckBox).Checked;
        NBANK_NAME.Enabled = (sender as CheckBox).Checked;
        NLS_MFOTitle.Enabled = (sender as CheckBox).Checked;
        NLS_MFO.Enabled = (sender as CheckBox).Checked;
        NLS_NAMETitle.Enabled = (sender as CheckBox).Checked;
        NLS_NAME.Enabled = (sender as CheckBox).Checked;
        NLS_OKPOTitle.Enabled = (sender as CheckBox).Checked;
        NLS_OKPO.Enabled = (sender as CheckBox).Checked;

        attrPayInstuctions2.Visible = (sender as CheckBox).Checked;
        cbINS2.Checked = false;
        cbINS2_CheckedChanged(cbINS2, e);
        upPayInstuctions2.Update();
    }

    protected void cbINS2_CheckedChanged(object sender, EventArgs e)
    {
        NBANK2.Enabled = (sender as CheckBox).Checked;
        btBanksReferNBANK2.Enabled = (sender as CheckBox).Checked;
        NBANK_NAMETitle2.Enabled = (sender as CheckBox).Checked;
        NBANK_NAME2.Enabled = (sender as CheckBox).Checked;
        NLS_MFOTitle2.Enabled = (sender as CheckBox).Checked;
        NLS_MFO2.Enabled = (sender as CheckBox).Checked;
        NLS_NAMETitle2.Enabled = (sender as CheckBox).Checked;
        NLS_NAME2.Enabled = (sender as CheckBox).Checked;
        NLS_OKPOTitle2.Enabled = (sender as CheckBox).Checked;
        NLS_OKPO2.Enabled = (sender as CheckBox).Checked;

        attrPayInstuctions3.Visible = (sender as CheckBox).Checked;
        cbINS3.Checked = false;
        cbINS3_CheckedChanged(cbINS3, e);
        upPayInstuctions3.Update();
    }

    protected void cbINS3_CheckedChanged(object sender, EventArgs e)
    {
        NBANK3.Enabled = (sender as CheckBox).Checked;
        btBanksReferNBANK3.Enabled = (sender as CheckBox).Checked;
        NBANK_NAMETitle3.Enabled = (sender as CheckBox).Checked;
        NBANK_NAME3.Enabled = (sender as CheckBox).Checked;
        NLS_MFOTitle3.Enabled = (sender as CheckBox).Checked;
        NLS_MFO3.Enabled = (sender as CheckBox).Checked;
        NLS_NAMETitle3.Enabled = (sender as CheckBox).Checked;
        NLS_NAME3.Enabled = (sender as CheckBox).Checked;
        NLS_OKPOTitle3.Enabled = (sender as CheckBox).Checked;
        NLS_OKPO3.Enabled = (sender as CheckBox).Checked;

        attrPayInstuctions4.Visible = (sender as CheckBox).Checked;
        cbINS4.Checked = false;
        cbINS4_CheckedChanged(cbINS4, e);
        upPayInstuctions4.Update();
    }

    protected void cbINS4_CheckedChanged(object sender, EventArgs e)
    {
        NBANK4.Enabled = (sender as CheckBox).Checked;
        btBanksReferNBANK4.Enabled = (sender as CheckBox).Checked;
        NBANK_NAMETitle4.Enabled = (sender as CheckBox).Checked;
        NBANK_NAME4.Enabled = (sender as CheckBox).Checked;
        NLS_MFOTitle4.Enabled = (sender as CheckBox).Checked;
        NLS_MFO4.Enabled = (sender as CheckBox).Checked;
        NLS_NAMETitle4.Enabled = (sender as CheckBox).Checked;
        NLS_NAME4.Enabled = (sender as CheckBox).Checked;
        NLS_OKPOTitle4.Enabled = (sender as CheckBox).Checked;
        NLS_OKPO4.Enabled = (sender as CheckBox).Checked;

        attrPayInstuctions5.Visible = (sender as CheckBox).Checked;
        cbINS5.Checked = false;
        cbINS5_CheckedChanged(cbINS5, e);
        upPayInstuctions5.Update();
    }

    protected void cbINS5_CheckedChanged(object sender, EventArgs e)
    {
        NBANK5.Enabled = (sender as CheckBox).Checked;
        btBanksReferNBANK5.Enabled = (sender as CheckBox).Checked;
        NBANK_NAMETitle5.Enabled = (sender as CheckBox).Checked;
        NBANK_NAME5.Enabled = (sender as CheckBox).Checked;
        NLS_MFOTitle5.Enabled = (sender as CheckBox).Checked;
        NLS_MFO5.Enabled = (sender as CheckBox).Checked;
        NLS_NAMETitle5.Enabled = (sender as CheckBox).Checked;
        NLS_NAME5.Enabled = (sender as CheckBox).Checked;
        NLS_OKPOTitle5.Enabled = (sender as CheckBox).Checked;
        NLS_OKPO5.Enabled = (sender as CheckBox).Checked;
    }

    protected void cbPAWN_CheckedChanged(object sender, EventArgs e)
    {
        if ((sender as CheckBox).Checked && !PAWN_RNK.Value.HasValue)
        {
            PAWN_RNK.Value = RNK.Value;
            RNK_ValueChanged(PAWN_RNK, e);
        }

        PAWN_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWN_RNK.Enabled = (sender as CheckBox).Checked;
        PAWN.Enabled = (sender as CheckBox).Checked;
        PAWN_S.Enabled = (sender as CheckBox).Checked;
        DPT_ID.Enabled = (sender as CheckBox).Checked;
        btDepositReferDPT_ID.Enabled = (sender as CheckBox).Checked;

        attrPawn2.Visible = (sender as CheckBox).Checked;
        cbPAWN2.Checked = false;
        cbPAWN2_CheckedChanged(cbPAWN2, e);
        upAttrPawn2.Update();
    }
    protected void cbPAWN2_CheckedChanged(object sender, EventArgs e)
    {
        if ((sender as CheckBox).Checked && !PAWN2_RNK.Value.HasValue)
        {
            PAWN2_RNK.Value = RNK.Value;
            RNK_ValueChanged(PAWN2_RNK, e);
        }

        PAWN2_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWN2_RNK.Enabled = (sender as CheckBox).Checked;
        PAWN2.Enabled = (sender as CheckBox).Checked;
        PAWN2_S.Enabled = (sender as CheckBox).Checked;

        attrPawn3.Visible = (sender as CheckBox).Checked;
        cbPAWN3.Checked = false;
        cbPAWN3_CheckedChanged(cbPAWN3, e);
        upAttrPawn3.Update();
    }
    protected void cbPAWN3_CheckedChanged(object sender, EventArgs e)
    {
        if ((sender as CheckBox).Checked && !PAWN3_RNK.Value.HasValue)
        {
            PAWN3_RNK.Value = RNK.Value;
            RNK_ValueChanged(PAWN3_RNK, e);
        }

        PAWN3_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWN3_RNK.Enabled = (sender as CheckBox).Checked;
        PAWN3.Enabled = (sender as CheckBox).Checked;
        PAWN3_S.Enabled = (sender as CheckBox).Checked;

        attrPawn4.Visible = (sender as CheckBox).Checked;
        cbPAWN4.Checked = false;
        cbPAWN4_CheckedChanged(cbPAWN4, e);
        upAttrPawn4.Update();
    }
    protected void cbPAWN4_CheckedChanged(object sender, EventArgs e)
    {
        if ((sender as CheckBox).Checked && !PAWN4_RNK.Value.HasValue)
        {
            PAWN4_RNK.Value = RNK.Value;
            RNK_ValueChanged(PAWN4_RNK, e);
        }

        PAWN4_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWN4_RNK.Enabled = (sender as CheckBox).Checked;
        PAWN4.Enabled = (sender as CheckBox).Checked;
        PAWN4_S.Enabled = (sender as CheckBox).Checked;

        attrPawn5.Visible = (sender as CheckBox).Checked;
        cbPAWN5.Checked = false;
        cbPAWN5_CheckedChanged(cbPAWN5, e);
        upAttrPawn5.Update();
    }
    protected void cbPAWN5_CheckedChanged(object sender, EventArgs e)
    {
        if ((sender as CheckBox).Checked && !PAWN5_RNK.Value.HasValue)
        {
            PAWN5_RNK.Value = RNK.Value;
            RNK_ValueChanged(PAWN5_RNK, e);
        }

        PAWN5_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWN5_RNK.Enabled = (sender as CheckBox).Checked;
        PAWN5.Enabled = (sender as CheckBox).Checked;
        PAWN5_S.Enabled = (sender as CheckBox).Checked;
    }
    protected void cbFPROC2_CheckedChanged(object sender, EventArgs e)
    {
        cbFPROC3.Visible = FPROC3Title.Visible = FPROC3.Visible = FPROC3_DATETitle.Visible = FPROC3_DATE.Visible =
             FPROC2.IsRequired = FPROC2_DATE.IsRequired = FPROC2.Enabled = FPROC2_DATE.Enabled = cbFPROC2.Checked;
    }

    protected void cbFPROC3_CheckedChanged(object sender, EventArgs e)
    {
        FPROC3.Enabled = FPROC3_DATE.Enabled = FPROC3.IsRequired = FPROC3_DATE.IsRequired = cbFPROC3.Checked;
    }
    protected void cbPAWNP_CheckedChanged(object sender, EventArgs e)
    {
        PAWNP_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWNP_RNK.Enabled = (sender as CheckBox).Checked;
        PAWNP.Enabled = (sender as CheckBox).Checked;
        PAWNP_S.Enabled = (sender as CheckBox).Checked;

        attrPawnP2.Visible = (sender as CheckBox).Checked;
        cbPAWNP2.Checked = false;
        cbPAWNP2_CheckedChanged(cbPAWNP2, e);
        upAttrPawnP2.Update();
    }
    protected void cbPAWNP2_CheckedChanged(object sender, EventArgs e)
    {
        PAWNP2_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWNP2_RNK.Enabled = (sender as CheckBox).Checked;
        PAWNP2.Enabled = (sender as CheckBox).Checked;
        PAWNP2_S.Enabled = (sender as CheckBox).Checked;

        attrPawnP3.Visible = (sender as CheckBox).Checked;
        cbPAWNP3.Checked = false;
        cbPAWNP3_CheckedChanged(cbPAWNP3, e);
        upAttrPawnP3.Update();
    }
    protected void cbPAWNP3_CheckedChanged(object sender, EventArgs e)
    {
        PAWNP3_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWNP3_RNK.Enabled = (sender as CheckBox).Checked;
        PAWNP3.Enabled = (sender as CheckBox).Checked;
        PAWNP3_S.Enabled = (sender as CheckBox).Checked;

        attrPawnP4.Visible = (sender as CheckBox).Checked;
        cbPAWNP4.Checked = false;
        cbPAWNP4_CheckedChanged(cbPAWNP4, e);
        upAttrPawnP4.Update();
    }
    protected void cbPAWNP4_CheckedChanged(object sender, EventArgs e)
    {
        PAWNP4_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWNP4_RNK.Enabled = (sender as CheckBox).Checked;
        PAWNP4.Enabled = (sender as CheckBox).Checked;
        PAWNP4_S.Enabled = (sender as CheckBox).Checked;

        attrPawnP5.Visible = (sender as CheckBox).Checked;
        cbPAWNP5.Checked = false;
        cbPAWNP5_CheckedChanged(cbPAWNP5, e);
        upAttrPawnP5.Update();
    }
    protected void cbPAWNP5_CheckedChanged(object sender, EventArgs e)
    {
        PAWNP5_RNK.Enabled = (sender as CheckBox).Checked;
        btCustomerReferPAWNP5_RNK.Enabled = (sender as CheckBox).Checked;
        PAWNP5.Enabled = (sender as CheckBox).Checked;
        PAWNP5_S.Enabled = (sender as CheckBox).Checked;
    }

    protected void METR_ValueChanged(object sender, EventArgs e)
    {
        if (METR.Value.HasValue)
        {
            METR_R.Enabled = true;
        }
        else
        {
            METR_R.Value = (Decimal?)null;
            METR_R.Enabled = false;
        }
    }

    protected void btSend_Click(object sender, EventArgs e)
    {
        if (ValidatePage() && SendZay())
        {
            // действия выполняются в проц ValidatePage, SendZay
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        BindControls();
        cbFPROC2.Visible = FPROC2Title.Visible = FPROC2.Visible = FPROC2_DATETitle.Visible = FPROC2_DATE.Visible = Request.Params.Get("CUSTTYPE") == "3"; //декілька ставок тільки для ФО
        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void BindControls()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        OracleDataAdapter adr = new OracleDataAdapter(cmd);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            // Основні реквізити
            // Код Контрагенту : 
            btCustomerReferRNK.OnClientClick = String.Format(_ShowCustomerReferPattern, Request.Params.Get("CUSTTYPE"), RNK.BaseClientID, OKPO.ClientID, FIO.ClientID);

            // Валюта : 
            if (!IsPostBack)
            {
                DataTable dtKV = new DataTable();
                cmd.CommandText = "select kv as id, kv || ' - ' || name || ' (' || lcv || ')' as name from tabval where (d_close is null or d_close > bankdate) and KV IN (978,840,980,643,752,974)";
                adr.Fill(dtKV);

                KV.DataSource = dtKV;
                KV.DataValueField = "ID";
                KV.DataTextField = "NAME";
                KV.SelectedIndex = 6;
                KV.DataBind();
            }

            // Базовий рік : 
            if (!IsPostBack)
            {
                DataTable dtBASEY = new DataTable();
                cmd.CommandText = "select basey as id, basey || ' - ' || name || ' (' || name_mb || ')' as name from basey order by id";
                adr.Fill(dtBASEY);

                BASEY.DataSource = dtBASEY;
                BASEY.DataValueField = "ID";
                BASEY.DataTextField = "NAME";
                BASEY.SelectedIndex = 1;
                BASEY.DataBind();
            }

            // Дата початку дії : 
            cmd.CommandText = "select web_utl.get_bankdate from dual";
            DateTime dBankDate = Convert.ToDateTime(cmd.ExecuteScalar());
            SDATE.MinValue = dBankDate;
            SDATE.Value = dBankDate;
            WDATE.Value = dBankDate.AddYears(Request.Params.Get("PROD")[3] == '3' ? 3 : 1); //довгострокові +3 роки, короткострокові +1 рік

            FPROC2_DATE.MinValue = dBankDate.AddDays(1); //min > bddate

            // Графік погашення (1,2,3) : 
            if (!IsPostBack)
            {
                DataTable dtGPK = new DataTable();

                dtGPK.Columns.Add("ID", typeof(Decimal));
                dtGPK.Columns.Add("NAME", typeof(String));

                dtGPK.Rows.Add(1, "1 - Класика");
                dtGPK.Rows.Add(2, "2 - В кінці строку");
                dtGPK.Rows.Add(3, "3 - Ануітет");

                GPK.DataSource = dtGPK;
                GPK.DataValueField = "ID";
                GPK.DataTextField = "NAME";
                GPK.SelectedIndex = 1;
                GPK.DataBind();
            }

            // Фін. стан : 
            if (!IsPostBack)
            {
                DataTable dtNFIN = new DataTable();
                cmd.CommandText = "select fin as id, fin || ' - ' || name as name from stan_fin";
                adr.Fill(dtNFIN);

                NFIN.DataSource = dtNFIN;
                NFIN.DataValueField = "ID";
                NFIN.DataTextField = "NAME";
                NFIN.DataBind();
            }

            // Період погашення тіла КД : 
            if (!IsPostBack)
            {
                DataTable dtNFREQ = new DataTable();
                cmd.CommandText = "select freq as id, freq || ' - ' || name as name from freq order by id";
                adr.Fill(dtNFREQ);

                NFREQ.DataSource = dtNFREQ;
                NFREQ.DataValueField = "ID";
                NFREQ.DataTextField = "NAME";
                NFREQ.SelectedIndex = 4;
                NFREQ.DataBind();
            }

            // Продукт (ОВ22) : 
            PROD.Text = Request.Params.Get("PROD") + " - " + Request.Params.Get("NAME");

            // Щомісячна комісія
            // Метод нарахування щомісячної комісії : 
            if (!IsPostBack)
            {
                DataTable dtMETR = new DataTable();
                cmd.CommandText = "select metr as id, metr || ' - ' || name as name from int_metr where metr > 94 or metr=0";
                adr.Fill(dtMETR);

                METR.DataSource = dtMETR;
                METR.DataValueField = "ID";
                METR.DataTextField = "NAME";
                METR.DataBind();

                METR_ValueChanged(METR, null);
            }

            // Платіжні інструкції
            // МФО : 
            btBanksReferNBANK.OnClientClick = String.Format(_ShowBanksReferPattern, NBANK.BaseClientID, NBANK_NAME.ClientID);
            btBanksReferNBANK2.OnClientClick = String.Format(_ShowBanksReferPattern, NBANK2.BaseClientID, NBANK_NAME2.ClientID);
            btBanksReferNBANK3.OnClientClick = String.Format(_ShowBanksReferPattern, NBANK3.BaseClientID, NBANK_NAME3.ClientID);
            btBanksReferNBANK4.OnClientClick = String.Format(_ShowBanksReferPattern, NBANK4.BaseClientID, NBANK_NAME4.ClientID);
            btBanksReferNBANK5.OnClientClick = String.Format(_ShowBanksReferPattern, NBANK5.BaseClientID, NBANK_NAME5.ClientID);

            // Застава
            // Код Контрагенту : 
            btCustomerReferPAWN_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWN_RNK.BaseClientID, PAWN_OKPO.ClientID, PAWN_FIO.ClientID);
            btCustomerReferPAWN2_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWN2_RNK.BaseClientID, PAWN2_OKPO.ClientID, PAWN2_FIO.ClientID);
            btCustomerReferPAWN3_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWN3_RNK.BaseClientID, PAWN3_OKPO.ClientID, PAWN3_FIO.ClientID);
            btCustomerReferPAWN4_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWN4_RNK.BaseClientID, PAWN4_OKPO.ClientID, PAWN4_FIO.ClientID);
            btCustomerReferPAWN5_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWN5_RNK.BaseClientID, PAWN5_OKPO.ClientID, PAWN5_FIO.ClientID);
            // Код Депозита :



            btDepositReferDPT_ID.OnClientClick = String.Format(_ShowDepositReferPattern, DPT_ID.BaseClientID, PAWN_DPTRNK.BaseClientID, PAWN_OKPO.ClientID, PAWN_FIO.ClientID, PAWN_DPTS.ClientID + "_tb");

            // Тип : 
            if (!IsPostBack)
            {
                DataTable dtPAWN = new DataTable();
                cmd.CommandText = "select pawn as id, pawn || ' - ' || name as name from cc_pawn where nbsz <> 9031";
                adr.Fill(dtPAWN);

                PAWN.DataSource = dtPAWN;
                PAWN.DataValueField = "ID";
                PAWN.DataTextField = "NAME";
                PAWN.DataBind();

                PAWN2.DataSource = dtPAWN;
                PAWN2.DataValueField = "ID";
                PAWN2.DataTextField = "NAME";
                PAWN2.DataBind();

                PAWN3.DataSource = dtPAWN;
                PAWN3.DataValueField = "ID";
                PAWN3.DataTextField = "NAME";
                PAWN3.DataBind();

                PAWN4.DataSource = dtPAWN;
                PAWN4.DataValueField = "ID";
                PAWN4.DataTextField = "NAME";
                PAWN4.DataBind();

                PAWN5.DataSource = dtPAWN;
                PAWN5.DataValueField = "ID";
                PAWN5.DataTextField = "NAME";
                PAWN5.DataBind();
            }

            // Порука
            // Код Контрагенту : 
            btCustomerReferPAWNP_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP_RNK.BaseClientID, PAWNP_OKPO.ClientID, PAWNP_FIO.ClientID);
            btCustomerReferPAWNP2_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP2_RNK.BaseClientID, PAWNP2_OKPO.ClientID, PAWNP2_FIO.ClientID);
            btCustomerReferPAWNP3_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP3_RNK.BaseClientID, PAWNP3_OKPO.ClientID, PAWNP3_FIO.ClientID);
            btCustomerReferPAWNP4_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP4_RNK.BaseClientID, PAWNP4_OKPO.ClientID, PAWNP4_FIO.ClientID);
            btCustomerReferPAWNP5_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP5_RNK.BaseClientID, PAWNP5_OKPO.ClientID, PAWNP5_FIO.ClientID);

            // Тип : 
            if (!IsPostBack)
            {
                DataTable dtPAWNP = new DataTable();
                cmd.CommandText = "select pawn as id, pawn || ' - ' || name as name from cc_pawn where nbsz = 9031";
                adr.Fill(dtPAWNP);

                PAWNP.DataSource = dtPAWNP;
                PAWNP.DataValueField = "ID";
                PAWNP.DataTextField = "NAME";
                PAWNP.DataBind();

                PAWNP2.DataSource = dtPAWNP;
                PAWNP2.DataValueField = "ID";
                PAWNP2.DataTextField = "NAME";
                PAWNP2.DataBind();

                PAWNP3.DataSource = dtPAWNP;
                PAWNP3.DataValueField = "ID";
                PAWNP3.DataTextField = "NAME";
                PAWNP3.DataBind();

                PAWNP4.DataSource = dtPAWNP;
                PAWNP4.DataValueField = "ID";
                PAWNP4.DataTextField = "NAME";
                PAWNP4.DataBind();

                PAWNP5.DataSource = dtPAWNP;
                PAWNP5.DataValueField = "ID";
                PAWNP5.DataTextField = "NAME";
                PAWNP5.DataBind();
            }
        }
        finally
        {
            adr.Dispose();
            con.Close();
            con.Dispose();
        }
    }
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }


    private void ShowConfirmInsider()
    {
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "confirm_isider", "ConfirmInsider('" + Text + "');", true);
        mpe.Show();
    }


    private void HideError()
    {
    }
    private Boolean ValidatePage()
    {
        // скрываем ошибки
        HideError();
        if (cbFPROC2.Checked && FPROC2_DATE.Value <= SDATE.Value)
        {
            ShowError("Дата введеня ставки №2 має бути більшою за дату початку КД");
            return false;
        }

        if (cbFPROC2.Checked && FPROC2_DATE.Value >= WDATE.Value)
        {
            ShowError("Дата введеня ставки №2 має бути меншою за дату закінчення КД");
            return false;
        }

        //якщо ввели третю ставку і вона <= дати другої ставки
        if (cbFPROC3.Checked && FPROC3_DATE.Value <= FPROC2_DATE.Value)
        {
            ShowError("Дата введеня ставки №3 має бути більшою за дату введеня ставки №2");
            return false;
        }

        if (cbFPROC3.Checked && FPROC3_DATE.Value >= WDATE.Value)
        {
            ShowError("Дата введеня ставки №3 має бути меншою за дату закінчення КД");
            return false;
        }

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        OracleDataAdapter adr = new OracleDataAdapter(cmd);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();
            // проверка счета
            if (NBANK.Value.HasValue && !String.IsNullOrEmpty(NLS_MFO.Value))
            {
                cmd.Parameters.Add("AMF_", OracleDbType.Varchar2, NBANK.Value.ToString().Substring(0, 5), ParameterDirection.Input);
                cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, NLS_MFO.Value, ParameterDirection.Input);
                cmd.CommandText = "select vkrzn(:AMF_, :NLS_) from dual";
                if (Convert.ToString(cmd.ExecuteScalar()) != NLS_MFO.Value)
                {
                    ShowError("Помилка у контрольному розряді рахунку Партнера");
                    return false;
                }
            }

            cmd.Parameters.Clear();
            // проверка счета
            if (NBANK2.Value.HasValue && !String.IsNullOrEmpty(NLS_MFO2.Value))
            {
                cmd.Parameters.Add("AMF_", OracleDbType.Varchar2, NBANK2.Value.ToString().Substring(0, 5), ParameterDirection.Input);
                cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, NLS_MFO2.Value, ParameterDirection.Input);
                cmd.CommandText = "select vkrzn(:AMF_, :NLS_) from dual";
                if (Convert.ToString(cmd.ExecuteScalar()) != NLS_MFO2.Value)
                {
                    ShowError("Помилка у контрольному розряді рахунку Партнера 2");
                    return false;
                }
            }

            cmd.Parameters.Clear();
            // проверка счета
            if (NBANK3.Value.HasValue && !String.IsNullOrEmpty(NLS_MFO3.Value))
            {
                cmd.Parameters.Add("AMF_", OracleDbType.Varchar2, NBANK3.Value.ToString().Substring(0, 5), ParameterDirection.Input);
                cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, NLS_MFO3.Value, ParameterDirection.Input);
                cmd.CommandText = "select vkrzn(:AMF_, :NLS_) from dual";
                if (Convert.ToString(cmd.ExecuteScalar()) != NLS_MFO3.Value)
                {
                    ShowError("Помилка у контрольному розряді рахунку Партнера 3");
                    return false;
                }
            }

            cmd.Parameters.Clear();
            // проверка счета
            if (NBANK4.Value.HasValue && !String.IsNullOrEmpty(NLS_MFO4.Value))
            {
                cmd.Parameters.Add("AMF_", OracleDbType.Varchar2, NBANK4.Value.ToString().Substring(0, 5), ParameterDirection.Input);
                cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, NLS_MFO4.Value, ParameterDirection.Input);
                cmd.CommandText = "select vkrzn(:AMF_, :NLS_) from dual";
                if (Convert.ToString(cmd.ExecuteScalar()) != NLS_MFO4.Value)
                {
                    ShowError("Помилка у контрольному розряді рахунку Партнера 4");
                    return false;
                }
            }

            cmd.Parameters.Clear();
            // проверка счета
            if (NBANK5.Value.HasValue && !String.IsNullOrEmpty(NLS_MFO5.Value))
            {
                cmd.Parameters.Add("AMF_", OracleDbType.Varchar2, NBANK5.Value.ToString().Substring(0, 5), ParameterDirection.Input);
                cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, NLS_MFO5.Value, ParameterDirection.Input);
                cmd.CommandText = "select vkrzn(:AMF_, :NLS_) from dual";
                if (Convert.ToString(cmd.ExecuteScalar()) != NLS_MFO5.Value)
                {
                    ShowError("Помилка у контрольному розряді рахунку Партнера 5");
                    return false;
                }
            }


            // cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_ccid", OracleDbType.Varchar2, CC_ID.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_sdate", OracleDbType.Date, SDATE.Value, ParameterDirection.Input);
            cmd.CommandText = "select count(*) as cnt from cc_deal where cc_id = :p_ccid and sos < 15 and sdate = trunc(:p_sdate)";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if ((Decimal)rdr["cnt"] > 0)
                {

                    ShowError("Номер договору існує (" + CC_ID.Value + ") введіть корректний номер");
                    return false;
                }
            }

        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return true;
    }
    private Boolean SendZay()
    {
        // скрываем ошибки
        HideError();

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            Decimal? ND;
            Decimal? ErrCode;
            String ErrMessage;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "cck_dop.cc_open";

            cmd.Parameters.Add("ND_", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("CC_ID_", OracleDbType.Varchar2, CC_ID.Value.Trim(), ParameterDirection.Input);
            cmd.Parameters.Add("nRNK", OracleDbType.Decimal, RNK.Value, ParameterDirection.Input);
            cmd.Parameters.Add("nKV", OracleDbType.Decimal, KV.Value, ParameterDirection.Input);
            cmd.Parameters.Add("SDOG", OracleDbType.Decimal, SDOG.Value, ParameterDirection.Input);
            cmd.Parameters.Add("SumSDI", OracleDbType.Decimal, sumSDI.Value, ParameterDirection.Input);
            cmd.Parameters.Add("fPROC", OracleDbType.Decimal, FPROC.Value, ParameterDirection.Input);
            cmd.Parameters.Add("BASEY", OracleDbType.Decimal, BASEY.Value, ParameterDirection.Input);
            cmd.Parameters.Add("SDATE", OracleDbType.Date, SDATE.Value, ParameterDirection.Input);
            cmd.Parameters.Add("WDATE", OracleDbType.Date, WDATE.Value, ParameterDirection.Input);
            cmd.Parameters.Add("GPK", OracleDbType.Decimal, GPK.Value, ParameterDirection.Input);

            cmd.Parameters.Add("METR", OracleDbType.Decimal, METR.Value, ParameterDirection.Input);
            cmd.Parameters.Add("METR_R", OracleDbType.Decimal, METR_R.Value, ParameterDirection.Input);
            cmd.Parameters.Add("METR_9", OracleDbType.Decimal, METR_9.Value, ParameterDirection.Input);

            cmd.Parameters.Add("nFIN", OracleDbType.Decimal, NFIN.Value, ParameterDirection.Input);
            cmd.Parameters.Add("nFREQ", OracleDbType.Decimal, NFREQ.Value, ParameterDirection.Input);
            cmd.Parameters.Add("dfDen", OracleDbType.Decimal, DFDEN.Value, ParameterDirection.Input);
            cmd.Parameters.Add("PROD_", OracleDbType.Varchar2, Convert.ToString(Request.Params.Get("PROD")), ParameterDirection.Input);

            cmd.Parameters.Add("nBANK", OracleDbType.Decimal, NBANK.Value, ParameterDirection.Input);
            cmd.Parameters.Add("NLS", OracleDbType.Varchar2, NLS_MFO.Value, ParameterDirection.Input);

            cmd.Parameters.Add("PAWN", OracleDbType.Decimal, cbPAWN.Checked ? PAWN.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN_S", OracleDbType.Decimal, cbPAWN.Checked ? PAWN_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN_RNK", OracleDbType.Decimal, cbPAWN.Checked ? PAWN_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWNP", OracleDbType.Decimal, cbPAWNP.Checked ? PAWNP.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP_S", OracleDbType.Decimal, cbPAWNP.Checked ? PAWNP_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP_RNK", OracleDbType.Decimal, cbPAWNP.Checked ? PAWNP_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWN2", OracleDbType.Decimal, cbPAWN2.Checked ? PAWN2.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN2_S", OracleDbType.Decimal, cbPAWN2.Checked ? PAWN2_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN2_RNK", OracleDbType.Decimal, cbPAWN2.Checked ? PAWN2_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWNP2", OracleDbType.Decimal, cbPAWNP2.Checked ? PAWNP2.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP2_S", OracleDbType.Decimal, cbPAWNP2.Checked ? PAWNP2_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP2_RNK", OracleDbType.Decimal, cbPAWNP2.Checked ? PAWNP2_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWN3", OracleDbType.Decimal, cbPAWN3.Checked ? PAWN3.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN3_S", OracleDbType.Decimal, cbPAWN3.Checked ? PAWN3_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN3_RNK", OracleDbType.Decimal, cbPAWN3.Checked ? PAWN3_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWNP3", OracleDbType.Decimal, cbPAWNP3.Checked ? PAWNP3.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP3_S", OracleDbType.Decimal, cbPAWNP3.Checked ? PAWNP3_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP3_RNK", OracleDbType.Decimal, cbPAWNP3.Checked ? PAWNP3_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWN4", OracleDbType.Decimal, cbPAWN4.Checked ? PAWN4.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN4_S", OracleDbType.Decimal, cbPAWN4.Checked ? PAWN4_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN4_RNK", OracleDbType.Decimal, cbPAWN4.Checked ? PAWN4_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWNP4", OracleDbType.Decimal, cbPAWNP4.Checked ? PAWNP4.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP4_S", OracleDbType.Decimal, cbPAWNP4.Checked ? PAWNP4_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP4_RNK", OracleDbType.Decimal, cbPAWNP4.Checked ? PAWNP4_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWN5", OracleDbType.Decimal, cbPAWN5.Checked ? PAWN5.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN5_S", OracleDbType.Decimal, cbPAWN5.Checked ? PAWN5_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWN5_RNK", OracleDbType.Decimal, cbPAWN5.Checked ? PAWN5_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("PAWNP5", OracleDbType.Decimal, cbPAWNP5.Checked ? PAWNP5.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP5_S", OracleDbType.Decimal, cbPAWNP5.Checked ? PAWNP5_S.Value : (Decimal?)null, ParameterDirection.Input);
            cmd.Parameters.Add("PAWNP5_RNK", OracleDbType.Decimal, cbPAWNP5.Checked ? PAWNP5_RNK.Value : (Decimal?)null, ParameterDirection.Input);

            cmd.Parameters.Add("ERR_Code", OracleDbType.Decimal, null, ParameterDirection.Output);
            cmd.Parameters.Add("ERR_Message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            ND = ((OracleDecimal)cmd.Parameters["ND_"].Value).IsNull ? (decimal?)null : ((OracleDecimal)cmd.Parameters["ND_"].Value).Value;
            ErrCode = ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).Value;
            ErrMessage = ((OracleString)cmd.Parameters["ERR_Message"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["ERR_Message"].Value).Value;

            InitOraConnection();
            try
            {
                ClearParameters();
                SetParameters("ND", DB_TYPE.Decimal, ND, DIRECTION.Input);

                SetParameters("nBANK", DB_TYPE.Decimal, NBANK.Value, DIRECTION.Input);
                SetParameters("NLS", DB_TYPE.Varchar2, NLS_MFO.Value, DIRECTION.Input);
                SetParameters("NLS_NAME", DB_TYPE.Varchar2, NLS_NAME.Value, DIRECTION.Input);
                SetParameters("NLS_OKPO", DB_TYPE.Varchar2, NLS_OKPO.Value, DIRECTION.Input);

                SetParameters("nBANK2", DB_TYPE.Decimal, cbINS2.Checked ? NBANK2.Value : (Decimal?)null, DIRECTION.Input);
                SetParameters("NLS2", DB_TYPE.Varchar2, cbINS2.Checked ? NLS_MFO2.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_NAME2", DB_TYPE.Varchar2, cbINS2.Checked ? NLS_NAME2.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_OKPO2", DB_TYPE.Varchar2, cbINS2.Checked ? NLS_OKPO2.Value : (String)null, DIRECTION.Input);

                SetParameters("nBANK3", DB_TYPE.Decimal, cbINS3.Checked ? NBANK3.Value : (Decimal?)null, DIRECTION.Input);
                SetParameters("NLS3", DB_TYPE.Varchar2, cbINS3.Checked ? NLS_MFO3.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_NAME3", DB_TYPE.Varchar2, cbINS3.Checked ? NLS_NAME3.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_OKPO3", DB_TYPE.Varchar2, cbINS3.Checked ? NLS_OKPO3.Value : (String)null, DIRECTION.Input);

                SetParameters("nBANK4", DB_TYPE.Decimal, cbINS4.Checked ? NBANK4.Value : (Decimal?)null, DIRECTION.Input);
                SetParameters("NLS4", DB_TYPE.Varchar2, cbINS4.Checked ? NLS_MFO4.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_NAME4", DB_TYPE.Varchar2, cbINS4.Checked ? NLS_NAME4.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_OKPO4", DB_TYPE.Varchar2, cbINS4.Checked ? NLS_OKPO4.Value : (String)null, DIRECTION.Input);

                SetParameters("nBANK5", DB_TYPE.Decimal, cbINS5.Checked ? NBANK5.Value : (Decimal?)null, DIRECTION.Input);
                SetParameters("NLS5", DB_TYPE.Varchar2, cbINS5.Checked ? NLS_MFO5.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_NAME5", DB_TYPE.Varchar2, cbINS5.Checked ? NLS_NAME5.Value : (String)null, DIRECTION.Input);
                SetParameters("NLS_OKPO5", DB_TYPE.Varchar2, cbINS5.Checked ? NLS_OKPO5.Value : (String)null, DIRECTION.Input);

                SetParameters("CREDIT_ORDER", DB_TYPE.Varchar2, creditOrder.Value, DIRECTION.Input);

                SQL_NONQUERY(@"begin 
                                    cc_ins_partners(:ND,:nBANK,:NLS,:NLS_NAME,:NLS_OKPO,
                                                        :nBANK2,:NLS2,:NLS_NAME2,:NLS_OKPO2,
                                                        :nBANK3,:NLS3,:NLS_NAME3,:NLS_OKPO3,
                                                        :nBANK4,:NLS4,:NLS_NAME4,:NLS_OKPO4,
                                                        :nBANK5,:NLS5,:NLS_NAME5,:NLS_OKPO5, :CREDIT_ORDER);
                                    end;");

                if (cbFPROC2.Checked && ND.HasValue)
                {
                    cmd.CommandText = @"bars.cck.p_int_save";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("nd", OracleDbType.Decimal, ND, ParameterDirection.Input);
                    cmd.Parameters.Add("int_2_val", OracleDbType.Decimal, FPROC2.Value, ParameterDirection.Input);
                    cmd.Parameters.Add("int_2_date", OracleDbType.Date, FPROC2_DATE.Value, ParameterDirection.Input);
                    cmd.Parameters.Add("int_3_val", OracleDbType.Decimal, FPROC3.Value, ParameterDirection.Input);
                    cmd.Parameters.Add("int_3_date", OracleDbType.Date, FPROC3_DATE.Value, ParameterDirection.Input);
                    cmd.ExecuteNonQuery();
                }

            }
            finally
            {

                DisposeOraConnection();
            }

            // анализируем результат
            if (ErrCode.HasValue)
            {
                ShowError(ErrMessage);
                return false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Заявка прийнята. Присвоєно номер " + ND.ToString() + "'); location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
                ViewState.Remove("PREV_URL");
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return true;
    }

    private void CountSDI()
    {
        Decimal? nSDOG = SDOG.Value;
        Decimal? nSumSDI = sumSDI.Value;
        Decimal? nPrSDI = prSDI.Value;

        if (nSDOG.HasValue && (nSumSDI.HasValue || nPrSDI.HasValue))
        {
            if (nSumSDI.HasValue)
                nPrSDI = nSumSDI / nSDOG * 100;
            if (nPrSDI.HasValue)
                nSumSDI = nSDOG * nPrSDI / 100;
        }

        sumSDI.Value = nSumSDI;
        prSDI.Value = nPrSDI;
    }
    # endregion


    private void UpdatePanelsEnable(bool state)
    {
        IList<object> UpdatePanelsCollection = new List<object>(new object[]
        {
            attrMain,
            pnlMonthlyCommission,
            attrSDI,
            attrPayInstuctions,
            attrPayInstuctions2,
            attrPayInstuctions3,
            attrPayInstuctions4,
            attrPayInstuctions5,
            attrPawn,
            attrPawn2,
            attrPawn3,
            attrPawn4,
            attrPawn5,
            attrPawnP,
            attrPawnP2,
            attrPawnP3,
            attrPawnP4,
            attrPawnP5
        });

        foreach (Panel updatePanel in UpdatePanelsCollection)
        {
            updatePanel.Enabled = state;
        }

        btSend.Enabled = state;
    }


    protected void btnNo_Click(object sender, EventArgs e)
    {
        (FindControl("RNK") as Bars.UserControls.TextBoxNumb).Value = (Decimal?)null;
        (FindControl("OKPO") as TextBox).Text = "";
        (FindControl("FIO") as TextBox).Text = "";

        UpdatePanelsEnable(false);
    }
}
