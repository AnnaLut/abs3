using System;
using System.IO;
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


public partial class vip : Bars.BarsPage
{
	public override void VerifyRenderingInServerForm(Control control){ }
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        if (this.DesignMode == true)
        {
            this.EnsureChildControls();
        }
        this.Page.RegisterRequiresControlState(this);
    } 

    //Населення грида
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsVip.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsKvip.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsVipNew.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsKvipNew.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        String SelectCommand = @"select v.mfo MFO,
                                     v.rnk RNK, 
                                     v.nmk NMK, 
                                     v.branch BRANCH, 
                                     v.vip  VIP, 
                                     v.vip_name VIP_NAME, 
                                     v.kvip KVIP, 
                                     v.datbeg DATBEG, 
                                     v.datend DATEND, 
                                     v.comments COMMENTS, 
                                     v.fio_manager FIO_MANAGER,
                                     v.phone_manager PHONE_MANAGER, 
                                     v.kvip_name  
                                 from v_vip_flags v where v.mfo=sys_context('bars_context','user_mfo') ";
        SelectCommand += " and upper(v.nmk) like  upper('%" + tbNMK.Text + "%') ";
        SelectCommand += " and v.rnk  like '%" + tbRNK.Text + "%' ";
        if (rbAll.Checked)
        {
            SelectCommand += " and kvip like '%'";
        }

        if (rbFin.Checked)
        {
            SelectCommand += " and kvip = '1'";
        }
        if (rbSoc.Checked)
        {
            SelectCommand += " and kvip = '2'";
        }
        if (rbPravl.Checked)
        {
            SelectCommand += " and kvip = '3'";
        }

        dsMain.SelectCommand = SelectCommand;
        bt_new.Visible = true;
        pnNew.Visible = false;
        //  gvMain.AutoGenerateCheckBoxColumn = true;
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



    protected void bt_save_Click(object sender, EventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            int pos = 0;
            if (chBox.Checked == false)
            {
                foreach (GridViewRow row in gvMain.Rows)
                {
                    string MFO = Convert.ToString(gvMain.DataKeys[pos].Values[0]);
                    string RNK = Convert.ToString(gvMain.DataKeys[pos].Values[1]);
                    TextBox ddVip = ((TextBox)row.Cells[4].Controls[1]);
                    DDLList ddKvip = ((DDLList)row.Cells[6].Controls[1]);
                    TextBoxDate tbDatBeg = ((TextBoxDate)row.Cells[7].Controls[1]);
                    TextBoxDate tbDatEnd = ((TextBoxDate)row.Cells[8].Controls[1]);
                    TextBox tbComments = ((TextBox)row.Cells[9].Controls[1]);
                    TextBoxString tbFIOMANAGER = ((TextBoxString)row.Cells[10].Controls[1]);
                    TextBox tbPHONEMANAGER = ((TextBox)row.Cells[11].Controls[1]);


                    ClearParameters();
                    SetParameters("P_MFO", DB_TYPE.Varchar2, MFO, DIRECTION.Input);
                    SetParameters("P_RNK", DB_TYPE.Varchar2, RNK, DIRECTION.Input);
                    SetParameters("P_VIP", DB_TYPE.Varchar2, ddVip.Text, DIRECTION.Input);
                    SetParameters("P_KVIP", DB_TYPE.Varchar2, String.IsNullOrEmpty(Convert.ToString(ddKvip.Value)) ? 1 : ddKvip.Value, DIRECTION.Input);
                    SetParameters("P_DATBEG", DB_TYPE.Date, tbDatBeg.Value, DIRECTION.Input);
                    SetParameters("P_DATEND", DB_TYPE.Date, tbDatEnd.Value, DIRECTION.Input);
                    SetParameters("P_RETURN", DB_TYPE.Varchar2, 4000, DIRECTION.Output);
                    SetParameters("p_COMMENTS", DB_TYPE.Varchar2, tbComments.Text, DIRECTION.Input);
                    SetParameters("p_FIOMANAGER", DB_TYPE.Varchar2, tbFIOMANAGER.Value, DIRECTION.Input);
                    SetParameters("p_PHONEMANAGER", DB_TYPE.Varchar2, tbPHONEMANAGER.Text, DIRECTION.Input);



                    SQL_NONQUERY(@" begin  load_vip_web(:P_MFO, :P_RNK, :P_VIP, :P_KVIP, :P_DATBEG,
                                                        :P_DATEND,
                                                        :P_RETURN, 
									                    :p_COMMENTS,
                                                        :p_FIOMANAGER,
                                                        :p_PHONEMANAGER);
                                                  end;");

                    pos++;
                }
            }
            else
            {
                ClearParameters();
                //SetParameters("P_MFO", DB_TYPE.Varchar2, MFO, DIRECTION.Input);
                SetParameters("P_RNK", DB_TYPE.Varchar2, trRNK.Value, DIRECTION.Input);
                SetParameters("P_VIP", DB_TYPE.Varchar2, ddVipNew.Value, DIRECTION.Input);
                SetParameters("P_KVIP", DB_TYPE.Varchar2, ddKvipNew.Value, DIRECTION.Input);
                SetParameters("P_DATBEG", DB_TYPE.Date, Convert.ToDateTime(tbDatBegNew.Value), DIRECTION.Input);
                SetParameters("P_DATEND", DB_TYPE.Date, Convert.ToDateTime(tbDatEndNew.Value), DIRECTION.Input);
                SetParameters("P_RETURN", DB_TYPE.Varchar2, 4000, DIRECTION.Output);
                SetParameters("p_COMMENTS", DB_TYPE.Varchar2, tbCommNew.Text, DIRECTION.Input);
                SetParameters("p_FIOMANAGER", DB_TYPE.Varchar2, tbFIOMANAGERNew.Value, DIRECTION.Input);
                SetParameters("p_PHONEMANAGER", DB_TYPE.Varchar2, tbPHONEMANAGERNew.Text, DIRECTION.Input);



                SQL_NONQUERY(@" begin  load_vip_web(f_ourmfo, :P_RNK, :P_VIP, :P_KVIP, :P_DATBEG,
                                                        :P_DATEND,
                                                        :P_RETURN, 
									                    :p_COMMENTS,
                                                        :p_FIOMANAGER,
                                                        :p_PHONEMANAGER);    
                                                  end;");
                trRNK.Value = null;
                ddVipNew.Value = null;
                ddKvipNew.Value = null;
                tbDatBegNew.Value = null;
                tbDatEndNew.Value = null;
                tbCommNew.Text = null;
                tbFIOMANAGERNew.Value = null;
                tbPHONEMANAGERNew.Text = null;
            }

            FillData();
        }
        finally
        {
            DisposeOraConnection();
        }

        gvMain.Visible = true;
        pnInfo.Visible = true;

        bt_new.Visible = true;

        bt_cancel.Visible = false;

        pnNew.Visible = false;
        chBox.Checked = false;
    }

    protected void btDel_Click(object sender, ImageClickEventArgs e)
    {
       
        ShowError("RNK:");
    }
    protected void gvMain_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DEL_ROW")
        {
            InitOraConnection();
            try
            {
                string[] pars = e.CommandArgument.ToString().Split(new char[] { ',' });
                String MFO = pars[0];
                String RNK = pars[1];
                
                    ClearParameters();
                    SetParameters("MFO", DB_TYPE.Varchar2, MFO, DIRECTION.Input);
                    SetParameters("RNK", DB_TYPE.Varchar2, RNK, DIRECTION.Input);
                    SetParameters("RNK2", DB_TYPE.Varchar2, RNK, DIRECTION.Input);
                    SQL_NONQUERY(@"begin 
                                    delete from vip_flags where mfo=:MFO and rnk=:RNK; 
                                    update customerw set value='0' where rnk=:RNK2 and tag='VIP_K';
                                    end;");

                    gvMain.DataBind();
                
            }
            finally
            {

                DisposeOraConnection();
            }
        }
    }
    protected void bt_new_Click(object sender, EventArgs e)
    {
        gvMain.Visible = false;
        pnInfo.Visible = false;

        bt_new.Visible = false;
        bt_Export.Visible = false;

        bt_cancel.Visible = true;

        pnNew.Visible = true;
        chBox.Checked = true;
    }
    protected void bt_cancelEdit_Click(object sender, EventArgs e)
    {
        gvMain.Visible = true;
        pnInfo.Visible = true;

        bt_new.Visible = true;
        bt_Export.Visible = true;

        bt_cancel.Visible = false;

        pnNew.Visible = false;
        chBox.Checked = false;
    }
    protected void bt_Export_Click(object sender, EventArgs e)
    {
     	LiteralControl lc = new LiteralControl();
        gvExport.Visible = true;
        gvExport.DataSourceID = "dsMain";
        gvExport.DataBind();

        string attachment = "attachment; filename=vip.xls";
        Response.ClearContent();
        Response.BufferOutput = true;
        Response.AddHeader("content-disposition", attachment);
        Response.Charset = "utf-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.ContentType = "application/vnd.ms-excel";
        Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");

        StringWriter swrt = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(swrt);
        lc.RenderControl(htw);
        
        gvExport.RenderControl(htw);
        Response.Write(swrt.ToString());
        Response.Flush();
        Response.End();
        gvExport.Visible = false;
	}
}
