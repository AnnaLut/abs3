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

/// <summary>
/// Вибір типу додаткової угоди
/// поповнення або часткове зняття
/// </summary>
public partial class Ask : Bars.BarsPage
{
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

	}
	#endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hAsk;
    }
}
