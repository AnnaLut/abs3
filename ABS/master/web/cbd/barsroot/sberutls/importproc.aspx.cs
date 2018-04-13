using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Runtime.InteropServices;
using System.Text;
using Bars.Configuration;
using Bars.DataComponents;
using Bars.Oracle;
using Bars.Classes;

public partial class sberutls_importproc : Bars.BarsPage
{
    private const string SESS_REF_NAME = "impref";
    private const string ERR_ONLY_ONE_ROW_ACCEPTED = "Для редагування потрiбно вибрати один рядок";
    private const string SESS_READONLY_TAG = "RO";
    private void configureDs()
    {
        if (Request["tp"].ToString() == "1")
        {
            ds.SelectCommand = "select * from v_xmlimpdocs_ui where status=:status and userid = user_id order by impref desc";
            dsFilter.SelectCommand = "select status, descript from xml_impstatus";
        }
        if (Request["tp"].ToString() == "2")
        {
            ds.SelectCommand = "select * from v_xmlimpdocs_ui where status=:status order by impref desc";
            dsFilter.SelectCommand = "select status, descript from xml_impstatus where status not in (0,1,2)";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["tp"] == null)
            throw new ArgumentException("Invalid parameters passed");
        //заполнить параметры datasource
        ds.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("OPER000");
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        configureDs();
        dsFilter.PreliminaryStatement = ds.PreliminaryStatement;
        dsFilter.ConnectionString = ds.ConnectionString;
        dsFilter.DataBind();
        //заголовок
        Session[SESS_REF_NAME] = null;
        lblMsg.Text = "";
        lblRes.Text = "";
    }

    protected override void OnPreRender(EventArgs e)
    {
        gv.DataBind();
        base.OnPreRender(e);
        Session[SESS_READONLY_TAG] = ddlFilter.SelectedIndex == 3 || ddlFilter.SelectedIndex == 4 ? "1" : null;
    }
    protected void ds_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        object obj = ddlFilter.SelectedValue;
        if (obj == null || obj.ToString() == "")
            obj = Request["tp"].ToString() == "1" ? 0 : 4;
        OracleParameter par = new OracleParameter("status", OracleDbType.Decimal, obj, System.Data.ParameterDirection.Input);
        e.Command.Parameters.Add(par);
    }

    private void goProc(String procName)
    {
        decimal errcode = 0;
        decimal impref = 0;
        InitOraConnection();
        try
        {
            SetRole("OPER000");
            int errCnt = 0;
            int okCnt = 0;
            foreach (int row in gv.SelectedRows)
            {
                impref = Convert.ToDecimal(gv.DataKeys[row].Values[0]);
                ClearParameters();
                SetParameters("p_impref", DB_TYPE.Varchar2, impref, DIRECTION.Input);
                SetParameters("p_errcode", DB_TYPE.Decimal, errcode, DIRECTION.Output);
                SQL_NONQUERY(
                    "begin " +
                    "  bars_xmlklb_imp." + procName + "( " +
                    "      p_impref  => :p_impref,  " +
                    "      p_errcode => :p_errcode); " +
                    " end;");
                if ("0" == GetParameter("p_errcode").ToString())
                    okCnt++;
                else
                    errCnt++;

            }
            lblRes.Text = String.Format("Оброблено без помилок: {0}, з помилками {1}",
                okCnt.ToString(), errCnt.ToString());
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btnVal_Click(object sender, EventArgs e)
    {
        goProc("validate_doc");
    }
    protected void btnPay_Click(object sender, EventArgs e)
    {
        goProc("pay_doc");
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        goProc("delete_doc");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (gv.SelectedRows.Count == 1)
        {
            Session[SESS_REF_NAME] = Convert.ToDecimal(gv.DataKeys[gv.SelectedRows[0]].Values[0]);
        }
        else
        {
            lblMsg.Text = ERR_ONLY_ONE_ROW_ACCEPTED;
            return;
        }

        Response.Redirect("importproced.aspx");
    }
}
