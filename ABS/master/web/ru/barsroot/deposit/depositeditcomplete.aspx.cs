using System;
using BarsWeb.Core.Logger;

/// <summary>
/// Summary description for DepositEditComplete.
/// </summary>
public partial class DepositEditComplete : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DepositEditComplete()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

	/// <summary>
	/// Загрузка формы
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositEditComplete;
		_dbLogger.Info("Пользователь успешно обновил счета выплаты депозитного договора.  Номер договора " + Convert.ToString(Request["dptid"]),
			"deposit");

		if (BankType.GetCurrentBank() == BANKTYPE.UPB)
			btnSubmit.Visible = false;

		lbActionResult.Text = lbActionResult.Text.Replace("%s", Request.Params.Get("dpt_id"));
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
	/// Нажатие кнопки "Следуюющий"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btnSubmit_Click(object sender, System.EventArgs e)
	{
		Response.Redirect("DepositSearch.aspx?action=edit");
	}
}
