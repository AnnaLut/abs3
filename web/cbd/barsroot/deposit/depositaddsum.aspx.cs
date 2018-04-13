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
using Bars.Logger;
using Bars.Exception;
using System.Web.Services;
using Bars.Classes;

/// <summary>
/// Summary description for DepositAddSum.
/// </summary>
public partial class DepositAddSum : Bars.BarsPage
{
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAddSum;

            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=1");

            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                if (Request["agr_id"] == null)
                    Response.Redirect("DepositSearch.aspx?action=agreement&extended=1");
                
                // fast - швидке поповнення вкладу без створення ДУ
                if ((Request["fast"] == null) && (Request["template"] == null))
                    Response.Redirect("DepositSearch.aspx?action=agreement&extended=1");
            }

            // Для депозитів у металах
            Bars.Metals.DepositMetals.ClearData();

            /// Формування процедури створеня додаткової угоди, що виконається 
            /// перед оплатою документа в одній тразакції з оплатою
            String BeforePayProc = String.Empty;
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            String rolecmd = conn.GetSetRoleCommand("DPT_ROLE");

            Deposit dpt;

            if (BankType.GetDptBankType() == BANKTYPE.UPB)
            {
                Boolean other = ((Convert.ToString(Request.QueryString["other"]) == "Y") ? true : false);

                dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]), other);
            }
            else
            {
                dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]));
            }

            dpt_id.Value = dpt.ID.ToString();

            BeforePayProc += rolecmd + "@";

            if (Convert.ToString(Request["fast"]) == "Y")
            {
                BeforePayProc += "begin dpt_web.fill_dpt_payments( " + Convert.ToString(Request["dpt_id"]) + ", :REF ); end;";
            }
            else
            {
                BeforePayProc += "declare " +
                " agr_id dpt_agreements.agrmnt_id%type; " +
                "begin " +
                "  dpt_web.create_agreement( " +
                   Convert.ToString(Request["dpt_id"]) + "," +
                   Convert.ToString(Request["agr_id"]) + "," +
                   (Request["rnk_tr"] == null ? Convert.ToString(dpt.Client.ID) : Convert.ToString(Request["rnk_tr"])) +
                  ",null,null,null,null, #, null,null,null,null,null,null,null,null,null,null, :REF, null, agr_id );" +
                "  dpt_web.fill_dpt_payments( " + Convert.ToString(Request["dpt_id"]) + ", :REF );" +
                "end;";
            }

            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                if (Convert.ToString(Request["fast"]) == "Y")
                {
                    dest_url.Value = "DepositSearch.aspx?action=replenish";
                }
                else
                {
                    /// Для Правекса - направляємось далі
                    String url = "DepositAgreementPrint.aspx?dpt_id=" + dpt_id.Value +
                        "&agr_id=" + Request["agr_id"] + "&template=" + Request["template"];
                    
                    if (Request["rnk_tr"] != null)
                        url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                    dest_url.Value = url;
                }

                AfterPay.Value = BeforePayProc;
            }

            if (AddPaymentEnabled())
            {
                FillControlsFromClass(dpt);
                CheckStopFunction(textMinAddSum.ValueDecimal * 100, Convert.ToDecimal(Kv_B.Value), Nls_A.Value, dpt_id.Value);
            }
            else
                throw new DepositException("Вибраний вид депозитного договору не передбачає поповнення");
        }
    }
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        DateR.ToolTip = Resources.Deposit.GlobalResources.tb22;
        textIntRate.ToolTip = Resources.Deposit.GlobalResources.tb23;
        dtStartContract.ToolTip = Resources.Deposit.GlobalResources.tb24;
        dtEndContract.ToolTip = Resources.Deposit.GlobalResources.tb26;
        textMinAddSum.ToolTip = Resources.Deposit.GlobalResources.tb87;
        textContractAddSum.ToolTip = Resources.Deposit.GlobalResources.tb88;
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
        ;
    }
    #endregion
    /// <summary>
    /// Заполнение контролов страницы из класса депозита
    /// </summary>
    /// <param name="dpt"></param>
    private void FillControlsFromClass(Deposit dpt)
    {
        textDepositNumber.Text = Convert.ToString(dpt.Number);
        textClientName.Text = dpt.Client.Name;
        textContractTypeName.Text = dpt.TypeName;
        textDepositCurrency.Text = dpt.CurrencyName;
        textIntRate.ValueDecimal = dpt.RealIntRate;
        textContractCurrency.Text = dpt.CurrencyISO;
        textMinSumCurrency.Text = dpt.CurrencyISO;
        textClientPasp.Text = dpt.Client.DocSerial + " " + dpt.Client.DocNumber
            + " " + dpt.Client.DocOrg;
        DateR.Date = dpt.Client.BirthDate;
        dtEndContract.Date = dpt.EndDate;
        dtStartContract.Date = dpt.BeginDate;

        // Вклади у БАНКІВСЬКИХ МЕТАЛАХ:
        if (dpt.Currency == 959 || dpt.Currency == 961 || dpt.Currency == 962)
        {
            // сума формується на основі опису злитків
            metalParameters.Visible = true;
            textContractAddSum.Value = "0";
            textContractAddSum.ReadOnly = true;

            // депозити розміщаються і виплачуються тільки через поточні рахунки
            if (dpt.EndDate == DateTime.MinValue)
            {
                TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.YES);
            }
            else
            {
                TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.NO);
            }
        }
        else
        {
            textContractAddSum.ReadOnly = false;
            TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.YES);
        }


        Kv_B.Value = Convert.ToString(dpt.Currency);
        Nls_A.Value = dpt.dpt_nls;

        if (Request["rnk_tr"] != null)
            RNK.Value = Convert.ToString(Request["rnk_tr"]);
        else
            RNK.Value = Convert.ToString(dpt.Client.ID);

        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelMinSum = connect.CreateCommand();
            cmdSelMinSum.CommandText = "select nvl(limit,0), tobopack.gettobocash from dpt_vidd where vidd = :vidd";
            cmdSelMinSum.Parameters.Add("vidd", OracleDbType.Decimal, dpt.Type, ParameterDirection.Input);

            OracleDataReader rdr = cmdSelMinSum.ExecuteReader();

            if (!rdr.Read())
                throw new DepositException("Не найдена информация о депозите №" + dpt.ID);

            Decimal limit = rdr.GetOracleDecimal(0).Value;
            
            if (!rdr.IsDBNull(1))
                Nls_B.Value = rdr.GetOracleString(1).Value;

            rdr.Close();
            rdr.Dispose();

            if (limit != Decimal.MinValue)
                textMinAddSum.ValueDecimal = limit;
            else
                textMinAddSum.ValueDecimal = 0;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Краткая проверка депозита на пополняемость
    /// </summary>
    /// <param name="dpt">депозит</param>
    /// <returns>возможно или нет пополнение</returns>
    private bool AddPaymentEnabled()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetRight = connect.CreateCommand();
            cmdGetRight.CommandText = @"select o.tt
                from dpt_tts_vidd v, op_rules o, dpt_deposit d 
                where v.vidd=d.vidd and v.tt=o.tt and o.TAG = 'DPTOP' and o.val = '1' 
                and o.tt not like 'DU%' and o.tt not like 'SC%'
                and d.deposit_id = :dpt_id";
            cmdGetRight.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id.Value, ParameterDirection.Input);

            /// Якщо не дозволено поповнення
            if (String.IsNullOrEmpty(Convert.ToString(cmdGetRight.ExecuteScalar())))
                return false;

            DBLogger.Debug("Вид депозитного договора № " + dpt_id.Value + 
                " допускает операцию пополнения.","deposit");

            return true;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Полная проверка депозита на пополняемость
    /// </summary>
    /// <param name="SUM">Сумма</param>
    /// <param name="dpt">Депозит</param>
    [WebMethod(EnableSession = true)]
    public static void CheckStopFunction(Decimal SUM, Decimal Kv, String Nls, String dpt_id)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCheckStopFunc = connect.CreateCommand();
            cmdCheckStopFunc.CommandText = "select f_dpt_stop(:kod,:kv,:nls,:s,bankdate) from dual";

            // Стоп правило на срок поповнення
            cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 1, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("kv", OracleDbType.Decimal, Kv, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("s", OracleDbType.Decimal, SUM, ParameterDirection.Input);

            Decimal result = Convert.ToDecimal(Convert.ToString(cmdCheckStopFunc.ExecuteScalar()));

            // Стоп правило на мінімальну суму поповнення
            cmdCheckStopFunc.Parameters.Clear();
            cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 2, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("kv", OracleDbType.Decimal, Kv, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("s", OracleDbType.Decimal, SUM, ParameterDirection.Input);

            result = Convert.ToDecimal(Convert.ToString(cmdCheckStopFunc.ExecuteScalar()));

            // Стоп правило на максимальну суму поповнення
            cmdCheckStopFunc.Parameters.Clear();

            if (BankType.GetDptBankType() == BANKTYPE.UPB)
                cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 23, ParameterDirection.Input);
            else
                cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 24, ParameterDirection.Input);

            cmdCheckStopFunc.Parameters.Add("kv", OracleDbType.Decimal, Kv, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("s", OracleDbType.Decimal, SUM, ParameterDirection.Input);

            result = Convert.ToDecimal(Convert.ToString(cmdCheckStopFunc.ExecuteScalar()));

            DBLogger.Debug("Стоп функция на пополнение счёта для депозита № " + dpt_id +
                " завершилась. Текущий депозитный договор можно пополнять.", "deposit");
            
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    
    /// <summary>
    /// Формування сум (в унціях та грамах) поповнення депозиту на основі інфр. про злитки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvAddSum_DataBound(object sender, EventArgs e)
    {
        textContractAddSum.Value = Bars.Metals.DepositMetals.SumOunce();
        ContractAddSumGrams.Value = Convert.ToString(Bars.Metals.DepositMetals.Sum());
    }

    //*************************
    //*** Робота з FormView ***
    //*************************

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvAddSum_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvAddSum.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvAddSum_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvAddSum.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvAddSum_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvAddSum.DataBind();
    }
    
    /// <summary>
    /// Заповнення значення поля проба металу "по замовчуванню"
    /// </summary>
    /// <param name="sender">об'єст</param>
    /// <param name="e">подія</param>
    protected void PROBA_I_PreRender(object sender, EventArgs e)
    {
        if (((Bars.Web.Controls.NumericEdit)sender).Value == 0)
            ((Bars.Web.Controls.NumericEdit)sender).Text = "999.9";
    }
}
