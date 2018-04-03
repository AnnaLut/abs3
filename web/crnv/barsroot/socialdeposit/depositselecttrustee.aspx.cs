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
    private   OracleDataAdapter adapterSearchAgreement;
	private int row_counter = 0;
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			if (Request["dpt_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement");

			RegisterClientScript();

			Decimal dptid = Convert.ToDecimal(Request["dpt_id"]);
            dpt_num.Text = Convert.ToString(Session["DPT_NUM"]);

			if(!this.IsClientScriptBlockRegistered("ADD_JS"))
				this.RegisterClientScriptBlock("ADD_JS", "<script language=\"javascript\" src=\"Scripts/Default.js\"></script>");

			btTrustee.Attributes["onclick"] = "javascript:if (tr_ck())";

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = new OracleCommand();
			cmdSearch.Connection = connect;
	 
			cmdSearch.CommandText = @"SELECT c.adds AS adds, c.version AS version,t.trust_rnk, df.name AS agr_name, c.id AS TEMPLATE,t.trust_rnk AS rnk, k.nmk AS nmk,
                DECODE(t.fl_act,0, DECODE(p.trust_id, NULL, 'закрито', 'анульовано дод. угодою №'||p.add_num),'активне') AS comm
                FROM CC_DOCS c, SOCIAL_CONTRACTS d, CUSTOMER k, SOCIAL_TEMPLATES ds, DPT_VIDD_FLAGS df, SOCIAL_TRUSTEE t, SOCIAL_TRUSTEE p 
                WHERE c.nd = :dpt_id 
                AND d.contract_id = c.nd 
                AND d.type_id = ds.TYPE_ID
                AND c.id = ds.templATE_ID
                AND ds.FLAG_ID != 1 
                AND c.state = 1 
                AND t.fl_act = 1 
                AND df.id IN (21,23) 
                AND ds.FLAG_ID = df.id 
                AND c.nd = t.contract_id(+)
                AND t.trust_rnk = k.rnk (+)
                AND t.trust_id = p.undo_id(+) 
                AND c.adds = t.add_num(+) 
                ORDER BY 1";
			cmdSearch.Parameters.Add("dpt_id",OracleDbType.Decimal,dptid,ParameterDirection.Input);
		
			adapterSearchAgreement = new OracleDataAdapter();
			adapterSearchAgreement.SelectCommand = cmdSearch;
			adapterSearchAgreement.Fill(dsTrustee);

			gridTrustee.DataSource = dsTrustee;
			gridTrustee.DataBind();

			gridTrustee.HeaderStyle.BackColor = Color.Gray;
			gridTrustee.HeaderStyle.Font.Bold = true;
			gridTrustee.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;	

			if (dsTrustee.Tables[0].Rows.Count < 1)
				btOwner_ServerClick(sender,e);
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
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
		this.btOwner.ServerClick += new System.EventHandler(this.btOwner_ServerClick);
		// 
		// dsTrustee
		// 
		this.dsTrustee.DataSetName = "NewDataSet";
		this.dsTrustee.Locale = new System.Globalization.CultureInfo("uk-UA");
		this.Load += new System.EventHandler(this.Page_Load);
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
			row.Attributes.Add("onclick", "S('"+row_counter.ToString()+"','"+row.Cells[2].Text+"')");
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
		Page.RegisterStartupScript(ID+"Script_C",script ) ;
	}

	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btOwner_ServerClick(object sender, System.EventArgs e)
	{
		String action = Convert.ToString(Request["dest"]);
        String dpt_id = Convert.ToString(Request["dpt_id"]);
		
		DBLogger.Info("Пользователь выбрал владельца вклада для осуществления операции. Депозитный договор №" + dpt_id,
			"SocialDeposit");
		
		switch (action)
		{
			case "percent":
			{
                String dest = "DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=percent";
				if (Request["fp"]!=null) dest += "&fp=html";
				Response.Redirect(dest);
				break;
			}
			case "close":
                Response.Redirect("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=close");
				break;
			case "SocialDeposit":
                Response.Redirect("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=return");
				break;
			case "agreement":
                Response.Redirect("DepositAgreement.aspx?dpt_id=" + dpt_id);
				break;
			default:
			{
                Response.Write(@"<script>alert('Некорректные данные!');
				location.replace('..//barsweb/welcome.aspx');</script>");
				Response.Flush();
				break;
			}
		}
	}

	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>	
    protected void btTrustee_ServerClick1(object sender, EventArgs e)
    {
        String action = Convert.ToString(Request["dest"]);
        String dpt_id = Convert.ToString(Request["dpt_id"]);

        DBLogger.Info("Пользователь выбрал доверенное лицо РНК=" + Convert.ToString(rnk.Value)
            + " для осуществления операции. Депозитный договор №" + dpt_id, "SocialDeposit");

        switch (action)
        {
            case "percent":
                Response.Redirect("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=percent&rnk_tr=" + Convert.ToString(rnk.Value));
                break;
            case "close":
                Response.Redirect("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=close&rnk_tr=" + Convert.ToString(rnk.Value));
                break;
            case "SocialDeposit":
                Response.Redirect("DepositSelectTT.aspx?dpt_id=" + dpt_id + "&dest=return&rnk_tr=" + Convert.ToString(rnk.Value));
                break;
            case "agreement":
                Response.Redirect("DepositAgreement.aspx?dpt_id=" + dpt_id + "&rnk_tr=" + Convert.ToString(rnk.Value));
                break;
            case "prolongation":
                Response.Redirect("DepositProlongation.aspx?dpt_id=" + dpt_id + "&rnk_tr=" + Convert.ToString(rnk.Value));
                break;
            default:
                {
                    Response.Write(@"<script>alert('Неопределенная операция!');
				location.replace('..//barsweb/welcome.aspx');</script>");
                    Response.Flush();
                    break;
                }
        }
    }
}
