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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Logger;
using Bars.Classes;

/// <summary>
/// Діалог для пошуку існуючого клієнта
/// </summary>
public partial class DptClientSearch : Bars.BarsPage
{
	private Boolean? _UsedPhoto;

    /// <summary>
    /// Використання фотокартки клієнта
    /// </summary>
    public Boolean UsedPhoto
    {
        get
        {
            if (!_UsedPhoto.HasValue)
            {
                Bars.UserControls.IDDocScheme DocScheme = new Bars.UserControls.IDDocScheme();

                _UsedPhoto = (DocScheme.ClientPhoto == 0 ? false : true);
            }

            return _UsedPhoto.Value;
        }
    }

    protected System.Data.DataSet fClients;

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
		this.fClients = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.fClients)).BeginInit();
		// 
		// fClients
		// 
		this.fClients.DataSetName = "fClients";
		this.fClients.Locale = new System.Globalization.CultureInfo("uk-UA");
		this.btSearch.Click += new System.EventHandler(this.btSearch_Click);
        this.btRegister.Click += new System.EventHandler(this.btRegister_Click);
        this.btClientCard.Click += new System.EventHandler(this.btClientCard_Click);
		((System.ComponentModel.ISupportInitialize)(this.fClients)).EndInit();
	}
	#endregion
	/// <summary>
	/// Загрузка страницы
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        if (Tools.DPT_WORK_SCHEME() != "EBP")
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", 
                "alert('Працівникам поточного підрозділу заборонено працювати в новій версії депозитного модуля!'); " +
                "location.replace('..//barsweb/welcome.aspx');", true);
        }
        
        lbSearchClient.Text = Resources.Deposit.GlobalResources.hSearchResults;

        Session.Remove("AccessRights");

		textClientCode.Attributes["onblur"]	= "javascript:doValueCheck(\"textClientCode\")";
		textClientNumber.Attributes["onblur"] = "javascript:doValueCheck(\"textClientNumber\")";

		if (!IsPostBack)
		{
			isPostBack.Value = "0";
		}
		else
		{
			isPostBack.Value = "1";
		}

        textClientDate.ToolTip = Resources.Deposit.GlobalResources.tb11;
	}  

	/// <summary>
	/// Нажатие кнопки "Поиск"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btSearch_Click(object sender, System.EventArgs e)
	{
		DBLogger.Info("Пользователь выполнил поиск клиента на странице поиска", "deposit");

		ddlSearchClient.Items.Clear();

		// Якщо поля запиту незаповнені, то на вхід процедурі подаємо null
		string parClientName = null;
		string parClientCode = null;
		DateTime? parClientDate = null;
		string parClientSerial = null;
		string parClientNumber = null;

		if (textClientName.Text != string.Empty)
			parClientName	= textClientName.Text.ToUpper() + "%";

		if (textClientCode.Text != string.Empty)
			parClientCode	= textClientCode.Text;
        
		if (!String.IsNullOrEmpty(textClientDate.Text))
            parClientDate = Convert.ToDateTime(textClientDate.Text, Tools.Cinfo());

        if (textClientSerial.Text != string.Empty)
			parClientSerial = textClientSerial.Text;

		if (textClientNumber.Text != string.Empty)
			parClientNumber = textClientNumber.Text;
		OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)Context.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Установка роли
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            //cmdSetRole.CommandText = "set role dpt_role";
            //cmdSetRole.CommandText = "begin bars_role_auth.set_role('DPT_ROLE'); end;";
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Формируем запрос на поиск
            OracleCommand cmdSearchCustomer = new OracleCommand();
            cmdSearchCustomer.Connection = connect;
            cmdSearchCustomer.CommandText = "dpt_web.p_search_customer";
            cmdSearchCustomer.CommandType = CommandType.StoredProcedure;

            cmdSearchCustomer.Parameters.Add("p_okpo", OracleDbType.Varchar2, parClientCode, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_nmk", OracleDbType.Varchar2, parClientName, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_bday", OracleDbType.Date, parClientDate, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_ser", OracleDbType.Varchar2, parClientSerial, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_numdoc", OracleDbType.Varchar2, parClientNumber, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_cust", OracleDbType.RefCursor, ParameterDirection.Output);

            cmdSearchCustomer.ExecuteNonQuery();

            // Беремо з процедури RefCursor, в якому записані дані про всіх знайдених клієнтів
            OracleRefCursor refcur = (OracleRefCursor)cmdSearchCustomer.Parameters["p_cust"].Value;

            OracleDataAdapter da = new OracleDataAdapter("", connect);
            da.Fill(fClients, refcur);

            ddlSearchClient.DataBind();

            for (int i = 0; i < ddlSearchClient.Items.Count; i++)
            {
                ddlSearchClient.Items[i].Text = "";
                for (int j = 0; j < fClients.Tables[0].Rows[0].ItemArray.Length; j++)
                {
                    ddlSearchClient.Items[i].Text += fClients.Tables[0].Rows[i].ItemArray[j];
                    ddlSearchClient.Items[i].Text += " / ";
                }
            }
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", 
                "window.showModalDialog('dialog.aspx?type=err','','dialogWidth:400px;dialogHeight:300px;center:yes;edge:sunken;help:no;status:no;');", true);
            return;
        }
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}

        ddlSearchClient.Items.Add(Resources.Deposit.GlobalResources.w03);
        ddlSearchClient.Items[ddlSearchClient.Items.Count - 1].Value = "-1";

        // якщо знайшли хоч одного клієнта
        if (ddlSearchClient.Items.Count > 1)
        {
            btClientCard.Visible = true;

            Bars.UserControls.IDDocScheme DocScheme = new Bars.UserControls.IDDocScheme();

            // Якщо використовується фото клієнта
            if (UsedPhoto)
            {
                biClietFoto.Visible = true;
                
                get_cliet_foto();
            }
        }
        else
        {
            biClietFoto.Visible = false;
            btClientCard.Visible = false;
        }
    }

    /// <summary>
    /// Реєстрація нового клієнта
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btRegister_Click(object sender, System.EventArgs e)
    {
        Session.Remove("AccessRights");

        DBLogger.Info("Користувач натиснув кнопку \"Реєструвати\" на сторінці пошук клієнта.", "deposit" );

        Response.Redirect("DepositClient.aspx?scheme=DELOITTE");
    }

    /// <summary>
    /// Перехід на сорінку "Картка Клієнта"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btClientCard_Click(object sender, System.EventArgs e)
    {
        Int64 cust_id = Convert.ToInt64(ddlSearchClient.SelectedItem.Value);

        ClientAccessRights AccessRights = new ClientAccessRights(cust_id, 0, Tools.Get_DocumentVerifiedState(cust_id));

        Session["AccessRights"] = AccessRights;

        DBLogger.Info("Користувач натиснув кнопку \"Картка Клієнта\" на сторінці пошук клієнта.", "deposit");

        Response.Redirect("DepositClient.aspx?rnk=" + Convert.ToString(cust_id) + "&scheme=DELOITTE");
    }

    /// <summary>
    /// Показати фотографію клієнта
    /// </summary>
    private void get_cliet_foto()
    {
        if (biClietFoto.Visible)
        {
            Int64 cust_id = Convert.ToInt64(ddlSearchClient.SelectedItem.Value);

            biClietFoto.Value = Tools.get_cliet_picture(cust_id, "PHOTO");
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Index_Changed(Object sender, EventArgs e)
    {
        get_cliet_foto();
    }

    /// <summary>
    /// Пошук + ідентифікація клієнта по БПК
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSearchByBPK_ClientIdentified(object sender, Bars.UserControls.ClientIdentifiedEventArgs e)
    {
        ClientAccessRights AccessRights = new ClientAccessRights(e.RNK, 1, Tools.Get_DocumentVerifiedState(e.RNK));

        Session["AccessRights"] = AccessRights;

        DBLogger.Info("Користувач здійснив ідентифікацію клієнта (rnk=" + Convert.ToString(e.RNK) +
            ") по БПК на сторінці Пошук клієнта.", "deposit");

        Response.Redirect("DepositClient.aspx?rnk=" + Convert.ToString(e.RNK) + "&scheme=DELOITTE");
    }


}
