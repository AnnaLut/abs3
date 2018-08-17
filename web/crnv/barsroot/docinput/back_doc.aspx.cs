using System;
using System.Data;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Collections;
using System.Web.UI;
using Oracle.DataAccess.Types;
using Bars.Exception;

public partial class sberutls_back_doc : Bars.BarsPage
{
    Decimal? Ref_;
    private void ShowError(String ErrorText, bool js_error = true)
    {
        if (js_error)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
        else
            throw new BarsException(ErrorText);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
            ViewState.Add("PREV_URL", "/barsroot/docinput/back_doc.aspx");
            LinREF.Visible = lbRef.Visible = false;
            LinREF.Text = "0";
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            cmd.ExecuteNonQuery();


            Int64? p_ref_;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "p_ref_search";
            p_ref_ = Convert.ToInt64(REFBACK.Value);
            cmd.Parameters.Add("p_ref", OracleDbType.Int64, p_ref_, ParameterDirection.InputOutput);
            cmd.ExecuteNonQuery();
            Ref_ = (cmd.Parameters["p_ref"].Status == OracleParameterStatus.Success ? ((OracleDecimal)cmd.Parameters["p_ref"].Value).Value : (Decimal?)null);
            // pb_del.Visible = true;
            hideREF.Value = Ref_;
            if (Ref_ != null)
            {
                LinREF.Visible = true;
                lbRef.Visible = true;
                lbRef.Text = "Документ Реф. №: ";
                LinREF.Text = Convert.ToString(Ref_);
                LinREF.NavigateUrl = "/barsroot/documentview/default.aspx?ref=" + Convert.ToString(Ref_);


                LinREF.Attributes.Add("onclick",
                  "javascript:" +
                  "window.showModalDialog(" +
                  LinREF.ClientID + ".href," +
                  "'ModalDialog'," +
                  "'dialogHeight:600px; dialogLeft:100px; dialogTop:100px; dialogWidth:1100px; help:no; resizable:yes; scroll:yes;'" +
                  ");" +
                  "return false;"
                  );
            }

        }
        finally
        {
            con.Close();
            con.Dispose();
        }


    }

    protected void btBack_Click(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {
            cmd.ExecuteNonQuery();

            Decimal? ErrCode;
            String ErrMessage;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "P_BACK_DOK";

            cmd.Parameters.Add("p_ref", OracleDbType.Int64, (hideREF.Value == null) ? 0 : Convert.ToDecimal(hideREF.Value), ParameterDirection.Input);
            cmd.Parameters.Add("p_lev", OracleDbType.Int64, '5', ParameterDirection.Input);
            cmd.Parameters.Add("p_reason", OracleDbType.Int64, '5', ParameterDirection.Input);
            cmd.Parameters.Add("p_par1", OracleDbType.Int64, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_par2", OracleDbType.Varchar2, null, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            ErrCode = ((OracleDecimal)cmd.Parameters["p_par1"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_par1"].Value).Value;
            ErrMessage = ((OracleString)cmd.Parameters["p_par2"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["p_par2"].Value).Value;


            // анализируем результат
            if (ErrCode.HasValue)
            {
                ShowError(ErrMessage, false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Документ " + hideREF.Value + " сторновано!');  location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
                ViewState.Remove("PREV_URL");
            }
           
        }
        finally
        {
            con.Close();
            con.Dispose();

        }
    }
}