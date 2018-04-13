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
/// Summary description for DepositAgreement.
/// </summary>
public partial class DepositAgreement : Bars.BarsPage
{
	protected System.Data.DataSet dsAddAgreement;
	private   OracleDataAdapter adapterSearchAgreement;
	protected System.Web.UI.WebControls.DataGrid gridCurAgr;
	protected System.Data.DataSet dsCurAgreement;
  	private int row_counter = 0;
	/// <summary>
	/// Завантаження сторінки
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
		if (Request["dpt_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

		RegisterClientScript_Add();
		RegisterClientScript_Cur();

		Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);       
		dpt_num.Value = Convert.ToString(Session["DPT_NUM"]);
        dptid.Value = Convert.ToString(dpt_id);

		if(!this.IsClientScriptBlockRegistered("ADD_CK"))
			this.RegisterClientScriptBlock("ADD_CK", "<script language=\"javascript\" src=\"js/ck.js\"></script>");
		if(!this.IsClientScriptBlockRegistered("ADD_JS"))
			this.RegisterClientScriptBlock("ADD_JS", "<script language=\"javascript\" src=\"js/js.js\"></script>");


		btForm.Attributes["onclick"] = "javascript:if (agr_ck())";

		DBLogger.Info("Пользователь зашел на страницу оформления доп. соглашений по договору №" + dpt_id.ToString(),
			"SocialDeposit");

        if (!IsPostBack)
            FillGrids();
	}
	/// <summary>
	/// Клієнтський скріпт, який
	/// при виборі рядка таблиці
	/// виділяє його кольором
	/// </summary>
	private void RegisterClientScript_Add ()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,val,name)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('agr_id').value = val;
			 document.getElementById('name').value = name;
			 document.getElementById('ccdoc_id').value = null;
			 document.getElementById('ccdoc_ads').value = null;
			 document.getElementById('ccdoc_agr_id').value = null;
             document.getElementById('btShow').disabled = 'disabled';
             document.getElementById('btFormText').disabled = 'disabled';
			}
			</script>";
		Page.RegisterStartupScript(ID+"Script_A",script ) ;
	}
	/// <summary>
	/// Клієнтський скріпт, який
	/// при виборі рядка таблиці
	/// виділяє його кольором
	/// </summary>
	private void RegisterClientScript_Cur ()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S_C(id,c_id,agr_id,adds,txt,tr_id)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('ccdoc_id').value = c_id;
			 document.getElementById('ccdoc_ads').value = adds;
			 document.getElementById('ccdoc_agr_id').value = agr_id;
			 document.getElementById('agr_id').value = null;
			 document.getElementById('name').value = null;
             document.getElementById('trustid').value = tr_id;
             if (txt == 1)
             {
                document.getElementById('btFormText').disabled = 'disabled';
                document.getElementById('btShow').disabled = '';
             }
             else
             {
                document.getElementById('btFormText').disabled = '';
                document.getElementById('btShow').disabled = 'disabled';
             }
			}
			</script>";
		Page.RegisterStartupScript(ID+"Script_C",script ) ;
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
		this.dsAddAgreement = new System.Data.DataSet();
		this.dsCurAgreement = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsAddAgreement)).BeginInit();
		((System.ComponentModel.ISupportInitialize)(this.dsCurAgreement)).BeginInit();
		this.gridAddAgreement.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridAddAgreement_ItemDataBound);
		this.gridCurAgreement.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridCurAgreement_ItemDataBound);
		// 
		// dsAddAgreement
		// 
		this.dsAddAgreement.DataSetName = "NewDataSet";
		this.dsAddAgreement.Locale = new System.Globalization.CultureInfo("uk-UA");
		// 
		// dsCurAgreement
		// 
		this.dsCurAgreement.DataSetName = "NewDataSet";
		this.dsCurAgreement.Locale = new System.Globalization.CultureInfo("uk-UA");
		this.Load += new System.EventHandler(this.Page_Load);
		((System.ComponentModel.ISupportInitialize)(this.dsAddAgreement)).EndInit();
		((System.ComponentModel.ISupportInitialize)(this.dsCurAgreement)).EndInit();

	}
	#endregion
	/// <summary>
	/// Перевірка дод.угоди на унікальність
	/// та можливість формувати
	/// </summary>
	/// <returns>Можна формувати, чи ні</returns>
	private bool CkUnique()
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			if (Request["dpt_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

			Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
			Decimal f_id = Convert.ToDecimal(Convert.ToString(agr_id.Value));

			DBLogger.Debug("Проверка взможности заключения доп. соглашения тип=" + f_id.ToString() +
				" по договору №" + dpt_id.ToString(),
				"SocialDeposit");

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = connect.CreateCommand();
						
			cmdSearch.CommandText = @"SELECT f.only_one 
                FROM CC_DOCS c,SOCIAL_CONTRACTS d,SOCIAL_TEMPLATES s,DPT_VIDD_FLAGS f 
                WHERE d.contract_id = :dpt_id AND c.nd = d.contract_id AND c.state = 1
                AND c.ID = s.TEMPLATE_ID AND s.type_id = d.type_id AND s.FLAG_ID = f.id AND f.id=:f_id";
			
			cmdSearch.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
			cmdSearch.Parameters.Add("f_id",OracleDbType.Decimal,f_id,ParameterDirection.Input);
			
			OracleDataReader rdr = cmdSearch.ExecuteReader();

			if (!rdr.Read())
			{
                rdr.Close();
                rdr.Dispose();
				DBLogger.Debug("Выбраное доп. соглашение№" + f_id + 
                    " по договору №" + dpt_id + " формировать можно",
					"SocialDeposit");

				return true;	
			}
			else{
				Decimal only_one = Decimal.MinValue;
				if (!rdr.IsDBNull(0))
					only_one = rdr.GetOracleDecimal(0).Value;
                rdr.Close();
                rdr.Dispose();
				if (only_one != 1)
				{
					DBLogger.Debug("Выбраное доп. соглашение тип=" + f_id + " по договору №" + 
                        dpt_id + " формировать можно","SocialDeposit");

					return true;	
				}
				DBLogger.Debug("Выбраное доп. соглашение по договору №" + dpt_id + 
                    " формировать нельзя: оно уникально и уже сформировано","SocialDeposit");

				return false;
			}
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void gridAddAgreement_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			row_counter++;
			string row_id = "r_" + row_counter.ToString();
			DataGridItem row = e.Item;
			row.Attributes.Add("id", row_id);
			row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + row.Cells[0].Text + 
                "','" + row.Cells[1].Text + "')");
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void gridCurAgreement_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			row_counter++;
			string row_id = "r_" + row_counter.ToString();
			DataGridItem row = e.Item;
			row.Attributes.Add("id", row_id);
			row.Attributes.Add("onclick", "S_C('"+row_counter.ToString()+"','"+row.Cells[4].Text+"','"
                + row.Cells[2].Text + "','" + row.Cells[0].Text + "','" + row.Cells[7].Text + "','" + row.Cells[8].Text + "')");
		}		
	}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btForm_ServerClick(object sender, EventArgs e)
    {
        if (CkUnique())
        {
            string dpt_id = Convert.ToString(Request["dpt_id"]);
            string agrm_id = agr_id.Value.ToString();
            string txt_name = name.Value.ToString();

            agr_id.Value = "";

            DBLogger.Info("Пользователь выбрал для формирования доп. соглашение тип=" + agrm_id +
                " для депозитного договора №" + dpt_id,
                "SocialDeposit");
            String url = "DepositAgreementTemplate.aspx?dpt_id=" + dpt_id + "&agr_id=" + agrm_id + "&name=" + txt_name;

            if (Request["rnk_tr"] != null)
                url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

            Response.Redirect(url);
        }
        else
        {
            Response.Write(@"<script>alert('Данное доп.соглашение уникально и уже было сформировано!\nОтмените сначала существующие доп.соглашение.');
				location.replace('..//barsweb/welcome.aspx');</script>");

            Response.Flush();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btFormText_ServerClick(object sender, EventArgs e)
    {
        SocialDeposit dpt = new SocialDeposit();
        dpt.ID = Convert.ToDecimal(Request["dpt_id"]);
        dpt.ReadFromDatabase(HttpContext.Current);
        dpt.WriteAddAgreement(ccdoc_agr_id.Value, ccdoc_id.Value, trustid.Value);

        FillGrids();
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrids()
    {
        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);       
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = new OracleCommand();
            cmdSearch.Connection = connect;

            string searchQuery = @"SELECT f.id, f.NAME ,f.DESCRIPTION 
                FROM DPT_VIDD_FLAGS f WHERE f.id != 1 AND f.id IN 
                (SELECT s.FLAG_id FROM SOCIAL_TEMPLATES s,SOCIAL_CONTRACTS d WHERE s.TYPE_ID=d.TYPE_ID AND d.CONTRACT_ID=:dpt_id ) ORDER BY f.id";
            cmdSearch.CommandText = searchQuery;
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            adapterSearchAgreement = new OracleDataAdapter();
            adapterSearchAgreement.SelectCommand = cmdSearch;
            adapterSearchAgreement.Fill(dsAddAgreement);

            gridAddAgreement.DataSource = dsAddAgreement;
            gridAddAgreement.DataBind();

            gridAddAgreement.HeaderStyle.BackColor = Color.Gray;
            gridAddAgreement.HeaderStyle.Font.Bold = true;
            gridAddAgreement.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

            cmdSearch.CommandText = @"select s.add_num adds, c.version version, s.flag_id as agr_id, flag_name agr_name,
                template_id template, s.trust_rnk rnk, s.trust_name nmk, s.details comm, decode(to_char(substr(c.text,1,1)),to_char(null),0,1) as txt, s.TRUST_ID TRUST_ID
                from v_socialtrustee s, cc_docs c
                where s.contract_id = c.nd (+) and s.add_num = c.adds(+) and s.contract_id = :dpt_id 
                order by s.add_num";
            adapterSearchAgreement.Fill(dsCurAgreement);

            gridCurAgreement.DataSource = dsCurAgreement;
            gridCurAgreement.DataBind();

            gridCurAgreement.HeaderStyle.BackColor = Color.Gray;
            gridCurAgreement.HeaderStyle.Font.Bold = true;
            gridCurAgreement.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
