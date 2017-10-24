using System;
using Bars.Classes;
using System.Collections;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;
using BarsWeb.Areas.Ndi.Infrastructure;


public partial class cbirep_export_dbf : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsMainZapros.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select z.kodz, z.name, z.create_stmt, z.txt 
                                     from zapros z, zapros_users u
                                     where Z.KODZ=U.KODZ
                                     and z.create_stmt is not null
                                     and U.USER_ID=user_id()
                                     order by z.kodz asc";

        dsMainZapros.SelectCommand = SelectCommand;
        if (IsPostBack)
        {
            dsMainData.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();


            String SelectCommandData = @"select 
                        id, 
                        to_char(creating_date,'dd-mm-yyyy HH24:MI:SS') creating_date, 
                        data
                     from tmp_export_to_dbf
                     where userid=user_id()
                     and kodz='" + Session["kodz"] + "'";

            dsMainData.SelectCommand = SelectCommandData;
        }

    }

    protected void gvMainZapros_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void gvMainData_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", "window.showModalDialog('" + URL + "');", true);
    }

    protected void btRun_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            string URL = "/barsroot/cbirep/export_dbf_var.aspx?KODZ=" + Session["kodz"];
            Window_open(URL);
        }
        finally
        {
            DisposeOraConnection();
            gvMainData.DataBind();
        }
    }

    protected void btDownloadTxt_Command(object sender, CommandEventArgs e)
    {
        InitOraConnection();
        try
        {
            SetParameters("id", DB_TYPE.Int64, e.CommandArgument, DIRECTION.Input);
            SQL_Reader_Exec(@"select data, file_name from tmp_export_to_dbf where id =:id");
            while (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();
                byte[] data = (byte[])reader[0];

                string fileName = string.Empty;
                if (reader[1].ToString().IsNullOrEmpty())
                {
                    fileName = Convert.ToString(Session["kodz"]) ;
                }
                else
                {
                    fileName = reader[1].ToString() ;
                }

                Response.AppendHeader("content-disposition", String.Format("attachment;filename={0}", fileName));
                Response.ContentType = "application/octet-stream";
                Response.BinaryWrite(data);
                Response.End();
            }
            SQL_Reader_Close();
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btDownload_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName=="SAVE")
        {
            InitOraConnection();

            try
            {
                SetParameters("id", DB_TYPE.Int64, e.CommandArgument, DIRECTION.Input);
                SQL_Reader_Exec(@"select data from tmp_export_to_dbf where id =:id");
                while (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();
                    byte[] data = (byte[])reader[0];

                    Response.AppendHeader("content-disposition", String.Format("attachment;filename={0}",Session["kodz"]+".dbf"));
                    Response.ContentType = "application/octet-stream";
                    Response.BinaryWrite(data);
                    Response.End();
                }
                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        if (e.CommandName == "DEL")
        {
            InitOraConnection();

            try
            {
                SetParameters("id", DB_TYPE.Int64, e.CommandArgument, DIRECTION.Input);
                SQL_NONQUERY("begin delete from tmp_export_to_dbf where id=:id; end;");
            }
            finally
            {
                DisposeOraConnection();
                gvMainData.DataBind();
            }
        }
    }

    protected void gvMainZapros_RowClicked(object sender, Bars.DataComponents.GridViewRowClickedEventArgs args)
    {
        dsMainData.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        Session["kodz"] = Convert.ToString(args.Row.Cells[0].Text).Replace("&nbsp", "null");

        String SelectCommandData = @"select 
                        id, 
                        to_char(creating_date,'dd-mm-yyyy HH24:MI:SS') creating_date, 
                        data
                     from tmp_export_to_dbf
                     where userid=user_id()
                     and kodz='" + Session["kodz"] + "'";

        dsMainData.SelectCommand = SelectCommandData;
        gvMainData.DataBind();
    }

    protected void gvMainZapros_DataBound(object sender, EventArgs e)
    {
        gvMainData.DataBind();
    }
}