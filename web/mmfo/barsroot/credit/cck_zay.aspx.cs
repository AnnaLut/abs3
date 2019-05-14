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
using Bars.Exception;

public partial class credit_cck_zay : Bars.BarsPage
{
    # region Приватные свойства
    private String _ShowCustomerReferPattern = "ShowCustomerRefer({0}, '{1}', '{2}', '{3}'); return false;";
    private String _ShowBanksReferPattern = "ShowBanksRefer('{0}', '{1}'); return false;";
    private String _ShowDepositReferPattern = "ShowDepositRefer('{0}', '{1}', '{2}', '{3}', '{4}'); return false;";
    string[] _creditOrders = { "220377", "220353" };
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbPageTitle.Text += Request.Params.Get("CUSTTYPE") == "3" ? " ФО" : " ЮО";
            // первичное отображение
            cbINS_CheckedChanged(cbINS, e);
            cbPAWN_CheckedChanged(cbPAWN, e);
            cbPAWNP_CheckedChanged(cbPAWNP, e);

            creditOrderTitle.Visible = creditOrder.Visible = _creditOrders.Contains(Request.Params.Get("PROD"));
        }

        btnNo.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnNo.UniqueID, "");

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
                                , c.crisk
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

                if (rdr["crisk"] != DBNull.Value && NFIN.Items.Count > Convert.ToInt32(rdr["crisk"].ToString())) //crisk = 10
                {
                    NFIN.SelectedIndex = Convert.ToInt32(rdr["crisk"].ToString());
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

                ShowError("Клієнт (" + RNK.ToString() + ") не знайдений");
            }

            rdr.Close();
            rdr.Dispose();

            if (DDL_PROD.Items != null)
                DDL_PROD.Items.Clear();

            IFRS.Value = "";

            SetBusMod(con);
            SetSPPI(con);
            SetIFRS(con);
            SetProd(con);
            InfoPanel.Update();
        }
        finally
        {
            cmd.Dispose();
            con.Close();
            con.Dispose();
        }
    }
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
            cmd.Dispose();
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
        toplink.Focus();
        if (ValidatePage() && SendZay())
        {
            // действия выполняются в проц ValidatePage, SendZay
        }

    }
    protected override void OnPreRender(EventArgs e)
    {
        BindControls();
        cbFPROC2.Visible = FPROC2Title.Visible = FPROC2.Visible = FPROC2_DATETitle.Visible = 
            FPROC2_DATE.Visible = Request.Params.Get("CUSTTYPE") == "3" && IsManyRatesActive();//декілька ставок тільки для ФО

        Panel_SumComObsl.Visible =                                                                                  //Комісія за обслуговування кредиту тільки для ФО також
                    lblINT_R.Visible = INTRT.Visible = Request.Params.Get("CUSTTYPE") == "3";                     //ну і ринкова туди ж
        attrSDI.GroupingText = Request.Params.Get("CUSTTYPE") == "3" ? "Разова комісія за надання кредиту" : "Одноразова комісія";

        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void BindControls()
    {

        btCustomerReferRNK.OnClientClick = String.Format(_ShowCustomerReferPattern, Request.Params.Get("CUSTTYPE"), RNK.BaseClientID, OKPO.ClientID, FIO.ClientID);
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

        // Порука
        // Код Контрагенту : 
        btCustomerReferPAWNP_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP_RNK.BaseClientID, PAWNP_OKPO.ClientID, PAWNP_FIO.ClientID);
        btCustomerReferPAWNP2_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP2_RNK.BaseClientID, PAWNP2_OKPO.ClientID, PAWNP2_FIO.ClientID);
        btCustomerReferPAWNP3_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP3_RNK.BaseClientID, PAWNP3_OKPO.ClientID, PAWNP3_FIO.ClientID);
        btCustomerReferPAWNP4_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP4_RNK.BaseClientID, PAWNP4_OKPO.ClientID, PAWNP4_FIO.ClientID);
        btCustomerReferPAWNP5_RNK.OnClientClick = String.Format(_ShowCustomerReferPattern, "0", PAWNP5_RNK.BaseClientID, PAWNP5_OKPO.ClientID, PAWNP5_FIO.ClientID);

        if (!IsPostBack)
        {
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con))
            using (OracleDataAdapter adr = new OracleDataAdapter(cmd))
            {
                try
                {
                    // установка роли
                    cmd.ExecuteNonQuery();

                    DataTable dtKV = new DataTable();
                    cmd.CommandText = "select kv as id, kv || ' - ' || name || ' (' || lcv || ')' as name from tabval where (d_close is null or d_close > bankdate) and KV IN (978,840,980,643,752,974)";
                    adr.Fill(dtKV);

                    KV.DataSource = dtKV;
                    KV.DataValueField = "ID";
                    KV.DataTextField = "NAME";
                    KV.SelectedIndex = 6;
                    KV.DataBind();

                    // Базовий рік : 

                    DataTable dtBASEY = new DataTable();
                    cmd.CommandText = "select basey as id, basey || ' - ' || name || ' (' || name_mb || ')' as name from basey order by id";
                    adr.Fill(dtBASEY);

                    BASEY.DataSource = dtBASEY;
                    BASEY.DataValueField = "ID";
                    BASEY.DataTextField = "NAME";
                    BASEY.SelectedIndex = 1;
                    BASEY.DataBind();


                    // Дата початку дії : 
                    cmd.CommandText = "select web_utl.get_bankdate from dual";
                    DateTime dBankDate = Convert.ToDateTime(cmd.ExecuteScalar());
                    SDATE.MinValue = dBankDate;
                    SDATE.Value = dBankDate;
                    WDATE.Value = dBankDate.AddYears(1);

                    FPROC2_DATE.MinValue = dBankDate.AddDays(1); //min > bddate


                    // Графік погашення (1,2,3) : 

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


                    // Фін. стан : 

                    DataTable dtNFIN = new DataTable();
                    cmd.CommandText = "select fin as id, fin || ' - ' || name as name from stan_fin order by fin";
                    adr.Fill(dtNFIN);

                    NFIN.DataSource = dtNFIN;
                    NFIN.DataValueField = "ID";
                    NFIN.DataTextField = "NAME";
                    NFIN.SelectedIndex = 1;
                    NFIN.DataBind();


                    // Період погашення тіла КД : 
                    DataTable dtNFREQ = new DataTable();
                    cmd.CommandText = "select freq as id, freq || ' - ' || name as name from freq order by id";
                    adr.Fill(dtNFREQ);

                    NFREQ.DataSource = dtNFREQ;
                    NFREQ.DataValueField = "ID";
                    NFREQ.DataTextField = "NAME";
                    NFREQ.SelectedIndex = 4;
                    NFREQ.DataBind();

                    // Щомісячна комісія
                    // Метод нарахування щомісячної комісії : 

                    DataTable dtMETR = new DataTable();
                    cmd.CommandText = "select metr as id, metr || ' - ' || name as name from int_metr where metr > 94 or metr=0";
                    adr.Fill(dtMETR);

                    METR.DataSource = dtMETR;
                    METR.DataValueField = "ID";
                    METR.DataTextField = "NAME";
                    METR.DataBind();

                    METR_ValueChanged(METR, null);

                    //мсфз-параметри
                    DDL_BUS_MOD.Width = 300;
                    DDL_SPPI.Width = DDL_POCI.Width = 75;
                    DDL_PROD.Width = 400;
                    DDL_AIM.Width = 150;

                    DataTable dtSPPI = new DataTable();
                    cmd.CommandText = "select SPPI_VALUE as id, SPPI_ID as name from SPPI";
                    adr.Fill(dtSPPI);

                    DDL_SPPI.DataSource = dtSPPI;
                    DDL_SPPI.DataValueField = "ID";
                    DDL_SPPI.DataTextField = "NAME";
                    DDL_SPPI.DataBind();

                    DataTable dtPOCI = new DataTable();
                    cmd.CommandText = "select id, name from POCI";
                    adr.Fill(dtPOCI);

                    DDL_POCI.DataSource = dtPOCI;
                    DDL_POCI.DataValueField = "ID";
                    DDL_POCI.DataTextField = "NAME";
                    DDL_POCI.DataBind();


                    DataTable dtAim = new DataTable();
                    cmd.CommandText = @" select distinct(aim) as id, name as name from cc_aim_2 
                                                where custtype = :custtype and (d_close is null or d_close > to_date(:p_deal_date, 'dd.mm.yyyy')) order by aim";
                    cmd.Parameters.Add("custtype", OracleDbType.Int32, Convert.ToInt32(Request.Params.Get("CUSTTYPE").ToString()), ParameterDirection.Input);
                    cmd.Parameters.Add("p_deal_date", OracleDbType.Varchar2, String.Format("{0:dd.MM.yyyy}", SDATE.Value), ParameterDirection.Input);

                    adr.Fill(dtAim);
                    DDL_AIM.DataSource = dtAim;
                    DDL_AIM.DataValueField = "ID";
                    DDL_AIM.DataTextField = "NAME";
                    DDL_AIM.DataBind();
                    DDL_AIM.SelectedValue = DDL_AIM.Items.Count > 0 ? DDL_AIM.Items[1].Value : DDL_AIM.Items[0].Value;


                    // Тип : 
                    DataTable dtPAWN = new DataTable();
                    cmd.CommandText = "select pawn as id, pawn || ' - ' || name as name from cc_pawn where nbsz <> 9031";
                    adr.Fill(dtPAWN);
                    List<ASP.credit_usercontrols_ddllist_ascx> pawns = new List<ASP.credit_usercontrols_ddllist_ascx> { PAWN, PAWN2, PAWN3, PAWN4, PAWN5 };
                    foreach (ASP.credit_usercontrols_ddllist_ascx pawn in pawns)
                    {
                        pawn.DataSource = dtPAWN;
                        pawn.DataValueField = "ID";
                        pawn.DataTextField = "NAME";
                        pawn.DataBind();
                        pawn.Width = 400;

                PAWN.Width = PAWN2.Width = PAWN3.Width = PAWN4.Width = PAWN5.Width = 400;
                    }

                    // Тип : 
                    DataTable dtPAWNP = new DataTable();
                    cmd.CommandText = "select pawn as id, pawn || ' - ' || name as name from cc_pawn where nbsz = 9031";
                    adr.Fill(dtPAWNP);
                    List<ASP.credit_usercontrols_ddllist_ascx> pawnps = new List<ASP.credit_usercontrols_ddllist_ascx> { PAWNP, PAWNP2, PAWNP3, PAWNP4, PAWNP5 };
                    foreach (ASP.credit_usercontrols_ddllist_ascx pawnp in pawnps)
                    {
                        pawnp.DataSource = dtPAWNP;
                        pawnp.DataValueField = "ID";
                        pawnp.DataTextField = "NAME";
                        pawnp.DataBind();
                        pawnp.Width = 400;

                PAWNP.Width = PAWNP2.Width = PAWNP3.Width = PAWNP4.Width = PAWNP5.Width = 400;
                    }
                }
                catch (Exception ex)
                {
                    ShowError(ex.Message);
                }
            }
        }
    }
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", String.Format("alert(\'{0}\');", ErrorText.Replace('"', ' ').Replace('\n', ' ')), true);
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
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {

                if (rdr.Read())
                {
                    if ((Decimal)rdr["cnt"] > 0)
                    {

                        ShowError("Номер договору існує (" + CC_ID.Value + ") введіть корректний номер");
                        return false;
                    }
                }
            }

        }
        finally
        {
            cmd.Dispose();
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
            cmd.Parameters.Add("PROD_", OracleDbType.Varchar2, DDL_PROD.SelectedValue.ToString(), ParameterDirection.Input);

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

                if (ND.HasValue)
                {
                    var list_params = new[] { new { Tag = "S_S36", Value = SumComObsl.Value.ToString() },
                        new { Tag = "BUS_MOD", Value = DDL_BUS_MOD.Value.ToString() },  new { Tag = "SPPI", Value = DDL_SPPI.Value.ToString() },
                        new { Tag = "IFRS", Value = IFRS.Value }, new { Tag = "POCI", Value = DDL_POCI.Value.ToString() },
                        new { Tag = "INTRT", Value = INTRT.Value.ToString() }
                    };

                    cmd.CommandText = @"bars.cck_app.set_nd_txt";
                    foreach (var item in list_params)
                    {
                        if (item.Value != "")
                        {
                            try
                            {
                                cmd.Parameters.Clear();
                                cmd.Parameters.Add("p_ND", OracleDbType.Decimal, ND, ParameterDirection.Input);
                                cmd.Parameters.Add("p_TAG", OracleDbType.Varchar2, item.Tag, ParameterDirection.Input);
                                cmd.Parameters.Add("p_TXT", OracleDbType.Varchar2, item.Value, ParameterDirection.Input);
                                cmd.ExecuteNonQuery();
                            }
                            catch (Exception e)
                            {
                                throw new BarsException(e.Message);
                            }
                        }
                    }
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
                ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Заявка прийнята. Присвоєно номер " + ND.ToString() + "');", true);
            }
        }
        finally
        {
            cmd.Dispose();
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

    protected void Bus_Mod_Changed(object sender, EventArgs e)
    {
        UpdateMSFZdata(true);
    }

    protected void SPPI_Changed(object sender, EventArgs e)
    {
        UpdateMSFZdata(true);
    }

    protected void Poci_Changed(object sender, EventArgs e)
    {
        UpdateMSFZdata(false);
    }

    protected void AIM_Changed(object sender, EventArgs e)
    {
        UpdateMSFZdata(false);
    }

    private void UpdateMSFZdata(bool UpdateIFRS)
    {
        if (DDL_PROD.Items != null)
            DDL_PROD.Items.Clear();
        using (OracleConnection conn = OraConnector.Handler.IOraConnection.GetUserConnection())
        {
            if (UpdateIFRS)
                SetIFRS(conn);

            SetProd(conn);
        }
    }

    private void SetSPPI(OracleConnection conn)
    {
        using (OracleCommand cmd = conn.CreateCommand())
        {
            try
            {
                byte custtype = 0;
                string bussl = "";
                cmd.CommandText = @" select c.custtype, cw.value from customer c left join customerw cw on c.rnk = cw.rnk and cw.tag = 'BUSSL' where c.rnk = :rnk ";
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, RNK.Value, ParameterDirection.Input);
                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        custtype = reader.GetByte(0);
                        bussl = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    }
                }
                DDL_SPPI.SelectedIndex = (custtype == 3) || (custtype == 2 && bussl == "2") ? 1 : 0;
                DDL_SPPI.Enabled = custtype != 3;
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }
    }

    private void SetIFRS(OracleConnection conn)
    {
        if (DDL_BUS_MOD.Items.Count == 0 || DDL_SPPI.SelectedIndex == 0)
            return;

        using (OracleCommand cmd = conn.CreateCommand())
        {
            try
            {
                cmd.CommandText = @" Select IFRS from BUSMOD_SPPI_IFRS where BUS_MOD = :bus_mode and SPPI = :sppi ";
                cmd.Parameters.Add("bus_mode", OracleDbType.Int32, DDL_BUS_MOD.Value, ParameterDirection.Input);
                cmd.Parameters.Add("sppi", OracleDbType.Int32, DDL_SPPI.Value, ParameterDirection.Input);
                IFRS.Value = cmd.ExecuteScalar().ToString();
                DDL_POCI.Enabled = IFRS.Value != "FVTPL/Other" && Request.Params.Get("CUSTTYPE").ToString() != "3";
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }
    }

    private void SetBusMod(OracleConnection conn)
    {
        string range = " (6, 7, 8, 9, 10, 11, 14) ";

        using (OracleCommand cmd = conn.CreateCommand())
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = @"bars.msfz9.f_business_model";
            OracleParameter output = new OracleParameter("l_BUS_MOD", OracleDbType.Int32, null, ParameterDirection.ReturnValue);
            cmd.Parameters.Add(output);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK.Value, ParameterDirection.Input);
            cmd.ExecuteNonQuery();
            if (output.Value.ToString() != "null")
                range = "(" + output.Value.ToString() + ")";

            using (OracleDataAdapter adr = new OracleDataAdapter(cmd))
            {
                DDL_BUS_MOD.Items.Clear();
                cmd.CommandType = CommandType.Text;
                DataTable dtBusMod = new DataTable();
                cmd.CommandText = String.Format("select bus_mod_id as id, bus_mod_id || ') ' || bus_mod_name as name from bus_mod where bus_mod_id in {0}", range);
                adr.Fill(dtBusMod);

                DDL_BUS_MOD.DataSource = dtBusMod;
                DDL_BUS_MOD.DataValueField = "ID";
                DDL_BUS_MOD.DataTextField = "NAME";
                DDL_BUS_MOD.DataBind();
                if (DDL_BUS_MOD.Items.Count > 0)
                    DDL_BUS_MOD.SelectedValue = DDL_BUS_MOD.Items[0].Value;
                DDL_BUS_MOD.Enabled = Request.Params.Get("CUSTTYPE").ToString() != "3";

            }
        }
    }

    private void SetProd(OracleConnection conn)
    {
        if (IFRS.Value == "" || DDL_AIM.SelectedIndex == 0)
            return;

        using (OracleCommand cmd = conn.CreateCommand())
        {
            try
            {
                DataTable dtProd = new DataTable();
                cmd.CommandText = @"select id, id || ' ' || name as name from CC_POTR_2 where IFRS =:ifrs and AIM = :aim and CUSTTYPE = :custtype and POCI = :poci";
                cmd.Parameters.Add("ifrs", OracleDbType.Varchar2, IFRS.Value, ParameterDirection.Input);
                cmd.Parameters.Add("aim", OracleDbType.Int32, DDL_AIM.Value, ParameterDirection.Input);
                cmd.Parameters.Add("custtype", OracleDbType.Int32, Convert.ToInt32(Request.Params.Get("CUSTTYPE").ToString()), ParameterDirection.Input);
                cmd.Parameters.Add("poci", OracleDbType.Int32, DDL_POCI.Value ?? 0, ParameterDirection.Input);

                using (OracleDataAdapter adr = new OracleDataAdapter(cmd))
                {
                    adr.Fill(dtProd);
                    DDL_PROD.DataSource = dtProd;
                    DDL_PROD.DataValueField = "ID";
                    DDL_PROD.DataTextField = "NAME";
                    DDL_PROD.DataBind();
                    if (DDL_PROD.Items.Count > 0)
                        DDL_PROD.SelectedValue = DDL_PROD.Items[0].Value;

                }
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }
    }

    private bool IsManyRatesActive()
    {
        using (OracleConnection conn = OraConnector.Handler.IOraConnection.GetUserConnection())
        using (OracleCommand cmd = conn.CreateCommand())
        {
            try
            {
                cmd.CommandText = @" Select getglobaloption('BAGATOSTAVOK') from dual ";
                string res = cmd.ExecuteScalar().ToString();
                return !String.IsNullOrEmpty(res) && res == "1";
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
                return false;
            }
        }
    }
}
