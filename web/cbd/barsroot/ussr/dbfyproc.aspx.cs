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
using Oracle.DataAccess.Types;
using System.Data.Common;
using Bars.Classes;
using Bars.Logger;
using Bars.Configuration;


public partial class ussr_dbfyproc : Bars.BarsPage
{
    public string mode = String.Empty;
    private string whereStmt = String.Empty;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRU.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        mode = null != Request["mode"] ? Request["mode"] : String.Empty;
        if (null != Session["curPageSize"])
            ds.MaximumRows = Convert.ToInt32(Session["curPageSize"]);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        btnAnalis.Visible = mode == "1";
        btnKorr.Visible = mode == "1";
        btnRest.Visible = mode == "1";
        btnPostAnalis.Visible = mode == "1";
        btnCalc.Visible = mode == "2";
        btnSavePidtv.Visible = mode == "2";
        //gv.Columns[4].Visible = mode == "2";
        if ("2" == mode) { lblTitle.InnerText = "Формування платежів за \"Y\"-файлами"; }

        if (!IsPostBack)
            reopenDataSource();

    }

    protected override void OnLoadComplete(EventArgs e)
    {
        base.OnLoadComplete(e);
    }

    protected void ds_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {

    }

    protected override System.Collections.Specialized.NameValueCollection DeterminePostBackMode()
    {
        System.Collections.Specialized.NameValueCollection postbackData;
        postbackData = base.DeterminePostBackMode();
        if (null != postbackData)
        {
            bool gvFound = false;
            string[] data = postbackData.ToString().Split('&');
            foreach (string s in data)
            {
                string[] pair = s.Split('=');
                if (pair[0] == "__EVENTTARGET" && pair[1] == gv.ID)
                    gvFound = true;
                if (pair[0] == "__EVENTARGUMENT" && gvFound && pair[1].Replace("%24", "$").Split('$')[1] == "PageSizeBox")
                    Session["curPageSize"] = Convert.ToInt32(pair[1].Replace("%24","$").Split('$')[2]) + 1;
            }
        }
        return postbackData;
    }


    protected void ds_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        ((OracleCommand)e.Command).BindByName = true;

        e.Command.CommandText = "select * from v_ussr_collation_files ";

        whereStmt = " trunc(loaded) >= to_date('"+deLoaded.Date.ToString("dd/MM/yyyy")+"','dd/mm/yyyy') and ";

        //по региональному управлению
        if (rbRu.Checked)
        {
            if (!String.IsNullOrEmpty(ddRU.SelectedValue))
                whereStmt += String.Format("ru = {0} and ", ddRU.SelectedValue);

            ddRU.Enabled = true;
            edtBranch.Enabled = false;
            branchSelect.Enabled = false;

            ddBranch.Enabled = false;
            ddBranch.Items.Clear();
            Session["ddBranch_Selected"] = null;

            Session["curStmt"] = " ru = " + ddRU.SelectedValue;

            edtBranch.Text = "";
        }
        else
        {
            ddRU.Enabled = false;
            edtBranch.Enabled = false;
            branchSelect.Enabled = false;
            ddRU.Items.Clear();
        }
        if (rbBranch.Checked)
        {
            //Session["ddRU_Selected"] = null;
            edtBranch.Enabled = true;
            branchSelect.Enabled = true;
            ddRU.Items.Clear();

            if (!String.IsNullOrEmpty(edtBranch.Text))
            {
                whereStmt = chBranchAll.Checked ? 
                    String.Format("branch like '{0}%' and ", edtBranch.Text) :
                    whereStmt += String.Format("branch = '{0}' and ", edtBranch.Text.Trim().Replace("'", String.Empty));
                Session["curStmt"] = " branch like '" + edtBranch.Text.Trim().Replace("'", String.Empty) + "%' ";
            }
        }

        whereStmt += rbFileOne.Checked && edtFileName.Text.Trim().Replace("'", String.Empty) != String.Empty ? 
            " file_name like '" + edtFileName.Text.Trim().Replace("'", String.Empty) + "' and " : String.Empty;

        //мусор
        whereStmt += rbGarClean.Checked ? "(garbage is null or garbage='P') and " : String.Empty;
        whereStmt += rbGarGarbage.Checked ? "garbage = 'Y' and " : String.Empty;

        //анализ
        whereStmt += rbAnalisNone.Checked ? "(analyzed is null or analyzed='P') and " : String.Empty;
        whereStmt += rbAnalisOk.Checked ? "analyzed = 'Y' and " : String.Empty;

        //квитанции
        whereStmt += rbAckOk.Checked ? "file_z = 2 and " : String.Empty;
        whereStmt += rbAckNone.Checked ? "(file_z != 2 or file_z is null ) and " : String.Empty;

        //файл корректировки
        whereStmt += rbKorrNone.Checked ? "(fix_file_created is null or fix_file_created='P') and " : String.Empty;
        whereStmt += rbKorrOk.Checked ? "fix_file_created = 'Y' and " : String.Empty;

        //подтверждения
        whereStmt += rbPidtvNone.Checked ? "(approved is null or approved='P') and " : String.Empty;
        whereStmt += rbPidtvOk.Checked ? "approved = 'Y' and " : String.Empty;

        //рассчеты
        whereStmt += rbRozrNone.Checked ? "(processed is null or processed='P') and " : String.Empty;
        whereStmt += rbRozrOk.Checked ? "processed = 'Y' and " : String.Empty;

        //выровнены остатки
        whereStmt += rbCorrectedNone.Checked ? "(corrected is null or corrected='P') and " : String.Empty;
        whereStmt += rbCorrectedOk.Checked ? "corrected = 'Y' and " : String.Empty;

        //пост-анализ
        whereStmt += rbPostAnalNone.Checked ? "(post_analyzed is null or post_analyzed='P') and " : String.Empty;
        whereStmt += rbPostAnalOk.Checked ? "post_analyzed = 'Y' and " : String.Empty;

        //убрать последний and
        whereStmt = String.IsNullOrEmpty(whereStmt) ? String.Empty : whereStmt.Substring(0, whereStmt.Length - 5);  

        //внедрить в SQL
        e.Command.CommandText = e.Command.CommandText.Replace(
            "v_ussr_collation_files",
            "(select * from v_ussr_collation_files " + 
                (whereStmt.Length > 0 ? " where " : String.Empty) + whereStmt + ")");

        //подсчет общего кол-ва файлов
        OracleConnection cn = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand cm = cn.CreateCommand();
        
        if (cn.State != ConnectionState.Open)
        {
            cn.Open();
            cm.CommandText = "begin bars_role_auth.set_role('WR_USSR_TECH');end;";
            cm.ExecuteNonQuery();
        }
        cm.CommandText = "select count(*) from ( " + e.Command.CommandText + " )";
        lblCnt.Text = cm.ExecuteScalar().ToString();

        //сортировка
        e.Command.CommandText += " order by loaded desc";

    }

    protected void rbRu_Checked(object sender, EventArgs e)
    {
        //gv.DataBind();   
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        
        btnSavePidtv.Enabled = gv.PageIndex == 0;
        btnSetGarbage.Enabled = gv.PageIndex == 0;
        btnAnalis.Enabled = gv.PageIndex == 0;
        btnKorr.Enabled = gv.PageIndex == 0;
        btnRest.Enabled = gv.PageIndex == 0;
        btnPostAnalis.Enabled = gv.PageIndex == 0;
        btnCalc.Enabled = gv.PageIndex == 0;

        ddRU.DataBind();
        ddRU.SelectedIndex = ddRU.Items.Count > 0 && (Session["ddRU_Selected"] != null) ? (int)Session["ddRU_Selected"] : -1;

        gv.DataBind();
    }

    protected void ddRU_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (-1 != ddRU.SelectedIndex)
            Session["ddRU_Selected"] = ddRU.SelectedIndex;
        //gv.DataBind();
    }

    protected void ddBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["ddBranch_Selected"] = ddBranch.SelectedIndex;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[ mode=="1" ? 2 : 2].Attributes.Add("Title", DataBinder.Eval(e.Row.DataItem, "BRANCH_NAME").ToString());
            Control control = e.Row.FindControl("btnBlk");
            if (null != control && control is LinkButton)
            {
                LinkButton btnBlk = (LinkButton)control;
                btnBlk.CommandArgument = DataBinder.Eval(e.Row.DataItem, "FILE_NAME").ToString();
            }
        }
    }
    
    protected void btnSavePidtv_Click(object sender, EventArgs e)
    {
        reopenDataSource();

        #region Получениe GridView
        foreach (GridViewRow gr in gv.Rows)
        {
            CheckBox chk = (CheckBox)gr.FindControl("chk");
            if (chk == null || Request[chk.UniqueID] != "on" || !chk.Enabled) continue;
            InitOraConnection();
            try
            {
                SetRole("WR_USSR_TECH");
                ClearParameters();
                SetParameters("p_filename", DB_TYPE.Varchar2, gv.DataKeys[gr.RowIndex].Values[1], DIRECTION.Input);
                SQL_PROCEDURE("ussr_collation.mark_for_processing");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        #endregion
        //gv.DataBind();
    }

    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        //не использовать defaultButton при нажатии Enter
        gv.Attributes.Add("onkeypress", "if (event.keyCode == 13) return false;");
        //gv.DataBind();

        //!!!! Дорабатывал tv_Sukhov 17.04.2008
        // выполняем событие gv_RowCommand после Render из-за того что только сейчас 
        // была применена сортировка
        gv_RowCommand_AfterRender(this.gv_RowCommand_Args);
    }

    private void execProcedure(string procName, bool needParam)
    {
        InitOraConnection();
        try
        {
            SetRole("WR_USSR_TECH");
            if (needParam)
            {
                ClearParameters();
                SetParameters(
                    "p_where_stmt",
                    DB_TYPE.Varchar2,
                    (whereStmt.Length > 0 ? whereStmt : "1=1"),
                    DIRECTION.Input);
            }
            SQL_PROCEDURE(String.Format("ussr_collation.{0}", procName));
        }
        finally
        {
            DisposeOraConnection();
        }

    }

    protected void btnAnalis_Click(object sender, EventArgs e)
    {
        execProcedure("mark_for_analysis", true);
    }

    protected void btnKorr_Click(object sender, EventArgs e)
    {
        execProcedure("mark_for_ffc", true);
    }

    protected void btnRest_Click(object sender, EventArgs e)
    {
        execProcedure("mark_for_correction", true);
    }

    protected void btnPostAnalis_Click(object sender, EventArgs e)
    {
        execProcedure("mark_for_post_analysis", true);
    }

    protected void btnCalc_Click(object sender, EventArgs e)
    {
        execProcedure("processing_job", false);
    }

    protected void btnReload_Click(object sender, EventArgs e)
    {
        //gv.DataBind();
    }

    private void reopenDataSource()
    {
        string cs = ds.ConnectionString;
        ds.ConnectionString = "";
        ds.ConnectionString = cs;
        gv.DataBind();
    }

    protected void btnSetGarbage_Click(object sender, EventArgs e)
    {
        reopenDataSource();

        #region Получениe GridView
        foreach (GridViewRow gr in gv.Rows)
        {
            CheckBox _chk = (CheckBox)gr.FindControl("chkGarb");
            if (_chk == null || Request[_chk.UniqueID] != "on"/*!_chk.Checked*/ || !_chk.Enabled) continue;
            InitOraConnection();
            try
            {
                SetRole("WR_USSR_TECH");
                ClearParameters();
                SetParameters("p_filename", DB_TYPE.Varchar2, gv.DataKeys[gr.RowIndex].Values[1], DIRECTION.Input);
                SQL_PROCEDURE("ussr_collation.mark_for_garbage");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        #endregion
//        gv.DataBind();
    }

    protected void btnBlk_Click(object sender, EventArgs e)
    {
        reopenDataSource();

        #region Получениe GridView
        foreach (GridViewRow gr in gv.Rows)
        {
            CheckBox _chk = (CheckBox)gr.FindControl("chkBlk");
            if (_chk == null || Request[_chk.UniqueID] != "on"/*!_chk.Checked*/ || !_chk.Enabled) continue;
            InitOraConnection();
            try
            {
                SetRole("WR_USSR_TECH");
                ClearParameters();
                SetParameters("p_filename", DB_TYPE.Varchar2, gv.DataKeys[gr.RowIndex].Values[1], DIRECTION.Input);
                SQL_PROCEDURE("ussr_collation.remove_blk_97");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        #endregion
        //        gv.DataBind();
    }

    protected void dsRU_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        //OracleConnection conn = (OracleConnection)e.Command.Connection;
        //conn.Open();
        //OracleCommand cmd = conn.CreateCommand();
        //cmd.CommandText = "begin bars_role_auth.set_role('WR_USSR_TECH');end;";
        //cmd.ExecuteNonQuery();
    }

    //!!!! Дорабатывал tv_Sukhov 17.04.2008
    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        this.gv_RowCommand_Args = e;
        
        /*
        switch (e.CommandName)
        {
            case "blkRemove":
                if (e.CommandSource is LinkButton)
                {
                    string fileName = ((LinkButton)e.CommandSource).CommandArgument;
                    removeBlk(fileName);
                } 
                break;
            case "View":
                int rowId = Convert.ToInt32(e.CommandArgument);
                if (String.Empty != e.CommandArgument && null != gv.DataKeys[rowId].Values[0])
                {
                    int fileId = Convert.ToInt32(gv.DataKeys[rowId].Values[0]);
                    Session["fileId"] = fileId;
                    Session["source"] = "dbfyproc";
                    Response.Redirect("dbfdataview.aspx");
                }
                break;

        }
        */
    }
    /// <summary>
    /// Функция аналогичная gv_RowCommand, только выполнять ее нада после Render'а
    /// </summary>
    /// <param name="e">Аргументы переданые в gv_RowCommand</param>
    private void gv_RowCommand_AfterRender(GridViewCommandEventArgs e)
    {
        if (e != null)
        {
            switch (e.CommandName)
            {
                case "View":
                    int rowId = Convert.ToInt32(e.CommandArgument);
                    if (String.Empty != e.CommandArgument && null != gv.DataKeys[rowId].Values[0])
                    {
                        int fileId = Convert.ToInt32(gv.DataKeys[rowId].Values[0]);
                        Session["fileId"] = fileId;
                        Session["source"] = "dbfyproc";
                        Response.Redirect("dbfdataview.aspx");
                    }
                    break;
            }
        }
    }
    private GridViewCommandEventArgs gv_RowCommand_Args = null;
    //!!!! Дорабатывал tv_Sukhov 17.04.2008

    protected string handleBlk(string branch)
    {
        //Response.Write(branch);
        return String.Empty;
    }
    protected void hypExcel_Command(object sender, CommandEventArgs e)
    {
        gv.Export(Bars.DataComponents.ExportMode.Excel);
    }
}
