using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class deposit_DepositApplicantsToImmobile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected override void OnInit(EventArgs e)
    {
        dsApplicants.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

        base.OnInit(e);
    }

    /// <summary>
    /// Відмітики усі депозити
    /// </summary>
    protected void btnCheckAll_Click(object sender, EventArgs e)
    {
        ToggleCheckState(true);

        DBLogger.Info("Користувач відмітив усі депозити для перенесення в нерухомі.", "deposit");
    }

    /// <summary>
    /// Зняти всі відмітки 
    /// </summary>
    protected void btnUncheckAll_Click(object sender, EventArgs e)
    {
        ToggleCheckState(false);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Checked"></param>
    private void ToggleCheckState(Boolean Checked)
    {
        foreach (GridViewRow row in gvApplicants.Rows)
        {
            CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;

            cbSelect.Checked = Checked;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    protected void btnImmobile_Click(object sender, EventArgs e)
    {
        /*
        DBLogger.Info("Користувач ініціював перенесення депозитів у картотеку нерухомих.", "deposit");
        
        foreach (GridViewRow row in gvApplicants.Rows)
        {
            CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;

            if (cbSelect.Checked)
            {
                Decimal DepositID = Convert.ToDecimal(gvApplicants.DataKeys[row.DataItemIndex]["DPT_ID"]);

                OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

                try
                {
                    OracleCommand cmd = connect.CreateCommand();

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "dpt_web.auto_move2immobile";
                    cmd.BindByName = true;

                    cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
                    cmd.Parameters.Add("p_runid", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    cmd.Parameters.Add("p_bdate", OracleDbType.Date, null, ParameterDirection.Input);

                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    if (connect.State != ConnectionState.Closed)
                    {
                        connect.Close();
                        connect.Dispose();
                    }
                }
            }
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "MoAgreement_Done", "alert('Перенесення депозитів у нерухомі виконано!'); location.replace(location.href);", true);
        */

        List<Int32> DepositList = new List<Int32>();

        foreach (GridViewRow row in gvApplicants.Rows)
        {
            CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;

            if (cbSelect.Checked)
            {                    
                Int32 idx = row.DataItemIndex - gvApplicants.PageIndex * gvApplicants.PageSize;

                DepositList.Add(Convert.ToInt32(gvApplicants.DataKeys[idx]["DPT_ID"]));
            }
        }

        if (DepositList.Count > 0)
        {
            DBLogger.Info("Користувач ініціював перенесення " + DepositList.Count.ToString() + " депозитних договорів у картотеку нерухомих.", "deposit");

            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "barsweb_session.set_session_id";
                cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, ParameterDirection.Input).Value = Session.SessionID;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "dpt_web.auto_move2immobile";
                cmd.BindByName = true;

                OracleParameter list = new OracleParameter("p_dptid", OracleDbType.Decimal, ParameterDirection.Input);
                list.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                list.Value = DepositList.ToArray();
                list.Size = DepositList.Count;

                cmd.Parameters.Add(list);
                cmd.Parameters.Add("p_runid", OracleDbType.Decimal, 0, ParameterDirection.Input);
                cmd.Parameters.Add("p_bdate", OracleDbType.Date, null, ParameterDirection.Input);
                cmd.ExecuteNonQuery();

                String errors = null;

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select barsweb_session.get_varchar2('ERRORS') from dual";

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        errors = rdr.GetOracleString(0).Value;
                }
                
                if (String.IsNullOrEmpty(errors))
                {                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "MoAgreement_Done", "alert('Перенесення депозитів у картотеку нерухомих виконано!'); location.replace(location.href);", true);
                }
                else
                {
                    String dlg = "window.showModalDialog('dialog.aspx?type=alert&message=" + HttpUtility.UrlEncode(errors);

                    dlg += "','','dialogWidth:450px;dialogHeight:250px;center:yes;edge:sunken;help:no;status:no;'); ";

                    dlg += "location.replace(location.href);";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "MoAgreement_Done", dlg , true);
                }
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('Не відмічено жодного депозитного договору!');", true);
            return;
        }
    }

    protected void cbSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cbSelectAll = (CheckBox)sender;

        // CheckBox cbSelectAll = gvApplicants.HeaderRow.FindControl("cbSelectAll") as CheckBox;

        if (cbSelectAll.Checked)
        {
            ToggleCheckState(true);
        }
        else
        {
            ToggleCheckState(false);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="source">string in CP1251</param>
    ///// <returns>string in UTF8</returns>
    //private string Win1251ToUTF8(string source)
    //{
    //    System.Text.Encoding win1251 = System.Text.Encoding.GetEncoding("Windows-1251");
    //    System.Text.Encoding utf8 = System.Text.Encoding.GetEncoding("UTF-8");

    //    byte[] win_bytes = win1251.GetBytes(source);
    //    byte[] utf_bytes = System.Text.Encoding.Convert(win1251, utf8, win_bytes);

    //    return System.Text.Encoding.UTF8.GetString(utf_bytes);
    //}
}