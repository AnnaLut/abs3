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


	/// <summary>
	/// Діалог для пошуку існуючого клієнта
	/// </summary>
public partial class SearchResults : Bars.BarsPage
{
    // Валідатори для перевірки обовязкових для заповнення полів
    protected System.Web.UI.WebControls.RequiredFieldValidator NameValidator;
    protected System.Web.UI.WebControls.RequiredFieldValidator CodeValidator;
    // Кнопки
    // Список знайдених клієнтів
    protected System.Web.UI.WebControls.RequiredFieldValidator BirthDateValidator;
    protected System.Data.DataSet fClients;
    protected System.Web.UI.WebControls.Label lbStar;
    protected System.Web.UI.WebControls.Label Label1;
    protected System.Web.UI.WebControls.Label Label2;
    // Приховане поле для перевірки на PostBack
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
        this.Load += new System.EventHandler(this.Page_Load);
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
        textClientCode.Attributes["onblur"] = "javascript:doValueCheck(\"textClientCode\")";
        textClientNumber.Attributes["onblur"] = "javascript:doValueCheck(\"textClientNumber\")";

        if (!IsPostBack)
        {
            isPostBack.Value = "0";
        }
        else
        {
            isPostBack.Value = "1";
        }
    }

    /// <summary>
    /// Нажатие кнопки "Поиск"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btSearch_Click(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь выполнил поиск клиента на странице поиска",
            "SocialDeposit");

        listSearchClient.Items.Clear();

        // Якщо поля запиту незаповнені, то на вхід процедурі подаємо null
        string parClientName = null;
        string parClientCode = null;
        DateTime parClientDate = DateTime.MinValue;
        string parClientSerial = null;
        string parClientNumber = null;

        if (textClientName.Text != string.Empty)
            parClientName = textClientName.Text.ToUpper() + "%";
        if (textClientCode.Text != string.Empty)
            parClientCode = textClientCode.Text;
        if (textClientDate.Date != DateTime.MinValue)
            parClientDate = textClientDate.Date;
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

            if (parClientDate != DateTime.MinValue)
                cmdSearchCustomer.Parameters.Add("p_bday", OracleDbType.Date, parClientDate, ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("p_bday", OracleDbType.Date, null, ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_ser", OracleDbType.Varchar2, parClientSerial, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_numdoc", OracleDbType.Varchar2, parClientNumber, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_cust", OracleDbType.RefCursor, ParameterDirection.Output);

            cmdSearchCustomer.ExecuteNonQuery();

            // Беремо з процедури RefCursor, в якому записані дані про всіх знайдених клієнтів
            OracleRefCursor refcur = (OracleRefCursor)cmdSearchCustomer.Parameters["p_cust"].Value;

            OracleDataAdapter da = new OracleDataAdapter("", connect);
            da.Fill(fClients, refcur);

            listSearchClient.DataBind();

            for (int i = 0; i < listSearchClient.Items.Count; i++)
            {
                listSearchClient.Items[i].Text = "";
                for (int j = 1; j < fClients.Tables[0].Rows[0].ItemArray.Length; j++)
                {
                    listSearchClient.Items[i].Text += fClients.Tables[0].Rows[i].ItemArray[j];
                    listSearchClient.Items[i].Text += " / ";
                }
            }
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            Response.Write("<script>window.showModalDialog('dialog.aspx?type=err','','dialogWidth:400px;dialogHeight:300px;center:yes;edge:sunken;help:no;status:no;');</script>");
            Response.Flush();
            return;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        listSearchClient.Items.Add("Не найдено ни одной подходящей записи");
        listSearchClient.Items[listSearchClient.Items.Count - 1].Value = "-1";
    }
}
