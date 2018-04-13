using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Globalization;
using System.Drawing;

public partial class safe_deposit_Default : System.Web.UI.Page
{
    int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterClientScript();

        if (!IsPostBack)
        {
            if (Convert.ToString(Request["type"]) == "arc") HideButtons();
            InitLists();
        }

        GetStatistics();
        FillGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridViewEx" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitLists()
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
            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "SELECT O_SK, NAME FROM SKRYNKA_TIP where branch = sys_context('bars_context','user_branch') ORDER BY O_SK";
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            DataSet dsSafeType = new DataSet();
            adapterSafeType.Fill(dsSafeType);

            listSafeType.DataSource = dsSafeType;
            listSafeType.DataTextField = "NAME";
            listSafeType.DataValueField = "O_SK";
            listSafeType.DataBind();

            listSafeType.Items.Insert(0, new ListItem("-", "-1"));
            listSafeType.SelectedIndex = 0;

            cmdSelectSafeType.Dispose();
            adapterSafeType.Dispose();

            cmdSetRole.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetBankDate = connect.CreateCommand();
            cmdGetBankDate.CommandText = "select to_char(bankdate,'dd/mm/yyyy') from dual";
            BANKDATE.Value = Convert.ToString(cmdGetBankDate.ExecuteScalar());

            OracleCommand cmdGetMode = connect.CreateCommand();
            cmdGetMode.CommandText = "SELECT nvl(substr(val,1),0) FROM params WHERE par='SKRN_ACC'";
            String mode = Convert.ToString(cmdGetMode.ExecuteScalar());
            /// Індивідуальні рахунки
            if (mode == "1")
            {
                btOpen.OnClientClick = "return OpenSafeEx(1)";
            }
            /// Котлові рахунки
            else
            {
                btOpen.OnClientClick = "return OpenSafe()";
            }
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
    protected void btSearch_Click(object sender, EventArgs e)
    {
        FillGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        dsSafeDeposit.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsSafeDeposit.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
        dsSafeDeposit.SelectParameters.Clear();
        dsSafeDeposit.WhereParameters.Clear();

        String selectCommand = "SELECT N_SK,SNUM, O_SK, TYPE, KEYUSED, " +
               "TO_CHAR(BAIL_SUM_EQUIV,'999999999990.99') BAIL_SUM_EQ, " +
               "TO_CHAR(OSTC/100,'999999999990.99') A_OSTC, " +
               "TO_CHAR(OSTB/100,'999999999990.99') A_OSTB, " +
               "KV, LCV, ACC, NLS, " +
               "ND, NUM, SOS, NMK, CUSTTYPE, " +
               "DAT_BEGIN, DAT_END, DOV_FIO, NLS3600, " +
               "case when skrn.f_get_opl_sum(nd)>0 then 'так' else 'ні' end FACT_PAY ";
        selectCommand += ((Convert.ToString(Request["type"]) != "arc") ?
            "FROM V_SAFE_DEPOSIT WHERE branch = sys_context('bars_context','user_branch') " :
            "FROM V_SAFE_DEPOSIT_ARCHIVE WHERE branch = sys_context('bars_context','user_branch') ");

        if (!String.IsNullOrEmpty(REF.Text))
        {
            selectCommand += " and ND = :ND ";
            dsSafeDeposit.SelectParameters.Add("ND", TypeCode.Decimal, REF.Text);
        }

        if (!String.IsNullOrEmpty(NUM.Text))
        {
            selectCommand += " and NUM = '" + NUM.Text + "' ";
        }

        if (DAT_BEGIN.Date != DAT_BEGIN.MinDate)
        {
            selectCommand += " and DAT_BEGIN = :DAT_BEGIN ";
            dsSafeDeposit.SelectParameters.Add("DAT_BEGIN", TypeCode.DateTime, DAT_BEGIN.Date.ToString("dd/MM/yyyy"));
        }

        if (DAT_END.Date != DAT_END.MinDate)
        {
            selectCommand += " and DAT_END = :DAT_END ";
            dsSafeDeposit.SelectParameters.Add("DAT_END", TypeCode.DateTime, DAT_END.Date.ToString("dd/MM/yyyy"));
        }

        if (!String.IsNullOrEmpty(PERSON.Text))
        {
            selectCommand += " and upper(NMK) like upper('%" + PERSON.Text + "%')";
            //selectCommand += " and upper(NMK) like upper(:NMK)";
            //dsSafeDeposit.SelectParameters.Add("NMK", TypeCode.String, PERSON.Text);
            //dsSafeDeposit.WhereParameters.Add("NMK", TypeCode.String, PERSON.Text);
        }

        if (!String.IsNullOrEmpty(SAFENUM.Text))
        {
            selectCommand += " and SNUM = :SAFENUM ";
            dsSafeDeposit.SelectParameters.Add("SAFENUM", TypeCode.String, SAFENUM.Text);
        }

        if (!String.IsNullOrEmpty(NLS.Text))
        {
            selectCommand += " and NLS like upper('%" + NLS.Text + "%') ";
            //dsSafeDeposit.SelectParameters.Add("NLS", TypeCode.Decimal, "%" + NLS.Text + "%");
        }

        if (!String.IsNullOrEmpty(TRUSTEE.Text))
        {
            selectCommand += " and upper(DOV_FIO) like upper('%" + TRUSTEE.Text + "%')";
            //dsSafeDeposit.SelectParameters.Add("TRUSTEE", TypeCode.String, "%" + TRUSTEE.Text + "%");
        }

        if (listSafeType.SelectedIndex != 0)
        {
            selectCommand += " and o_sk = :o_sk ";
            dsSafeDeposit.SelectParameters.Add("o_sk", TypeCode.Decimal, listSafeType.SelectedValue);
        }

        selectCommand += " order by SNUM, ND ";

        dsSafeDeposit.SelectCommand = selectCommand;
        gridSafeDeposit.DataBind();
    }
    /// <summary>
	/// Клієнтський скріпт, який
	/// при виборі рядка таблиці
	/// виділяє його кольором
	/// </summary>
	private void RegisterClientScript()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
            var lastColor;
			function S_A(id,safe_id,dpt_id,fio,safe_num)
			{
			 if(selectedRow != null) selectedRow.style.backgroundColor = lastColor;
			 lastColor = document.getElementById('r_'+id).style.backgroundColor;
             document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('SAFE_ID').value = safe_id;
             document.getElementById('DPT_ID').value = dpt_id;
             document.getElementById('FIO').value = fio;
             document.getElementById('hSAFENUM').value = safe_num;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gridSafeDeposit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
            e.Row.Cells[15].Visible = false;
        else if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                row.Cells[13].Text + "','" + row.Cells[5].Text + "',\"" +
                row.Cells[7].Text + "\",'" + row.Cells[0].Text + "')");

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (Convert.ToString(Request["type"]) != "arc")
            {
                /// Є договір по сейфу
                if (!String.IsNullOrEmpty(row.Cells[5].Text))
                {
                    DateTime bankdate = Convert.ToDateTime(BANKDATE.Value, cinfo);
                    DateTime end_date;
                    try
                    {
                        end_date = Convert.ToDateTime(row.Cells[9].Text, cinfo);
                    }
                    /// Якщо якимось чином дата завершення не заповнена
                    catch
                    {
                        //row.BackColor = Color.Red;
                        row.Cells[14].Visible = false;
                        return;
                    }

                    if (row.Cells[15].Text == "1")
                    {
                        row.ForeColor = Color.DarkGreen;
                    }
                    /// Прострочені
                    else if (end_date < bankdate)
                    {
                        row.ForeColor = Color.Red;
                    }
                    /// Залишилось менше 7 днів
                    else if (end_date <= bankdate.AddDays(7))
                    {
                        row.ForeColor = Color.FromArgb(221, 197, 55);
                    }
                    /// Нормальні
                    else
                    {
                        row.ForeColor = Color.Green;
                    }
                }
            }
            else
            {
                /// Активні
                if (row.Cells[15].Text == "0")
                {
                    row.ForeColor = Color.Green;
                }
            }

            row.Cells[15].Visible = false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btDelete_Click(object sender, EventArgs e)
    {
        safe_deposit sdpt = new safe_deposit();
        sdpt.DeleteSafe(Convert.ToDecimal(SAFE_ID.Value));

        FillGrid();

        Response.Write("<script>alert('Сейф успешно закрыт!');</script>");
        Response.Flush();
    }
    /// <summary>
    /// 
    /// </summary>
    private void HideButtons()
    {
        btNew.Visible = false;
        btDelete.Visible = false;
        btOpen.Visible = false;
        btPay.Visible = false;
        //btDocs.Visible = false;
        bindDoc.Visible = false;
        btArchive.Visible = false;
        btPrint.Visible = false;
        btVisit.Visible = false;

        Separator1.Visible = false;
        Separator2.Visible = false;
        Separator3.Visible = false;
        Separator4.Visible = false;
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetStatistics()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetStats = connect.CreateCommand();

            cmdGetStats.CommandText = "begin skrn.init(null); end;";
            cmdGetStats.ExecuteNonQuery();

            cmdGetStats.CommandText = "select count(*) FROM V_SAFE_DEPOSIT WHERE nd is not null and branch = sys_context('bars_context','user_branch')";
            USED.Text = Convert.ToString(cmdGetStats.ExecuteScalar());

            cmdGetStats.CommandText = "select count(*) FROM V_SAFE_DEPOSIT WHERE dat_end < bankdate and branch = sys_context('bars_context','user_branch')";
            HOT.Text = Convert.ToString(cmdGetStats.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
