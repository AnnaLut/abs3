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
using Bars.Web.Report;
using System.IO;

/// <summary>
/// Summary description for DepositLettersPrint.
/// </summary>
public partial class DepositLettersPrint : Bars.BarsPage
{
    protected System.Data.DataSet dsContractType;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterContractType;
    protected System.Data.DataSet dsResults;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterSearch;
    private int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositLettersPrint;
        if (Request["template"] == null)
            Response.Redirect("DepositLetters.aspx");

        listOper.Attributes["onchange"] = "javascript:CkDateCtrl()";
        btPrint.Attributes["onclick"] = "if (FillDpts())";

        if (!IsPostBack)
        {
            FillControls();
        }
        else
        {
            if (ckUse.Checked)
                listDepositType.Enabled = true;
            else
                listDepositType.Enabled = false;

            if (listOper.SelectedValue != "-10" && listOper.SelectedValue != "10")
                dtDptEndDate.Enabled = true;
            else
                dtDptEndDate.Enabled = false;
        }
    }
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridDeposit.Controls.Count > 0)
        {
            Table tb = gridDeposit.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb1;
            tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb2;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb3;
            tb.Rows[0].Cells[4].Text = Resources.Deposit.GlobalResources.tb4;
            tb.Rows[0].Cells[5].Text = Resources.Deposit.GlobalResources.tb5;
            tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb6;
            tb.Rows[0].Cells[7].Text = Resources.Deposit.GlobalResources.tb7;
            tb.Rows[0].Cells[8].Text = Resources.Deposit.GlobalResources.tb9;
            tb.Rows[0].Cells[9].Text = Resources.Deposit.GlobalResources.tb10;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillControls()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Заполняем список видов договоров
            adapterContractType = new OracleDataAdapter();
            OracleCommand cmdContractType = connect.CreateCommand();
            cmdContractType.CommandText = "select dpt_type, dpt_name from v_dpt_type order by 1";
            adapterContractType.SelectCommand = cmdContractType;
            adapterContractType.Fill(dsContractType);
            listDepositType.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
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
        this.dsContractType = new System.Data.DataSet();
        this.adapterContractType = new Oracle.DataAccess.Client.OracleDataAdapter();
        this.dsResults = new System.Data.DataSet();
        this.adapterSearch = new Oracle.DataAccess.Client.OracleDataAdapter();
        ((System.ComponentModel.ISupportInitialize)(this.dsContractType)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsResults)).BeginInit();
        // 
        // dsContractType
        // 
        this.dsContractType.DataSetName = "NewDataSet";
        this.dsContractType.Locale = new System.Globalization.CultureInfo("uk-UA");
        // 
        // dsResults
        // 
        this.dsResults.DataSetName = "NewDataSet";
        this.dsResults.Locale = new System.Globalization.CultureInfo("uk-UA");
        this.btSearch.Click += new System.EventHandler(this.btSearch_Click);
        this.gridDeposit.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridDeposit_ItemDataBound);
        this.btPrint.ServerClick += new System.EventHandler(this.btPrint_ServerClick);
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsContractType)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsResults)).EndInit();

    }
    #endregion
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('letter_id').value = val;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void gridDeposit_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);

            int tab_index = (10 + row_counter);
            String control_name = row.Cells[1].Text;

            System.Web.UI.WebControls.CheckBox ck = new CheckBox();
            ck.TabIndex = (short)tab_index;
            ck.Attributes["onclick"] = "javascript:Mark();";
            ck.Attributes["dpt_id"] = control_name;

            row.Cells[0].Controls.Add(ck);
            clientNames.Value += Convert.ToString(ck.ClientID) + "%";
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btSearch_Click(object sender, System.EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            adapterSearch = new OracleDataAdapter();
            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = @"select NULL,DPT_ID,VIDD_NAME,TO_CHAR(DAT_BEGIN,'dd/mm/yyyy'),TO_CHAR(DAT_END,'dd/mm/yyyy'),
                CUST_ID,CUST_IDCODE,CUST_NAME,DPT_CURCODE,to_char(DPT_SALDO/100,'999999999990.99'),to_char(INT_SALDO/100,'999999999990.99')
                from v_dpt_portfolio_active
                WHERE 1=1";

            if (textClientName.Text != String.Empty)
            {
                cmdSearch.CommandText += " and CUST_NAME like :name ";
                cmdSearch.Parameters.Add("name", OracleDbType.Varchar2,
                    textClientName.Text, ParameterDirection.Input);
            }
            if (ckUse.Checked)
            {
                cmdSearch.CommandText += " and VIDD_CODE = :vidd ";
                cmdSearch.Parameters.Add("vidd", OracleDbType.Decimal,
                    Convert.ToDecimal(listDepositType.SelectedValue), ParameterDirection.Input);
            }
            if (listOper.SelectedValue != "-10")
            {
                switch (listOper.SelectedValue)
                {
                    case "-2":
                        {
                            cmdSearch.CommandText += " and dat_end > :dt";
                            cmdSearch.Parameters.Add("dt", OracleDbType.Date,
                                dtDptEndDate.Date, ParameterDirection.Input);
                            break;
                        }
                    case "-1":
                        {
                            cmdSearch.CommandText += " and dat_end >= :dt";
                            cmdSearch.Parameters.Add("dt", OracleDbType.Date,
                                dtDptEndDate.Date, ParameterDirection.Input);
                            break;
                        }
                    case "0":
                        {
                            cmdSearch.CommandText += " and dat_end = :dt";
                            cmdSearch.Parameters.Add("dt", OracleDbType.Date,
                                dtDptEndDate.Date, ParameterDirection.Input);
                            break;
                        }
                    case "1":
                        {
                            cmdSearch.CommandText += " and dat_end <= :dt";
                            cmdSearch.Parameters.Add("dt", OracleDbType.Date,
                                dtDptEndDate.Date, ParameterDirection.Input);
                            break;
                        }
                    case "2":
                        {
                            cmdSearch.CommandText += " and dat_end < :dt";
                            cmdSearch.Parameters.Add("dt", OracleDbType.Date,
                                dtDptEndDate.Date, ParameterDirection.Input);
                            break;
                        }
                    case "10":
                        {
                            cmdSearch.CommandText += " and dat_end is null";
                            break;
                        }
                }
            }
            adapterSearch.SelectCommand = cmdSearch;
            adapterSearch.Fill(dsResults);

            dsResults.Tables[0].Columns[0].ColumnName = "*";
            dsResults.Tables[0].Columns[1].ColumnName = "Вклад";
            dsResults.Tables[0].Columns[2].ColumnName = "Тип вклада";
            dsResults.Tables[0].Columns[3].ColumnName = "Заключен";
            dsResults.Tables[0].Columns[4].ColumnName = "Завершение";
            dsResults.Tables[0].Columns[5].ColumnName = "РНК";
            dsResults.Tables[0].Columns[6].ColumnName = "Ид.код";
            dsResults.Tables[0].Columns[7].ColumnName = "ФИО";
            dsResults.Tables[0].Columns[8].ColumnName = "Валюта";
            dsResults.Tables[0].Columns[9].ColumnName = "Остаток";
            dsResults.Tables[0].Columns[10].ColumnName = "%%";

            gridDeposit.HeaderStyle.BackColor = Color.Gray;
            gridDeposit.HeaderStyle.Font.Bold = true;
            gridDeposit.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

            gridDeposit.DataBind();

            if (clientNames.Value.EndsWith("%"))
                clientNames.Value = clientNames.Value.Substring(0, clientNames.Value.Length - 1);
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
    /// <param name="_params"></param>
    /// <returns></returns>
    private String WriteLetter(String dpt_num, String path, OracleConnection connect)
    {
        string template = Convert.ToString(Request["template"]);

        // Из шаблона создаем текст договора
        RtfReporter rep = new RtfReporter(Context);
        rep.RoleList = "reporter,dpt_role,cc_doc";

        rep.ContractNumber = Convert.ToInt64(dpt_num);
        rep.TemplateID = template;

        // Формируем текст договора
        rep.Generate();

        DBLogger.Debug("Формирование текста письма (уведомления) " +
            " по депозитному договору №" + dpt_num + " шаблон = "
            + Convert.ToString(Request["template"]) + " успешно завершилось.",
            "deposit");

        String filename = path + dpt_num + ".rtf";
        File.Copy(rep.ReportFile, filename, true);

        rep.DeleteReportFiles();

        OracleCommand cmdInsertLetter = connect.CreateCommand();
        cmdInsertLetter.CommandText = "begin dpt_web.create_text(:template, :dptid, -1, null); end;";
        cmdInsertLetter.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
        cmdInsertLetter.Parameters.Add("dptid", OracleDbType.Decimal, dpt_num, ParameterDirection.Input);
        cmdInsertLetter.ExecuteNonQuery();

        return filename;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btPrint_ServerClick(object sender, System.EventArgs e)
    {
        String dpt_vals = dpts.Value;
        String[] dpt = dpt_vals.Split(',');

        String[] file_names = new String[dpt.Length];

        String tmp = Path.GetTempPath();
        tmp += "tlet\\" + Session.SessionID + "\\";

        if (Directory.Exists(Path.GetTempPath() + "tlet"))
        {
            try { Directory.Delete(Path.GetTempPath() + "tlet", true); }
            catch { }
        }

        Directory.CreateDirectory(tmp);

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            int i = 0;
            foreach (String dpt_id in dpt)
            {
                file_names[i++] = WriteLetter(dpt_id, tmp, connect);
            }

            /// Очищаємо поля, щоб не було проблем після постбека
            dpts.Value = String.Empty;
            clientNames.Value = String.Empty;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        String par = String.Empty;
        foreach (String val in file_names)
            par += val + "?";
        par = par.Substring(0, par.Length - 1);

        par = par.Replace("\\", "\\\\");

        String script = "<script language='javascript' src='js/js.js'></script>" +
            "<script>var windows = new Array();PrintLetters(escape('" + par + "'));</script>";
        Response.Write(script);
        Response.Flush();
    }
}
