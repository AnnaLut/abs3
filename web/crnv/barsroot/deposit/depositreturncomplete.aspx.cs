﻿using System;
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
/// Summary description for DepositReturnComplete.
/// </summary>
public partial class DepositReturnComplete : Bars.BarsPage
{

	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositReturnComplete;
		DBLogger.Info("Пользователь успешно выполнил операцию возврата депозита по завершению.  Номер договора " + Convert.ToString(Request["dptid"]),
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

	private void btnSubmit_Click(object sender, System.EventArgs e)
	{			
		Response.Redirect("DepositSearch.aspx?action=deposit&extended=0");
	}
}