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

/// <summary>
/// Summary description for DepositAddSumComplete.
/// </summary>
public partial class DepositAddSumComplete : Bars.BarsPage
{
	/// <summary>
	/// Загрузка страницы
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAddSumComplete;
		if (BankType.GetCurrentBank() == BANKTYPE.UPB)
			btnSubmit.Visible = false;				

		lbActionResult.Text = lbActionResult.Text.Replace("%s", Request.Params.Get("dptid"));
		
		// _ID.Value = Request.QueryString["dptid"];
        // btDopAgrPrint.Attributes["onclick"] = "javascript:AddSumAgreementPrint();";

        if (Request.QueryString["rnk"] == null)
        {
            btnSubmit.Enabled = true;
            btnContracts.Enabled = false;
        }
        else
        {
            btnSubmit.Enabled = false;
            btnContracts.Enabled = true;
        }
	}

    protected override void OnPreRender(EventArgs evt)
    {
        base.OnPreRender(evt);
        lbActionResult.Text = lbActionResult.Text.Replace("%s",  Convert.ToString(Session["DPT_NUM"]));

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
		this.btnSubmit.Click += new System.EventHandler(this.btnSubmit_Click);
		;

	}
	#endregion
	/// <summary>
	/// Нажатие кнопки "Следующий"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btnSubmit_Click(object sender, System.EventArgs e)
	{
		// DBLogger.Info("Пользователь нажал на кнопку \"следующий\" на странице печати доп. соглашения на пополнение депозита", "deposit");

        Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=replenish");
	}

	/// <summary>
	/// Нажатие кнопки "Печать доп. соглашения"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btDopAgrPrint_Click(object sender, System.EventArgs e)
	{
		btnSubmit.Enabled = true;
		
		DBLogger.Info("Пользователь нажал кнопку печати доп. соглашения на пополнение депозита.  Номер депозита = " + Convert.ToString(Request["dptid"]),
			"deposit");
	}

    /// <summary>
    /// Візування документів
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSignDoc_Click(object sender, EventArgs e)
    {
        Response.Redirect("/barsroot/checkinner/default.aspx?type=0");
    }

    /// <summary>
    /// Портфель договорів
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnContracts_Click(object sender, EventArgs e)
    {
        Response.Redirect("/barsroot/clientproducts/DptClientPortfolioContracts.aspx?cust_id=" + Request.QueryString["rnk"]);
    }
}
