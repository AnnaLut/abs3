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
using Bars.Oracle;
using Bars.Classes;
using Bars.DataComponents;

public partial class docinput_docexportback : Bars.BarsPage
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        configureCurrentDs();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    /// <summary>
    /// Возвращает роль в зависимости от параметра в QueryString
    /// </summary>
    private string currentRoleName()
    {
        switch (Request["type"])
        {
            case "1": return "WR_EDOCS_BACK_ADM";
                break;
            case "2": return "WR_EDOCS_BACK";
                break;
            default: return "START1";
        }
    }

    /// <summary>
    /// Возвращает команду установки роли в зависимости от параметра в запросе
    /// </summary>
    private string currentSetRoleCmd()
    {
        return String.Format(@"begin bars_role_auth.set_role('{0}'); end;", currentRoleName());
    }

    /// <summary>
    /// Возвращает текущий datasource в зависимости от параметра Type в QueryString
    /// </summary>
    private BarsSqlDataSource currentDs()
    {
        switch (Request["type"])
        {
            case "1":
                return dsAll;
                break;
            case "2": 
                return ds;
                break;
            default: return null;
        }
    }

    /// <summary>
    /// В зависимости от параметра type в QueryString выбирает нужный DataSource
    /// </summary>
    private void configureCurrentDs()
    {
        BarsSqlDataSource currDs = currentDs();
        if (null != currDs)
        {
            gv.DataSourceID = currDs.ID;
            currDs.PreliminaryStatement = currentSetRoleCmd();
            currDs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        }
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
            if (chk != null)
            {
                chk.Attributes.Add("onclick", "SelectRow()");
            }
            e.Row.Attributes.Add("onclick", "SelectRow()");
        }
    }

    protected void ImageTextButton1_Command(object sender, CommandEventArgs e)
    {
        decimal docRef = 0;
        bool docRefFound = false;
        if ("storno" == e.CommandName.ToLower())
        {
            foreach (GridViewRow gr in gv.Rows)
            {
                CheckBox chk = (CheckBox)gr.FindControl("chkSelect");
                if (chk == null) continue;
                if (!chk.Checked) continue;
                if (gv.DataKeys[gr.RowIndex]["ref"] != null)
                {
                    docRef = Convert.ToDecimal(gv.DataKeys[gr.RowIndex]["ref"].ToString());
                    docRefFound = true;
                }
                break;
            }
        }
        if (docRefFound)
        {
            InitOraConnection();
            try
            {
                SetRole(currentRoleName());
                ClearParameters();
                SetParameters("ref", DB_TYPE.Decimal, docRef, DIRECTION.Input);
                SetParameters("lev", DB_TYPE.Decimal, 5, DIRECTION.Input);
                SetParameters("reason_id", DB_TYPE.Decimal, hid_SR.Value, DIRECTION.Input);
                SetParameters("par2", DB_TYPE.Decimal, 0, DIRECTION.Output);
                SetParameters("par3", DB_TYPE.Varchar2, 0, DIRECTION.Output);
                SQL_NONQUERY("begin p_back_dok(:ref, :lev, :reason_id, :par2, :par3); end;");
                gv.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
}
