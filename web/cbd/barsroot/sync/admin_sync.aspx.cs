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
using ibank.core;
using ibank.objlayer;
using System.Collections.Generic;
using System.Web.Configuration;
using Oracle.DataAccess.Types;
using Bars;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using System.Globalization;

public partial class admin_sync : BarsPage
{
    String role_name = "IBANK_ADMIN";
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        dsCapture.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCapture.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);
        dsCapture.SelectCommand = @"select capture_name, status, state, startup_time, state_changed_time, status_change_time, error_message 
                                    from barsaq.v_cb_capture";
        gvCapture.DataBind();
        
        dsApply.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsApply.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);
        dsApply.SelectCommand = @"select apply_name, status, status_change_time, apply_time, error_message
                                  from barsaq.v_cb_apply";
        gvApply.DataBind();
        
        dsSync.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsSync.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);
        dsSync.SelectCommand = @"select table_name, sync_sql, parameter_name, sync_date, status, status_comment, start_time, finish_time, error_message, job_id 
                                    from barsaq.v_sync_tables_info";
        gvSync.DataBind();
        
        base.OnPreRender(e);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gvCapture_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "START_CAPTURE")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String capture_name = e.CommandArgument.ToString();

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("capture_name", DB_TYPE.Varchar2, capture_name, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.start_capture(:capture_name); end;");

                string msg = "alert('Процес усіпшно стартований');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "start_capture", msg, true); 
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else if (e.CommandName == "STOP_CAPTURE")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String capture_name = e.CommandArgument.ToString();

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("capture_name", DB_TYPE.Varchar2, capture_name, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.stop_capture(:capture_name); end;");

                string msg = "alert('Процес усіпшно зупинений');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "stop_capture", msg, true);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvApply_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "START_APPLY")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String apply_name = e.CommandArgument.ToString();

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("apply_name", DB_TYPE.Varchar2, apply_name, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.start_apply(:apply_name); end;");

                string msg = "alert('Процес усіпшно стартований');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "start_apply", msg, true);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else if (e.CommandName == "STOP_APPLY")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String apply_name = e.CommandArgument.ToString();

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("apply_name", DB_TYPE.Varchar2, apply_name, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.stop_apply(:apply_name); end;");

                string msg = "alert('Процес усіпшно зупинений');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "stop_apply", msg, true);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvSync_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "SYNC")
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("uk-UA");

            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String[] obj = e.CommandArgument.ToString().Split('-');

            String command = obj[0];
            String parameter = obj[1];
            DateTime? p_selectedDate = ((controls_DateEdit)gvSync.Rows[Convert.ToInt32(obj[2])].Cells[1].FindControl("start_date")).SelectedDate;
            String sync_table = obj[3];
            
            InitOraConnection();
            try
            {
                SetRole(role_name);
                if (!String.IsNullOrEmpty(parameter))
                {
                    ClearParameters();
                    SetParameters(parameter, DB_TYPE.Date, p_selectedDate, DIRECTION.Input);
                    SetParameters(parameter, DB_TYPE.Varchar2, sync_table, DIRECTION.Input);
                    SQL_NONQUERY("update barsaq.sync_tables set sync_date = :sync_date where table_name = :table_name");

                    ClearParameters();
                    SetParameters(parameter, DB_TYPE.Date, p_selectedDate, DIRECTION.Input);
                }

                SQL_NONQUERY(command);

                string msg = "alert('Синхронізація успішно запущена');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "start_sync", msg, true);

                gvSync.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
}
