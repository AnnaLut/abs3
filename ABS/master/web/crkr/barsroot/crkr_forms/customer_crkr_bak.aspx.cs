using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;


public partial class customer_crkr_customer_crkr_bak : Bars.BarsPage
{
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    //Населення грида
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        String SelectCommand = @"select *  from v_customer_crkr ";

        if (String.IsNullOrEmpty(flFio.Text) && String.IsNullOrEmpty(flIDCODE.Text))
        {
            SelectCommand += "where 1=0 ";
        }
        else
        {
            SelectCommand += "where 1=1 ";
        }

        if (!String.IsNullOrEmpty(flFio.Text))
        {
            SelectCommand += " and upper(name) like upper('%" + flFio.Text + "%') ";
        }

        if (!String.IsNullOrEmpty(flIDCODE.Text))
        {
            SelectCommand += " and okpo like '%" + flIDCODE.Text + "%' ";
        }

        if (!String.IsNullOrEmpty(tbRnk.Text))
        {
            SelectCommand += " and RNK = " + tbRnk.Text + " ";
        }
        dsMain.SelectCommand = SelectCommand;

        if (!String.IsNullOrEmpty(tbSerial.Text))
        {
            SelectCommand += " and SER like '%" + tbSerial.Text + "%' ";
        }
        dsMain.SelectCommand = SelectCommand;

        if (!String.IsNullOrEmpty(tbNumber.Text))
        {
            SelectCommand += " and NUMDOC like '%" + tbNumber.Text + "%' ";
        }

        dsMain.SelectCommand = SelectCommand;
        FillData();
    }

    //редірект на форму створення нового клієнта
    protected void btNewClient_Click(object sender, EventArgs e)
    {
        Response.Redirect("/barsroot/Crkr/ClientProfile/Index?rnk=");
    }

    //Перечитати дани
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    // Для коректного відображення алертiв
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    //Для открытия в новом окне
    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", " window.open('" + URL + "');", true);
    }

    //Кнопка HELP
    // protected void btHelp(object sender, ImageClickEventArgs e)
    // {
    //     Window_open("/barsroot/over/over_help.htm");
    // }


    //Редагування картки вклада
    protected void btEdit_Click(object sender, ImageClickEventArgs e)
    {
        string rnk = Convert.ToString(gvMain.SelectedDataKey.Values[0]);
        ShowError("KEY:" + rnk);
        //  Response.Redirect("/barsroot/neruhomi/edit_neruhomi.aspx?key=" + key);
    }

    //Розкраска грида
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //    DateTimeFormatInfo dateFormat = new DateTimeFormatInfo();
        //    dateFormat.ShortDatePattern = "dd.MM.yyyy";

        //    try
        //    {
        //        InitOraConnection();
        //        if (e.Row.RowType == DataControlRowType.DataRow)
        //        {
        //            object o1 = ((DataRowView)e.Row.DataItem).Row["SD_2600"];
        //            object o2 = ((DataRowView)e.Row.DataItem).Row["Lim_2600"];
        //            object o3 = SQL_SELECT_scalar(@"select to_char(sysdate,'dd.mm.yyyy') from dual");
        //            object o4 = ((DataRowView)e.Row.DataItem).Row["datd2"];

        //            decimal sd_2600 = o1 == DBNull.Value || o1 == null ? 0 : Convert.ToDecimal(o1);
        //            decimal lim_2600 =  o2 == DBNull.Value || o2 == null ? 0 : Convert.ToDecimal(o2);
        //            DateTime sysdate =  Convert.ToDateTime(o3, dateFormat);
        //            DateTime datd2 =  o4 == DBNull.Value || o4 == null ? DateTime.Now : Convert.ToDateTime(o4, dateFormat);

        //                    if (sd_2600 != lim_2600)
        //            {
        //                e.Row.Cells[13].BackColor = System.Drawing.Color.Plum;
        //            }
        //            if (sysdate == datd2)
        //            {
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.LightGreen;
        //            }
        //            if (datd2 < sysdate)
        //            {
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Tomato;
        //            }
        //            if (datd2 <= sysdate.AddDays(7) && sysdate != datd2 && datd2>sysdate)
        //            {
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Aquamarine;
        //            }
        //        }

        //    }
        //    finally
        //    {
        //        DisposeOraConnection();
        //    }

    }

}
