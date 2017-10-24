using System;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class barsroot_deposit_DepositChangeFrequency : System.Web.UI.Page
{
    private readonly IDbLogger _dbLogger;
    public barsroot_deposit_DepositChangeFrequency()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["dpt_id"] == null || Request["agr_id"] == null || Request["template"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
            else
                _dbLogger.Info("Користувач почав заключення ДУ з кодом " + Request.QueryString["agr_id"] +
                              " по договору №" + Request.QueryString["dpt_id"] + 
                              " з шаблоном " + Request.QueryString["template"], "deposit");

            Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]));

            tbDepositID.Text = dpt.ID.ToString();
            tbCurrencyID.Text = dpt.Currency.ToString();
            tbCurrencyNAME.Text = dpt.CurrencyName;
            tbTypeID.Text = dpt.Type.ToString();
            tbTypeNAME.Text = dpt.TypeName;           
            
            // Параметри депозитного продукту
            FillControls(dpt.Type);

            // Перелік періодичностей
            FillFreqList();
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        _dbLogger.Info("Користувач натиснув кнопку \"Повернутись\" на сорінці зміни періодичності виплати відсотків по депозиту №" + tbDepositID.Text,
            "deposit");

        Response.Redirect("DepositAgreement.aspx?dpt_id=" + Request.QueryString["dpt_id"]);
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(tbFrequencyID.Text))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error_mesage",
                "alert('Не вибрано нову періодичність виплати відсотків!');", true);
        }
        else
        {
            _dbLogger.Info(
                "Користувач натиснув кнопку \"Продовжити\" на сорінці зміни періодичності виплати відсотків по депозиту №" +
                tbDepositID.Text,
                "deposit");

            Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + Request.QueryString["dpt_id"] +
                              "&agr_id=" + Request.QueryString["agr_id"] +
                              "&template=" + Request.QueryString["template"] +
                              "&rnk_tr=" + Request.QueryString["rnk_tr"] +
                              "&freq=" + tbFrequencyID.Text);
        }
    }

    protected void listFrequency_SelectedIndexChanged(object sender, EventArgs e)
    {
        tbFrequencyID.Text = listFrequency.SelectedItem.Value;
    }

    /// <summary>
    /// Параметри депозитного продукту
    /// </summary>
    /// <param name="TypeID">Код виду депозиту</param>
    private void FillControls(Decimal TypeID)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Формируем запрос
            OracleCommand cmdSelectContractParams = new OracleCommand();
            cmdSelectContractParams.Connection = connect;
            cmdSelectContractParams.CommandText = @"select v.freq_k as freq_id, t.type_id, t.type_name
                                                      from dpt_vidd  v
                                                      join dpt_types t on (t.type_id = v.type_id)
                                                     where v.vidd = :p_vidd";

            cmdSelectContractParams.BindByName = true;
            cmdSelectContractParams.Parameters.Add("p_vidd", OracleDbType.Decimal, TypeID, ParameterDirection.Input);

            // Читаем данные запроса
            OracleDataReader rdr = cmdSelectContractParams.ExecuteReader();
            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    tbFrequencyID.Text = rdr.GetOracleDecimal(0).ToString();
                    CompareFrequency.ValueToCompare = rdr.GetOracleDecimal(0).ToString();
                }
                else
                    tbFrequencyID.Text = String.Empty;
                    
                if (!rdr.IsDBNull(1))
                    tbProductID.Text = rdr.GetOracleDecimal(1).ToString();
                else
                    tbProductID.Text = String.Empty;

                if (!rdr.IsDBNull(2))
                    tbProductNAME.Text = rdr.GetOracleString(2).Value;
                else
                    tbProductNAME.Text = String.Empty;
            }
            else
            {
                tbFrequencyID.Text = string.Empty;
                tbProductID.Text = string.Empty;
                tbProductNAME.Text = string.Empty;
            }

            rdr.Close();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Список допустимих періодичностей для даного продукту
    /// </summary>
    protected void FillFreqList()
    {
        dsFreq.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsFreq.SelectCommand = @" SELECT f.freq as freq_id, f.name as freq_name 
                                    FROM bars.freq f
                                   WHERE f.freq in ( SELECT v1.freq_k 
                                                       FROM dpt_vidd v1,
                                                            dpt_vidd v2
                                                      WHERE v1.type_id  = v2.type_id
                                                        AND v1.bsd      = v2.bsd
                                                        AND v1.kv       = v2.kv
                                                        AND v1.freq_k  != v2.freq_k 
                                                        AND v1.duration = v2.duration 
                                                        AND v1.duration_days = v2.duration_days 
                                                     -- AND v1.flag     = 1
                                                        AND v1.comproc  = 0
                                                        AND v2.vidd     = :p_vidd )
                                   ORDER BY 1 ";

        dsFreq.SelectParameters.Add("p_vidd", TypeCode.Int32, tbTypeID.Text);
        listFrequency.DataBind();

        // listFrequency.SelectedValue = tbFrequencyID.Text;

        if ( listFrequency.Items.Count == 1 )
        {
            tbFrequencyID.Text = listFrequency.SelectedItem.Value;
        }
    }
}