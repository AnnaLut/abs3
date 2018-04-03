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
using System.Globalization;
using Bars.Exception;

/// <summary>
/// Summary description for DepositRateEdit.
/// </summary>
public partial class DepositRateEdit : Bars.BarsPage
{
    /// <summary>
    /// Зміна відсоткової ставки
    /// Використовується тільки в УПБ!!!
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositRateEdit;
        if (BankType.GetCurrentBank() != BANKTYPE.UPB)
            Response.Redirect("../barsweb/Welcome.aspx");
        if (Request["dpt_id"] == null)
            Response.Redirect("../barsweb/Welcome.aspx");

        textDptNum.Text = Convert.ToString(Session["DPT_NUM"]);
        btSet.Attributes["onclick"] = "javascript:if(rateChanged())";

        FillControls();

        if (!IsPostBack)
            btSet.Disabled = false;
        else
            btSet.Disabled = true;
    }
    /// <summary>
    /// Локализация
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        dtStartDate.ToolTip = Resources.Deposit.GlobalResources.tb113;
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillControls()
    {
        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"].ToString());
        Deposit dpt = new Deposit(dpt_id);

        textClientName.Text = dpt.Client.Name;
        textClientPasp.Text = dpt.Client.DocTypeName + " " + dpt.Client.DocSerial +
            " " + dpt.Client.DocNumber + " " + dpt.Client.DocOrg;
        DepositType.Text = dpt.TypeName;
        dptCurrency.Text = dpt.CurrencyISO;
        textCurRate.ValueDecimal = dpt.RealIntRate;

        OracleConnection connect = new OracleConnection();
        OracleDataReader rdr = null;
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "select a1.ostc/100,decode(a1.acc,a2.acc,0,a2.ostc/100),a1.acc,to_char(bankdate,'dd/mm/yyyy') " +
                "from dpt_deposit d, saldo a1,int_accn i,saldo a2 " +
                "where d.deposit_id = :dpt_id and d.acc = a1.acc and d.acc = i.acc and i.acra = a2.acc";
            cmdGetInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new DepositException("Інформація про депозитний договір №" +
                    dpt.ID.ToString() + " і його рахунки не знайдена!");

            String dt = String.Empty;
            if (!rdr.IsDBNull(0))
                dptSum.ValueDecimal = Convert.ToDecimal(Convert.ToString(rdr.GetOracleDecimal(0).Value));
            if (!rdr.IsDBNull(1))
                percentSum.ValueDecimal = Convert.ToDecimal(Convert.ToString(rdr.GetOracleDecimal(1).Value));
            if (!rdr.IsDBNull(2))
                dptacc.Value = Convert.ToString(rdr.GetOracleDecimal(2).Value);
            if (!rdr.IsDBNull(3))
                dt = Convert.ToString(rdr.GetOracleString(3).Value);

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (dt != String.Empty)
                dtStartDate.Date = Convert.ToDateTime(dt, cinfo);
            else
                throw new DepositException("Некоректна банківська дата!");

        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
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
        this.btSet.ServerClick += new System.EventHandler(this.btSet_ServerClick);
        ;

    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btSet_ServerClick(object sender, System.EventArgs e)
    {
        Decimal dpt_acc = Convert.ToDecimal(Convert.ToString(dptacc.Value));

        if (textNewRate.ValueDecimal == textCurRate.ValueDecimal)
        {
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al33 + "');</script>");
            //Response.Write("<script>alert('Новая процентная ставка ровна предыдущей!');</script>");
            Response.Flush();
            return;
        }

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

            OracleCommand cmdUpdateRate = connect.CreateCommand();
            cmdUpdateRate.CommandText = "BEGIN " +
                "update int_ratn SET IR=:RAT,BDAT=bankdate,br=null,op=null " +
                "WHERE ACC=:ACC AND ID=1 and BDAT=bankdate; " +
                "IF SQL%ROWCOUNT = 0 THEN " +
                "INSERT INTO INT_RATN(ACC,ID,BDAT,IR) " +
                "VALUES(:ACCN,1,bankdate,:RATN); " +
                "end if; " +
                "END;";
            cmdUpdateRate.Parameters.Add("RAT", OracleDbType.Decimal, textNewRate.ValueDecimal, ParameterDirection.Input);
            cmdUpdateRate.Parameters.Add("ACC", OracleDbType.Decimal, dpt_acc, ParameterDirection.Input);
            cmdUpdateRate.Parameters.Add("ACCN", OracleDbType.Decimal, dpt_acc, ParameterDirection.Input);
            cmdUpdateRate.Parameters.Add("RATN", OracleDbType.Decimal, textNewRate.ValueDecimal, ParameterDirection.Input);

            cmdUpdateRate.ExecuteNonQuery();

            DBLogger.Info("Пользователь установил процентную ставку=" + textNewRate.ValueDecimal.ToString() +
                " по счету = " + dpt_acc.ToString(), "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        Page_Load(sender, e);
    }
}