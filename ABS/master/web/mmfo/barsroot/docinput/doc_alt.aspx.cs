using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using System.Drawing;

public partial class docinput_doc_alt : System.Web.UI.Page
{    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
            fvDocAlt.ChangeMode(FormViewMode.Insert);        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        gvAltDocs.DataBind();

        GetSumCount();

        base.OnPreRender(e);
    }
    /// <summary>
    /// 
    /// </summary>
    override protected void OnInit(EventArgs e)
    {
        dsDocAlt.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDocAlt.PreliminaryStatement = "begin " + Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("PYOD001") + 
            " begin barsweb_session.set_session_id('" + HttpContext.Current.Session.SessionID + "'); end;" + " end;";

        dsDocAltList.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDocAltList.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("PYOD001");

        base.OnInit(e);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btPay_Click(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection(Context);

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin " + Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("PYOD001") +
            " begin barsweb_session.set_session_id('" + HttpContext.Current.Session.SessionID + "'); end;" + " end;";
            cmd.ExecuteNonQuery();

            cmd.CommandText = "begin alt_payments.pay_documents; alt_payments.clean_up; end;";
            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetSumCount()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection(Context);

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("PYOD001");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "select nvl(sum(nvl(s,0)),0), count(*) from vpay_alt";
            OracleDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    textSum.Text = rdr.GetOracleDecimal(0).Value.ToString("### ### ### ### ### ### ### ##0.00");
                if (!rdr.IsDBNull(1))
                    textCount.Text = rdr.GetOracleDecimal(1).Value.ToString();
            }

            if (!rdr.IsClosed)
                rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvAltDocs_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        fvDocAlt.ChangeMode(FormViewMode.Edit);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvAltDocs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow row = e.Row;

            if (Convert.ToString(((DataRowView)e.Row.DataItem).Row["nmsb"]) == String.Empty)
                row.ForeColor = Color.Red;
            else if (Convert.ToString(((DataRowView)e.Row.DataItem).Row["cep_acc"]) != String.Empty)
                row.ForeColor = Color.Green;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvDocAlt_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvAltDocs.SelectedIndex = -1;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvDocAlt_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvAltDocs.SelectedIndex = -1;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvDocAlt_ItemDeleting(object sender, FormViewDeleteEventArgs e)
    {
        dsDocAlt.DeleteCommand = "delete from vpay_alt where id = " + gvAltDocs.SelectedValue;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvDocAlt_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvAltDocs.SelectedIndex = -1;        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvDocAlt_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
            gvAltDocs.SelectedIndex = -1;        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void et_dsPretenders_DataBinding(object sender, EventArgs e)
    {
        if (sender != null)
        {
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("PYOD001");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void et_dsPretenders_Init(object sender, EventArgs e)
    {
        if (sender != null)
        {
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("PYOD001");
        }
    }
}
