using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Oracle;
using BarsWeb.Core.Logger;
using Bars.Exception;

public partial class DptProcessingAgreement : Bars.BarsPage
{
    /// <summary>
    /// 
    /// </summary>
    private readonly IDbLogger _dbLogger;
    
    /// <summary>
    /// 
    /// </summary>
    public DptProcessingAgreement()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }
    //
    private Int16 mode
    {
        get
        {
            return (Int16)this.ViewState["mode"];
        }
        set
        {
            this.ViewState["mode"] = value;
        }
    }

    /// <summary>
    /// Статус ДУ
    /// </summary>
    private Int16 agrmnt_state
    {
        get
        {
            return (Int16)this.ViewState["agrmnt_state"];
        }
        set
        {
            this.ViewState["agrmnt_state"] = value;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    private Int64 agrmnt_id
    {
        get
        {
            return (Int64)this.ViewState["agrmnt_id"];
        }
        set
        {
            this.ViewState["agrmnt_id"] = value;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    private Int64 dpu_id
    {
        get
        {
            return (Int64)this.ViewState["dpu_id"];
        }
        set
        {
            this.ViewState["dpu_id"] = value;
        }
    }
    private Int64 cust_id
    {
        get
        {
            return (Int64)this.ViewState["cust_id"];
        }
        set
        {
            this.ViewState["cust_id"] = value;
        }
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
            if (Request["agrmnt_id"] == null)
            {
                String script  = "bars.ui.alert({ text: 'Ідентифікатор додаткової угоди не вказано!' })";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", script, true);
            }
            else
            {
                agrmnt_id = Convert.ToInt64(Request.QueryString["agrmnt_id"]);

                GetAgreementDetails();

                if (Request.QueryString["mode"] == "1")
                {
                    // обробка (візування/відхилення)

                    mode = 1;

                    #region unchangeable
                    
                    if (tbAgrnmtTypeId.Text != "4")
                    {
                        tbRecipientAcnt.ReadOnly = true;
                        tbRecipientName.ReadOnly = true;
                        tbBankName.ReadOnly = true;
                    }

                    #endregion

                    if (Bars.Configuration.ConfigurationSettings.GetCurrentUserInfo.user_id == tbCreationUserId.Text)
                    {
                        btnConfirm.Visible = false;

                        String script = "bars.ui.alert({ text: 'Користувачу який створив ДУ заборонено її візування!' })";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", script, true);
                    }

                }
                else
                {
                    // перегляд
                    
                    mode = 3;

                    foreach (Control ctrl in frmProcessingAgreement.Controls)
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
                        // else if (ctrl is Button)
                        //     ((Button)ctrl).Enabled = false;
                    }

                    tbComments.Enabled = false;
                    btnConfirm.Visible = false;
                    btnRefuse.Visible = false;
                }

                FillDropDownLists(Convert.ToInt32(tbAgrnmtTypeId.Text));
            }
            // ddlFrequencies
            // ddlPenalties

        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="agrmntID"></param>
    private void GetAgreementDetails()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSQL = connect.CreateCommand();
            cmdSQL.CommandText = @"select AGRMNT_NUMBER, AGRMNT_DUE_DATE, AGRMNT_TYPE_ID, AGRMNT_TYPE_NAME,
                                          AGRMNT_AMOUNT, AGRMNT_RATE,     AGRMNT_FREQ,    AGRMNT_STOP_ID,
                                          AGRMNT_DPU_ID, CNTRCT_CUST_ID,  AGRMNT_STATE,
                                          AGRMNT_CREATOR_ID, AGRMNT_CREATOR_NAME, AGRMNT_CRDATE,
                                          AGRMNT_HANDLER_ID, AGRMNT_HANDLER_NAME, AGRMNT_PRCDATE
                                     from BARS.V_DPU_AGREEMENTS
                                    where AGRMNT_ID = :agreement_id";

            cmdSQL.Parameters.Add("agreement_id", OracleDbType.Int32, agrmnt_id, ParameterDirection.Input);

            OracleDataReader rdrSQL = cmdSQL.ExecuteReader();

            if (!rdrSQL.Read())
            {
                String script = "bars.ui.alert({ text: 'Інформація про додаткову угоду #" + agrmnt_id.ToString() + " не знайдена!' })";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", script, true);
            }

            #region DATABIND

            // AGRMNT_NUMBER
            if (!rdrSQL.IsDBNull(0))
                tbAgrnmtNum.Text = rdrSQL.GetString(0).ToString();

            // AGRMNT_DUE_DATE
            if (!rdrSQL.IsDBNull(1))
                tbAgrnmtDate.Text = rdrSQL.GetDateTime(1).ToString("dd/MM/yyyy");

            // AGRMNT_TYPE_ID
            if (!rdrSQL.IsDBNull(2))
                tbAgrnmtTypeId.Text = rdrSQL.GetInt32(2).ToString();

            // AGRMNT_TYPE_NAME
            if (!rdrSQL.IsDBNull(3))
                tbAgrnmtTypeName.Text = rdrSQL.GetString(3);

            // AGRMNT_AMOUNT
            if (!rdrSQL.IsDBNull(4))
            {
                if (tbAgrnmtTypeId.Text == "1")
                    tbAgrnmtAmnt.Text = rdrSQL.GetOracleDecimal(4).ToString();
            }                

            // AGRMNT_RATE
            if (!rdrSQL.IsDBNull(5))
                tbAgrnmtRate.Text = rdrSQL.GetDecimal(5).ToString("#0.00#");

            // AGRMNT_FREQ
            if (!rdrSQL.IsDBNull(6))
                tbFrequencyId.Text = rdrSQL.GetDecimal(6).ToString();

            // AGRMNT_STOP_ID
            if (!rdrSQL.IsDBNull(7))
                tbPenaltyId.Text = rdrSQL.GetDecimal(7).ToString();

            // AGRMNT_DPU_ID
            if (!rdrSQL.IsDBNull(8))
                dpu_id = rdrSQL.GetInt64(8);

            // CNTRCT_CUST_ID
            if (!rdrSQL.IsDBNull(9))
                cust_id = rdrSQL.GetInt64(9);

            // AGRMNT_STATE,
            if (!rdrSQL.IsDBNull(10))
                agrmnt_state = rdrSQL.GetInt16(10);

            //  AGRMNT_CREATOR_ID
            if (!rdrSQL.IsDBNull(11))
                tbCreationUserId.Text = rdrSQL.GetInt64(11).ToString();

            // AGRMNT_CREATOR_NAME
            if (!rdrSQL.IsDBNull(12))
                tbCreationUserName.Text = rdrSQL.GetString(12);

            // AGRMNT_CRDATE
            if (!rdrSQL.IsDBNull(13))
                tbCreationDate.Text = rdrSQL.GetDateTime(13).ToString("dd/MM/yyyy");

            // AGRMNT_HANDLER_ID
            if (!rdrSQL.IsDBNull(14))
                tbProcessingUserId.Text = rdrSQL.GetOracleDecimal(14).ToString();

            // AGRMNT_HANDLER_NAME
            if (!rdrSQL.IsDBNull(15))
                tbProcessingUserName.Text = rdrSQL.GetString(15);

            // AGRMNT_PRCDATE
            if (!rdrSQL.IsDBNull(16))
                tbProcessingDate.Text = rdrSQL.GetDateTime(16).ToString("dd/MM/yyyy");

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

    /// <summary>
    /// Населення випадаючих списків
    /// </summary>
    protected void FillDropDownLists(Int32 agrmntType)
    {
        try
        {
            InitOraConnection();

            if (agrmntType == 3)
            {
                // Періодичність сплати
                ddlFrequencies.Enabled = ((agrmnt_state == 0 && mode == 1) ? true : false);
                if (!ddlFrequencies.Enabled)
                    ddlFrequencies.BackColor = System.Drawing.Color.Gainsboro;

                ddlFrequencies.DataSource = SQL_SELECT_dataset("select FREQ as FREQ_ID, NAME as FREQ_NAME from BARS.FREQ order by 1");
                ddlFrequencies.DataBind();
                ddlFrequencies.SelectedValue = tbFrequencyId.Text;
            }

            if (agrmntType == 6)
            {
                // Штраф за дострокове вилучення
                ddlPenalties.Enabled = ((agrmnt_state == 0 && mode == 1) ? true : false);
                if (!ddlPenalties.Enabled)
                    ddlPenalties.BackColor = System.Drawing.Color.Gainsboro;

                ddlPenalties.DataSource = SQL_SELECT_dataset("select ID as STOP_ID, NAME as STOP_NAME from BARS.DPT_STOP where MOD_CODE = 'DPU' or MOD_CODE IS NULL order by 1");
                ddlPenalties.DataBind();
                ddlPenalties.SelectedValue = tbPenaltyId.Text;
            }
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        
        if (mode == 1)
        {
            Response.Redirect("/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPU_AGREEMENTS_VISA&accessCode=1&sPar=[CONDITIONS=>AGRMNT_STATE=0]");
        }
        else
        {
            // Перегляд ДУ
            Response.Redirect("/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPU_AGREEMENTS&accessCode=1");
        }
        
    }

    /// <summary>
    /// Відмовити
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnRefuse_Click(object sender, EventArgs e)
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        String script;
        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.BindByName = true;

            cmd.CommandText = "dpu_agr.refuse_agreement";

            // Input
            cmd.Parameters.Add("p_agrmnt_id", OracleDbType.Decimal, agrmnt_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, tbComments.Text, ParameterDirection.Input);
            
            cmd.ExecuteNonQuery();

            script = "bars.ui.alert({ text: 'Відмовлено в заключенні додаткової угоди #" + agrmnt_id.ToString() + "!' }); ";
            ClientScript.RegisterStartupScript(this.GetType(), "Done", script, true);

            _dbLogger.Info("Користувач відмовив в заключенні додаткової угоди #" + agrmnt_id.ToString(), "udeposit");
             
        }
        catch (Exception ex)
        {
            script = "bars.ui.alert({ text: 'Помилка відмови від заключення додаткової угоди!' }); ";
            ClientScript.RegisterStartupScript(this.GetType(), "Error", script, true);
            
            _dbLogger.Error("Помилка відмови від заключення додаткової угоди:" + ex.Message, "udeposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        Response.Redirect("/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPU_AGREEMENTS_VISA&accessCode=1&sPar=[CONDITIONS=>AGRMNT_STATE=0]");
    }
    
    /// <summary>
    /// Погодити
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        String script;
        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.BindByName = true;

            cmd.CommandText = "DPU_AGR.CONFIRM_AGREEMENT";

            // Input
            cmd.Parameters.Add("p_agrmnt_id", OracleDbType.Decimal, agrmnt_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            script = "bars.ui.alert({ text: 'Підтверджено заключення додаткової угоди #" + agrmnt_id.ToString() + "!' }); ";
            ClientScript.RegisterStartupScript(this.GetType(), "Done", script, true);
            
            _dbLogger.Info("Користувач підтвердив заключення додаткової угоди #" + agrmnt_id.ToString(), "udeposit");

        }
        catch (Exception ex)
        {
            script = "bars.ui.alert({ text: 'Помилка при підтвердженні додаткової угоди:" + ex.Message + "' }); ";
            ClientScript.RegisterStartupScript(this.GetType(), "Error", script, true);

            _dbLogger.Error("Помилка при підтвердженні додаткової угоди:" + ex.Message, "udeposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        Response.Redirect("/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPU_AGREEMENTS_VISA&accessCode=1&sPar=[CONDITIONS=>AGRMNT_STATE=0]");
    }
}