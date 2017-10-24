using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Bars.Oracle;
using BarsWeb.Core.Logger;
using Bars.Exception;

using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;

public partial class PenaltyDetails : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public PenaltyDetails()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {      
        if (!IsPostBack)
        {
            FillDropDownLists();

            if (Request["penalty_id"] != null)
            {
                Int32 penaltyID = Convert.ToInt32(Request.QueryString["penalty_id"]);

                lbPenaltyTitle.Text = "Параметри штрафу № " + penaltyID.ToString();

                GetPenaltyDetails(penaltyID);
            }
            else
            {
                tbl2.Visible = false;
                ddlBalTypes.Items.Insert(0, new ListItem("", "", true));
                ddlPeriods.Items.Insert(0, new ListItem("", "", true));
            }
        }
    }

    /// <summary>
    /// 
    /// </summary>
    private void GetPenaltyDetails(Int32 penaltyID)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSQL = connect.CreateCommand();
            cmdSQL.CommandText = @"select PENALTY_NM "      + // 0
                                  "     , MSR_PRD_ID "      + // 1
                                  "     , PNY_BAL_TP "      + // 2
                                  "     , RUTHLESS "        + // 3
                                  "     , DIF_PNY_TP "      + // 4
                                  "     , PNY_TP_ID "       + // 5
                                  "     , DIF_TERM_TP "     + // 6
                                  "     , TERM_TP_ID "      + // 7
                                  "     , MODULE_CODE "     + // 8
                                  "  from V_DPU_PENALTIES " +
                                  " where PENALTY_ID = :pny_id";

            cmdSQL.Parameters.Add("pny_id", OracleDbType.Int32, penaltyID, ParameterDirection.Input);

            OracleDataReader rdrSQL = cmdSQL.ExecuteReader();

            if (!rdrSQL.Read())
            {
                String script = "bars.ui.alert({ text: 'Інформація про додаткову угоду #" + penaltyID.ToString() + " не знайдена!' })";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", script, true);
            }

            #region DATABIND

            // PENALTY_NM
            if (!rdrSQL.IsDBNull(0))
                tbPenaltyName.Text = rdrSQL.GetString(0);
            
            // MSR_PRD_ID
            if (!rdrSQL.IsDBNull(1))
            {
                tbPeriodId.Text = rdrSQL.GetInt32(1).ToString();
                ddlPeriods.SelectedValue = tbPeriodId.Text;
            }

            // PNY_BAL_TP
            if (!rdrSQL.IsDBNull(2))
            {
                tbBalTypeId.Text = rdrSQL.GetInt32(2).ToString();
                ddlBalTypes.SelectedValue = tbBalTypeId.Text;
            }

            // RUTHLESS
            if (!rdrSQL.IsDBNull(3))
            {
                cbCruelPenalty.Checked = (rdrSQL.GetInt32(3) == 1 ? true : false);
            }

            // DIF_PNY_TP
            if (!rdrSQL.IsDBNull(4))
            {
                cbPenaltyType.Checked = (rdrSQL.GetInt32(4) == 1 ? true : false);
                
                if (cbPenaltyType.Checked)
                {
                    ddlPenaltyTypes.Enabled = false;
                    ddlPenaltyTypes.SelectedItem.Text = "";
                }
                else
                {
                    // PNY_TP_ID
                    if (!rdrSQL.IsDBNull(5))
                    {
                        tbPenaltyTypeId.Text = rdrSQL.GetInt32(5).ToString();
                        ddlPenaltyTypes.SelectedValue = tbPenaltyTypeId.Text;
                    }
                }
            }

            // DIF_TERM_TP
            if (!rdrSQL.IsDBNull(6))
            {
                cbPenaltyPeriod.Checked = (rdrSQL.GetInt32(6) == 1 ? true : false);

                if (cbPenaltyPeriod.Checked)
                {
                    ddlPenaltyPeriods.Enabled = false;
                    ddlPenaltyPeriods.SelectedItem.Text = "";
                }
                else
                {
                    // 
                    if (!rdrSQL.IsDBNull(7))
                    {
                        tbPenaltyPeriodId.Text = rdrSQL.GetInt32(7).ToString();
                        ddlPenaltyPeriods.SelectedValue = tbPenaltyPeriodId.Text;
                    }
                }
            }

            // MODULE_CODE
            if (rdrSQL.IsDBNull(8))
            {
                // ТІЛЬКИ перегляд
                lbPenaltyTitle.Text = lbPenaltyTitle.Text + " (перегляд)";

                ReadOnlyMode.Value = "1";

                foreach (Control ctrl in frmPenaltyDetails.Controls)
                {
                    if (ctrl is TextBox)
                        ((TextBox)ctrl).Enabled = false;
                    else if (ctrl is DropDownList)
                        ((DropDownList)ctrl).Enabled = false;
                    else if (ctrl is CheckBox)
                        ((CheckBox)ctrl).Enabled = false;
                    else if (ctrl is HtmlInputButton)
                        ((HtmlInputButton)ctrl).Disabled = true;
                    else if (ctrl is HtmlInputText)
                        ((HtmlInputText)ctrl).Disabled = true;
                    else if (ctrl is HtmlInputCheckBox)
                        ((HtmlInputCheckBox)ctrl).Disabled = true;
                    else if (ctrl is Button)
                        ((Button)ctrl).Enabled = false;
                }
                
                // Вихід
                btnExit.Enabled = true;
            }
                
            #endregion
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

    protected void FillDropDownLists()
    {
        try
        {
            InitOraConnection();

            // Тип обчислення залишку
            ddlBalTypes.DataValueField = "ID";
            ddlBalTypes.DataTextField = "NAME";
            ddlBalTypes.DataSource = SQL_SELECT_dataset("select ID, NAME from BARS.DPT_SHOST order by ID");
            ddlBalTypes.DataBind();

            // Одиниці виміру періоду для штрафу
            ddlPeriods.DataValueField = "ID";
            ddlPeriods.DataTextField = "NAME";
            ddlPeriods.DataSource = SQL_SELECT_dataset("select ID, NAME from BARS.DPT_SHSROK order by ID");
            ddlPeriods.DataBind();

            // Тип штрафу
            ddlPenaltyTypes.DataValueField = "ID";
            ddlPenaltyTypes.DataTextField = "NAME";
            ddlPenaltyTypes.DataSource = SQL_SELECT_dataset("select ID, NAME from BARS.DPT_SHTYPE order by ID");
            ddlPenaltyTypes.DataBind();
            ddlPenaltyTypes.Items.Insert(0, new ListItem("", "", true));

            // Штрафний період
            ddlPenaltyPeriods.DataValueField = "ID";
            ddlPenaltyPeriods.DataTextField = "NAME";
            ddlPenaltyPeriods.DataSource = SQL_SELECT_dataset("select ID, NAME from BARS.DPT_SHTERM order by ID");
            ddlPenaltyPeriods.DataBind();
            ddlPenaltyPeriods.Items.Insert(0, new ListItem("", "", true));
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Decimal? pny_id = null;
        OracleString error_msg = String.Empty;

        if (Request["penalty_id"] != null)
        {
            pny_id = Convert.ToInt32(Request.QueryString["penalty_id"]);
        }

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.BindByName = true;

            if (!pny_id.HasValue)
            {
                cmd.CommandText = "dpu_utils.add_penalty";
                
                // Output
                cmd.Parameters.Add("penalty_id", OracleDbType.Decimal, pny_id, ParameterDirection.Output);
            }
            else
            {
                cmd.CommandText = "dpu_utils.upd_penalty";

                cmd.Parameters.Add("penalty_id", OracleDbType.Decimal, pny_id, ParameterDirection.Input);

                if (cbPenaltyType.Checked)
                {
                    cmd.Parameters.Add("penalty_tp", OracleDbType.Decimal, null, ParameterDirection.Input);
                }
                else
                {
                    cmd.Parameters.Add("penalty_tp", OracleDbType.Decimal, Convert.ToInt32(tbPenaltyTypeId.Text), ParameterDirection.Input);
                }

                if (cbPenaltyPeriod.Checked)
                {
                    cmd.Parameters.Add("pny_prd_tp", OracleDbType.Decimal, null, ParameterDirection.Input);
                }
                else
                {
                    cmd.Parameters.Add("pny_prd_tp", OracleDbType.Decimal, Convert.ToInt32(tbPenaltyPeriodId.Text), ParameterDirection.Input);
                }
            }

            cmd.Parameters.Add("penalty_nm", OracleDbType.Varchar2, tbPenaltyName.Text, ParameterDirection.Input);
            cmd.Parameters.Add("msr_prd_id", OracleDbType.Decimal, Convert.ToInt32(tbPeriodId.Text), ParameterDirection.Input);
            cmd.Parameters.Add("pny_bal_tp", OracleDbType.Decimal, Convert.ToInt32(tbBalTypeId.Text), ParameterDirection.Input);
            cmd.Parameters.Add("ruthless", OracleDbType.Decimal, (cbCruelPenalty.Checked ? 1 : 0), ParameterDirection.Input);

            // Output
            cmd.Parameters.Add("p_err_msg", OracleDbType.Varchar2, error_msg, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            error_msg = (OracleString)cmd.Parameters["p_err_msg"].Value;

            String script = String.Empty;

            if ( error_msg.IsNull )
            {
                // без помилки
                if (pny_id.HasValue)
                {
                    script = "bars.ui.alert({ text: 'Оновлено параметри штрафу!' }); ";
                }
                else
                {
                    pny_id = ((OracleDecimal)cmd.Parameters["penalty_id"].Value).Value;

                    script = "alert('Створено штраф #" + pny_id.ToString() + "'); location.replace('/barsroot/udeposit_admin/dpupenaltydetails.aspx?mode=1&penalty_id=" + Convert.ToString(pny_id) + "');";
                }
            }
            else
            {
                script = "bars.ui.alert({ text: 'Помилка при " + (pny_id.HasValue ? " оновленні параметрів" : "створенні") +
                    " штрафу:" + error_msg.ToString() + "' }); ";
            }

            ClientScript.RegisterStartupScript(this.GetType(), "Done", script, true);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}