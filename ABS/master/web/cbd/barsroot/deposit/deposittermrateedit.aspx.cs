using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;
using System.Globalization;
using Bars.Classes;

/// <summary>
/// Summary description for DepositTermRateEdit.
/// </summary>
public partial class DepositTermRateEdit : Bars.BarsPage
{
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositTermRateEdit;

        if (!IsPostBack)
        {
            if (Request["dpt_id"] == null || Request["agr_id"] == null || Request["template"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
            Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
            String template = Convert.ToString(Request["template"]);

            textDptNum.Text = Convert.ToString(Session["DPT_NUM"]);
            text_agr_id.Value = agr_id.ToString();
            template_id.Value = template;

            if (agr_id == 3)
            // Ду про зміну %% ставки 
            #region arg_id=3
            {
                tbRate.Visible = true;
                tbTerm.Visible = false;
                tbNewRate.Visible = false;
                btChangeDptRate.Attributes["onclick"] = "javascript:if(AddAgrIsRateChanged())";

                OracleConnection connect = new OracleConnection();

                try
                {
                    IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                    connect = conn.GetUserConnection();

                    OracleCommand cmd = connect.CreateCommand();
                    cmd.CommandText = "select DPT_WEB.get_dptrate(d.acc, d.kv, d.LIMIT, TRUNC(SYSDATE)), DPT_WEB.get_bonus_rate(d.deposit_id), to_char(bankdate,'dd/mm/yyyy') " +
                                       " from BARS.DPT_DEPOSIT d where d.deposit_id = :p_dptid ";
                    cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                    OracleDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        if (!rdr.IsDBNull(0))
                            CurRate.Text = Convert.ToString(rdr.GetOracleDecimal(0).Value);
                        if (!rdr.IsDBNull(1))
                            NewRate.Text = Convert.ToString(rdr.GetOracleDecimal(1).Value);
                        if (!rdr.IsDBNull(2))
                            NewRateDate.Text = rdr.GetOracleString(2).Value;
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error_mesage",
                            String.Format("alert('Не знайдено інформацію про депозитний договір №{0}!'); location.href = 'DepositContractInfo.aspx?dpt_id={1}&scheme=DELOITTE'", dpt_id, dpt_id), true);
                    }

                    //if (!rdr.IsClosed) rdr.Close();
                    //rdr.Dispose();
                }
                finally
                {
                    if (connect.State != ConnectionState.Closed)
                    {
                        connect.Close();
                        connect.Dispose();
                    }
                }

                /*
                FillGrid();

                if (gridRates.Rows.Count < 1)
                    throw new DepositException("Заборонено змінювати відсоткову ставку по депозитному договору №" + Convert.ToString(Session["DPT_NUM"]));
                */
            }
            #endregion
            else if (agr_id == 4)
            #region arg_id=4
            {
                tbRate.Visible = false;
                tbTerm.Visible = true;
                tbNewRate.Visible = false;
                btChangeDptTerm.Attributes["onclick"] = "javascipt:if(AddAgrIsDateChanged())";
                
                OracleConnection connect = new OracleConnection();

                try
                {
                    IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                    connect = conn.GetUserConnection();

                    OracleCommand cmd = connect.CreateCommand();
                    cmd.CommandText = @"
                    select to_char(dat_begin,'dd/mm/yyyy'), to_char(dat_end,'dd/mm/yyyy'),
                           to_char(decode(months, trunc(months), add_months(dat_end,months), (dat_end + days)),'dd/mm/yyyy')
                      from (select dat_begin, dat_end, months_between(dat_end, dat_begin) as months, dat_end - dat_begin as days
                              from dpt_deposit where deposit_id = :p_dptid)";
                    cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                    //cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                    OracleDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        if (!rdr.IsDBNull(0))
                            CurStartDate.Text = rdr.GetOracleString(0).Value;
                        if (!rdr.IsDBNull(1))
                            CurEndDate.Text   = rdr.GetOracleString(1).Value;
                        if (!rdr.IsDBNull(2))
                            NewEndDate.Text   = rdr.GetOracleString(2).Value;
                    }

                    CurEndDate.ReadOnly = true;
                    NewEndDate.ReadOnly = true;

                    if (!rdr.IsClosed) rdr.Close();
                    rdr.Dispose();
                }
                finally
                {
                    if (connect.State != ConnectionState.Closed)
                    { connect.Close(); connect.Dispose(); }
                }
            }
            #endregion
            else
            {
            }

            DBLogger.Info("Пользователь начал формирование доп. соглашения тип=" + agr_id +
                " по договору №" + dpt_id + " с шаблоном " + template, "deposit");
        }
        else if (!String.IsNullOrEmpty(hid_req_id.Value))   
        {
            String par1 = hid_req_id.Value;
            String par2 = hid_new_rate.Value;
            String par3 = hid_new_date.Value;
            hid_req_id.Value = String.Empty;
            hid_new_rate.Value = String.Empty;
            hid_new_date.Value = String.Empty;
            FormRate(par1, par2, par3);
        }
    }
    /// <summary>
    /// Локализация
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
        if (agr_id == 3)
        {
            lbInfo.Text = Resources.Deposit.GlobalResources.tb93;
        }
        else
        {
            lbInfo.Text = Resources.Deposit.GlobalResources.tb94;
        }

    }
    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        this.btChangeDptRate.ServerClick += new System.EventHandler(this.btChangeDptRate_ServerClick);
        this.btChangeDptTerm.ServerClick += new System.EventHandler(this.btChangeDptTerm_ServerClick);
        ;

    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    private void btChangeDptTerm_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Змінити\" (Термін вкладу) на сторінці зміни терміну депозитного договору №" + textDptNum.Text, "deposit");

        Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]) +
        "&agr_id=" + text_agr_id.Value +
        "&template=" + template_id.Value +
        "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]) +
        "&date_begin=" + CurEndDate.Text +
        "&date_end=" + NewEndDate.Text );
    }
    /// <summary>
    /// 
    /// </summary>
    private void btChangeDptRate_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал кнопку \"Изменить\" (Процентную ставку) на странице изменения процентной ставки по депозитного договору №" + textDptNum.Text,
            "deposit");

        Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]) +
            "&agr_id=" + text_agr_id.Value +
            "&template=" + template_id.Value +
            "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]) +
            "&rate=" + NewRate.Text +
            "&rate_date=" + NewRateDate.Text);
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        dsRates.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRates.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsRates.SelectParameters.Clear();

        String selectCommand = "SELECT '<A href=# onclick=\"FormRate('||req_id||','''|| to_char(REQC_BEGDATE,'dd/mm/yyyy') ||''','''|| to_char(reqc_newint,'90.9999') || " +
          "''')\">Змінити ставку</a>' AS FORM , " +
          "req_id, reqc_oldint, reqc_newint, reqc_expdate,REQC_BEGDATE, req_crdate, req_cruser " +
          "FROM v_dpt_chgintreq_active " +
         "WHERE dpt_id =:dpt_id";

        dsRates.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));

        dsRates.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="req_id"></param>
    /// <param name="new_int"></param>
    /// <param name="new_dat"></param>
    private void FormRate(String req_id, String new_int, String new_dat)
    {
        DBLogger.Info("Пользователь нажал кнопку \"Изменить\" (Процентную ставку) на странице изменения процентной ставки по депозитного договору №" + textDptNum.Text,
            "deposit");

        Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]) +
            "&agr_id=" + text_agr_id.Value +
            "&template=" + template_id.Value +
            "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]) +
            "&rate=" + new_int +
            "&rate_date=" + new_dat +
            "&rate_req=" + req_id);
    }

}

