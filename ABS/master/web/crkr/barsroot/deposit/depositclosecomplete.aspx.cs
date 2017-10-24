﻿using System;
using BarsWeb.Core.Logger;

/// <summary>
/// Summary description for DepositCloseComplete.
/// </summary>
public partial class DepositCloseComplete : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DepositCloseComplete()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositCloseComplete;
		_dbLogger.Info("Пользователь осуществил досрочную выплату депозита.  Номер договора " + Convert.ToString(Request["dpt_id"]),
			"deposit");

		if (BankType.GetCurrentBank() == BANKTYPE.UPB)
			btnSubmit.Visible = false;

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
		Response.Redirect("DepositSearch.aspx?action=close&extended=0");
	}
}
