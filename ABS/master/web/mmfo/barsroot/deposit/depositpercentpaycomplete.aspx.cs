using System;
using BarsWeb.Core.Logger;

/// <summary>
/// Summary description for DepositPercentPayComplete.
/// </summary>
public partial class DepositPercentPayComplete : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DepositPercentPayComplete()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

	/// <summary>
	/// Загрузка страницы
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositPercentPayComplete;
		_dbLogger.Info("Пользователь осуществил выплату процентов по договору.  Номер договора " + Convert.ToString(Request["dptid"]),
			"deposit");

		if (BankType.GetCurrentBank() == BANKTYPE.UPB)
			btnSubmit.Visible = false;
		
//			lbActionResult.Text = lbActionResult.Text.Replace("%s", Request.Params.Get("dptid"));
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
		_dbLogger.Info("Пользователь нажал на кнопку \"Следующий\" на странице выплаты процентов по договору",
			"deposit");

		Response.Redirect("DepositSearch.aspx?action=percent&extended=0");
	}
}
