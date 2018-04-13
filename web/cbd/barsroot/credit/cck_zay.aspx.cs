using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

using Bars.UserControls;

public partial class credit_cck_zay : Bars.BarsPage
{
    # region Приватные свойства
    private String _ShowCustomerReferPattern = "ShowCustomerRefer({0}, '{1}', '{2}', '{3}'); return false;";
    private String _ShowBanksReferPattern = "ShowBanksRefer('{0}', '{1}'); return false;";
    private String _ShowDepositReferPattern = "ShowDepositRefer('{0}', '{1}', '{2}', '{3}', '{4}'); return false;";
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
            // первичное отображение
            cbPAWN_CheckedChanged(cbPAWN, e);
            cbPAWNP_CheckedChanged(cbPAWNP, e);

            switch(Request.Params.Get("PROD"))
            {
                case "220234":
                case "220239":
                case "220325":
                case "220330": {
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
                break;
            }
        }
    }
    protected void RNK_ValueChanged(object sender, EventArgs e)
    {
        Decimal? RNK = (sender as Bars.UserControls.TextBoxNumb).Value;
        String RNK_CtrlID = (sender as Control).ID;
        String BaseID = RNK_CtrlID.Substring(0, RNK_CtrlID.IndexOf("_") + 1);

        if (!RNK.HasValue) return;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            cmd.CommandText = "select okpo, nmk as fio, date_off from customer where rnk = :p_rnk";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
            	if (rdr["DATE_OFF"] == DBNull.Value)
            	{
                	(FindControl(BaseID + "OKPO") as TextBox).Text = rdr["OKPO"] == DBNull.Value ? (String)null : (String)rdr["OKPO"];
                	(FindControl(BaseID + "FIO") as TextBox).Text = rdr["FIO"] == DBNull.Value ? (String)null : (String)rdr["FIO"];
            	}
            	else
            	{
	                (sender as Bars.UserControls.TextBoxNumb).Value = (Decimal?)null;
	                (FindControl(BaseID + "OKPO") as TextBox).Text = "";
	                (FindControl(BaseID + "FIO") as TextBox).Text = "";

	                ShowError("Клієн (" + RNK.ToString() + ") закритий");
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
                cmd.CommandText = "select kv as id, kv || ' - ' || name || ' (' || lcv || ')' as name from tabval where d_close is null or d_close > bankdate";
                adr.Fill(dtKV);

                KV.DataSource = dtKV;
                KV.DataValueField = "ID";
                KV.DataTextField = "NAME";
                KV.DataBind();
            }

            // Базовий рік : 
            if (!IsPostBack)
            {
                DataTable dtBASEY = new DataTable();
                cmd.CommandText = "select basey as id, basey || ' - ' || name || ' (' || name_mb || ')' as name from basey";
                adr.Fill(dtBASEY);

                BASEY.DataSource = dtBASEY;
                BASEY.DataValueField = "ID";
                BASEY.DataTextField = "NAME";
                BASEY.DataBind();
            }

            // Дата початку дії : 
            cmd.CommandText = "select web_utl.get_bankdate from dual";
            DateTime dBankDate = Convert.ToDateTime(cmd.ExecuteScalar());
            SDATE.MinValue = dBankDate;

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
                cmd.CommandText = "select freq as id, freq || ' - ' || name as name from freq";
                adr.Fill(dtNFREQ);

                NFREQ.DataSource = dtNFREQ;
                NFREQ.DataValueField = "ID";
                NFREQ.DataTextField = "NAME";
                NFREQ.DataBind();
            }

            // Продукт (ОВ22) : 
            PROD.Text = Request.Params.Get("PROD") + " - " + Request.Params.Get("NAME");

            // Щомісячна комісія
            // Метод нарахування щомісячної комісії : 
            if (!IsPostBack)
            {
                DataTable dtMETR = new DataTable();
                cmd.CommandText = "select metr as id, metr || ' - ' || name as name from int_metr where metr > 94";
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
    private void HideError()
    {
    }
    private Boolean ValidatePage()
    {
        // скрываем ошибки
        HideError();

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
                    ShowError("Помилка у контрольному розряді рахунку");
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
            cmd.Parameters.Add("PROD_", OracleDbType.Decimal, Convert.ToDecimal(Request.Params.Get("PROD")), ParameterDirection.Input);
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

            ND = ((OracleDecimal)cmd.Parameters["ND_"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ND_"].Value).Value;
            ErrCode = ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).Value;
            ErrMessage = ((OracleString)cmd.Parameters["ERR_Message"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["ERR_Message"].Value).Value;

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
}
