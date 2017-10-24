using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;
using System.Threading;

public partial class money_transfer_mt_search : Bars.BarsPage
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // если параметры передали в урл то наполняем
        if (!IsPostBack && Request.Params.Get("magicword") != null)
        {
            tbMagicWord.Text = Request.Params.Get("magicword");
            ibSearch_Click(sender, null);
        }
    }
    protected void ibSearch_Click(object sender, ImageClickEventArgs e)
    {
        Decimal? Ref = 0;
        Decimal? Kv = 0;
        Decimal? Sum = 0;
        String Nazn = "";

        Decimal? ResCode = 0;
        String ResText = "";

        Search(tbMagicWord.Text.Trim(),  out Ref, out Kv, out Sum, out Nazn, out ResCode, out ResText);

        // обработка результата
        if (ResCode == 0)
        {
            mvResult.ActiveViewIndex = 0;
            lbOkText.Text = ResText;
        }
        else
        {
            mvResult.ActiveViewIndex = 1;
            lbErrorText.Text = ResText;
        }
    }
    protected void btPay_Click(object sender, EventArgs e)
    {
        Decimal? Ref = 0;
        Decimal? Kv = 0;
        Decimal? Sum = 0;
        String Nazn = "";

        Decimal? ResCode = 0;
        String ResText = "";

        Search(tbMagicWord.Text.Trim(), out Ref, out Kv, out Sum, out Nazn, out ResCode, out ResText);

        String MT_P_TT = "";
        String MT_SREF = "";
        String FIO_SEND = "";
        String FIO_RECIEV = "";
        String PASP = "";
        String PASPN = "";
        String WDOC = "";
        String ADRES = "";
        String ATRT = "";
        String REZID = "";
        String DT_R = "";

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand com = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_MT"), con);

        if (con.State == ConnectionState.Closed) con.Open();
        try
        {
            // установка роли
            com.ExecuteNonQuery();

            com.CommandType = CommandType.Text;
            com.CommandText = "select mt_pack.f_mt_p_tt from dual";
            MT_P_TT = Convert.ToString(com.ExecuteScalar());
            if (String.IsNullOrEmpty(MT_P_TT)) throw new Bars.Exception.BarsException("Не задано операцію для видачі");

            com.CommandType = CommandType.Text;
            com.CommandText = "select trim(mt_pack.f_mt_sref) from dual";
            MT_SREF = Convert.ToString(com.ExecuteScalar());
            if (String.IsNullOrEmpty(MT_SREF)) throw new Bars.Exception.BarsException("Не задано код реквізита Референс начальной операции");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select doc from mt_transfers where ref=:ref2";
            com.Parameters.Add("ref2", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            WDOC = Convert.ToString(com.ExecuteScalar());
            if (String.IsNullOrEmpty(WDOC)) throw new Bars.Exception.BarsException("Не заповнено реквізит WDOC2");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='FIO'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            FIO_SEND = Convert.ToString(com.ExecuteScalar());
            if (String.IsNullOrEmpty(FIO_SEND)) throw new Bars.Exception.BarsException("Не заповнено реквізит FIO");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='FIO_2'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            FIO_RECIEV = Convert.ToString(com.ExecuteScalar());
            if (String.IsNullOrEmpty(FIO_RECIEV)) throw new Bars.Exception.BarsException("Не заповнено реквізит FIO_2");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='PASP'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            PASP = Convert.ToString(com.ExecuteScalar());
            // if (String.IsNullOrEmpty(PASP)) throw new Bars.Exception.BarsException("Не заповнено реквізит PASP");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='PASPN'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            PASPN = Convert.ToString(com.ExecuteScalar());
           // if (String.IsNullOrEmpty(PASPN)) throw new Bars.Exception.BarsException("Не заповнено реквізит PASPN");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='ADRES'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            ADRES = Convert.ToString(com.ExecuteScalar());
           // if (String.IsNullOrEmpty(ADRES)) throw new Bars.Exception.BarsException("Не заповнено реквізит ADRES");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='ATRT'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            ATRT = Convert.ToString(com.ExecuteScalar());
            // if (String.IsNullOrEmpty(ATRT)) throw new Bars.Exception.BarsException("Не заповнено реквізит ATRT");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='REZID'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            REZID = Convert.ToString(com.ExecuteScalar());
            if (String.IsNullOrEmpty(REZID)) throw new Bars.Exception.BarsException("Не заповнено реквізит REZID");

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select value from operw where ref=:ref_ and tag='DT_R'";
            com.Parameters.Add("ref_", OracleDbType.Varchar2, 100, Ref, ParameterDirection.Input);
            DT_R = Convert.ToString(com.ExecuteScalar());
            //if (String.IsNullOrEmpty(DT_R)) throw new Bars.Exception.BarsException("Не заповнено реквізит DT_R");


        }
        finally
        {
            con.Close();
        }

        // переходим на класс ввода
        string sDocInputUrl = "/barsroot/DocInput/DocInput.aspx?";
        sDocInputUrl += "tt=" + MT_P_TT;
        // по просьбе Т.И. Маршавиной убрали подстановку референса исходного док.
        // sDocInputUrl += "&nd=" + Ref.ToString();
        sDocInputUrl += "&reqv_" + MT_SREF + "=" + Ref.ToString();
        sDocInputUrl += "&reqv_FIO="   + HttpUtility.UrlEncode(FIO_SEND.Replace("'","`"));
        sDocInputUrl += "&reqv_FIO_2=" + HttpUtility.UrlEncode(FIO_RECIEV);
        sDocInputUrl += "&reqv_WDOC2=" + HttpUtility.UrlEncode(WDOC);
        sDocInputUrl += "&reqv_PASP="  + HttpUtility.UrlEncode(PASP);
        sDocInputUrl += "&reqv_PASPN=" + HttpUtility.UrlEncode(PASPN);
        sDocInputUrl += "&reqv_ADRES=" + HttpUtility.UrlEncode(ADRES);
        sDocInputUrl += "&reqv_ATRT="  + HttpUtility.UrlEncode(ATRT);
        sDocInputUrl += "&reqv_REZID=" + HttpUtility.UrlEncode(REZID);
        sDocInputUrl += "&reqv_DT_R=" + HttpUtility.UrlEncode(DT_R);
        sDocInputUrl += "&Kv_A=" + Kv.ToString();
        sDocInputUrl += "&Kv_B=" + Kv.ToString();
        sDocInputUrl += "&SumC_t=" + Sum.ToString();
        sDocInputUrl += "&nazn=" + HttpUtility.UrlEncode(Nazn);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "show_pay_dialog", "ShowPayDialog('" + sDocInputUrl + "')", true);
    }
    # endregion

    # region Приватные методы
    private void Search(String MagicWord,  out Decimal? Ref, out Decimal? Kv, out Decimal? Sum, out String Nazn, out Decimal? ResCode, out String ResText)
    {
        Ref = 0;
        Kv = 0;
        Sum = 0;
        Nazn = "";

        ResCode = 0;
        ResText = "";

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand com = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_MT"), con);

        if (con.State == ConnectionState.Closed) con.Open();
        try
        {
            // установка роли
            com.ExecuteNonQuery();

            com.CommandType = CommandType.StoredProcedure;
            com.CommandText = "mt_pack.p_search";
            com.Parameters.Clear();
            com.Parameters.Add("p_magicword", OracleDbType.Varchar2, 100, MagicWord, ParameterDirection.Input);
            com.Parameters.Add("p_ref", OracleDbType.Decimal, 100, Ref, ParameterDirection.Output);
            com.Parameters.Add("p_kv", OracleDbType.Decimal, 100, Kv, ParameterDirection.Output);
            com.Parameters.Add("p_sum", OracleDbType.Decimal, 100, Sum, ParameterDirection.Output);
            com.Parameters.Add("p_nazn", OracleDbType.Varchar2, 4000, Nazn, ParameterDirection.Output);
			
            com.Parameters.Add("p_rescode", OracleDbType.Decimal, 100, ResCode, ParameterDirection.Output);
            com.Parameters.Add("p_restext", OracleDbType.Varchar2, 4000, ResText, ParameterDirection.Output);
            com.ExecuteNonQuery();

            Ref = (com.Parameters["p_ref"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["p_ref"].Value).Value : (Decimal?)null);
            Kv = (com.Parameters["p_kv"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["p_kv"].Value).Value : (Decimal?)null);
            Sum = (com.Parameters["p_sum"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["p_sum"].Value).Value : (Decimal?)null);
            Nazn = (com.Parameters["p_nazn"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["p_nazn"].Value).Value : (String)null);

            ResCode = (com.Parameters["p_rescode"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["p_rescode"].Value).Value : (Decimal?)null);
            ResText = (com.Parameters["p_restext"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["p_restext"].Value).Value : (String)null);
        }
        finally
        {
            con.Close();
        }
    }
    # endregion
}