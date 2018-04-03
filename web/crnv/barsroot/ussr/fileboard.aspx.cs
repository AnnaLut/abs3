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
using System.Text;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.IO;

public partial class FileBoard : Bars.BarsPage
{
    # region Приватные свойства

    private string Role = "WR_BOARD";
    private GridViewCommandEventArgs lastGridViewCommandEventArgs = null;

    # endregion

    # region События страницы

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        ds.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(Role);
        if (null != Session["curPageSize"])
            ds.MaximumRows = Convert.ToInt32(Session["curPageSize"]);
    }

    /// <summary>
    /// Фиксит глюк грида
    /// </summary>
    /// <returns></returns>
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
                    Session["curPageSize"] = Convert.ToInt32(pair[1].Replace("%24", "$").Split('$')[2]) + 1;
            }
        }
        return postbackData;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnAddFile_Click(object sender, EventArgs e)
    {
        
        if (fileUpload.PostedFile.FileName == String.Empty)
        {
            lblErrm.Text = "Необхiдно вибрати файл";
            return;
        }
        
        if (fileUpload.PostedFile.ContentLength==0)
        {
            lblErrm.Text = "Вибрано пустий файл";
            return;
        }
        if (String.Empty == tbFileDesc.Text.Trim())
        {
            lblErrm.Text = "Не заповнене поле: опис";
            return;
        }

        byte[] buffer = fileUpload.FileBytes;
        string fileName = Path.GetFileName(fileUpload.FileName);
        InitOraConnection();
        try
        {
            SetRole(Role);
            ClearParameters();
            //параметры в порядке использования
            SetParameters("p_file_desc", DB_TYPE.Varchar2, tbFileDesc.Text, DIRECTION.Input);
            SetParameters("p_file_body", DB_TYPE.Blob, buffer, DIRECTION.Input);
            SetParameters("p_file_size", DB_TYPE.Decimal, fileUpload.PostedFile.ContentLength, DIRECTION.Input);
            SetParameters("p_file_size", DB_TYPE.Decimal, fileUpload.PostedFile.ContentLength, DIRECTION.Input);
            SetParameters("p_file_name", DB_TYPE.Varchar2, fileName.ToUpper(), DIRECTION.Input);
            SetParameters("p_file_name1", DB_TYPE.Varchar2, fileName.ToUpper(), DIRECTION.Input);
            SetParameters("p_file_desc1", DB_TYPE.Varchar2, tbFileDesc.Text, DIRECTION.Input);
            SetParameters("p_file_body1", DB_TYPE.Blob, buffer, DIRECTION.Input);
            SetParameters("p_file_size1", DB_TYPE.Decimal, fileUpload.PostedFile.ContentLength, DIRECTION.Input);
            SQL_NONQUERY(
                "begin "+
                  "update bars_file_board "+
                    "set file_desc=:p_file_desc, file_body=:p_file_body, file_size=:p_file_size, "+
                      "file_version=decode(file_size,:file_size,file_version, file_version+1), "+
                      "modified=sysdate "+
                    "where file_name = :p_file_name; "+
                  "if (sql%rowcount = 0) then "+
                    "insert into bars_file_board (file_name, file_desc, file_body, file_size) "+
                    "values (:p_file_name1, :p_file_desc1, :p_file_body1, :p_file_size1); "+
                  "end if; "+  
                "end; "
            );
            gv.DataBind();
        }
        finally
        {
            DisposeOraConnection();
        }

    }

    protected void gv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (null != lastGridViewCommandEventArgs)
        {
            ds.DeleteParameters.Clear();
            Parameter p1 = new Parameter("id", TypeCode.String, 
                lastGridViewCommandEventArgs.CommandArgument.ToString());
            ds.DeleteParameters.Add(p1);
        }
    }

    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        gv.Columns[0].Visible = gv.PageIndex == 0 && Request["mode"].ToUpper() == "ADM";
        pnlAddFile.Visible = Request["mode"].ToUpper() == "ADM";


        //не использовать defaultButton при нажатии Enter
        gv.Attributes.Add("onkeypress", "if (event.keyCode == 13) return false;");

        if (null != lastGridViewCommandEventArgs)
        {
            switch (lastGridViewCommandEventArgs.CommandName)
            {
                case "download":
                    downloadFile(
                        gv.DataKeys[
                            Convert.ToInt32(lastGridViewCommandEventArgs.CommandArgument.ToString())
                        ].Value.ToString());
                    break;
            }
        }
    }

    private void downloadFile(string fileId)
    {
        InitOraConnection();
        try
        {
            SetRole(Role);
            ClearParameters();
            SetParameters("p_id", DB_TYPE.Decimal, fileId, DIRECTION.Input);
            object[] res = SQL_SELECT_reader("select file_name, file_body from bars_file_board where id=:p_id");
            if (null != res)
            {
                string attachment = "attachment; filename=" + Server.UrlEncode(Convert.ToString(res[0]));
                Response.Clear();
                Response.ClearContent();
                Response.AppendHeader("Cache-control", "private");
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/octet-stream";
                Response.Flush();
                Response.BinaryWrite((byte[])res[1]);
                Response.End();
            }
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lastGridViewCommandEventArgs = e; 
    }

    protected override void OnPreRender(EventArgs e)
    {
        gv.DataBind();
    }

    protected void ds_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
    }

    # endregion

}
