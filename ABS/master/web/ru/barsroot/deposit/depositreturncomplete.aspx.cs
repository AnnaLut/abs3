using System;
using BarsWeb.Core.Logger;

/// <summary>
/// Summary description for DepositReturnComplete.
/// </summary>
public partial class DepositReturnComplete : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DepositReturnComplete()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositReturnComplete;
		_dbLogger.Info("Пользователь успешно выполнил операцию возврата депозита по завершению.  Номер договора " + Convert.ToString(Request["dptid"]),
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