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
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;

/// <summary>
/// Summary description for DepositCancelAgreement.
/// </summary>
public partial class DepositCancelAgreement : Bars.BarsPage
{
	private   OracleDataAdapter adapterSearchAgreement;
	protected System.Data.DataSet dsAgreement;
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
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
			if (Request["agr_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
			if (Request["template"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

			RegisterClientScript();

			Decimal dpt_id_v	= Convert.ToDecimal(Request["dpt_id"]);
			Decimal agr_id_v	= Convert.ToDecimal(Request["agr_id"]);
			String template_id = Convert.ToString(Request["template"]);

			dpt_id.Value = dpt_id_v.ToString();
			template.Value = template_id;
			agr_id.Value = agr_id_v.ToString();				

			if(!this.IsClientScriptBlockRegistered("ADD_CK"))
				this.RegisterClientScriptBlock("ADD_CK", "<script language=\"javascript\" src=\"js/ck.js\"></script>");

			btCancel.Attributes["onclick"] = "javascript:if (rnk_ck())";

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = new OracleCommand();
			cmdSearch.Connection = connect;

            cmdSearch.CommandText = @"SELECT c.adds AS adds, c.version AS version,df.id AS agr_id, df.name AS agr_name, c.id AS TEMPLATE,t.trust_rnk AS rnk, k.nmk AS nmk, 
                DECODE(t.fl_act,0, DECODE(p.trust_id, NULL, 'закрито', 'анульовано дод. угодою №'||p.add_num),'активне') AS comm
                FROM CC_DOCS c, SOCIAL_CONTRACTS d, CUSTOMER k, SOCIAL_TEMPLATES ds, DPT_VIDD_FLAGS df, SOCIAL_TRUSTEE t, SOCIAL_TRUSTEE p
                WHERE c.nd = :dpt_id 
                AND d.contract_id = c.nd 
                AND d.type_id = ds.TYPE_ID
                AND c.id = ds.templATE_ID
                AND ds.FLAG_ID != 1 
                AND c.state = 1 
				AND df.id = :agr_id
                AND ds.FLAG_ID = df.id  
                AND c.nd = t.contract_id(+)
                AND c.adds = t.add_num(+) 
                AND t.trust_rnk = k.rnk (+)
                AND t.trust_id = p.undo_id(+) 
                ORDER BY 2, 3";

			cmdSearch.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id_v,ParameterDirection.Input);
			cmdSearch.Parameters.Add("agr_id",OracleDbType.Decimal,agr_id_v - 1,ParameterDirection.Input);
			
			adapterSearchAgreement = new OracleDataAdapter();
			adapterSearchAgreement.SelectCommand = cmdSearch;
			adapterSearchAgreement.Fill(dsAgreement);

			gridAgreement.DataSource = dsAgreement;
			gridAgreement.DataBind();

			gridAgreement.HeaderStyle.BackColor = Color.Gray;
			gridAgreement.HeaderStyle.Font.Bold = true;
			gridAgreement.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;	
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
	private void RegisterClientScript()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('rnk').value = val;
			}
			</script>";
		Page.RegisterStartupScript(ID+"Script_A",script ) ;
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
		this.dsAgreement = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsAgreement)).BeginInit();
		this.gridAgreement.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridAgreement_ItemDataBound);
		this.btCancel.ServerClick += new System.EventHandler(this.btCancel_ServerClick);
		// 
		// dsAgreement
		// 
		this.dsAgreement.DataSetName = "NewDataSet";
		this.dsAgreement.Locale = new System.Globalization.CultureInfo("uk-UA");
		this.Load += new System.EventHandler(this.Page_Load);
		((System.ComponentModel.ISupportInitialize)(this.dsAgreement)).EndInit();

	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void gridAgreement_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			row_counter++;
			string row_id = "r_" + row_counter.ToString();
			DataGridItem row = e.Item;
			row.Attributes.Add("id", row_id);
			row.Attributes.Add("onclick", "S_A('"+row_counter.ToString()+"','"+row.Cells[5].Text + "')");
		}
	}

	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btCancel_ServerClick(object sender, System.EventArgs e)
	{
		OracleConnection connect = new OracleConnection();
		
		try {
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
			Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
			String  rnkstr = Convert.ToString(rnk.Value);

			DBLogger.Info("Пользователь выбрал для отмены доп. соглашение тип=" + agr_id.ToString() 
				+ " ,номер депозитного договора =" +  dpt_id.ToString()
				+ " ,рнк 3 лица=" + rnkstr,
				"SocialDeposit");

			String  dest = "DepositAgreementPrint.aspx?dpt_id=" 
				+ Convert.ToString(dpt_id) + "&agr_id=" + Convert.ToString(agr_id) + 
				"&template=" + Convert.ToString(Request["template"]) + "&rnk=" + rnkstr;

			OracleCommand cmd = connect.CreateCommand();
			cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmd.ExecuteNonQuery();
				
			cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
			cmd.Parameters.Add("agr_id",OracleDbType.Decimal,Convert.ToDecimal(agr_id),ParameterDirection.Input);

			String TT = Convert.ToString(cmd.ExecuteScalar());

			if (TT != String.Empty)
			{
				cmd.Parameters.Clear();
				cmd.CommandText = "select s.nls, s.kv from social_contracts d, saldo s where d.contract_id = :dpt_id and d.acc = s.acc";
				cmd.Parameters.Add("dpt_id",OracleDbType.Decimal,Convert.ToString(dpt_id),ParameterDirection.Input);

				OracleDataReader rdr = cmd.ExecuteReader();

				if (!rdr.Read())
					throw new ApplicationException("Депозитный договор №" + Convert.ToString(dpt_id) + " не найден!");

				String nls = Convert.ToString(rdr.GetOracleString(0).Value);
				Decimal kv = Convert.ToDecimal(rdr.GetOracleDecimal(1).Value);

				if (!rdr.IsClosed)
					rdr.Close();

				Client cl;

				if (Request["rnk_tr"] != null)
				{
					cl = new Client(Convert.ToDecimal(Convert.ToString(Request["rnk_tr"])));
				}
				else
				{
					SocialDeposit dpt_dop = new SocialDeposit();
					dpt_dop.ID = dpt_id;
					dpt_dop.ReadFromDatabase(Context);
					cl = dpt_dop.Client;
				}

                Random r = new Random();
                String dop_rec = "&RNK=" + Convert.ToString(cl.ID) +
                    "&Code=" + Convert.ToString(r.Next());

                //String dop_rec = "&FIO=" + cl.Name +
                //    "&PASP=" + cl.DocTypeName + "&PASPN=" + cl.DocSerial + " " + cl.DocNumber +
                //    "&ATRT=" + cl.DocOrg + " " + cl.DocDate.ToString("dd/mm/yyyy") +
                //    "&ADRES=" + cl.Address +
                //    "&DT_R=" + cl.BirthDate.ToString("dd/mm/yyyy");

                string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + TT + "&nd=" + Convert.ToString(dpt_id) + "&SumC_t=1";

				string script = "<script>window.showModalDialog(encodeURI(" + url + dop_rec + "\"" + "),null," +
					"'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

				script += "location.replace('" + dest + "');";

				script += "</script>";
				Response.Write(script);
				Response.Flush();
				return;
			}
			else
			{
				String script = "<script>location.replace('" + dest + "');";

				script += "</script>";
				Response.Write(script);
				Response.Flush();
				return;
			}
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
}

