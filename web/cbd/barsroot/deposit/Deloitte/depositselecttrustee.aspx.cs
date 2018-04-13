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
using Oracle.DataAccess.Client;
using Bars.Logger;
using Bars.Oracle;

/// <summary>
/// Summary description for DepositSelectTrustee.
/// </summary>
public partial class DepositSelectTrustee : Bars.BarsPage
{
    protected System.Data.DataSet dsTrustee;
    private OracleDataAdapter adapterSearchAgreement;
    private int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositSelectTrustee;
        OracleConnection connect = new OracleConnection();

        try
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            RegisterClientScript();

            Decimal dptid = Convert.ToDecimal(Request["dpt_id"]);
            dpt_num.Text = Request.QueryString["dpt_id"];

            btTrustee.Attributes["onclick"] = "javascript:if (tr_ck())";

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = new OracleCommand();
            cmdSearch.Connection = connect;

            /// Завантажуємо всіх довірених осіб по даному депозиту
            /// можемо оформити на будь-якого
            cmdSearch.CommandText = @"select AGRMNT_NUM as adds, AGRMNT_DATE as version, AGRMNT_TYPE as agr_id,
                AGRMNT_TYPENAME as agr_name, TEMPLATE_ID as template, TRUSTEE_ID as rnk_tr, 
                TRUSTEE_NAME as nmk, COMMENTS as comm, TRUSTEE_ID as rnk  
                from v_dpt_agreements
                where DPT_ID = :dpt_id and AGRMNT_TYPE in (12) and FL_ACTIVITY = 1";
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dptid, ParameterDirection.Input);

            adapterSearchAgreement = new OracleDataAdapter();
            adapterSearchAgreement.SelectCommand = cmdSearch;
            adapterSearchAgreement.Fill(dsTrustee);

            gridTrustee.DataSource = dsTrustee;
            gridTrustee.DataBind();

            gridTrustee.HeaderStyle.BackColor = Color.Gray;
            gridTrustee.HeaderStyle.Font.Bold = true;
            gridTrustee.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

            if (dsTrustee.Tables[0].Rows.Count < 1)
                btOwner_ServerClick(sender, e);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridTrustee.Controls.Count > 0)
        {
            Table tb = gridTrustee.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb27;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb28;
            tb.Rows[0].Cells[5].Text = Resources.Deposit.GlobalResources.tb29;
            tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb30;

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
        this.dsTrustee = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsTrustee)).BeginInit();
        this.gridTrustee.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridTrustee_ItemDataBound);
        this.btTrustee.ServerClick += new System.EventHandler(this.btTrustee_ServerClick);
        this.btOwner.ServerClick += new System.EventHandler(this.btOwner_ServerClick);
        // 
        // dsTrustee
        // 
        this.dsTrustee.DataSetName = "NewDataSet";
        this.dsTrustee.Locale = new System.Globalization.CultureInfo("uk-UA");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsTrustee)).EndInit();

    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void gridTrustee_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S('" + row_counter + "','" + row.Cells[2].Text + "')");
        }
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
			function S(id,rnk)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('rnk').value = rnk;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_C", script);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btOwner_ServerClick(object sender, System.EventArgs e)
    {
        Selecting_Trustee(false);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btTrustee_ServerClick(object sender, System.EventArgs e)
    {
        Selecting_Trustee(true);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="owner">Ознака оформлення на довірену особу</param>
    private void Selecting_Trustee(bool Trustee)
    {
        String action = Convert.ToString(Request["dest"]);
        String dpt_id = Convert.ToString(Request["dpt_id"]);
        String destination;

        switch (action)
        {
            case "percent":
                destination = ("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=percent");
                break;

            case "close":
                destination = ("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=close");
                break;

            case "payout": // виплата вкладу готівкою в день завершення (ЕБП)
                destination = ("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=payout");
                break;

            case "deposit":
                destination = ("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=return");
                break;

            case "agreement":
                destination = ("DepositAgreement.aspx?dpt_id=" + dpt_id);
                break;

            case "prolongation":
                destination = ("DepositProlongation.aspx?dpt_id=" + dpt_id);
                break;

            default:
                {
                    destination = "..//barsweb/Welcome.aspx";

                    //Response.Write(@"<script>alert('Некорректные данные!');
                    Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al34 + "');" +
                        "location.replace('" + destination + "');</script>");
                    Response.Flush();
                    break;
                }
        }

        if (Trustee)
        {
            // Якщо не вибрано довірену особу
            if (String.IsNullOrEmpty(rnk.Value))
            {
                Response.Write("<script>alert('Не вибрано довірену особу!');</script>");
                Response.Flush();
            }
            else
            {
                DBLogger.Info("Пользователь выбрал доверенное лицо РНК=" + Convert.ToString(rnk.Value) +
                    " для осуществления операции. Депозитный договор №" + dpt_id, "deposit");

                destination += "&rnk_tr=" + rnk.Value;
            }
        }
        else
        {
            DBLogger.Info("Пользователь выбрал владельца вклада для осуществления операции. Депозитный договор №" + dpt_id, "deposit");
        }

        if (Request.QueryString["other"] == "Y")
            destination += "&other=Y";

        if (Request["scheme"] != null)
            destination += ("&scheme=" + Request.QueryString["scheme"]);

        Response.Redirect(destination);
    }
}