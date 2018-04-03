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

/// <summary>
/// Summary description for DepositAgreementTemplate.
/// </summary>
public partial class DepositAgreementTemplate : Bars.BarsPage
{
	protected System.Data.DataSet dsTemplate;
	private   OracleDataAdapter adapterSearchAgreement;
	private int row_counter = 0;
	/// <summary>
	/// Завантаження сторінки
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			if (Request["dpt_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
			if (Request["agr_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

			Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
			Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);

			if (BankType.GetCurrentBank() != BANKTYPE.UPB)
				hid_agr_id.Value = Convert.ToString(Request["agr_id"]);
			else
				OP.Value = "1";
			
			text_dpt_num.Text = Convert.ToString(Session["DPT_NUM"]);
			text_agr_id.Text = Convert.ToString(Request["name"]);

			DBLogger.Info("Выбор шаблона для доп. соглашения тип=" + agr_id.ToString() + " по договору №" + dpt_id.ToString(),
				"SocialDeposit");

			RegisterClientScript ();

			if(!this.IsClientScriptBlockRegistered("TMPL_CK"))
				this.RegisterClientScriptBlock("TMPL_CK", "<script language=\"javascript\" src=\"js/ck.js\"></script>");
			if(!this.IsClientScriptBlockRegistered("AGR_PK"))
				this.RegisterClientScriptBlock("AGR_PK", "<script language=\"javascript\" src=\"js/js.js\"></script>");

			btForm.Attributes["onclick"] = "javascript:if (tmpl_ck()&&openOPDialog())";

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = connect.CreateCommand();
			string searchQuery = @"SELECT v.template_id AS id,name 
                FROM SOCIAL_TEMPLATES v, DOC_SCHEME s, SOCIAL_CONTRACTS d 
                WHERE v.TEMPLATE_ID=s.id  AND d.contract_id = :dpt_id AND d.type_id = v.type_id AND v.FLAG_iD = :agr_id
                ";
				
			cmdSearch.CommandText = searchQuery;
			cmdSearch.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
			cmdSearch.Parameters.Add("agr_id",OracleDbType.Decimal,agr_id,ParameterDirection.Input);
			
			adapterSearchAgreement = new OracleDataAdapter();
			adapterSearchAgreement.SelectCommand = cmdSearch;
			adapterSearchAgreement.Fill(dsTemplate);

			gridTemplate.DataSource = dsTemplate;
			gridTemplate.DataBind();

			if (dsTemplate.Tables[0].Rows.Count == 1)
			{
				Template_id.Value = dsTemplate.Tables[0].Rows[0].ItemArray[0].ToString();
				btForm_ServerClick(sender,e);
			}

			gridTemplate.HeaderStyle.BackColor = Color.Gray;
			gridTemplate.HeaderStyle.Font.Bold = true;
			gridTemplate.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;				 
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// Клієнтський скріпт, який
	/// при виборі рядка таблиці
	/// виділяє його кольором
	/// </summary>
	private void RegisterClientScript ()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S(id,val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('Template_id').value = val;
			}
			</script>";
		Page.RegisterStartupScript(ID+"Script",script ) ;
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
		this.dsTemplate = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsTemplate)).BeginInit();
		this.gridTemplate.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridTemplate_ItemDataBound);
		this.btForm.ServerClick += new System.EventHandler(this.btForm_ServerClick);
		// 
		// dsTemplate
		// 
		this.dsTemplate.DataSetName = "NewDataSet";
		this.dsTemplate.Locale = new System.Globalization.CultureInfo("uk-UA");
		this.Load += new System.EventHandler(this.Page_Load);
		((System.ComponentModel.ISupportInitialize)(this.dsTemplate)).EndInit();

	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void gridTemplate_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			row_counter++;
			string row_id = "r_" + row_counter.ToString();
			DataGridItem row = e.Item;
			row.Attributes.Add("id", row_id);
			row.Attributes.Add("onclick", "S('"+row_counter.ToString()+"','"+row.Cells[0].Text+"')");
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btForm_ServerClick(object sender, System.EventArgs e)
	{
		if (Request["dpt_id"] == null || Request["agr_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

		Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
		Int32 agr_id = Convert.ToInt32(Request["agr_id"]);
		string  template_id = Convert.ToString(Template_id.Value);

		DBLogger.Info("Пользователь выбрал шаблон " + template_id +" для доп. соглашения тип=" + agr_id.ToString() + " по договору №" + dpt_id.ToString(),
			"SocialDeposit");
				
		switch(agr_id) {
    		/// Про заповідане розпорядження
			case 23:
			{
				String add_tr = String.Empty;
				if (Request["rnk_tr"] != null)
					add_tr = "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

				Response.Redirect("Default.aspx?next=print&dpt_id="+dpt_id.ToString()
					+"&agr_id="+agr_id.ToString()+"&template="+template_id + add_tr);	
				break;
			}
			/// Про відміну заповіданого розпорядження
			case 24:
			{
				String add_tr = String.Empty;
				if (Request["rnk_tr"] != null)
					add_tr = "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

				Response.Redirect("DepositCancelAgreement.aspx?next=print&dpt_id="+dpt_id.ToString()
					+"&agr_id="+agr_id.ToString()+"&template="+template_id + add_tr);	
				break;
			}
			/// Дополнительное соглашение о доверенности
			case 21:
			{
				String add_tr = String.Empty;
				if (Request["rnk_tr"] != null)
					add_tr = "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                Response.Redirect("Default.aspx?next=print&dpt_id=" + dpt_id.ToString()
					+"&agr_id="+agr_id.ToString()+"&template="+template_id + add_tr);	
				break;
			}
			/// Дополнительное соглашение об отмене доверенности
			case 22:
			{
				String add_tr = String.Empty;
				if (Request["rnk_tr"] != null)
					add_tr = "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

				Response.Redirect("DepositCancelAgreement.aspx?next=print&dpt_id="+dpt_id.ToString()
					+"&agr_id="+agr_id.ToString()+"&template="+template_id + add_tr);	
				break;
			}
			default:{
				Response.Write(@"<script>alert('Некоректний тип дод. угоди!');
					location.replace('..//barsweb/welcome.aspx');</script>");
				Response.Flush();
				break;
			}
		}
	}
}

