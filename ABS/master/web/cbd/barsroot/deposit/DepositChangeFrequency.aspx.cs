using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class barsroot_deposit_DepositChangeFrequency : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["dpt_id"] == null || Request["agr_id"] == null || Request["template"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
            else
                DBLogger.Info("Користувач почав заключення ДУ з кодом " + Request.QueryString["agr_id"] +
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
        DBLogger.Info("Користувач натиснув кнопку \"Повернутись\" на сорінці зміни періодичності виплати відсотків по депозиту №" + tbDepositID.Text,
            "deposit");

        Response.Redirect("DepositAgreement.aspx?dpt_id=" + Request.QueryString["dpt_id"]);
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Продовжити\" на сорінці зміни періодичності виплати відсотків по депозиту №" + tbDepositID.Text,
           "deposit");

        Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + Request.QueryString["dpt_id"] +
            "&agr_id=" + Request.QueryString["agr_id"] +
            "&template=" + Request.QueryString["template"] +
            "&rnk_tr=" + Request.QueryString["rnk_tr"] +
            "&freq=" + tbFrequencyID.Text );
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

        dsFreq.SelectCommand = @" SELECT f.freq as freq_id, f.name as freq_name FROM bars.freq f
                                   WHERE f.freq in ( SELECT v.freq_k FROM dpt_vidd v 
                                                      WHERE (v.type_id, v.bsd, v.kv) in (SELECT type_id, bsd, kv FROM dpt_vidd WHERE vidd = :p_vidd)
                                                        AND v.flag = 1
                                                        AND v.comproc = 0 )
                                   ORDER BY 1 ";

        dsFreq.SelectParameters.Add("p_vidd", TypeCode.Int32, tbTypeID.Text);
        listFrequency.DataBind();

        listFrequency.SelectedValue = tbFrequencyID.Text;
    }
}