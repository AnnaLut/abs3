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
using Bars.Exception;

/// <summary>
/// Summary description for DepositDelete.
/// </summary>
public partial class DepositDelete : Bars.BarsPage
{
	/// <summary>
	/// Загрузка страницы
	/// </summary>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositDelete;
        if (!IsPostBack)
		{
			DptDeleteEnabled();
			FillControls();
		}
	}
    /// <summary>
    /// Локализация
    /// </summary>
    protected override void OnPreRender(EventArgs evt) {
        base.OnPreRender(evt);

        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=delete&extended=0");
        else
        {
            dpt_id.Value = Convert.ToString(Request["dpt_id"]);
            
            lbDepositClose.Text = lbDepositClose.Text.Replace("%s", Convert.ToString(Session["DPT_NUM"]));
            lbAlert.Text = lbAlert.Text.Replace("%s", Convert.ToString(Session["DPT_NUM"]));
        }     
    }
	/// <summary>
	/// Инициализация контролов
	/// </summary>
	private void FillControls()
	{
		Deposit dpt = new Deposit();

		dpt.ID = Convert.ToDecimal(Request["dpt_id"]);	
		dpt.ReadFromDatabase();

		textContractTypeName.Text	= dpt.TypeName;
		textClientName.Text			= dpt.Client.Name;
		textClientPasp.Text			= dpt.Client.DocTypeName + " " + 
            dpt.Client.DocSerial + " " + dpt.Client.DocNumber;
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
		this.btConfirmDelete.Click += new System.EventHandler(this.btConfirmDelete_Click);
		this.btCancel.Click += new System.EventHandler(this.btCancel_Click);
		this.btNext.Click += new System.EventHandler(this.btNext_Click);
		;

	}
	#endregion
	/// <summary>
	/// Нажатие на кнопку "Отмена"
	/// </summary>
	private void btCancel_Click(object sender, System.EventArgs e)
	{
		Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
		
		DBLogger.Info("Пользователь нажал кнопку \"Отмена\" на странице удаления депозитного договора.  Номер договора " + dpt_id.ToString(),
			"deposit");

		Response.Redirect("..//barsweb/welcome.aspx");
	}
	/// <summary>
	/// Нажатие на кнопку "Следующий"
	/// </summary>
	private void btNext_Click(object sender, System.EventArgs e)
	{
		Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
		
		DBLogger.Info("Пользователь нажал кнопку \"Следующий\" на странице удаления депозитного договора.  Номер договора " + dpt_id.ToString(),
			"deposit");
		
		Response.Redirect("DepositSearch.aspx?action=delete&extended=0");
	}
	/// <summary>
	/// Нажатие на кнопку "Подтверждаю удаление"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btConfirmDelete_Click(object sender, System.EventArgs e)
	{
		Decimal dpt_id = Decimal.MinValue;

		if (Request["dpt_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=delete&extended=0");
		else
			dpt_id = Convert.ToDecimal(Request["dpt_id"]);

		DBLogger.Info("Пользователь нажал кнопку \"Подтверждаю удаление\" на странице удаления депозитного договора.  Номер договора " + dpt_id.ToString(),
			"deposit");

		btCancel.Enabled		= false;
        btShowDepositCard.Disabled = true;
		btConfirmDelete.Enabled = false;
		lbAlert.Visible			= true;
        lbDepDeleteConfirm.Visible = false;

		if (BankType.GetCurrentBank() == BANKTYPE.UPB)
			btNext.Visible = false;			
		else
			btNext.Visible			= true;

		OracleConnection connect = new OracleConnection();
		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			// Устанавливаем роль
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

            Decimal p_delcode = Decimal.MinValue;

			OracleCommand cmdCloseDpt = connect.CreateCommand();
            cmdCloseDpt.CommandText = "begin dpt_web.delete_deposit(:p_dptid); dpt_web.GET_DELDEPOSIT_MSG(:p_delcode,:p_delmsg); end;";
			cmdCloseDpt.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
            cmdCloseDpt.Parameters.Add("p_delcode",OracleDbType.Decimal,p_delcode,ParameterDirection.Output);
            OracleParameter p_delmsg = cmdCloseDpt.Parameters.Add("p_delmsg",OracleDbType.Varchar2,5000);
            p_delmsg.Direction = ParameterDirection.Output;
			
			cmdCloseDpt.ExecuteNonQuery();

            lbAlert.Text = Convert.ToString(p_delmsg.Value);

			DBLogger.Debug("Процедура удаления договора завершилась успешно на странице удаления депозитного договора.  Номер договора " + dpt_id.ToString(),
				"deposit");
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// Проверка на возможность удалить договор
	/// </summary>
	private void DptDeleteEnabled()
	{
		Decimal dpt_id = Decimal.MinValue;

		if (Request["dpt_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=delete&extended=0");
		else
			dpt_id = Convert.ToDecimal(Request["dpt_id"]);

		OracleConnection connect = new OracleConnection();
		try
		{
			DBLogger.Debug("Проверка можно ли удалять договор на странице удаления депозитного договора.  Номер договора " + dpt_id.ToString(),
				"deposit");

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			// Устанавливаем роль
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdCloseDpt = new OracleCommand();
			cmdCloseDpt.Connection = connect;
			cmdCloseDpt.CommandText = "select dpt_web.dpt_del_enabled(:dpt_id) from dual";
			cmdCloseDpt.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);

			Decimal result = Convert.ToDecimal(cmdCloseDpt.ExecuteScalar());

			if (result != 1)
                throw new DepositException("Депозитний договір №" + 
                    dpt_id.ToString() + " видаляти заборонено!");
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
}
